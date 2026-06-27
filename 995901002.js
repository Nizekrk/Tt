delete window.$;
let w = webpackChunkdiscord_app.push([[Symbol()], {}, r => r]);
webpackChunkdiscord_app.pop();

let As = Object.values(w.c).find(x => x?.exports?.A?.__proto__?.getStreamerActiveStreamMetadata).exports.A;
let Rg = Object.values(w.c).find(x => x?.exports?.Ay?.getRunningGames).exports.Ay;
let Qs = Object.values(w.c).find(x => x?.exports?.A?.__proto__?.getQuest).exports.A;
let Cs = Object.values(w.c).find(x => x?.exports?.A?.__proto__?.getAllThreadsForParent).exports.A;
let Gs = Object.values(w.c).find(x => x?.exports?.Ay?.getSFWDefaultChannel).exports.Ay;
let Fd = Object.values(w.c).find(x => x?.exports?.h?.__proto__?.flushWaitQueue).exports.h;
let api = Object.values(w.c).find(x => x?.exports?.Bo?.get).exports.Bo;

const st = ["WATCH_VIDEO", "PLAY_ON_DESKTOP", "STREAM_ON_DESKTOP", "PLAY_ACTIVITY", "WATCH_VIDEO_ON_MOBILE"];

const _css = document.createElement('style');
_css.textContent = `
:root {
  --a: rgba(255,255,255,0.75); --b: rgba(0,0,0,0.06); --c: #E95420; --d: rgba(233,84,32,0.25);
  --e: rgba(233,84,32,0.1); --f: #2eb872; --g: rgba(46,184,114,0.25); --h: rgba(46,184,114,0.1);
  --i: rgba(20,20,20,0.95); --j: rgba(20,20,20,0.55); --k: rgba(20,20,20,0.35);
  --l: rgba(0,0,0,0.025); --m: rgba(0,0,0,0.05); --n: rgba(0,0,0,0.04);
  --r1: 8px; --r2: 12px; --r3: 18px; --r4: 22px;
  --t1: cubic-bezier(0.22,1,0.36,1); --t2: cubic-bezier(0.34,1.56,0.64,1);
}
#_n0 { position: fixed; inset: 0; z-index: 999999; background: #ffffff; display: flex; align-items: center; justify-content: center; flex-direction: column; gap: 24px; transition: opacity 0.6s ease; }
#_n0.hide { opacity: 0; pointer-events: none; }
._n0-t { font-family: -apple-system, BlinkMacSystemFont, sans-serif; color: #1a1a1a; font-weight: 700; font-size: 22px; letter-spacing: 2px; text-transform: uppercase; }
._n0-s { width: 40px; height: 40px; stroke: var(--c); animation: _n0r 1s linear infinite; }
@keyframes _n0r { to { transform: rotate(360deg); } }
#_n1 { position: fixed; top: 24px; right: 24px; width: 340px; font-family: -apple-system, BlinkMacSystemFont, sans-serif; z-index: 99998; animation: _cE 0.7s var(--t1) forwards; opacity: 0; transform: translateY(-16px) scale(0.97); filter: blur(8px); }
@keyframes _cE { 0% { opacity: 0; transform: translateY(-16px) scale(0.97); filter: blur(8px); } 100% { opacity: 1; transform: translateY(0) scale(1); filter: blur(0); } }
._g1 { background: var(--a); backdrop-filter: blur(24px) saturate(180%); -webkit-backdrop-filter: blur(24px) saturate(180%); border-radius: var(--r4); border: 1px solid var(--b); box-shadow: 0 0 0 1px rgba(255,255,255,0.5) inset, 0 24px 60px -12px rgba(0,0,0,0.15); overflow: hidden; color: var(--i); position: relative; }
._g1::before { content: ''; position: absolute; top: 0; left: 0; right: 0; height: 1px; background: linear-gradient(90deg, transparent, rgba(0,0,0,0.05) 30%, rgba(0,0,0,0.1) 50%, rgba(0,0,0,0.05) 70%, transparent); pointer-events: none; }
._g1::after { content: ''; position: absolute; top: 0; left: 0; right: 0; bottom: 0; background: radial-gradient(ellipse at 30% -20%, var(--e), transparent 70%); pointer-events: none; opacity: 0.8; }
._h1 { padding: 18px 22px; display: flex; align-items: center; gap: 12px; position: relative; z-index: 1; }
._h2 { width: 32px; height: 32px; display: flex; align-items: center; justify-content: center; border-radius: var(--r1); background: var(--e); position: relative; }
._h2::after { content: ''; position: absolute; inset: -1px; border-radius: inherit; background: linear-gradient(135deg, rgba(233,84,32,0.3), transparent); z-index: -1; filter: blur(4px); }
._h3 { color: var(--c); width: 16px; height: 16px; animation: _iP 3s ease-in-out infinite; }
@keyframes _iP { 0%, 100% { opacity: 0.9; transform: scale(1); } 50% { opacity: 1; transform: scale(1.05); } }
._h4 { display: flex; flex-direction: column; gap: 1px; }
._h5 { font-weight: 600; font-size: 13px; letter-spacing: 0.3px; color: var(--i); }
._h6 { font-size: 10.5px; color: var(--k); font-weight: 400; letter-spacing: 0.2px; }
._h7 { margin-left: auto; width: 28px; height: 28px; display: flex; align-items: center; justify-content: center; border-radius: var(--r1); border: none; background: transparent; color: var(--k); cursor: pointer; transition: all 0.25s var(--t1); }
._h7:hover { background: var(--m); color: var(--j); transform: scale(1.05); }
._h7:active { transform: scale(0.95); }
._h7 svg { width: 14px; height: 14px; }
._d1 { height: 1px; margin: 0 22px; background: linear-gradient(90deg, transparent, var(--n) 20%, var(--n) 80%, transparent); }
._q1 { padding: 14px 16px; display: flex; flex-direction: column; gap: 10px; max-height: 380px; overflow-y: auto; }
._q1::-webkit-scrollbar { width: 3px; } ._q1::-webkit-scrollbar-track { background: transparent; } ._q1::-webkit-scrollbar-thumb { background: rgba(0,0,0,0.1); border-radius: 10px; } ._q1::-webkit-scrollbar-thumb:hover { background: rgba(0,0,0,0.2); }
._q2 { background: var(--l); border: 1px solid var(--n); border-radius: var(--r2); padding: 14px 16px; transition: all 0.35s var(--t1); position: relative; overflow: hidden; animation: _cE 0.5s var(--t1) forwards; opacity: 0; transform: translateY(8px); }
._q2:nth-child(1) { animation-delay: 0.05s; } ._q2:nth-child(2) { animation-delay: 0.1s; } ._q2:nth-child(3) { animation-delay: 0.15s; } ._q2:nth-child(4) { animation-delay: 0.2s; } ._q2:nth-child(5) { animation-delay: 0.25s; }
._q2::before { content: ''; position: absolute; inset: 0; background: radial-gradient(circle at 0% 0%, var(--e), transparent 60%); opacity: 0; transition: opacity 0.4s ease; pointer-events: none; }
._q2:hover { border-color: rgba(0,0,0,0.1); background: var(--m); transform: translateY(-1px); box-shadow: 0 4px 20px -8px rgba(0,0,0,0.1); }
._q2:hover::before { opacity: 1; }
._q2.active { border-color: rgba(233,84,32,0.2); }
._q2.active::before { opacity: 0.5; }
._q2.done { border-color: rgba(46,184,114,0.2); }
._q2.done::before { background: radial-gradient(circle at 0% 0%, var(--h), transparent 60%); opacity: 0.5; }
._q3 { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; gap: 10px; }
._q4 { font-size: 13px; font-weight: 500; line-height: 1.35; color: var(--i); flex: 1; min-width: 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
._q5 { font-size: 9.5px; padding: 3px 9px; border-radius: 20px; font-weight: 600; letter-spacing: 0.6px; text-transform: uppercase; flex-shrink: 0; transition: all 0.3s var(--t1); }
._q6 { background: var(--e); color: var(--c); animation: _sP 2.5s ease-in-out infinite; }
@keyframes _sP { 0%, 100% { box-shadow: 0 0 0 0 var(--d); } 50% { box-shadow: 0 0 12px 2px var(--d); } }
._q7 { background: var(--h); color: var(--f); animation: _sPop 0.4s var(--t2); }
@keyframes _sPop { 0% { transform: scale(0.8); opacity: 0; } 100% { transform: scale(1); opacity: 1; } }
._q8 { position: relative; }
._q9 { width: 100%; height: 3px; background: rgba(0,0,0,0.08); border-radius: 10px; overflow: hidden; position: relative; }
._qA { height: 100%; border-radius: 10px; background: linear-gradient(90deg, var(--c), #ff7e45); width: 0%; transition: width 0.6s var(--t1); position: relative; }
._qA::after { content: ''; position: absolute; top: 0; left: 0; right: 0; bottom: 0; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent); animation: _sh 2s ease-in-out infinite; }
@keyframes _sh { 0% { transform: translateX(-100%); } 100% { transform: translateX(100%); } }
._q2.done ._qA { background: linear-gradient(90deg, var(--f), #54d98c); }
._q2.done ._qA::after { animation: none; opacity: 0; }
._qB { position: absolute; top: -2px; bottom: -2px; left: 0; width: 0%; background: var(--d); filter: blur(6px); border-radius: 10px; transition: width 0.6s var(--t1); pointer-events: none; }
._q2.done ._qB { background: var(--g); }
._qC { display: flex; justify-content: space-between; align-items: center; margin-top: 10px; }
._qD { font-size: 10.5px; color: var(--k); font-variant-numeric: tabular-nums; font-feature-settings: 'tnum'; letter-spacing: 0.3px; }
._qE { font-size: 10.5px; color: var(--j); font-weight: 500; font-variant-numeric: tabular-nums; }
._l1 { position: relative; }
._l2 { padding: 12px 18px; max-height: 100px; overflow-y: auto; background: rgba(0,0,0,0.03); }
._l2::-webkit-scrollbar { width: 2px; } ._l2::-webkit-scrollbar-thumb { background: rgba(0,0,0,0.1); border-radius: 10px; }
._l3 { font-size: 10.5px; color: var(--k); margin-bottom: 3px; font-variant-numeric: tabular-nums; animation: _lS 0.3s var(--t1) forwards; opacity: 0; transform: translateX(-6px); display: flex; align-items: center; }
@keyframes _lS { to { opacity: 1; transform: translateX(0); } }
._l3.ok { color: var(--f); }
._l3-p { margin-right: 5px; font-weight: 700; }
._e1 { padding: 32px 20px; text-align: center; animation: _fI 0.5s ease forwards; opacity: 0; }
@keyframes _fI { to { opacity: 1; } }
._e1-i { width: 28px; height: 28px; margin: 0 auto 10px auto; opacity: 0.3; color: var(--j); }
._e1-t { font-size: 12px; color: var(--k); line-height: 1.5; }
#_n1.min ._g1 { border-radius: var(--r3); }
#_n1.min ._q1, #_n1.min ._l1, #_n1.min ._d1 { display: none; }
#_n1.min ._h1 { padding: 12px 16px; }
`;
document.head.appendChild(_css);

