CREATE TABLE IF NOT EXISTS public.readers (
    ticket_number bigserial PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    firts_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50) UNIQUE NOT NULL,
    e_mail VARCHAR(100),
    date_of_issue DATE NOT NULL,
    stop_list BOOL NOT NULL,
    bithday DATE CHECK (birthday > '1900-01-01')
);
CREATE TABLE IF NOT EXISTS public.publisher(
    publisher_id serial PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
);
CREATE TABLE IF NOT EXISTS public.books (
    book_id bigserial PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    date_of_issue DATE NOT NULL,
    sheets SMALLINT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    number_of_instances SMALLINT NOT NULL,
    bookcase SMALLINT NOT NULL,
    shelf SMALLINT NOT NULL,
    publisher_id INTEGER NOT NULL,
    FOREIGN KEY (publisher_id) REFERENCES publisher (publisher_id) ON DELETE SET RESTRICT
);
CREATE TABLE IF NOT EXISTS public.staff(
    staff_id smallserial PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR,
    position VARCHAR(50),
    address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50) NOT NULL,
    e-mail VARCHAR(100),
    current_employee_status BOOL NOT NULL
);
CREATE TABLE IF NOT EXISTS public.rent (
    rent_id serial PRIMARY KEY,
    book_id BIGINT NOT NULL,
    ticket_number BIGINT NOT NULL,
    FOREIGN KEY (ticket_number) REFERENCES readers (ticket_number) ON DELETE SET CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE SET RESTRICT,
    date_of_issue DATE CHECK (date_of_issue > '1900-01-01'),
    return_date DATE CHECK (return_date > date_of_issue),
    actual_return_date DATE,
    staff_id SMALLINT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES staff (staff_id) ON DELETE SET RESTRICT
);
CREATE TABLE IF NOT EXISTS public.authors(
    author_id serial PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50),
    middle_name VARCHAR(50),
);
CREATE TABLE IF NOT EXISTS public.books_authors(
    id serial PRIMARY KEY,
    book_id BIGINT NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books (book_id) ON DELETE SET CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors (author_id) ON DELETE SET CASCADE
);
CREATE TABLE IF NOT EXISTS public.damage(
    damage_id serial PRIMARY KEY,
    ticket_number BIGINT NOT NULL,
    book_id BIGINT NOT NULL,
    type_of_damage VARCHAR(50) NOT NULL,
    cost_of_damage DECIMAL(10,2) NOT NULL,
    date_of_damage DATE CHECK (date_of_damage > '1900-01-01'),
    date_of_damage_compensation DATE,
    FOREIGN KEY (ticket_number) REFERENCES readers(ticket_number) ON DELETE SET RESTRICT,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE SET RESTRICT
);

    