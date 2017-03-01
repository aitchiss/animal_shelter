DROP TABLE adoptions;
DROP TABLE owners;
DROP TABLE animals; 
DROP TABLE animal_types;
DROP TABLE adoption_statuses;



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
  phone_number VARCHAR(255),
  has_outside_space BOOLEAN,
  has_children_at_home BOOLEAN,
  has_cats BOOLEAN,
  has_dogs BOOLEAN,
  has_rabbits BOOLEAN,
  can_give_special_attention BOOLEAN
);

CREATE TABLE animals(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) not null,
  admission_date DATE not null,
  type_id INT4 REFERENCES animal_types(id),
  breed VARCHAR(255),
  adoption_status_id INT4 REFERENCES adoption_statuses(id),
  photo_file_path VARCHAR(255),
  needs_outside_space BOOLEAN,
  can_live_with_children BOOLEAN,
  can_live_with_same_type BOOLEAN,
  can_live_with_other_type BOOLEAN,
  needs_special_attention BOOLEAN
);

CREATE TABLE adoptions(
  id SERIAL4 PRIMARY KEY,
  owner_id INT4 REFERENCES owners(id),
  animal_id INT4 REFERENCES animals(id),
  date DATE
);