let _ov = document.createElement('div');
_ov.id = '_n0';
_ov.innerHTML = `
  <svg class="_n0-s" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="2" x2="12" y2="6"></line><line x1="12" y1="18" x2="12" y2="22"></line><line x1="4.93" y1="4.93" x2="7.76" y2="7.76"></line><line x1="16.24" y1="16.24" x2="19.07" y2="19.07"></line><line x1="2" y1="12" x2="6" y2="12"></line><line x1="18" y1="12" x2="22" y2="12"></line><line x1="4.93" y1="19.07" x2="7.76" y2="16.24"></line><line x1="16.24" y1="7.76" x2="19.07" y2="4.93"></line></svg>
  <div class="_n0-t">Nizk Mods</div>
`;
document.body.appendChild(_ov);

setTimeout(() => {
  let ov = document.getElementById('_n0');
  if(ov) {
    ov.classList.add('hide');
    setTimeout(() => ov.remove(), 600);
  }
}, 2500);

const _ui = document.createElement('div');
_ui.id = '_n1';
_ui.innerHTML = `
  <div class="_g1">
    <div class="_h1">
      <div class="_h2">
        <svg class="_h3" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L22 8.5V15.5L12 22L2 15.5V8.5L12 2Z"></path></svg>
      </div>
      <div class="_h4">
        <div class="_h5">Kryx</div>
        <div class="_h6">n i z k</div>
      </div>
      <button class="_h7" id="_m">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><line x1="5" y1="12" x2="19" y2="12"></line></svg>
      </button>
    </div>
    <div class="_d1"></div>
    <div class="_q1" id="_ql"></div>
    <div class="_d1"></div>
    <div class="_l1">
      <div class="_l2" id="_lg"></div>
    </div>
  </div>
`;
document.body.appendChild(_ui);

