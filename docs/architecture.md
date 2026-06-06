# Rhythma — System Architecture

## Overview

Rhythma follows an **offline-first, privacy-first** architecture designed for low-connectivity environments in tier-2 and tier-3 India.

```
┌────────────────────────────────────────────────────────────────┐
│                        Flutter App                              │
│                                                                 │
│  ┌──────────┐  ┌──────────┐  ┌───────────┐  ┌─────────────┐   │
│  │   Home   │  │  Cycle   │  │ Assistant │  │  Insights   │   │
│  └──────────┘  └──────────┘  └───────────┘  └─────────────┘   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  Hive (Local Storage) ← AES-256 encrypted               │   │
│  └──────────────────────────┬────────────────────────────┘   │
│                             │ sync (when online)              │
└─────────────────────────────┼───────────────────────────────┘
                              │
                    ┌─────────▼──────────┐
                    │   FastAPI Backend   │
                    │                    │
                    │ /assistant ──► Gemini API
                    │ /cycle     ──► Firestore
                    │ /insights  ──► XGBoost + LR models
                    │ /sms       ──► Twilio
                    └────────────────────┘
```

## Data Flow

### Offline Mode
1. User logs cycle data / symptoms → stored in Hive (encrypted locally)
2. CVI / MHS scores computed on-device
3. AI assistant queries cached or gracefully degraded

### Online Mode
1. Hive data syncs to Firestore when connectivity detected
2. Gemini API handles multilingual assistant queries via FastAPI
3. Twilio dispatches weekly SMS summaries

## Privacy Design

- All health data encrypted with AES-256 before being written to Hive
- No data leaves the device unless user explicitly enables cloud sync
- Firestore security rules restrict read/write to authenticated user's own documents
- Backend never stores raw health data in logs

## ML Models

| Model | Purpose | Training Data |
|-------|---------|---------------|
| XGBoost | Cycle Variability Index (CVI) — 0–100 score | Synthetic + anonymized cycle datasets |
| Logistic Regression | Menstrual Health Score (MHS) — 0–100 score | Multi-factor wellness inputs |

Models are exported via `joblib` and bundled for on-device inference (planned: TFLite conversion for Flutter).

## Planned: WhatsApp Integration

```
User (WhatsApp) ──► Twilio / Meta Cloud API ──► FastAPI webhook
                                                      │
                                               Gemini API (multilingual)
                                                      │
                                              Response back to user
```
