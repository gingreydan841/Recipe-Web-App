const db = require("./database");

const express = require("express");
const path = require("path");

const app = express();

// Middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Static folder
app.use(express.static(path.join(__dirname, "public")));

// View engine
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

// Home Page
app.get("/", (req, res) => {
  const countSQL = "SELECT COUNT(*) AS total FROM recipes";
  const featuredSQL = "SELECT * FROM recipes ORDER BY id DESC LIMIT 3";

  db.query(countSQL, (err, countResult) => {
    if (err) {
      console.error(err);
      return res.send("Database error");
    }

    db.query(featuredSQL, (err, featuredResult) => {
      if (err) {
        console.error(err);
        return res.send("Database error");
      }

      res.render("pages/home", {
        totalRecipes: countResult[0].total,
        featuredRecipes: featuredResult,
      });
    });
  });
});

// View All Recipes
app.get("/recipes", (req, res) => {
  const sql = "SELECT * FROM recipes";

  db.query(sql, (err, results) => {
    if (err) {
      console.error(err);
      return res.send("Database error");
    }

    res.render("pages/recipes", { recipes: results });
  });
});

// Add Recipe Page
app.get("/addRecipe", (req, res) => {
  res.render("pages/addRecipe");
});

// View Single Recipe
app.get("/recipes/:id", (req, res) => {
  const recipeId = req.params.id;

  const sql = `
    SELECT r.*, i.name, i.description
    FROM recipes r
    LEFT JOIN recipe_ingredients ri ON r.id = ri.recipe_id
    LEFT JOIN ingredients i ON i.id = ri.ingredient_id
    WHERE r.id = ?
  `;

  db.query(sql, [recipeId], (err, results) => {
    if (err) {
      console.error(err);
      return res.send("Database error");
    }

    if (results.length === 0) {
      return res.send("Recipe not found");
    }

    res.render("pages/recipe", { recipe: results });
  });
});

// Add Recipe POST
app.post("/addRecipe", (req, res) => {
  const { title, protein_type, ingredients, instructions } = req.body;

  const recipeSQL = `
    INSERT INTO recipes (title, protein_type, instructions)
    VALUES (?, ?, ?)
  `;

  db.query(recipeSQL, [title, protein_type, instructions], (err, result) => {
    if (err) {
      console.error(err);
      return res.send("Error inserting recipe");
    }

    const recipeId = result.insertId;

    const ingredientList = ingredients.split(",");

    ingredientList.forEach((ingredient) => {
      const ingredientName = ingredient.trim();

      // Insert ingredient only if it doesn't already exist
      const insertIngredientSQL = `
        INSERT IGNORE INTO ingredients (name)
        VALUES (?)
      `;

      db.query(insertIngredientSQL, [ingredientName], (err) => {
        if (err) {
          console.error(err);
          return;
        }

        // Get the ingredient ID
        const getIngredientSQL = `
          SELECT id FROM ingredients WHERE name = ?
        `;

        db.query(getIngredientSQL, [ingredientName], (err, results) => {
          if (err) {
            console.error(err);
            return;
          }

          const ingredientId = results[0].id;

          // Link recipe and ingredient
          const linkSQL = `
            INSERT INTO recipe_ingredients (recipe_id, ingredient_id)
            VALUES (?, ?)
          `;

          db.query(linkSQL, [recipeId, ingredientId], (err) => {
            if (err) {
              console.error(err);
            }
          });
        });
      });
    });

    res.redirect("/recipes");
  });
});

module.exports = app;