let m = false;
const mB = document.getElementById('_m');
mB.addEventListener('click', () => {
  m = !m;
  _ui.classList.toggle('min', m);
  mB.innerHTML = m 
    ? '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>'
    : '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><line x1="5" y1="12" x2="19" y2="12"></line></svg>';
  mB.style.transform = 'scale(0.9)';
  setTimeout(() => mB.style.transform = '', 150);
});

const qL = document.getElementById('_ql');
const lE = document.getElementById('_lg');
const qE = {};

function aL(m, s = false) {
  const d = document.createElement('div');
  d.className = `_l3 ${s ? 'ok' : ''}`;
  const p = document.createElement('span');
  p.className = '_l3-p';
  p.innerHTML = '&rsaquo;';
  d.appendChild(p);
  d.appendChild(document.createTextNode(` ${m}`));
  lE.prepend(d);
  if (lE.children.length > 12) lE.lastChild.remove();
}

function cQ(id, name) {
  const c = document.createElement('div');
  c.className = '_q2 active';
  c.id = `q-${id}`;
  c.innerHTML = `
    <div class="_q3">
      <div class="_q4" title="${name}">${name}</div>
      <div class="_q5 _q6">rodando</div>
    </div>
    <div class="_q8">
      <div class="_qB"></div>
      <div class="_q9"><div class="_qA"></div></div>
    </div>
    <div class="_qC">
      <div class="_qD">00:00 / 00:00</div>
      <div class="_qE">0%</div>
    </div>
  `;
  qL.appendChild(c);
  qE[id] = c;
}

