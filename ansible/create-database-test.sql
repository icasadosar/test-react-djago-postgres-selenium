/* Database and user create */
CREATE DATABASE {{ name_db }} WITH ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_TYPE = 'en_US.UTF-8' TABLESPACE = pg_default CONNECTION LIMIT -1;
CREATE USER {{ user_db }};
ALTER USER {{ user_db }} PASSWORD '{{ pass_db }}';
GRANT ALL PRIVILEGES ON DATABASE {{ name_db }} TO {{ user_db }};