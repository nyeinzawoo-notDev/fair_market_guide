# 🌾 Fair Market Guide - ကျေးလက်ဒေသ ဈေးကွက်ပွင့်လင်းမြင်သာရေး မိုဘိုင်းအက်ပ်စီမံကိန်း

\!

## 📋 Project Overview

ကျေးလက်ဒေသမှ ထုတ်လုပ်သူများ အရှုံးပေါ်ပြီး စားသုံးသူများ ဈေးမြင့်ပေးနေရသည့် **ဈေးကွက်ပွင့်လင်းမြင်သာမှုမရှိသည့် ပြဿနာ**ကို ဖြေရှင်းရန် ဒီဇိုင်းဆွဲထားသော မိုဘိုင်းအက်ပ်စီမံကိန်းဖြစ်သည်။ ဤအက်ပ်သည် ထုတ်ကုန်၏ မူလအစ၊ ထုတ်လုပ်စရိတ်နှင့် လက်လီဈေးနှုန်း ခရီးစဉ်များကို စားသုံးသူများအား QR Code စနစ်ဖြင့် ဖော်ပြပေးမည်ဖြစ်ပြီး၊ ဒေသတွင်း ဈေးနှုန်းနှိုင်းယှဉ်ချက်များကိုပါ သိရှိစေမည်။

### ✨ Core Features (အဓိကလုပ်ဆောင်ချက်များ)

  * **ထုတ်ကုန်ခြေရာခံခြင်း (Traceability):** QR Code ဖြင့် ကုန်ပစ္စည်း၏ မူလထုတ်လုပ်သူမှ စားသုံးသူလက်သို့ ရောက်ရှိသည်အထိ အဆင့်ဆင့်သော ကုန်ကျစရိတ်များကို စစ်ဆေးနိုင်ခြင်း။
  * **ဈေးနှုန်းနှိုင်းယှဉ်ချက် (Price Comparison):** ဒေသအလိုက် ထုတ်လုပ်သူရရှိသည့်ဈေးနှုန်းနှင့် စားသုံးသူပေးရသည့်ဈေးနှုန်း ကွာခြားချက်များကို ဖော်ပြခြင်း။
  * **SMS စနစ်ဖြင့် အသုံးပြုနိုင်ခြင်း (SMS Access):** အင်တာနက် သို့မဟုတ် စမတ်ဖုန်းမရှိသည့် ကျေးလက်ဒေသမှ ထုတ်လုပ်သူများ ဈေးနှုန်းထည့်သွင်းခြင်းနှင့် မေးမြန်းခြင်းများကို SMS ဖြင့် လုပ်ဆောင်နိုင်ခြင်း။
  * **တည်နေရာအခြေပြု အချက်အလက် (Geo-Spatial Data):** PostGIS ကို အသုံးပြု၍ ထုတ်လုပ်သူများ၏ တည်နေရာကို မှတ်သားနိုင်ခြင်း။

-----

## 🚀 Quick Start (အမြန်စတင်အသုံးပြုရန်)

### Prerequisites (လိုအပ်ချက်များ)

ဤစီမံကိန်းကို run ရန် အောက်ပါပတ်ဝန်းကျင်များ လိုအပ်ပါသည်။

  * **Flutter 3.0+**
  * **Node.js 16+**
  * **PostgreSQL 13+** (အထူးသဖြင့် **PostGIS extension** ကို ဖွင့်ထားရန် လိုအပ်သည်)

### Installation (စနစ်ထည့်သွင်းခြင်း)

```bash
# Clone repository
git clone https://github.com/your-username/fair-market-guide.git
cd fair-market-guide

# 1. Backend Setup
cd backend
npm install
cp .env.example .env
# Configure .env file with your PostgreSQL database credentials

# 2. Database Setup (Database ထဲသို့ Schema နှင့် Sample Data များထည့်သွင်းခြင်း)
# PostGIS extension ကို ဖွင့်ထားရန် သေချာပါစေ။
psql -U postgres -f ../docs/database/schema.sql

# 3. Frontend Setup
cd ../frontend
flutter pub get
```

### Running the Application (အက်ပ်ပလီကေးရှင်းကို စတင်ခြင်း)

```bash
# 1. Start backend API Server
cd backend
npm start

# 2. Start frontend Mobile Application (Emulator သို့မဟုတ် Device တွင်)
cd ../frontend
flutter run
```

-----

