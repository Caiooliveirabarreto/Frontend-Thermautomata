// Função para abrir e fechar o menu lateral mobile
(function () {
    const body = document.body;

    function fecharMenu() {
        const navPanel = document.getElementById("mobileNavPanel");
        const navOverlay = document.getElementById("mobileNavOverlay");
        const hamburgerBtn = document.getElementById("hamburgerBtn");

        if (navPanel) navPanel.classList.remove("is-open");
        if (navOverlay) navOverlay.classList.remove("is-visible");

        body.classList.remove("nav-locked");

        if (hamburgerBtn) {
            hamburgerBtn.classList.remove("menu-aberto");
            hamburgerBtn.style.removeProperty("display");
            hamburgerBtn.setAttribute("aria-expanded", "false");
        }
    }

    function alternarMenu() {
        const navPanel = document.getElementById("mobileNavPanel");
        const navOverlay = document.getElementById("mobileNavOverlay");
        const hamburgerBtn = document.getElementById("hamburgerBtn");

        if (!navPanel || !navOverlay) return;

        const aberto = navPanel.classList.contains("is-open");

        if (aberto) {
            fecharMenu();
            return;
        }

        navPanel.classList.add("is-open");
        navOverlay.classList.add("is-visible");
        body.classList.add("nav-locked");

        if (hamburgerBtn) {
            hamburgerBtn.classList.add("menu-aberto");
            hamburgerBtn.setAttribute("aria-expanded", "true");
        }
    }

    // Delegação: funciona mesmo depois de atualizar o HTML do login.
    document.addEventListener("click", function (event) {
        const target = event.target;

        if (!(target instanceof Element)) return;

        if (target.closest("#hamburgerBtn")) {
            alternarMenu();
            return;
        }

        if (
            target.closest("#closeNavBtn") ||
            target.closest("#mobileNavOverlay") ||
            target.closest("#mobileNavPanel a")
        ) {
            fecharMenu();
        }
    });

    document.addEventListener("keydown", function (event) {
        if (event.key === "Escape") {
            fecharMenu();
        }
    });

    // Fecha o menu quando a tela muda entre mobile e desktop.
    let larguraAnterior = window.innerWidth;

    window.addEventListener("resize", function () {
        const mudouDeLayout =
            (larguraAnterior <= 1069 && window.innerWidth > 1069) ||
            (larguraAnterior > 1069 && window.innerWidth <= 1069);

        larguraAnterior = window.innerWidth;

        if (mudouDeLayout) {
            fecharMenu();
        }
    });
})();

// Atualiza o menu lateral mobile com base no usuário logado.
function atualizarMenuMobile(usuario) {
    const painel = document.getElementById("mobileAdminLink");
    const acaoLogin = document.getElementById("mobileAuthAction");

    // O PAINEL aparece apenas para administradores.
    if (painel) {
        painel.hidden = !(usuario && Number(usuario.tipo) === 1);
    }

    if (!acaoLogin) return;

    // Limpa o evento anterior para evitar duplicações.
    acaoLogin.onclick = null;

    if (usuario) {
        acaoLogin.textContent = "SAIR";
        acaoLogin.href = "#";

        acaoLogin.onclick = function (event) {
            event.preventDefault();

            localStorage.removeItem("token");
            sessionStorage.removeItem("filtrosArtigos");

            window.location.href = "index.html";
        };
    } else {
        acaoLogin.textContent = "LOGIN";
        acaoLogin.href = "login.html";
    }
}

// Filtro de tags para artigos
const filtroTags = document.getElementById("filtroTags");

if (filtroTags) {
    filtroTags.addEventListener("click", function (event) {
        const tag = event.target.closest("li");

        if (!tag) return;

        tag.classList.toggle("selecionada");

        const tagsSelecionadas = Array.from(
            filtroTags.querySelectorAll("li.selecionada")
        ).map(function (tagSelecionada) {
            return Number(tagSelecionada.dataset.tagId);
        });

        sessionStorage.setItem(
            "filtrosArtigos",
            JSON.stringify(tagsSelecionadas)
        );

        carregarArtigos(tagsSelecionadas);
    });
}

