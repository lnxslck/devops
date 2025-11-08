import express from "express";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { pool } from "../db.js";
import dotenv from "dotenv";

dotenv.config();
const router = express.Router();

// POST /api/login
router.post("/login", async (req, res) => {
  const { username, password } = req.body;
  try {
    const { rows } = await pool.query("SELECT * FROM users WHERE username=$1", [username]);
    if (rows.length === 0) return res.status(401).json({ error: "Invalid username or password" });

    const user = rows[0];
    const valid = await bcrypt.compare(password, user.password_hash);
    if (!valid) return res.status(401).json({ error: "Invalid username or password" });

    const token = jwt.sign({ id: user.id, username: user.username }, process.env.JWT_SECRET, { expiresIn: "1d" });
    res.json({ token });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

export default router;