## 📁 Project Structure (ပရောဂျက်ဖွဲ့စည်းပုံ)

```
fair-market-guide/
├── 📱 frontend/                     # Flutter Mobile Application
│   ├── lib/
│   │   ├── screens/                # App screens (e.g., home_screen.dart)
│   │   ├── services/               # API calls & utilities (e.g., qr_service.dart)
│   └── pubspec.yaml                # Flutter dependencies (includes Pyidaungsu font)
├── ⚙️ backend/                      # Node.js Backend API
│   ├── src/
│   │   ├── controllers/            # Route controllers
│   │   ├── routes/                 # API routes (e.g., products.js, prices.js)
│   │   └── app.js                  # App entry point
│   └── .env.example                # Environment variables
├── 🗃️ database/                   # Database schemas & migrations
│   └── schema.sql                  # Main database schema (with PostGIS)
└── 📚 docs/                        # Documentation (API, Setup)
```

## 🔐 Configuration (တည်ဆောက်ပုံဆိုင်ရာများ)

### Database Schema (အဓိက Table များ)

| Table Name | အဓိက လုပ်ဆောင်ချက် |
| :--- | :--- |
| **`products`** | ကုန်ပစ္စည်း၏ မူလထုတ်လုပ်မှုအချက်အလက်နှင့် တည်နေရာ (PostGIS)။ |
| **`product_journey`** | ထုတ်ကုန်၏ ဈေးနှုန်းနှင့် တန်ဖိုးတိုးလာမှု (Cost Added) အဆင့်ဆင့်ကို မှတ်တမ်းတင်ခြင်း (Blockchain-like Hash ပါဝင်)။ |
| **`price_data`** | ဒေသအလိုက် ကုန်ပစ္စည်းဈေးနှုန်း နှိုင်းယှဉ်အချက်အလက်များ။ |

### Backend API Endpoints (အဓိက API များ)

| Method | Endpoint | ဖော်ပြချက် |
| :--- | :--- | :--- |
| `GET` | `/api/products/:qrCode` | QR Code ဖြင့် ကုန်ပစ္စည်းအသေးစိတ်နှင့် ဈေးနှုန်းခရီးစဉ်ကို ရယူခြင်း။ |
| `POST`| `/api/products` | ကုန်ပစ္စည်းအသစ် မှတ်ပုံတင်ခြင်း။ |
| `GET` | `/api/products/nearby/:radius` | သတ်မှတ်ထားသော အချင်းဝက်အတွင်းရှိ ထုတ်လုပ်သူများကို ရှာဖွေခြင်း။ |
| `POST`| `/api/sms/webhook` | SMS ပေးပို့မှုများအတွက် ဝင်ပေါက် (ဈေးနှုန်းစစ်ခြင်း၊ မှတ်ပုံတင်ခြင်း)။ |

-----

## 🤝 Contributing (ပူးပေါင်းပါဝင်ခြင်း)

ဤစီမံကိန်းသည် ကျေးလက်ဒေသ ဈေးကွက်ပွင့်လင်းမြင်သာရေးအတွက် ရည်ရွယ်ပြီး Open Source ဖြစ်သည့်အတွက် မည်သူမဆို လာရောက် ပူးပေါင်းပါဝင်ကူညီနိုင်ပါသည်။

  * Code ပံ့ပိုးမှုများအတွက် **CONTRIBUTING.md** ကို ဖတ်ရှုပါ။
  * Pull Requests များကို ကြိုဆိုပါသည်။

## 📄 License (လိုင်စင်)

ဤပရောဂျက်သည် **MIT License** အောက်တွင် ထုတ်ဝေထားပါသည်။ အသုံးပြုခြင်း၊ ပြောင်းလဲခြင်းနှင့် ဖြန့်ချိခြင်းတို့ကို လွတ်လပ်စွာ ဆောင်ရွက်နိုင်ပါသည်။ အသေးစိတ်ကို **LICENSE.md** ဖိုင်တွင် ကြည့်ရှုပါ။

-----

## 🙏 Acknowledgments (ဂုဏ်ပြုမှတ်တမ်းတင်ခြင်း)

  * Myanmar Unicode နှင့် Font များအတွက် ပံ့ပိုးကူညီပေးသူများ။
  * ကျေးလက်ဖွံ့ဖြိုးရေး အဖွဲ့အစည်းများ။
  * Open Source Community မှ ပံ့ပိုးကူညီသူများအားလုံး။

-----
