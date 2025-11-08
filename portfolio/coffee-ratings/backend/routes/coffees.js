import express from "express";
import multer from "multer";
import path from "path";
import fs from "fs";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import { pool } from "../db.js";

dotenv.config();
const router = express.Router();

// Setup upload directory
const uploadDir = path.join(process.cwd(), "backend", process.env.UPLOAD_DIR || "uploads");
if (!fs.existsSync(uploadDir)) fs.mkdirSync(uploadDir, { recursive: true });

const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadDir),
  filename: (req, file, cb) => {
    const unique = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, unique + path.extname(file.originalname));
  },
});

const upload = multer({ storage });

// Auth middleware
function verifyToken(req, res, next) {
  const authHeader = req.headers.authorization;
  if (!authHeader) return res.status(401).json({ error: "Missing token" });
  const token = authHeader.split(" ")[1];
  try {
    req.user = jwt.verify(token, process.env.JWT_SECRET);
    next();
  } catch {
    return res.status(401).json({ error: "Invalid token" });
  }
}

// POST /api/coffees/upload
router.post("/upload", verifyToken, upload.array("images", 5), async (req, res) => {
  const { rating, recipe, notes } = req.body;
  const userId = req.user.id;

  try {
    const result = await pool.query(
      "INSERT INTO coffees (user_id, rating, recipe, notes) VALUES ($1, $2, $3, $4) RETURNING id",
      [userId, rating, recipe, notes]
    );

    const coffeeId = result.rows[0].id;

    for (const file of req.files) {
      const imagePath = `/uploads/${file.filename}`;
      await pool.query("INSERT INTO coffee_images (coffee_id, image_path) VALUES ($1, $2)", [coffeeId, imagePath]);
    }

    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Upload failed" });
  }
});

// GET /api/coffees/feed
router.get("/feed", async (req, res) => {
  try {
    const { rows } = await pool.query(`
      SELECT c.*, u.username, array_agg(ci.image_path) AS images
      FROM coffees c
      JOIN users u ON u.id = c.user_id
      LEFT JOIN coffee_images ci ON ci.coffee_id = c.id
      GROUP BY c.id, u.username
      ORDER BY c.created_at DESC
    `);
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to load feed" });
  }
});

export default router;

