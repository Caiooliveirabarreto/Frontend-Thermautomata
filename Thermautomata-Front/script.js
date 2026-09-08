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

// Filtro de tags
const filtroTags = document.getElementById("filtroTags");

if (filtroTags) {
    filtroTags.addEventListener("click", function (event) {
        const tag = event.target.closest("li");
        if (!tag) return;

        tag.classList.toggle("selecionada");

        const tagsSelecionadas = Array.from(
            filtroTags.querySelectorAll("li.selecionada")
        ).map(function (tag) {
            return Number(tag.dataset.tagId);
        });

        console.log(tagsSelecionadas);
    });
}

// Função para carregar artigos do backend
async function carregarArtigos() {
    try {
        const resposta = await fetch("http://127.0.0.1:8000/artigos/");

        if (!resposta.ok) {
            throw new Error("Erro ao buscar artigos");
        }

        const artigos = await resposta.json();

        const listaArtigos = document.getElementById("listaArtigos");

        listaArtigos.innerHTML = "";

        const artigosAprovados = artigos.filter(function (artigo) {
            return artigo.status === "aprovado";
        });

        artigosAprovados.forEach(function (artigo) {
            const elemento = document.createElement("div");

            elemento.classList.add("artigos");

            elemento.innerHTML = `
                <h2 class="artigo-titulo" style="cursor: pointer;" onclick="window.location.href='artigo.html?id=${artigo.idart}'">${artigo.titulo}</h2>
                <h3 class="autor">${artigo.nome_autor}</h3>
                <p class="data-artigo">${new Date(artigo.data_criacao).toLocaleDateString("pt-BR")}</p>
                <p class="artigo-texto">${
                    artigo.artigo.length > 50
                        ? artigo.artigo.substring(0, 50) + "..."
                        : artigo.artigo
                }</p>
            `;

            listaArtigos.appendChild(elemento);
        });
    } catch (erro) {
        console.error("Erro:", erro);
    }
}

if (document.getElementById("listaArtigos")) {
    carregarArtigos();
}