function uQ(id, c, t) {
  const k = qE[id];
  if (!k) return;
  const p = Math.min((c / t) * 100, 100);
  k.querySelector('._qA').style.width = `${p}%`;
  k.querySelector('._qB').style.width = `${p}%`;
  k.querySelector('._qE').textContent = `${Math.floor(p)}%`;
  const f = s => `${String(Math.floor(s / 60)).padStart(2, '0')}:${String(s % 60).padStart(2, '0')}`;
  k.querySelector('._qD').textContent = `${f(c)} / ${f(t)}`;
}

function cU(id) {
  const k = qE[id];
  if (!k) return;
  k.className = '_q2 done';
  const s = k.querySelector('._q5');
  s.className = '_q5 _q7';
  s.textContent = 'feito';
  k.querySelector('._qA').style.width = '100%';
  k.querySelector('._qB').style.width = '100%';
  k.querySelector('._qE').textContent = '100%';
}

let quests = [...Qs.quests.values()].filter(x => x.userStatus?.enrolledAt && !x.userStatus?.completedAt && new Date(x.config.expiresAt).getTime() > Date.now() && st.find(y => Object.keys((x.config.taskConfig ?? x.config.taskConfigV2).tasks).includes(y)));
let isApp = typeof DiscordNative !== "undefined";

