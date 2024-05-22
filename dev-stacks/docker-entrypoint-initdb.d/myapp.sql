CREATE TABLE developers (id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL, expertise VARCHAR(100) NOT NULL, years_of_experience INT NOT NULL);
INSERT INTO developers (name, expertise, years_of_experience) VALUES ('Alice', 'Java', 8), ('Bob', 'Kafka', 5), ('Charlie', 'Spring Boot', 7), ('David', 'PostgreSQL', 6), ('Eva', 'Liquibase', 4);

