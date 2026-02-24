CREATE TABLE Appointment (
    AppointmentId INT NOT NULL,
    DateAndTime VARCHAR(20) NOT NULL,
    DoctorId INT NOT NULL,
    PatientId INT NOT NULL,
    PRIMARY KEY (AppointmentId),
    FOREIGN KEY (PatientId) REFERENCES Patient_Inpatient(PatientId)
);


CREATE TABLE Doctor_Treat_Inpatient (
    DoctorId INT NOT NULL,
    PatientId INT NOT NULL,
    PRIMARY KEY (DoctorId, PatientId),
    FOREIGN KEY (PatientId) REFERENCES patient_inpatient(PatientId),
    FOREIGN KEY (DoctorId) REFERENCES doctor(DoctorId)
);


CREATE TABLE Doctor_Treatment (
    TreatmentId INT NOT NULL,
    DoctorId INT NOT NULL,
    PRIMARY KEY (TreatmentId, DoctorId),
    FOREIGN KEY (TreatmentId) REFERENCES Treatment(TreatmentId),
    FOREIGN KEY (DoctorId) REFERENCES Doctor(DoctorId)
);


CREATE TABLE Doctor (
    DoctorId INT NOT NULL,
    DoctorFirstName VARCHAR(50) NOT NULL,
    DoctorLastName VARCHAR(50) NOT NULL,
    DateJoined DATE NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    Classification VARCHAR(50) NOT NULL,
    PRIMARY KEY (DoctorId)
);


CREATE TABLE Guardian (
    GuardianName VARCHAR(100) NOT NULL,
    GuardianNIC VARCHAR(12) NOT NULL UNIQUE,
    Telephone VARCHAR(10) NOT NULL,
    PatientId INT NOT NULL,
    FOREIGN KEY (PatientId) REFERENCES Patient_Inpatient(PatientId)
);


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


CREATE TABLE Patient_Outpatient (
    PatientId INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PatientType VARCHAR(20) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    NIC VARCHAR(12) NOT NULL,
    Telephone VARCHAR(15) NOT NULL,
    VisitReason VARCHAR(255),
    DoctorId INT NOT NULL,
    PRIMARY KEY (PatientId),
    FOREIGN KEY (DoctorId) REFERENCES Doctor(DoctorId)
);