// Carrega os artigos com base nas tags selecionadas e no autor, se fornecido.
async function carregarArtigos(tagsSelecionadas = [], autor = "") {
    try {
        let url = "http://127.0.0.1:8000/artigos/";
        const parametros = [];

        if (autor.trim() !== "") {
            parametros.push(
                `autor=${encodeURIComponent(autor.trim())}`
            );
        }

        tagsSelecionadas.forEach(function (id) {
            parametros.push(`tags=${id}`);
        });

        if (parametros.length > 0) {
            url += "?" + parametros.join("&");
        }

        const resposta = await fetch(url);

        if (!resposta.ok) {
            throw new Error("Erro ao buscar artigos");
        }

        const artigos = await resposta.json();
        const listaArtigos = document.getElementById("listaArtigos");

        // Evita erro em páginas sem lista de artigos.
        if (!listaArtigos) return;

        listaArtigos.innerHTML = "";

        const artigosAprovados = artigos.filter(function (artigo) {
            return artigo.status === "aprovado";
        });

        artigosAprovados.forEach(function (artigo) {
            const elemento = document.createElement("div");
            elemento.classList.add("artigos");

            const titulo = document.createElement("h2");
            titulo.className = "artigo-titulo";
            titulo.style.cursor = "pointer";
            titulo.textContent = artigo.titulo;

            titulo.addEventListener("click", function () {
                window.location.href =
                    `artigo.html?id=${encodeURIComponent(artigo.idart)}`;
            });

            const autorElemento = document.createElement("h3");
            autorElemento.className = "autor";
            autorElemento.textContent = artigo.nome_autor;

            const dataElemento = document.createElement("p");
            dataElemento.className = "data-artigo";
            dataElemento.textContent = new Date(
                artigo.data_criacao
            ).toLocaleDateString("pt-BR");

            const textoElemento = document.createElement("p");
            textoElemento.className = "artigo-texto";

            const textoArtigo = artigo.artigo || "";

            textoElemento.textContent =
                textoArtigo.length > 50
                    ? textoArtigo.substring(0, 50) + "..."
                    : textoArtigo;

            elemento.appendChild(titulo);
            elemento.appendChild(autorElemento);
            elemento.appendChild(dataElemento);
            elemento.appendChild(textoElemento);

            listaArtigos.appendChild(elemento);
        });
    } catch (erro) {
        console.error("Erro ao carregar artigos:", erro);
    }
}

// Restaura os filtros de tags salvos na sessão e carrega os artigos correspondentes.
const listaArtigosInicial = document.getElementById("listaArtigos");

if (listaArtigosInicial) {
    const filtrosSalvos = JSON.parse(
        sessionStorage.getItem("filtrosArtigos") || "[]"
    );

    if (filtroTags) {
        filtrosSalvos.forEach(function (idTag) {
            const tag = filtroTags.querySelector(
                `li[data-tag-id="${idTag}"]`
            );

            if (tag) {
                tag.classList.add("selecionada");
            }
        });
    }

    carregarArtigos(filtrosSalvos);
}

// Filtro de autor
const filtroAutor = document.getElementById("filtroAutor");

if (filtroAutor) {
    filtroAutor.addEventListener("input", function () {
        const tagsSelecionadas = filtroTags
            ? Array.from(
                filtroTags.querySelectorAll("li.selecionada")
            ).map(function (tag) {
                return Number(tag.dataset.tagId);
            })
            : [];

        carregarArtigos(tagsSelecionadas, filtroAutor.value);
    });
}

