const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const OpenAI = require("openai");

require("dotenv").config();

const app = express();
app.use(cors());
app.use(bodyParser.json());

// ------------------------------------
// OPENAI CLIENT
// ------------------------------------
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

// ------------------------------------
// SYSTEM PROMPT — LOGIX AI
// ------------------------------------
const SYSTEM_BEHAVIOR = `
You are LogiX, an AI quiz generator for digital logic.

STRICT RULES:
- Generate EXACTLY 10 multiple-choice questions.
- Questions must be about the specified gate type only.
- Do NOT include other gate types.
- Each question must have exactly 4 choices.
- Choices are labeled by order as A, B, C, D.
- correctAnswer MUST be ONLY ONE LETTER: "A", "B", "C", or "D".
- Do NOT return true/false.
- Do NOT return 0 or 1.
- Output ONLY valid JSON.
- No markdown.
- No explanation.

FORMAT:
{
  "questions": [
    {
      "question": "Question text",
      "choices": [
        "Choice A",
        "Choice B",
        "Choice C",
        "Choice D"
      ],
      "correctAnswer": "A"
    }
  ]
}
`;

// ------------------------------------
// API ROUTE — GENERATE QUIZ
// ------------------------------------
app.post("/api/questions", async (req, res) => {
  try {
    const { gate } = req.body;

    if (!gate) {
      return res.status(400).json({ error: "Gate is required" });
    }

    const prompt = `
Generate 10 multiple choice questions.
- ALL questions must be about ${gate} gates ONLY.
- Each question must have 4 choices (A, B, C, D).
- Provide correct answer letter only.
Return in JSON format:
{
  "questions": [
    {
      "question": "",
      "choices": ["", "", "", ""],
      "correctAnswer": ""
    }
  ]
}
`;

    const response = await openai.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [
  { role: "system", content: SYSTEM_BEHAVIOR },
  { role: "user", content: prompt }
],
    });

  const text = response.choices[0].message.content;

let data;
try {
  data = JSON.parse(text);
} catch (e) {
  console.error("Invalid JSON from OpenAI:", text);
  return res.status(500).json({ error: "Invalid AI response format" });
}

    res.json(data);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to generate quiz" });
  }
});

// ------------------------------------
// SERVER START
// ------------------------------------
const PORT = process.env.PORT || 3000;
app.listen(PORT, "0.0.0.0", () => {
  console.log(`✅ LogiX AI running on port ${PORT}`);
});
