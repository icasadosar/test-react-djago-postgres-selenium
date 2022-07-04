CREATE DATABASE "{{ name_db }}" WITH ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8' TABLESPACE = pg_default CONNECTION LIMIT -1 TEMPLATE template0;
CREATE USER "{{ user_db }}";
ALTER USER "{{ user_db }}" PASSWORD "{{ pass_db }}";
ALTER USER "{{ user_db }}" CREATEDB;
GRANT ALL PRIVILEGES ON DATABASE "{{ name_db }}" TO "{{ user_db }}";