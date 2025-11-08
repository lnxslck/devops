CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS coffees (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  rating INTEGER NOT NULL,
  recipe TEXT,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS coffee_images (
  id SERIAL PRIMARY KEY,
  coffee_id INTEGER REFERENCES coffees(id),
  image_path TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL
);

INSERT INTO users (username, password) VALUES ('admin', 'admin123')
ON CONFLICT (username) DO NOTHING;
