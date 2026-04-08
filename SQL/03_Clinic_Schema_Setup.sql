CREATE TABLE clinics (
    cid VARCHAR(50),
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE clinic_sales (
    id VARCHAR(50),
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime TIMESTAMP,
    sales_channel VARCHAR(50)
);

CREATE TABLE expenses (
    id VARCHAR(50),
    cid VARCHAR(50),
    description VARCHAR(100),
    amount DECIMAL(10,2),
    datetime TIMESTAMP
);

-- Sample data
INSERT INTO clinics VALUES 
('C1','XYZ Clinic','Vizag','AP','India');

INSERT INTO clinic_sales VALUES 
('S1','U1','C1',2500,'2021-09-10 10:00:00','online');

INSERT INTO expenses VALUES 
('E1','C1','Medical supplies',500,'2021-09-10 09:00:00');
