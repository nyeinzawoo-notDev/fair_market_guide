# 📖 Fair Market Guide API Documentation

ဤစာရွက်စာတမ်းသည် Fair Market Guide မိုဘိုင်းအက်ပ်နှင့် အခြားဝန်ဆောင်မှုများမှ အသုံးပြုသော Backend API Endpoints များကို အသေးစိတ် ဖော်ပြထားသည်။

## 🌐 Base URL

API Endpoints များအားလုံးကို အောက်ပါ Base URL မှ စတင် အသုံးပြုရမည်-

```

[https://api.fairmarketguide.com/v1](https://api.fairmarketguide.com/v1)

# (သို့) သင့် Server ၏ URL နှင့် Port: http://localhost:3000/api

```
*(မှတ်ချက်: Production Environment အတွက် `https` ကို အသုံးပြုသင့်ပါသည်။)*

## 🔑 Authentication

ထုတ်ကုန်မှတ်ပုံတင်ခြင်းနှင့် sensitive ဖြစ်သော Endpoints အများစုသည် JWT (JSON Web Token) ကို အသုံးပြု၍ ခွင့်ပြုချက် (Authentication) လိုအပ်ပါသည်။ Token ကို Request ၏ Header တွင် အောက်ပါအတိုင်း ထည့်သွင်းရမည်-

```

Authorization: Bearer \<your\_jwt\_token\>

````

---

## ⚡ Endpoints Summary

| Endpoint | Method | Description | Authentication |
| :--- | :--- | :--- | :--- |
| `/products/:qrCode` | `GET` | QR Code ဖြင့် ထုတ်ကုန်အချက်အလက်နှင့် ဈေးနှုန်းခွဲခြမ်းစိတ်ဖြာချက်ကို ရယူသည်။ | NO |
| `/products` | `POST` | ထုတ်ကုန်အသစ်ကို မှတ်ပုံတင်သည်။ | YES (Producer Role) |
| `/products/nearby/:radius` | `GET` | သတ်မှတ်ထားသော တည်နေရာပတ်ဝန်းကျင်ရှိ ထုတ်လုပ်သူများကို ရှာဖွေသည်။ | NO |
| `/prices` | `GET` | ဒေသအလိုက် ဈေးနှုန်းဒေတာများကို ရယူသည်။ | NO |
| `/sms/webhook` | `POST` | SMS Gateway မှ ပေးပို့သော မက်ဆေ့ချ်များကို လက်ခံရယူပြီး အကြောင်းပြန်သည်။ | NO (Webhook Secret Key ဖြင့် စစ်ဆေးရန်) |
| `/health` | `GET` | API Server ၏ Status ကို စစ်ဆေးသည်။ | NO |

---

## 📋 Detail Endpoints

### 1. Products

#### 1.1 Get Product by QR Code (ထုတ်ကုန်အချက်အလက်)

* **Endpoint:** `/api/products/:qrCode`
* **Method:** `GET`
* **Parameters:**
    * `qrCode`: ထုတ်ကုန်၏ QR Code (e.g., `FMG001`)

**Response (200 OK):**
```json
{
  "success": true,
  "product": {
    "id": 1,
    "qr_code": "FMG001",
    "product_name": "စပါး",
    "producer_name": "ဦးဘကြီး",
    "production_cost": 1500,
    "production_date": "2024-01-15",
    "producer_location": {
      "longitude": 96.129,
      "latitude": 16.802
    }
  },
  "price_breakdown": {
    "producer_price": 1500,
    "transport_cost": 300,
    "wholesale_margin": 400,
    "final_price": 2500
  },
  "journey": [
    {
        "stage": "production",
        "actor_name": "ဦးဘကြီး",
        "cost_added": 1500,
        "timestamp": "2024-01-15T10:00:00Z"
    }
    // ... subsequent stages
  ]
}
````

#### 1.2 Create New Product (ထုတ်ကုန်အသစ် မှတ်ပုံတင်ခြင်း)

  * **Endpoint:** `/api/products`
  * **Method:** `POST`
  * **Authentication:** YES (Producer/Admin)

**Request Body:**

```json
{
  "product_name": "စပါး",
  "producer_name": "ဦးဘကြီး",
  "production_cost": 1500,
  "latitude": 16.802,
  "longitude": 96.129
}
```

**Response (201 Created):**

```json
{
  "success": true,
  "product": {
    "id": 4,
    "qr_code": "FMG1705391983...",
    "product_name": "စပါး",
    // ...
  },
  "message": "Product registered successfully"
}
```