if (quests.length === 0) {
  qL.innerHTML = `
    <div class="_e1">
      <svg class="_e1-i" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
      <div class="_e1-t">nenhuma missão ativa encontrada</div>
    </div>
  `;
  aL("Nenhuma missão ativa encontrada.", true);
} else {
  aL(`Encontradas ${quests.length} missões.`);

  let doJob = function () {
    const q = quests.pop();
    if (!q) {
      aL("Todas as missões foram processadas.", true);
      return;
    }

    const pid = Math.floor(Math.random() * 30000) + 1000;
    const appId = q.config.application.id;
    const appName = q.config.application.name;
    const qName = q.config.messages.questName;
    const tCfg = q.config.taskConfig ?? q.config.taskConfigV2;
    const tName = st.find(x => tCfg.tasks[x] != null);
    const sNeed = tCfg.tasks[tName].target;
    let sDone = q.userStatus?.progress?.[tName]?.value ?? 0;

    cQ(q.id, qName);
    uQ(q.id, sDone, sNeed);
    aL(`Iniciando: ${qName}`);

    if (tName === "WATCH_VIDEO" || tName === "WATCH_VIDEO_ON_MOBILE") {
      const maxF = 10, spd = 7, intv = 1;
      const enr = new Date(q.userStatus.enrolledAt).getTime();
      let comp = false;
      let fn = async () => {
        while (true) {
          const maxA = Math.floor((Date.now() - enr) / 1000) + maxF;
          const diff = maxA - sDone;
          const ts = sDone + spd;
          if (diff >= spd) {
            const res = await api.post({ url: `/quests/${q.id}/video-progress`, body: { timestamp: Math.min(sNeed, ts + Math.random()) } });
            comp = res.body.completed_at != null;
            sDone = Math.min(sNeed, ts);
            uQ(q.id, sDone, sNeed);
          }
          if (ts >= sNeed) break;
          await new Promise(r => setTimeout(r, intv * 1000));
        }
        if (!comp) await api.post({ url: `/quests/${q.id}/video-progress`, body: { timestamp: sNeed } });
        cU(q.id);
        aL(`Concluído: ${qName}`, true);
        doJob();
      };
      fn();
    } else if (tName === "PLAY_ON_DESKTOP") {
      if (!isApp) {
        aL(`Erro: Use o App Desktop para ${qName}.`);
        doJob();
      } else {
        api.get({ url: `/applications/public?application_ids=${appId}` }).then(res => {
          const aD = res.body[0];
          const exN = aD.executables?.find(x => x.os === "win32")?.name?.replace(">", "") ?? aD.name.replace(/[\/\\:*?"<>|]/g, "");
          const fG = { cmdLine: `C:\\Program Files\\${aD.name}\\${exN}`, exeName: exN, exePath: `c:/program files/${aD.name.toLowerCase()}/${exN}`, hidden: false, isLauncher: false, id: appId, name: aD.name, pid, pidPath: [pid], processName: aD.name, start: Date.now() };
          const rG = Rg.getRunningGames();
          const fGs = [fG];
          const rGet = Rg.getRunningGames;
          const rPid = Rg.getGameForPID;
          Rg.getRunningGames = () => fGs;
          Rg.getGameForPID = (p) => fGs.find(x => x.pid === p);
          Fd.dispatch({ type: "RUNNING_GAMES_CHANGE", removed: rG, added: [fG], games: fGs });

          let fn = d => {
            let pr = q.config.configVersion === 1 ? d.userStatus.streamProgressSeconds : Math.floor(d.userStatus.progress.PLAY_ON_DESKTOP.value);
            uQ(q.id, pr, sNeed);
            if (pr >= sNeed) {
              cU(q.id);
              aL(`Concluído: ${qName}`, true);
              Rg.getRunningGames = rGet;
              Rg.getGameForPID = rPid;
              Fd.dispatch({ type: "RUNNING_GAMES_CHANGE", removed: [fG], added: [], games: [] });
              Fd.unsubscribe("QUESTS_SEND_HEARTBEAT_SUCCESS", fn);
              doJob();
            }
          };
          Fd.subscribe("QUESTS_SEND_HEARTBEAT_SUCCESS", fn);
          aL(`Spoofing App: ${appName} (${Math.ceil((sNeed - sDone) / 60)} min)`);
        });
      }
    } else if (tName === "STREAM_ON_DESKTOP") {
      if (!isApp) {
        aL(`Erro: Use o App Desktop para ${qName}.`);
        doJob();
      } else {
        let rF = As.getStreamerActiveStreamMetadata;
        As.getStreamerActiveStreamMetadata = () => ({ id: appId, pid, sourceName: null });
        let fn = d => {
          let pr = q.config.configVersion === 1 ? d.userStatus.streamProgressSeconds : Math.floor(d.userStatus.progress.STREAM_ON_DESKTOP.value);
          uQ(q.id, pr, sNeed);
          if (pr >= sNeed) {
            cU(q.id);
            aL(`Concluído: ${qName}`, true);
            As.getStreamerActiveStreamMetadata = rF;
            Fd.unsubscribe("QUESTS_SEND_HEARTBEAT_SUCCESS", fn);
            doJob();
          }
        };
        Fd.subscribe("QUESTS_SEND_HEARTBEAT_SUCCESS", fn);
        aL(`Spoofing Stream: ${appName} (Precisa de 1 pessoa na call)`);
      }
    } else if (tName === "PLAY_ACTIVITY") {
      const cId = Cs.getSortedPrivateChannels()[0]?.id ?? Object.values(Gs.getAllGuilds()).find(x => x != null && x.VOCAL.length > 0).VOCAL[0].channel.id;
      const sKey = `call:${cId}:1`;
      let fn = async () => {
        while (true) {
          const res = await api.post({ url: `/quests/${q.id}/heartbeat`, body: { stream_key: sKey, terminal: false } });
          const pr = res.body.progress.PLAY_ACTIVITY.value;
          uQ(q.id, pr, sNeed);
          await new Promise(r => setTimeout(r, 20 * 1000));
          if (pr >= sNeed) {
            await api.post({ url: `/quests/${q.id}/heartbeat`, body: { stream_key: sKey, terminal: true } });
            break;
          }
        }
        cU(q.id);
        aL(`Concluído: ${qName}`, true);
        doJob();
      };
      fn();
    }
  };
  doJob();
}
