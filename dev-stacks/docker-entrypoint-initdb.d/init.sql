-- init.sql

-- Create a new schema
CREATE SCHEMA example_schema AUTHORIZATION example_user;

-- set default schema to ipce
ALTER ROLE example_user SET search_path TO example_schema;

--\i '/docker-entrypoint-initdb.d/myapp.sql'
