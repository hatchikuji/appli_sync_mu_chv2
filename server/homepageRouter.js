// server/homepageRouter.js
import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
import fs from 'fs';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const manifestPath = path.join(__dirname, '../dist/.vite/manifest.json');
let manifest = {};

if (fs.existsSync(manifestPath)) {
    manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf-8'));
} else {
    console.error('Manifest file not found:', manifestPath);
}

const router = express.Router();

router.get('/*', (req, res) => {
    const environment = process.env.NODE_ENV || 'development';
    res.render('index.html.ejs', { environment, manifest });
});

export default router;