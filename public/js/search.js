const searchInput = document.getElementById("searchInput");

searchInput.addEventListener("keyup", function () {
  const searchValue = searchInput.value.toLowerCase();

  const recipes = document.querySelectorAll(".recipe-list li");

  recipes.forEach(function (recipe) {
    const text = recipe.innerText.toLowerCase();

    if (text.includes(searchValue)) {
      recipe.style.display = "";
    } else {
      recipe.style.display = "none";
    }
  });
});