CREATE TABLE Payment (
    PaymentId INT PRIMARY KEY,
    PaymentType VARCHAR(50) NOT NULL,
    Amount INT NOT NULL,
    DateTime DATETIME NOT NULL,
    Payer VARCHAR(100) NOT NULL,
    PatientType VARCHAR(10) NOT NULL CHECK (PatientType IN ('inpatient', 'outpatient')),
    InpatientPatientId INT,
    OutpatientPatientId INT,
    FOREIGN KEY (InpatientPatientId) REFERENCES patient_inpatient(PatientId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (OutpatientPatientId) REFERENCES patient_outpatient(PatientId) ON DELETE CASCADE ON UPDATE CASCADE
);





CREATE TABLE Inpatient_Receive_Treatment (
    PatientId INT NOT NULL,
    TreatmentId INT NOT NULL,
    PRIMARY KEY (PatientId, TreatmentId),
    FOREIGN KEY (PatientId) REFERENCES patient_inpatient(PatientId),
    FOREIGN KEY (TreatmentId) REFERENCES treatment(TreatmentId)
);


CREATE TABLE Room (
    RoomId INT NOT NULL,
    RoomType VARCHAR(50) NOT NULL,
    WardId INT NOT NULL,
    PRIMARY KEY (RoomId),
    FOREIGN KEY (WardId) REFERENCES Ward(WardId)
);

CREATE TABLE Treatment (
    TreatmentId INT NOT NULL,
    Dosage VARCHAR(100) NOT NULL,
    MedicalCondition VARCHAR(255) NOT NULL,
    TypeOfTreatment VARCHAR(100) NOT NULL,
    Medications VARCHAR(255) NOT NULL,
    PRIMARY KEY (TreatmentId)
);


CREATE TABLE Ward (
    WardId INT NOT NULL,
    WardType VARCHAR(50) NOT NULL,
    WardCapacity INT NOT NULL,
    PRIMARY KEY (WardId)
);

INSERT INTO Ward (WardId, WardType, WardCapacity) VALUES
(10001, 'General', 30),
(10002, 'ICU', 10),
(10003, 'Surgical', 20),
(10004, 'Maternity', 15),
(10005, 'General', 25);


INSERT INTO Room (RoomId, RoomType, WardId) VALUES
(20001, 'Standard', 10001),
(20002, 'Deluxe', 10002),
(20003, 'Standard', 10003),
(20004, 'VIP', 10004),
(20005, 'Standard', 10005);


INSERT INTO Doctor (DoctorId, DoctorFirstName, DoctorLastName, DateJoined, Specialization, Classification) VALUES
(30001, 'Saman', 'Perera', '2015-03-01', 'Dermatology', 'In-house'),
(30002, 'Nadeesha', 'Fernando', '2018-06-15', 'Orthopaedics', 'Consultant'),
(30003, 'Chamika', 'Jayawardena', '2020-07-25', 'Pediatrics', 'In-house'),
(30004, 'Ravi', 'Kumara', '2017-11-10', 'Cardiology', 'Consultant'),
(30005, 'Anjali', 'Senanayake', '2019-02-05', 'Neurology', 'In-house');


INSERT INTO Treatment (TreatmentId, Dosage, MedicalCondition, TypeOfTreatment, Medications) VALUES
(40001, '500mg daily', 'Common Cold', 'Symptomatic Treatment', 'Paracetamol, Cough Syrup'),
(40002, '10mg twice daily', 'Hypertension', 'Chronic Treatment', 'Amlodipine, Lisinopril'),
(40003, '1 tablet before bed', 'Insomnia', 'Sleep Aid', 'Melatonin'),
(40004, '250mg three times a day', 'Diabetes', 'Chronic Treatment', 'Metformin'),
(40005, '50mg daily', 'Anxiety', 'Mental Health Treatment', 'Sertraline');


INSERT INTO Patient_Inpatient (PatientId, FirstName, LastName, PatientType, DateOfBirth, Gender, NIC, Telephone, AdmissionDateTime, DischargeDateTime, RoomId) VALUES
(50001, 'Ruwan', 'Perera', 'Inpatient', '1985-07-15', 'Male', '123456789V', '0712345678', '2024-12-01 10:00:00', '2024-12-10 15:00:00', 20001),
(50002, 'Dilani', 'Fernando', 'Inpatient', '1990-03-22', 'Female', '234567890V', '0723456789', '2024-12-05 08:30:00', '2024-12-15 12:00:00', 20002),
(50003, 'Chamika', 'Jayawardena', 'Inpatient', '1980-11-05', 'Male', '345678901V', '0734567890', '2024-12-07 14:45:00', '2024-12-12 09:00:00', 20003),
(50004, 'Anjali', 'Senanayake', 'Inpatient', '1995-01-10', 'Female', '456789012V', '0745678901', '2024-12-06 11:00:00', '2024-12-13 13:30:00', 20004),
(50005, 'Saman', 'Kumara', 'Inpatient', '2000-08-30', 'Male', '567890123V', '0756789012', '2024-12-03 09:00:00', '2024-12-11 16:00:00', 20005);



INSERT INTO Patient_Outpatient (PatientId, FirstName, LastName, PatientType, DateOfBirth, Gender, NIC, Telephone, VisitReason, DoctorId) VALUES
(60001, 'Sita', 'Gunaratne', 'Outpatient', '1992-06-15', 'Female', '123456789V', '0781234567', 'Routine Checkup', 30001),
(60002, 'Tharindu', 'Rajapaksha', 'Outpatient', '1988-04-10', 'Male', '234567890V', '0792345678', 'Back Pain', 30002),
(60003, 'Priya', 'Mendis', 'Outpatient', '1995-09-20', 'Female', '345678901V', '0703456789', 'Skin Rash', 30001),
(60004, 'Kamal', 'Perera', 'Outpatient', '1980-12-25', 'Male', '456789012V', '0714567890', 'Hypertension', 30003),
(60005, 'Anusha', 'Fernando', 'Outpatient', '2002-02-18', 'Female', '567890123V', '0725678901', 'Headache', 30004);


INSERT INTO Appointment (AppointmentId, DateAndTime, DoctorId, PatientId) VALUES
(70001, '2024-12-02 10:30:00', 30001, 50001),
(70002, '2024-12-06 14:00:00', 30002, 50002),
(70003, '2024-12-08 09:15:00', 30003, 50003),
(70004, '2024-12-10 11:00:00', 30004, 50004),
(70005, '2024-12-12 13:45:00', 30001, 50005);


INSERT INTO Doctor_Treat_Inpatient (DoctorId, PatientId) VALUES
(30001, 50001),
(30002, 50002),
(30003, 50003),
(30004, 50004),
(30001, 50005);


INSERT INTO Doctor_Treatment (TreatmentId, DoctorId) VALUES
(40001, 30001),
(40002, 30002),
(40003, 30003),
(40004, 30004),
(40005, 30001);

INSERT INTO Guardian (GuardianName, GuardianNIC, Telephone, PatientId) VALUES
('Priya Perera', '123456789V', '0712345678', 50001),
('Kamal Rajapaksha', '234567890V', '0723456789', 50002),
('Nina Jayasinghe', '345678901V', '0734567890', 50003),
('Ravi Fernando', '456789012V', '0745678901', 50004),
('Anjali Mendis', '567890123V', '0756789012', 50005);

INSERT INTO Inpatient_Receive_Treatment (PatientId, TreatmentId) VALUES
(50001, 40001),
(50002, 40002),
(50003, 40003),
(50004, 40004),
(50005, 40005);

INSERT INTO Payment (PaymentId, PaymentType, Amount, DateTime, Payer, PatientType, InpatientPatientId, OutpatientPatientId) VALUES
(80001, 'Cash', 5000, '2024-12-01 15:30:00', 'Ruwan Perera', 'inpatient', 50001, NULL),
(80002, 'Card', 3000, '2024-12-05 11:00:00', 'Dilani Fernando', 'inpatient', 50002, NULL),
(80003, 'Insurance', 7000, '2024-12-08 13:45:00', 'Chamika Jayawardena', 'inpatient', 50003, NULL),
(80004, 'Cash', 2500, '2024-12-10 09:00:00', 'Kamal Perera', 'outpatient', NULL, 60001),
(80005, 'Card', 4500, '2024-12-12 14:15:00', 'Anusha Fernando', 'outpatient', NULL, 60002);

SELECT 
    SUM(Payment.Amount) AS TotalCashPayment
FROM 
    Payment
INNER JOIN 
    Patient_Outpatient ON Payment.OutpatientPatientId = Patient_Outpatient.PatientId
INNER JOIN 
    Doctor ON Patient_Outpatient.DoctorId = Doctor.DoctorId
WHERE 
    Payment.PaymentType = 'Cash'
    AND Patient_Outpatient.PatientType = 'Outpatient'
    AND Doctor.Specialization = 'Pediatrics'
    AND (Doctor.DoctorLastName = 'Peterson' OR Doctor.DoctorLastName = 'Fedrick')
    AND Payment.DateTime >= CURDATE() - INTERVAL 10 DAY;


SELECT 
    Ward.WardId, 
    Ward.WardType, 
    Ward.WardCapacity AS AvailableWardCapacity
FROM 
    Ward
INNER JOIN 
    Room 
ON 
    Ward.WardId = Room.WardId
WHERE 
    Room.RoomType = 'Deluxe'
    AND Ward.WardCapacity > 5;


SELECT DoctorFirstName, DoctorLastName, Specialization
FROM Doctor
WHERE Specialization IN ('Cardiology', 'Neurology')
  AND Classification = 'In-house'
  AND DateJoined < '2022-01-01'
ORDER BY DateJoined DESC;



