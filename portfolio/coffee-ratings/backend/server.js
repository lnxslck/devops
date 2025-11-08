import express from 'express';
import path from 'path';
import pkg from 'pg';
const { Pool } = pkg;
const pool = new Pool({ connectionString: process.env.DATABASE_URL });

const app = express();
const PORT = process.env.PORT || 4000;

app.use(express.static(path.resolve('./public')));
app.use(express.json());

// Login endpoint
app.post('/api/login', async (req, res) => {
  const { username, password } = req.body;
  try {
    const result = await pool.query(
      'SELECT username, password FROM users WHERE username = $1',
      [username]
    );

    if (result.rows.length === 0) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    const user = result.rows[0];

    // For now, plain-text password check; replace with bcrypt in production
    if (password !== user.password) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    res.json({ username: user.username });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
