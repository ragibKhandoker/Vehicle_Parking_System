# 🚗 UNI Parking System (Assembly Language)

## 📌 Project Overview

The **UNI Parking System** is a **console-based parking management system** developed in **x86 Assembly Language (MASM/TASM)**.

It simulates a real-world parking system with **Admin and User roles**, allowing vehicle entry, billing, searching, and record management within a limited parking capacity.

---

## ⚙️ Key Features

### 🔐 1. Dual Role Access (Admin & User)

* Role-based system:

  * **Admin Panel**
  * **User Panel**
* Secure Admin login:

  * ID: `66`
  * Password: `6666`
* Prevents unauthorized access

---

### 🚘 2. Smart Vehicle Entry System

* Takes input:

  * Vehicle Number (5 digits)
  * Phone Number (11 digits)
* Supports vehicle types:

  * Bike
  * Car
  * Bus
  * Cycle
* Displays:

  * Parking charge
  * Confirmation message
  * Parking time (1 hour)

---

### 📦 3. Capacity Management

* Maximum capacity: **8 vehicles**
* Displays:

  * ❌ "Parking is Full" when limit reached
* Efficient storage using:

  * Static array (`vehicleList`)

---

### 💰 4. Automated Billing System

| Vehicle Type | Charge |
| ------------ | ------ |
| Bike         | 30     |
| Car          | 50     |
| Bus          | 100    |
| Cycle        | 20     |

* Automatically calculates:

  * Total revenue
  * Individual category counts

---

### 📊 5. Admin Dashboard

Admin can:

* 📋 View full parking records:

  * Total vehicles
  * Total revenue
  * Category-wise counts
* 🔍 Search vehicle by number
* 🗑️ Delete all records (reset system)

---

### 🔍 6. Search Functionality

* Search vehicle using **vehicle number**
* Displays:

  * ✅ Found message
  * ❌ Not found message

---

### 🧹 7. System Reset (Delete Record)

* Clears:

  * All vehicle records
  * Counters
  * Total amount
* Uses:

```asm
rep stosb
```

👉 Efficiently resets memory by filling it with zeros

---

### ⚠️ 8. Error Handling

* Handles:

  * Invalid menu input
  * Login failure
  * Parking full condition
  * Search failure

---

## 🧠 How It Works

### 🔄 Flow:

1. Select user type (Admin/User)
2. Admin logs in securely
3. User enters:

   * Vehicle number
   * Phone number
4. Select vehicle type
5. System:

   * Stores data
   * Calculates charge
   * Updates counters
6. Admin can:

   * View records
   * Search vehicles
   * Reset system

---

## 🏗️ Technical Details

* **Language:** x86 Assembly (MASM/TASM)
* **Architecture:** 16-bit DOS
* **Interrupts Used:**

  * `int 21h` → Input/Output
  * `int 10h` → Screen handling
* **Memory Model:** `.model small`
* **Storage:**

  * Static arrays (no dynamic allocation)

---

## 📂 Data Structures

* `vehicleList` → Stores vehicle numbers
* `vehicleIndex` → Tracks total vehicles
* Counters:

  * `bike`, `car`, `bus_count`, `cycle`
* `amount` → Total revenue

---

## ▶️ How to Run

1. Use **DOSBox** or any DOS emulator
2. Assemble the code:

```
tasm parking.asm
tlink parking.obj
```

3. Run:

```
parking.exe
```

---

## 📷 Sample Output

```
======Welcome to UNI PARKING SYSTEM =====
1. Admin
2. User

Enter your choice: 2

Please enter your vehicle number: 12345
Please enter your phone number: 017XXXXXXXX

***User Menu***
1. Bike
2. Car
3. Bus
4. Cycle

Your parking charge is: 50
Your parking time is 1 hour.
Your vehicle was parked successfully.
```

---

## 🚀 Future Improvements

* Database integration (MySQL/PostgreSQL)
* GUI version (Windows/Linux)
* Online booking system
* Multi-user real-time system
* License plate validation

---

## 👨‍💻 Author

* Your Name

---

## 📄 License

This project is open-source and available under the **MIT License**.

---

## ⭐ Support

If you like this project, give it a ⭐ on GitHub!

---
