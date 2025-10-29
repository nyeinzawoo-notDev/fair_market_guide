# 🌾 Fair Market Guide - ကျေးလက်ဒေသ ဈေးကွက်ပွင့်လင်းမြင်သာရေး မိုဘိုင်းအက်ပ်စီမံကိန်း

> ကျေးလက်ဒေသမှ **ထုတ်လုပ်သူများ အရှုံးပေါ်ပြီး စားသုံးသူများ ဈေးနှုန်းမြင့်မားစွာ ပေးနေရသည့် ပြဿနာ** ကို ဖြေရှင်းရန် ဒီဇိုင်းဆွဲထားသော မိုဘိုင်းအက်ပ်နှင့် API စီမံကိန်းဖြစ်သည်။ ထုတ်ကုန်၏ ခရီးစဉ် (Traceability) နှင့် ဈေးနှုန်းခွဲခြမ်းစိတ်ဖြာချက် (Price Breakdown) များကို မြင်သာစေရန် ရည်ရွယ်သည်။

## ✨ အဓိက လုပ်ဆောင်ချက်များ

* **ထုတ်ကုန်လမ်းကြောင်း (Traceability):** QR Code ဖြင့် ကုန်ပစ္စည်း၏ မူလအစ၊ ထုတ်လုပ်သူ၊ ကုန်ကျစရိတ်နှင့် လက်ရှိဈေးနှုန်း အချက်အလက်များကို ကြည့်ရှုနိုင်သည်။
* **ဈေးနှုန်း နှိုင်းယှဉ်ချက်:** ဒေသအလိုက် ထုတ်လုပ်သူဈေးနှုန်းနှင့် လက်လီဈေးနှုန်းများကို နှိုင်းယှဉ် ဖော်ပြခြင်း။
* **SMS Integration:** အင်တာနက်အသုံးပြုရန် ခက်ခဲသော ကျေးလက်ဒေသများအတွက် SMS ဖြင့် ဈေးနှုန်းမေးမြန်းခြင်းနှင့် ထုတ်ကုန်မှတ်ပုံတင်ခြင်း။
* **Geolocation (PostGIS):** ထုတ်လုပ်သူတည်နေရာနှင့် အနီးအနားမှ ကုန်ပစ္စည်းများကို ရှာဖွေခြင်း။

---

## 🚀 Quick Start

### Prerequisites

ဤပရောဂျက်ကို စတင်အသုံးပြုရန် အောက်ပါတို့ကို ထည့်သွင်းထားရန် လိုအပ်သည်-

* **Flutter** `3.0+`
* **Node.js** `16+`
* **PostgreSQL** `13+`
* **PostGIS** extension (Database အတွက်)

### Installation

Repository ကို Clone ဆွဲခြင်းဖြင့် စတင်ပါ-

```bash
# Clone repository
git clone [https://github.com/your-username/fair-market-guide.git](https://github.com/your-username/fair-market-guide.git)
cd fair-market-guide
````

#### ⚙️ Backend Setup (Node.js/Express)

```bash
cd backend
npm install
cp .env.example .env
# .env ဖိုင်ထဲတွင် သင့်၏ Database အချက်အလက်များဖြင့် ဖြည့်စွက်ပါ။
```

#### 🗃️ Database Setup

PostgreSQL ကို အသုံးပြုပြီး `schema.sql` ဖိုင်ကို run ပါ။

```bash
# PostgreSQL သို့ ဝင်ရောက်ပြီး PostGIS extension ကို enable လုပ်ရန်နှင့် schema.sql ကို run ရန်
psql -U postgres -f database/schema.sql
# မှတ်ချက်: PostGIS ကို manually enable လုပ်ရန် လိုအပ်နိုင်သည်။ (e.g., CREATE EXTENSION postgis;)
```

#### 📱 Frontend Setup (Flutter)

```bash
cd ../frontend
flutter pub get
```

### Running the Application

```bash
# 1. Start Backend API
cd backend
npm start &

# 2. Start Flutter Mobile App (Emulator/Device ပေါ်တွင်)
cd ../frontend
flutter run
```

-----

## 📁 Project Structure

ပရောဂျက်ကို `frontend` (Flutter) နှင့် `backend` (Node.js) ဟူ၍ ခွဲခြားထားသည်-

```
fair-market-guide/
├── 📱 frontend/              # Flutter Mobile Application
│   ├── lib/
│   │   ├── models/           # Data models (ထုတ်ကုန်၊ ဈေးနှုန်း)
│   │   ├── services/         # API ခေါ်ဆိုမှုများနှင့် QR/Location ဝန်ဆောင်မှုများ
│   │   ├── screens/          # App မျက်နှာပြင်များ (Home, ProductDetail)
│   │   └── main.dart         # App စတင်ရာ
├── ⚙️ backend/               # Node.js Backend API
│   ├── src/
│   │   ├── controllers/      # Route logic
│   │   ├── routes/           # API routes (/api/products, /api/prices, /api/sms)
│   │   └── app.js            # Server entry point
│   └── .env.example          # Environment variable ပုံစံ
├── 🗃️ database/             # Database Schemas
│   └── schema.sql            # Main database schema (PostGIS ပါဝင်)
└── 📚 docs/                  # Documentation
    └── api/README.md         # API Documentation
