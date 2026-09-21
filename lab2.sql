-- 1. СОЗДАНИЕ ВСЕХ ТАБЛИЦ (NOT NULL + PRIMARY KEY)
CREATE TABLE Airline_info (
    airline_id INT PRIMARY KEY NOT NULL,
    airline_code VARCHAR(30) NOT NULL,
    airline_name VARCHAR(50) NOT NULL,
    airline_country VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    info VARCHAR(50) NOT NULL
);

CREATE TABLE Airport (
    airport_id INT PRIMARY KEY NOT NULL,
    airport_name VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(50) NOT NULL,
    country_of_citizenship VARCHAR(50) NOT NULL,
    country_of_residence VARCHAR(50) NOT NULL,
    passport_number VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE Flights (
    flight_id INT PRIMARY KEY NOT NULL,
    sch_departure_time TIMESTAMP NOT NULL,
    sch_arrival_time TIMESTAMP NOT NULL,
    departing_airport_id INT NOT NULL,
    arriving_airport_id INT NOT NULL,
    departing_gate VARCHAR(50) NOT NULL,
    arriving_gate VARCHAR(50) NOT NULL,
    airline_id INT NOT NULL,
    act_departure_time TIMESTAMP NOT NULL,
    act_arrival_time TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY NOT NULL,
    flight_id INT NOT NULL,
    passenger_id INT NOT NULL,
    booking_platform VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL,
    price DECIMAL(7,2) NOT NULL
);

CREATE TABLE Security_check (
    security_check_id INT PRIMARY KEY NOT NULL,
    check_result VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    passenger_id INT NOT NULL
);

CREATE TABLE Baggage_check (
    baggage_check_id INT PRIMARY KEY NOT NULL,
    check_result VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    booking_id INT NOT NULL,
    passenger_id INT NOT NULL
);

CREATE TABLE Baggage (
    baggage_id INT PRIMARY KEY NOT NULL,
    weight_in_kg DECIMAL(4,2) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    booking_id INT NOT NULL
);

CREATE TABLE Boarding_pass (
    boarding_pass_id INT PRIMARY KEY NOT NULL,
    booking_id INT NOT NULL,
    seat VARCHAR(50) NOT NULL,
    boarding_time TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE Booking_flight (
    booking_flight_id INT PRIMARY KEY NOT NULL,
    booking_id INT NOT NULL,
    flight_id INT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

-- 2. МОДИФИКАЦИИ ТАБЛИЦ И КОЛОНОК (ALTER TABLE)
ALTER TABLE Airline_info RENAME TO Airline;
ALTER TABLE Booking RENAME COLUMN price TO ticket_price;
ALTER TABLE Flights ALTER COLUMN departing_gate TYPE TEXT;
ALTER TABLE Airline DROP COLUMN info;

-- 3. СОЗДАНИЕ ВНЕШНИХ КЛЮЧЕЙ (FOREIGN KEYS)
ALTER TABLE Security_check ADD CONSTRAINT fk_sec_pass FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id);
ALTER TABLE Booking ADD CONSTRAINT fk_book_pass FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id);
ALTER TABLE Baggage_check ADD CONSTRAINT fk_bagcheck_pass FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id);

ALTER TABLE Baggage_check ADD CONSTRAINT fk_bagcheck_book FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);
ALTER TABLE Baggage ADD CONSTRAINT fk_bag_book FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);
ALTER TABLE Boarding_pass ADD CONSTRAINT fk_board_book FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);
ALTER TABLE Booking_flight ADD CONSTRAINT fk_bookfl_book FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);

ALTER TABLE Booking_flight ADD CONSTRAINT fk_bookfl_fl FOREIGN KEY (flight_id) REFERENCES Flights(flight_id);

ALTER TABLE Flights ADD CONSTRAINT fk_fl_dep_air FOREIGN KEY (departing_airport_id) REFERENCES Airport(airport_id);
ALTER TABLE Flights ADD CONSTRAINT fk_fl_arr_air FOREIGN KEY (arriving_airport_id) REFERENCES Airport(airport_id);
ALTER TABLE Flights ADD CONSTRAINT fk_fl_airline FOREIGN KEY (airline_id) REFERENCES Airline(airline_id);