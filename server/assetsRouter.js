import express from "express";

const router = express.Router();

const supportedAssets = ["svg", "png", "jpg", "jpeg", "mp4", "ogv"];

const assetExtensionRegex = () => {
    const formattedExtensionList = supportedAssets.join("|");
    return new RegExp(`^(https?:\\/\\/|\\.\\/|\\/)?([\\w\\-]+\\.)*[\\w\\-]+(\\/[^\\/\\s]*)*\\.(${formattedExtensionList})$`, "i");
};

// Middleware pour vérifier les requêtes
router.use((req, res, next) => {
    const { path } = req;
    if (assetExtensionRegex().test(path)) {
        res.redirect(`http://localhost:5173/src${path}`);
    } else {
        next(); // passe au middleware suivant si ce n'est pas un asset valide
    }
});

export default router;
