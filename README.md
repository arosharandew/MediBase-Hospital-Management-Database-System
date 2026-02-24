# 🏥 MediBase – Hospital Management Database System

A comprehensive relational database design for a Hospital Management System. This project includes SQL scripts to create tables for patients (inpatient and outpatient), doctors, appointments, treatments, payments, guardians, wards, and rooms, along with sample data and example queries.

The design is fully normalized up to **Third Normal Form (3NF)** and includes an **Enhanced Entity-Relationship Diagram (EERD)** and relational schema.

---

## 📌 Features

- Separate entities for **Inpatients** and **Outpatients** with shared patient details
- Doctor management with specialization and classification (In-house / Consultant)
- Appointment scheduling for outpatients
- Treatment records including dosage, medical condition, and medications
- Payment tracking for both inpatient and outpatient services
- Ward and room allocation system for inpatients
- Guardian management for inpatients
- Many-to-many relationships handled using junction tables
- Fully normalized database schema (1NF, 2NF, 3NF)

---

## 🗄️ Database Schema

The database consists of the following tables:

| Table | Description |
|-------|------------|
| Ward | Hospital wards (e.g., General, ICU) with capacity |
| Room | Rooms within wards (Standard, Deluxe, VIP) |
| Doctor | Doctors' personal and professional details |
| Treatment | Medical treatments with dosage and medication |
| Patient_Inpatient | Admitted patients |
| Patient_Outpatient | Visiting patients |
| Appointment | Outpatient appointments |
| Guardian | Guardians responsible for inpatients |
| Payment | Payment records |
| Doctor_Treat_Inpatient | Junction table for doctors treating inpatients |
| Doctor_Treatment | Junction table for doctors associated with treatments |
| Inpatient_Receive_Treatment | Junction table for inpatient treatments |

---

## 🔗 Entity-Relationship Overview

The Enhanced Entity-Relationship Diagram (EERD) captures:

- A patient is either an **Inpatient** or **Outpatient** (mutually exclusive)
- Inpatients are assigned to one room at a time
- Rooms belong to a ward
- Inpatients can have multiple guardians
- Doctors can treat multiple patients
- Appointments are made by outpatients with specific doctors
- Payments are linked to either inpatient or outpatient
- Many-to-many relationships resolved using junction tables

---

## 📊 Normalization

All tables are normalized up to **Third Normal Form (3NF)**:

- ✔ No repeating groups (1NF)
- ✔ No partial dependencies (2NF)
- ✔ No transitive dependencies (3NF)

This ensures minimal redundancy and improved data integrity.

---

## 🛠️ SQL Scripts

### 1️⃣ Table Creation Example

```sql
CREATE TABLE Patient_Inpatient (
    PatientId INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PatientType VARCHAR(20) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    NIC VARCHAR(15) NOT NULL,
    Telephone VARCHAR(15) NOT NULL,
    AdmissionDateTime DATETIME NOT NULL,
    DischargeDateTime DATETIME,
    RoomId INT,
    PRIMARY KEY (PatientId),
    FOREIGN KEY (RoomId) REFERENCES Room(RoomId)
);
```

---

### 2️⃣ Sample Data Insertion Example

```sql
INSERT INTO Ward (WardId, WardType, WardCapacity) VALUES
(10001, 'General', 30),
(10002, 'ICU', 10),
(10003, 'Surgical', 20),
(10004, 'Maternity', 15),
(10005, 'General', 25);
```

---

### 3️⃣ Example Business Queries

#### ✅ Q1: Resident Cardiologists & Neurologists

```sql
SELECT DoctorFirstName, DoctorLastName, Specialization
FROM Doctor
WHERE Specialization IN ('Cardiology', 'Neurology')
  AND Classification = 'In-house'
  AND DateJoined < '2022-01-01'
ORDER BY DateJoined DESC;
```

---

#### ✅ Q2: Wards with Deluxe Rooms & Availability

```sql
SELECT Ward.WardId, Ward.WardType, Ward.WardCapacity AS AvailableWardCapacity
FROM Ward
INNER JOIN Room ON Ward.WardId = Room.WardId
WHERE Room.RoomType = 'Deluxe'
  AND Ward.WardCapacity > 5;
```

---

#### ✅ Q3: Total Cash Payments for Pediatricians (Last 10 Days)

```sql
SELECT SUM(Payment.Amount) AS TotalCashPayment
FROM Payment
INNER JOIN Patient_Outpatient ON Payment.OutpatientPatientId = Patient_Outpatient.PatientId
INNER JOIN Doctor ON Patient_Outpatient.DoctorId = Doctor.DoctorId
WHERE Payment.PaymentType = 'Cash'
  AND Patient_Outpatient.PatientType = 'Outpatient'
  AND Doctor.Specialization = 'Pediatrics'
  AND (Doctor.DoctorLastName = 'Peterson' OR Doctor.DoctorLastName = 'Fedrick')
  AND Payment.DateTime >= CURDATE() - INTERVAL 10 DAY;
```

---

## 🚀 Getting Started

### Prerequisites

- MySQL or any relational database management system (RDBMS)
- SQL execution tool (MySQL Workbench, CLI, etc.)

### Installation Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/arosharandew/MediBase-Hospital-Management-Database-System.git
   ```

2. Open your SQL tool.

3. Execute `MediBase.sql`.

4. Run the insert statements to populate sample data.

5. Execute the sample queries or create your own.

---

## 📁 File Structure

```
MediBase.sql
README.md
```

---

## 🤝 Contributing

Contributions are welcome!

If you find issues or have improvements:
- Open an issue
- Submit a pull request

---

