(function () {
  var hamburgerBtn = document.getElementById("hamburgerBtn");
  var closeNavBtn = document.getElementById("closeNavBtn");
  var navPanel = document.getElementById("mobileNavPanel");
  var navOverlay = document.getElementById("mobileNavOverlay");
  var body = document.body;
  var loginButtons = document.getElementById("loginButtons");

  function openNav() {
    navPanel.classList.add("is-open");
    navOverlay.classList.add("is-visible");
    hamburgerBtn.style.display = "none";
    body.classList.add("nav-locked");
  }

  function closeNav() {
    navPanel.classList.remove("is-open");
    navOverlay.classList.remove("is-visible");
    body.classList.remove("nav-locked");
    hamburgerBtn.style.display = "block";
  }
  if (window.innerWidth <= 1069) {
    loginButtons.classList.remove("col-2");
    loginButtons.classList.add("col-7");
  }

  hamburgerBtn.addEventListener("click", function () {
    if (navPanel.classList.contains("is-open")) {
      closeNav();
    } else {
      openNav();
    }
  });

  closeNavBtn.addEventListener("click", closeNav);
  navOverlay.addEventListener("click", closeNav);

  // Fecha o menu ao clicar em um link
  navPanel.querySelectorAll("a").forEach(function (link) {
    link.addEventListener("click", closeNav);
  });

  // Fecha com a tecla Esc
  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape") closeNav();
  });
})();