```

-----

## 🗃️ Database Schema

PostgreSQL နှင့် PostGIS ကို အသုံးပြုထားသော Core Tables များ-

```sql
-- Products Table (ထုတ်လုပ်သူ အချက်အလက်)
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    qr_code VARCHAR(100) UNIQUE NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    producer_name VARCHAR(100) NOT NULL,
    production_cost DECIMAL(10,2),
    producer_location GEOGRAPHY(Point), -- PostGIS: ထုတ်လုပ်သူ တည်နေရာ
    -- ...
);

-- Product Journey Table (ဈေးနှုန်းခရီးစဉ်မှတ်တမ်း/Blockchain Alternative)
CREATE TABLE product_journey (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    stage VARCHAR(50) NOT NULL, -- (production, transport, wholesale, retail)
    cost_added DECIMAL(10,2) DEFAULT 0,
    current_hash VARCHAR(64) NOT NULL, -- Data Integrity စစ်ဆေးရန်
    -- ...
);

-- Price Data Table (ဈေးနှုန်း နှိုင်းယှဉ်ရန်)
CREATE TABLE price_data (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    producer_price DECIMAL(10,2),
    consumer_price DECIMAL(10,2),
    date DATE NOT NULL,
    -- ...
);

-- SMS users Table (SMS အသုံးပြုသူများ)
CREATE TABLE sms_users (
    id SERIAL PRIMARY KEY,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    user_type VARCHAR(20), -- (producer, consumer)
    -- ...
);
```

-----

## 📱 Flutter Frontend Code (အကျဉ်း)

`frontend/lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:fair_market_guide/screens/home_screen.dart';

void main() {
  runApp(FairMarketApp());
}

class FairMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'တရားမျှတသော ဈေးကွက်လမ်းညွှန်',
      theme: ThemeData(
        primaryColor: Colors.green,
        fontFamily: 'Pyidaungsu', // မြန်မာစာလုံး Pyidaungsu အသုံးပြု
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

`frontend/lib/screens/home_screen.dart` (QR Scanner/Price Comparison မျက်နှာပြင်)

```dart
// ... imports
class HomeScreen extends StatelessWidget {
  // ... services and build method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( /* ... */ ),
      body: Column(
        children: [
          // QR Scan Section (Scan လုပ်ရန် ခလုတ်)
          Expanded( /* ... */ ), 
          // Price Comparison Section (ဈေးနှုန်း နှိုင်းယှဉ်ရန် ခလုတ်)
          Expanded( /* ... */ ), 
          // SMS Access Section (SMS အသုံးပြုရန် ညွှန်ကြားချက်)
          Expanded( /* ... */ ), 
        ],
      ),
    );
  }

  // void _scanQRCode(BuildContext context) { ... }
  // void _openSMSDialog(BuildContext context) { ... }
}
```

-----

## ⚙️ Backend API Code (အကျဉ်း)

`backend/src/app.js` (Server စတင်ရာ)

```javascript
const express = require('express');
// ... other imports (cors, helmet, rateLimit, dotenv)
const { Pool } = require('pg'); 

const app = express();

// ... Middleware Setup

// Database Connection
const pool = new Pool({ /* ... config from .env */ });

// Routes
app.use('/api/products', require('./routes/products'));
app.use('/api/prices', require('./routes/prices'));
app.use('/api/sms', require('./routes/sms')); // SMS Webhook အတွက်

// ... Error Handling / 404 / Server Listen
```

`backend/src/routes/products.js` (ထုတ်ကုန် Routes)

```javascript
const express = require('express');
// ...
const router = express.Router();

// Get product by QR code
router.get('/:qrCode', async (req, res) => {
  // SQL Query to join products and product_journey tables by qr_code
  // AND use PostGIS to get location coordinates
  // ...
});

// Create new product (ထုတ်လုပ်သူ မှတ်ပုံတင်ခြင်း)
router.post('/', async (req, res) => {
  // Use ST_MakePoint for PostGIS location storage
  // ...
});

// Get nearby producers (အနီးအနားရှိ ထုတ်လုပ်သူများ)
router.get('/nearby/:radius', async (req, res) => {
  // Use PostGIS ST_DWithin and ST_Distance functions
  // ...
});

module.exports = router;
```

-----

## 📚 Documentation & Deployment

### API Documentation

API Endpoint အချက်အလက်များကို အသေးစိတ် သိရှိလိုပါက [docs/api/README.md](./api/README.md) တွင် ဖတ်ရှုနိုင်ပါသည်။

### 🚀 Deployment (Production)

Backend ကို PM2 ဖြင့် စီမံခန့်ခွဲခြင်း-

```bash
# Install PM2
npm install -g pm2

# Start application with PM2
pm2 start backend/src/app.js --name "fair-market-api"

# Save PM2 configuration
pm2 save
# pm2 startup
```

-----

## 🤝 Contributing

ဤပရောဂျက်တွင် ပူးပေါင်းပါဝင်လိုပါက [CONTRIBUTING.md](../CONTRIBUTING.md) တွင် ဖော်ပြထားသော လမ်းညွှန်ချက်များကို ဖတ်ရှုပြီး Pull Request ပေးပို့နိုင်ပါသည်။

## 📄 License

ဤပရောဂျက်ကို **MIT License** ဖြင့် ထုတ်ဝေထားပါသည်။ အသေးစိတ်ကို [LICENSE.md](../LICENSE.md) တွင် ကြည့်ရှုပါ။

## 🙏 Acknowledgments

  * Myanmar Unicode and Font support (Pyidaungsu)
  * Rural development organizations
  * Open source community contributors

<!-- end list -->

```
```
