const express = require('express');
const axios = require('axios');
const app = express();

app.use(express.json());

const apiKey = "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"; // Substitua pela sua chave da OpenAI

app.post('/api/chat', async (req, res) => {
    const { prompt } = req.body;

    if (!prompt) {
        return res.status(400).json({ error: "Prompt não fornecido" });
    }

    try {
        const response = await axios.post('https://api.openai.com/v1/chat/completions', {
            model: "gpt-3.5-turbo",
            messages: [
                { role: "system", content: "Você é um NPC amigável no Roblox. Responda de forma curta e divertida!" },
                { role: "user", content: prompt }
            ],
            max_tokens: 50,
            temperature: 0.7
        }, {
            headers: {
                'Authorization': `Bearer ${apiKey}`,
                'Content-Type': 'application/json'
            }
        });

        const reply = response.data.choices[0].message.content;
        res.json({ reply });
    } catch (error) {
        console.error("Erro na API da OpenAI:", error.message);
        res.status(500).json({ error: "Erro ao conectar com a API da OpenAI" });
    }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
});
