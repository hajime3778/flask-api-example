SET client_encoding = 'UTF8';

-- Automatically update TIMESTAMP when updating
CREATE FUNCTION update_updated_at_column()
  RETURNS TRIGGER AS $$
  BEGIN
      NEW.updated_at = now();
      RETURN NEW;
  END;
  $$ language 'plpgsql';


-- users
CREATE TABLE users (
  id BIGSERIAL NOT NULL,
  name varchar(64) NOT NULL DEFAULT '',
  email varchar(64) NOT NULL DEFAULT '',
  password varchar(200) NOT NULL DEFAULT '',
  salt varchar(10) NOT NULL DEFAULT '',
  created_at TIMESTAMP NOT NULL DEFAULT current_timestamp,
  updated_at TIMESTAMP NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (id)
);
CREATE UNIQUE INDEX idx_email ON users (email);
CREATE TRIGGER update_user_modtime
  BEFORE UPDATE
  ON users
  FOR EACH ROW
EXECUTE PROCEDURE update_updated_at_column();

INSERT INTO users (name, email, password, salt) VALUES
('ユーザー１', 'sample@example.com', 'password', 'salt');


-- tasks
CREATE TABLE tasks (
  id BIGSERIAL NOT NULL,
  user_id bigint NOT NULL,
  title varchar(50) NOT NULL DEFAULT '',
  content varchar(200) NOT NULL DEFAULT '',
  due_date TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT current_timestamp,
  updated_at TIMESTAMP NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
);
CREATE INDEX idx_user_id ON tasks (user_id);
CREATE TRIGGER update_task_modtime
  BEFORE UPDATE
  ON tasks
  FOR EACH ROW
EXECUTE PROCEDURE update_updated_at_column();

INSERT INTO tasks (title, user_id, content, due_date) VALUES
('お米を炊く', 1, '買い出しに帰ってくる頃に炊けるようにセットしておく', now()),
('買い出しに行く', 1,'スーパーで、卵と鶏肉と三葉を買う', now()),
('晩御飯を作る', 1,'親子丼を作る', now()),
('お風呂に入る', 1,'肩まで浸かって10数えよう', now());
