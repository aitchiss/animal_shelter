DROP TABLE animal_types;
DROP TABLE adoption_statuses;
DROP TABLE owners;
DROP TABLE animals;
DROP TABLE adoptions;

CREATE TABLE animal_types(
  id SERIAL4 PRIMARY KEY,
  type VARCHAR(255) not null
);

CREATE TABLE adoption_statuses(
  id SERIAL4 PRIMARY KEY,
  status VARCHAR(255) not null
);

CREATE TABLE owners(
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  address VARCHAR(255),
  phone_number INT4
);

CREATE TABLE animals(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) not null,
  admission_date DATE not null,
  type_id INT4 REFERENCES animal_types(id),
  breed VARCHAR(255),
  adoption_status_id INT4 REFERENCES adoption_statuses(id),
  photo_file_path VARCHAR(255)
);

CREATE TABLE adoptions(
  id SERIAL4 PRIMARY KEY,
  owner_id INT4 REFERENCES owners(id),
  animal_id INT4 REFERENCES animals(id),
  date DATE
);