# 🧠 Neuralis 
**AI-powered Parkinson's Disease screening from spiral drawings and voice recordings.**

Neuralis is a full-stack web application that screens for Parkinson's Disease using two independent biomarker channels — hand-drawn spiral analysis (CNN) and voice analysis (custom STRN architecture) — fused into a single weighted risk score.



> ⚠️ **Disclaimer:** Neuralis is a research/educational screening tool, **not a medical device**. It does not diagnose Parkinson's Disease. Always consult a qualified neurologist.

---

## ✨ Features

- ✍️ **Spiral Drawing Analysis** — Upload or draw a spiral; a CNN detects motor-impairment patterns (tremor, micrographia-like distortions)
- 🎙️ **Voice Biomarker Analysis** — Record a sustained phonation in-browser; a custom **STRN** model analyzes 54 acoustic features
- ⚖️ **Fused Risk Score** — Weighted combination of both modalities into a single interpretable result

---

## 🏗️ Architecture

```
Browser (React, Vercel)
   ├── Spiral image (128×128 RGB) ──► Flask API (HF Spaces, Docker)
   │                                     ├── CNN (TensorFlow/Keras) ──► drawing score
   └── Voice (WebM) ──► ffmpeg ──► WAV ──► STRN ensemble ──► voice score
                                              │
                                              ▼
                                    Weighted fusion ──► Risk score + report
```

---

## 🧬 STRN — Spectro-Temporal Resonance Network

A **custom neural architecture built in pure NumPy** (no deep-learning framework), designed for small-data voice biomarker classification.

| Component | Detail |
|---|---|
| Input | 54-dim feature vector (26 base acoustic + 28 engineered features) |
| Key innovation | Learnable **per-neuron threshold τ** (resonance gating) |
| Training | 3-phase: Cohen's d–based initialization → Adam + L2 → CMA-ES fine-tuning |
| Ensemble | 3 members per domain |
| Framework | Pure NumPy |

### 📊 Results

| Model | Metric | Score |
|---|---|---|
| STRN (voice) | Cross-domain mean AUC | **0.972** |
| STRN — UCI PD | AUC | 1.000* |
| STRN — MDVR-KCL | AUC | 0.944 |
| CNN — Spiral | Accuracy | **89.2%** |
| CNN — All drawings (spiral/circle/meander) | Accuracy | 87.3% |



**Datasets:** UCI Parkinson's (195 recordings, 31 subjects) + MDVR-KCL (73 subjects)

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Frontend | React  |
| Backend | Flask REST API |
| Deployment | Docker on Hugging Face Spaces |
| Drawing model | CNN — TensorFlow/Keras, 128×128 RGB input |
| Voice model | STRN — pure NumPy custom architecture |
| Audio pipeline | ffmpeg (WebM → WAV) |

---

## 🚀 Getting Started

### Prerequisites
- Python 3.10+
- Node.js 18+
- ffmpeg installed and on PATH

### Backend
```bash
cd backend
pip install -r requirements.txt
python app.py
# API runs on http://localhost:5000
```

### Frontend
```bash
cd frontend
npm install
npm run dev
```





## 👤 Author

**Janga Dheeraj** — CSE (AI/ML), SRM Institute of Science and Technology
GitHub: [@Dheeraj2105](https://github.com/Dheeraj2105)