// Verifica se o usuário está logado e atualiza o menu lateral de acordo.
async function verificarLogin() {
    const token = localStorage.getItem("token");
    const loginButtons = document.getElementById("loginButtons");

    if (!token) {
        atualizarMenuMobile(null);
        return;
    }

    try {
        const resposta = await fetch(
            "http://127.0.0.1:8000/auth/me",
            {
                headers: {
                    Authorization: `Bearer ${token}`
                }
            }
        );

        if (!resposta.ok) {
            localStorage.removeItem("token");
            atualizarMenuMobile(null);
            return;
        }

        const usuario = await resposta.json();

        // Atualiza o menu lateral mesmo se não houver cabeçalho nesta página.
        atualizarMenuMobile(usuario);

        if (!loginButtons) return;

        const fotoUsuario =
            usuario.foto_perfil ||
            usuario.foto ||
            "template-perfil.jpg";

        const fotoUrl =
            `http://127.0.0.1:8000/uploads/perfis/${encodeURIComponent(fotoUsuario)}`;

        loginButtons.innerHTML = `
            <div class="perfil-menu">
                <img
                    src="${fotoUrl}"
                    alt="Foto de perfil"
                    class="foto-perfil-nav"
                    id="fotoPerfilNav"
                >

                <div class="perfil-dropdown" id="perfilDropdown">
                    <button id="btnMeusArtigos" type="button">
                        Meus artigos
                    </button>

                    ${Number(usuario.tipo) === 1 ? `
                        <button id="btnPainelAdmin" type="button">
                            Painel administrativo
                        </button>
                    ` : ""}

                    <button id="btnLogout" type="button">
                        Sair
                    </button>
                </div>
            </div>

            <button
                class="hamburger-btn"
                id="hamburgerBtn"
                type="button"
                aria-label="Abrir menu"
                aria-expanded="false"
                aria-controls="mobileNavPanel"
            >
                <span></span>
                <span></span>
                <span></span>
            </button>
        `;

        // Abrir e fechar dropdown do perfil.
        const fotoPerfilNav = document.getElementById("fotoPerfilNav");

        if (fotoPerfilNav) {
            fotoPerfilNav.addEventListener("click", function () {
                const dropdown = document.getElementById("perfilDropdown");

                if (dropdown) {
                    dropdown.classList.toggle("aberto");
                }
            });

            // Imagem padrão caso a foto do usuário não carregue.
            fotoPerfilNav.addEventListener("error", function () {
                if (!fotoPerfilNav.dataset.fallbackUsado) {
                    fotoPerfilNav.dataset.fallbackUsado = "true";
                    fotoPerfilNav.src =
                        "http://127.0.0.1:8000/uploads/perfis/template-perfil.jpg";
                }
            });
        }

        // Meus artigos.
        const btnMeusArtigos = document.getElementById("btnMeusArtigos");

        if (btnMeusArtigos) {
            btnMeusArtigos.addEventListener("click", function () {
                window.location.href = "meus-artigos.html";
            });
        }

        // Painel administrativo, apenas para administradores.
        const btnPainelAdmin = document.getElementById("btnPainelAdmin");

        if (btnPainelAdmin && Number(usuario.tipo) === 1) {
            btnPainelAdmin.addEventListener("click", function () {
                window.location.href = "admin.html";
            });
        }

        // Logout do dropdown do perfil.
        const btnLogout = document.getElementById("btnLogout");

        if (btnLogout) {
            btnLogout.addEventListener("click", function () {
                localStorage.removeItem("token");
                sessionStorage.removeItem("filtrosArtigos");

                window.location.href = "index.html";
            });
        }
    } catch (erro) {
        console.error("Erro ao verificar login:", erro);

        // Em caso de falha na verificação, não presumimos login válido.
        atualizarMenuMobile(null);
    }
}

verificarLogin();

// Botão "Criar Artigo" - redireciona para criar.html se estiver logado, caso contrário mostra notificação.
const btnCriarArtigo = document.getElementById("btnCriarArtigo");

if (btnCriarArtigo) {
    btnCriarArtigo.addEventListener("click", function () {
        const token = localStorage.getItem("token");

        if (!token) {
            mostrarNotificacao(
                "Você precisa estar logado para escrever um artigo.",
                "aviso"
            );

            return;
        }

        window.location.href = "criar.html";
    });
}

// Função para exibir notificações na tela
function mostrarNotificacao(mensagem, tipo = "sucesso") {
    let notificacao = document.getElementById("notificacao");

    if (!notificacao) {
        notificacao = document.createElement("div");
        notificacao.id = "notificacao";
        document.body.appendChild(notificacao);
    }

    notificacao.textContent = mensagem;

    notificacao.className = "";
    notificacao.classList.add("notificacao", tipo);

    setTimeout(function () {
        notificacao.classList.add("visivel");
    }, 10);

    setTimeout(function () {
        notificacao.classList.remove("visivel");
    }, 3500);
}