#### 1.3 Get Nearby Producers (အနီးအနား ထုတ်လုပ်သူများ)

  * **Endpoint:** `/api/products/nearby/:radius`
  * **Method:** `GET`
  * **Parameters:**
      * `radius`: ကီလိုမီတာဖြင့် သတ်မှတ်ထားသော အချင်းဝက် (e.g., `10` km)
  * **Query Parameters:**
      * `lat`: လက်ရှိတည်နေရာ၏ လတ္တီတွဒ် (e.g., `16.802`)
      * `lon`: လက်ရှိတည်နေရာ၏ လောင်ဂျီတွဒ် (e.g., `96.129`)

**Response (200 OK):**

```json
{
  "success": true,
  "producers": [
    {
      "product_name": "စပါး",
      "producer_name": "ဦးဘကြီး",
      "production_cost": 1500,
      "distance_km": 1.54 
    },
    // ...
  ],
  "count": 20
}
```

-----

### 2\. Price Data

#### 2.1 Get Price Data (ဈေးနှုန်းဒေတာ ရယူခြင်း)

  * **Endpoint:** `/api/prices`
  * **Method:** `GET`
  * **Query Parameters:**
      * `product_name`: ကုန်ပစ္စည်းအမည် (e.g., `စပါး`) (Optional)
      * `region`: ဒေသ (e.g., `ရန်ကုန်`) (Optional)
      * `date`: နေ့စွဲ (e.g., `2024-01-15`) (Optional)

**Response (200 OK):**

```json
{
  "success": true,
  "data": [
    {
      "product_name": "စပါး",
      "region": "ရန်ကုန်",
      "producer_price": 1500,
      "consumer_price": 2500,
      "date": "2024-01-15"
    },
    // ...
  ]
}
```

-----

### 3\. SMS Integration

#### 3.1 SMS Webhook

  * **Endpoint:** `/api/sms/webhook`
  * **Method:** `POST`
  * **Description:** SMS Gateway (e.g., Twilio, Local SMS Provider) မှ ဝင်လာသော မက်ဆေ့ချ်များကို လက်ခံသည်။ ဤ Endpoint သည် စာသားကို ခွဲခြမ်းစိတ်ဖြာကာ သင့်လျော်သော အကြောင်းပြန်စာကို ပေးပို့မည်။

**Request Body Example (SMS Provider ပေါ်မူတည်၍ ပြောင်းလဲနိုင်):**

```json
{
  "from": "+959123456789",
  "message": "PRICE စပါး",
  "to": "+95987654321",
  "timestamp": "..."
}
```

  * `message`: စာသားပုံစံမှာ `COMMAND [Argument1] [Argument2]` ဖြစ်သည်။ (ဥပမာ: `PRICE စပါး`, `REG ပဲမျိုးစုံ 50kg`)

-----

## 🚨 Error Responses

API မှ ပြန်လည်ဖြေကြားသော Error များသည် HTTP Status Code များအပြင်၊ အောက်ပါ JSON ပုံစံကိုလည်း လိုက်နာပါသည်-

```json
{
  "error": "Error Type (e.g., ValidationError, NotFound)",
  "message": "Human readable error message (e.g., Provided QR code is invalid)"
}
```

### Common HTTP Status Codes

| Code | Meaning | Description |
| :--- | :--- | :--- |
| `200` | OK | Request အောင်မြင်ပြီး ဒေတာများ ပြန်ပို့သည်။ |
| `201` | Created | Resource အသစ်ကို အောင်မြင်စွာ ဖန်တီးလိုက်ပြီ။ |
| `400` | Bad Request | Request Body သို့မဟုတ် Query Parameters များ မှားယွင်းနေသည်။ |
| `401` | Unauthorized | Authentication Token မပါဝင်ခြင်း သို့မဟုတ် မမှန်ကန်ခြင်း။ |
| `404` | Not Found | တောင်းဆိုသော Resource ကို ရှာမတွေ့ခြင်း။ |
| `429` | Too Many Requests | Rate Limit ကန့်သတ်ချက်ကို ကျော်လွန်သွားခြင်း။ |
| `500` | Internal Server Error | Server ဘက်တွင် မမျှော်လင့်ထားသော အမှားတစ်ခု ဖြစ်ပေါ်ခြင်း။ |

```

ဤဖိုင်ကို `docs/api/README.md` အဖြစ် GitHub Repository တွင် တင်နိုင်ပါသည်။

အခြားသော Documentation ဖိုင်များ (ဥပမာ: Setup Guides, Testing Procedures) ကိုပါ ရေးသားပေးစေလိုပါက ဆက်လက်ပြောကြားနိုင်ပါသည်။
```
