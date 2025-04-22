# 🔮 TarotApp

**TarotApp** is a spiritual iOS application designed to provide Tarot card readings, intuitive guidance, and personalized experiences. It offers full deck spreads, multilingual support, sound customization, and a sleek user interface. Upcoming features include a lunar calendar and AI-powered insights.

---

## ✨ Features

### ✅ Implemented:

- 🎴 Full Tarot deck (78 cards) with upright and reversed meanings
- 🌐 Multilingual support: 🇺🇦 Ukrainian, 🇷🇺 Russian, 🇬🇧 English
- 🔊 Background music and sound effects
- 🎚 Adjustable sound and music volume
- 🧠 User preferences stored via `@AppStorage`
- 🎵 SoundManager using `AVFoundation`

---

### 🔮 Coming Soon:

- 🌙 **Lunar calendar** with moon phases and zodiac signs
- ✨ **Lunar-based spreads** with custom interpretations
- 📓 **Reading journal** with notes and history
- 🤖 **AI-powered Tarot interpretations** (using CoreML or ChatGPT API)
- 🧘‍♀️ **Tarot meditations** with sound and visualization
- 🔔 **Daily notifications** with a card of the day

---

## 🛠 Dependencies & Requirements

### 📦 Dependencies:
- [`Firebase`](https://firebase.google.com/) (Auth, Analytics)
- `AVFoundation` (for sound playback)
- `@AppStorage` (via `UserDefaults`)
- SwiftUI

### 📲 Requirements:
- Xcode 15+
- iOS 16.0+
- Swift 5.9+

### 🔌 Before running:
1. Install dependencies via Swift Package Manager (already integrated in Xcode)
2. Ensure Firebase is properly initialized (or comment out if not used yet)
3. Add your `GoogleService-Info.plist` if using Firebase

---

## 🚀 Getting Started

1. Clone the repository:

```bash
git clone https://github.com/totSamyGaspar/whisper.git
```

2.	Open the project in Xcode:
```
open TarotApp.xcodeprojt
```
3.	Run the app on a simulator or physical device.


