-- Create users table
CREATE TABLE users (
    user_id VARCHAR(50),
    name VARCHAR(100),
    phone_number VARCHAR(20),
    mail_id VARCHAR(100),
    billing_address VARCHAR(200)
);

-- Create bookings table
CREATE TABLE bookings (
    booking_id VARCHAR(50),
    booking_date TIMESTAMP,
    room_no VARCHAR(50),
    user_id VARCHAR(50)
);

-- Create items table
CREATE TABLE items (
    item_id VARCHAR(50),
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

-- Create booking_commercials table
CREATE TABLE booking_commercials (
    id VARCHAR(50),
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date TIMESTAMP,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2)
);

-- Sample data (you can add more if needed)
INSERT INTO users VALUES 
('U1','John Doe','9876543210','john@example.com','ABC Street');

INSERT INTO bookings VALUES 
('B1','2021-11-10 10:00:00','R101','U1');

INSERT INTO items VALUES 
('I1','Tawa Paratha',18),
('I2','Mix Veg',89);

INSERT INTO booking_commercials VALUES 
('C1','B1','BL1','2021-11-10 12:00:00','I1',2),
('C2','B1','BL1','2021-11-10 12:00:00','I2',1);
