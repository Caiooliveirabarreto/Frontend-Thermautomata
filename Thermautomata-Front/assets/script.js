
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
    const menu = document.querySelector("#mobileNavPanel nav");

    // Cria o link Meu Perfil caso ainda não exista.
    let linkPerfil = document.getElementById("mobileProfileLink");

    if (menu && !linkPerfil) {
        linkPerfil = document.createElement("a");

        linkPerfil.href = "perfil.html";
        linkPerfil.className = "nav-link-custom";
        linkPerfil.id = "mobileProfileLink";
        linkPerfil.textContent = "MEU PERFIL";

        const linkDownload = menu.querySelector(
            'a[href="download.html"]'
        );

        if (linkDownload) {
            linkDownload.insertAdjacentElement(
                "afterend",
                linkPerfil
            );
        } else {
            menu.appendChild(linkPerfil);
        }
    }

    if (linkPerfil) {
        linkPerfil.hidden = !usuario;
    }

    // Os atalhos antigos serão acessados pelo perfil.
    if (menu) {
        menu.querySelectorAll(
            'a[href="meus-artigos.html"]'
        ).forEach(function (link) {
            link.hidden = true;
        });
    }

    // Painel administrativo apenas para administradores.
    if (painel) {
        painel.hidden = !(usuario && Number(usuario.tipo) === 1);
    }

    if (!acaoLogin) return;

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
        let url = `${window.API_BASE}/artigos/`;
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
            elemento.classList.add("artigo");

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

            const linkAutor = document.createElement("a");

            linkAutor.className = "link-perfil-autor";
            linkAutor.href =
                `perfil.html?id=${encodeURIComponent(artigo.iduser)}`;

            linkAutor.textContent = artigo.nome_autor;

            autorElemento.appendChild(linkAutor);

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

            const separador = document.createElement("hr");
            separador.classList.add("separador-artigos");

            listaArtigos.appendChild(separador);
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
    const finalizarVerificacao = () => {
        document.documentElement.classList.remove("usuario-autenticando");
    };

    if (!token) {
        atualizarMenuMobile(null);
        finalizarVerificacao();
        return;
    }

    try {
        const resposta = await fetch(
            `${window.API_BASE}/auth/me`,
            {
                headers: {
                    Authorization: `Bearer ${token}`
                }
            }
        );

        if (!resposta.ok) {
            localStorage.removeItem("token");
            atualizarMenuMobile(null);
            finalizarVerificacao();
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
            `${window.API_BASE}/uploads/perfis/${encodeURIComponent(fotoUsuario)}`;

        loginButtons.innerHTML = `
            <div class="perfil-menu">
                <img
                    src="${fotoUrl}"
                    alt="Foto de perfil"
                    class="foto-perfil-nav"
                    id="fotoPerfilNav"
                >

                <div class="perfil-dropdown" id="perfilDropdown">

                    <button id="btnMeuPerfil" type="button">
                        Meu perfil
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

        finalizarVerificacao();

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
                        `${window.API_BASE}/uploads/perfis/template-perfil.jpg`;
                }
            });
        }

        // Acessar o perfil do usuário.
        const btnMeuPerfil = document.getElementById("btnMeuPerfil");

        if (btnMeuPerfil) {
            btnMeuPerfil.addEventListener("click", function () {
                window.location.href = "perfil.html";
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
        finalizarVerificacao();
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

// ======================================================
// PÁGINA DE PERFIL
// ======================================================

(function inicializarPaginaPerfil() {

    const paginaPerfil = document.querySelector(".pagina-perfil");

    // Não executa em outras páginas do site.
    if (!paginaPerfil) return;

    const API = window.API_BASE;

    const foto = document.getElementById("perfilFoto");
    const nome = document.getElementById("perfilNome");
    const descricao = document.getElementById("perfilDescricao");
    const totalArtigos = document.getElementById("perfilTotalArtigos");

    const abas = document.getElementById("perfilAbas");
    const mensagem = document.getElementById("perfilMensagem");
    const lista = document.getElementById("listaPerfilArtigos");

    let artigosEscritos = [];
    let artigosFavoritos = [];


    // Faz requisições à API.
    async function requisitarAPI(url, token = null) {
        const opcoes = {};

        if (token) {
            opcoes.headers = {
                Authorization: `Bearer ${token}`
            };
        }

        const resposta = await fetch(url, opcoes);
        const dados = await resposta.json().catch(() => ({}));

        if (!resposta.ok) {
            throw new Error(
                dados.detail || "Não foi possível carregar as informações."
            );
        }

        return dados;
    }


    // Formata datas.
    function formatarData(valor) {
        if (!valor) return "Data não informada";

        const data = new Date(valor);

        if (Number.isNaN(data.getTime())) {
            return "Data não informada";
        }

        return data.toLocaleDateString("pt-BR");
    }


    // Cria elementos de texto sem interpretar o conteúdo como HTML.
    function criarTexto(tag, classe, conteudo) {
        const elemento = document.createElement(tag);

        if (classe) {
            elemento.className = classe;
        }

        elemento.textContent = conteudo || "";

        return elemento;
    }


    // Cria um link para o perfil de um autor.
    function criarLinkAutor(idUsuario, nomeAutor) {
        const link = document.createElement("a");

        link.className = "link-perfil-autor";
        link.href = `perfil.html?id=${encodeURIComponent(idUsuario)}`;
        link.textContent = nomeAutor || "Autor não informado";

        return link;
    }


    // Exibe mensagens na página.
    function exibirMensagem(texto, tipo = "") {
        mensagem.textContent = texto;
        mensagem.className = "perfil-mensagem";

        if (tipo) {
            mensagem.classList.add(tipo);
        }

        mensagem.hidden = !texto;
    }


    // Atualiza o cabeçalho do perfil.
    function preencherPerfil(perfil, proprio) {
        nome.textContent = perfil.nome || "Usuário";

        descricao.textContent = proprio
            ? "Este é o seu perfil no Thermautomata."
            : "Perfil de autor no Thermautomata.";

        totalArtigos.textContent = perfil.total_artigos ?? 0;

        const fotoUsuario =
            perfil.foto_perfil ||
            perfil.foto ||
            "template-perfil.jpg";

        foto.src =
            `${API}/uploads/perfis/${encodeURIComponent(fotoUsuario)}`;

        foto.onerror = function () {
            foto.onerror = null;

            foto.src =
                `${API}/uploads/perfis/template-perfil.jpg`;
        };
    }


    // Cria um cartão para os artigos escritos.
    function criarCartaoEscrito(artigo, publico = false) {
        const card = document.createElement("article");
        card.className = "meu-artigo";

        const conteudo = document.createElement("div");
        conteudo.className = "meu-artigo-conteudo";

        const status = artigo.status || "aprovado";
        const publicado = status === "aprovado";

        // Define o endereço correto para abrir o artigo
        const urlArtigo = publicado
            ? `artigo.html?id=${encodeURIComponent(artigo.idart)}`
            : `artigo.html?id=${encodeURIComponent(artigo.idart)}&preview=1`;

        // Título do artigo
        const titulo = document.createElement("h2");
        const linkTitulo = document.createElement("a");

        linkTitulo.href = urlArtigo;
        linkTitulo.textContent =
            artigo.titulo || "Artigo sem título";

        titulo.appendChild(linkTitulo);
        conteudo.appendChild(titulo);

        // Data
        const dataExibida = publicado
            ? (artigo.data_publicacao || artigo.data_criacao)
            : artigo.data_criacao;

        const textoData = publicado
            ? "Publicado em: "
            : "Enviado em: ";

        conteudo.appendChild(
            criarTexto(
                "p",
                "meu-artigo-data",
                textoData + formatarData(dataExibida)
            )
        );

        const texto = String(
            artigo.resumo || artigo.artigo || ""
        ).replace(/\s+/g, " ").trim();

        const resumo = texto.length > 220
            ? texto.slice(0, 220).trimEnd() + "..."
            : texto;

        conteudo.appendChild(
            criarTexto(
                "p",
                "perfil-resumo",
                resumo || "Nenhuma descrição disponível."
            )
        );

        card.appendChild(conteudo);

        // No perfil próprio, exibe os status dos artigos.
        if (!publico) {
            const acoes = document.createElement("div");
            acoes.className = "meu-artigo-acoes";

            const classeStatus = {
                aprovado: "status-aprovado",
                pendente: "status-pendente",
                rejeitado: "status-rejeitado"
            };

            const textoStatus = {
                aprovado: "Publicado",
                pendente: "Pendente",
                rejeitado: "Rejeitado"
            };

            const etiqueta = document.createElement("span");

            etiqueta.className =
                `status-artigo ${classeStatus[status] || ""}`;

            etiqueta.textContent =
                textoStatus[status] || status;

            acoes.appendChild(etiqueta);

            const botao = document.createElement("a");

            botao.className = "btn-visualizar";
            botao.href = urlArtigo;
            botao.textContent = "VISUALIZAR";

            acoes.appendChild(botao);
            card.appendChild(acoes);
        }

        return card;
    }


    // Cria um cartão para os artigos favoritados.
    function criarCartaoFavorito(artigo) {
        const card = document.createElement("article");
        card.className = "card-artigo-salvo";

        const conteudo = document.createElement("div");
        conteudo.className = "card-salvo-conteudo";

        const data = artigo.data_publicacao || artigo.data_criacao;

        conteudo.appendChild(
            criarTexto(
                "p",
                "card-salvo-data",
                `Publicado em: ${formatarData(data)}`
            )
        );

        // Título do artigo.
        const titulo = document.createElement("h2");
        const linkTitulo = document.createElement("a");

        linkTitulo.href =
            `artigo.html?id=${encodeURIComponent(artigo.idart)}`;

        linkTitulo.textContent =
            artigo.titulo || "Artigo sem título";

        titulo.appendChild(linkTitulo);
        conteudo.appendChild(titulo);

        // Nome do autor com link para o perfil.
        const autor = document.createElement("p");
        autor.className = "card-salvo-autor";

        autor.append("Por ");

        autor.appendChild(
            criarLinkAutor(artigo.iduser, artigo.nome_autor)
        );

        conteudo.appendChild(autor);

        // Resumo do artigo.
        const texto = String(
            artigo.resumo || artigo.artigo || ""
        ).replace(/\s+/g, " ").trim();

        const resumo = texto.length > 220
            ? texto.slice(0, 220).trimEnd() + "..."
            : texto;

        conteudo.appendChild(
            criarTexto(
                "p",
                "card-salvo-resumo",
                resumo || "Nenhuma descrição disponível."
            )
        );

        card.appendChild(conteudo);

        // Botões de ação.
        const acoes = document.createElement("div");
        acoes.className = "card-salvo-acoes";

        // Abrir artigo.
        const botaoLer = document.createElement("a");

        botaoLer.className = "btn-abrir-salvo";
        botaoLer.href =
            `artigo.html?id=${encodeURIComponent(artigo.idart)}`;

        botaoLer.textContent = "Ler artigo";

        acoes.appendChild(botaoLer);

        // Remover dos favoritos.
        const botaoRemover = document.createElement("button");

        botaoRemover.className = "btn-remover-salvo";
        botaoRemover.type = "button";
        botaoRemover.dataset.idArtigo = artigo.idart;
        botaoRemover.textContent = "Remover dos favoritos";

        acoes.appendChild(botaoRemover);

        card.appendChild(acoes);

        return card;
    }


    // Mostra uma lista de artigos na página.
    function exibirArtigos(artigos, tipo) {
        lista.innerHTML = "";

        if (!Array.isArray(artigos) || artigos.length === 0) {
            let texto = "Nenhum artigo encontrado.";

            if (tipo === "escritos") {
                texto = "Você ainda não escreveu nenhum artigo.";
            } else if (tipo === "favoritos") {
                texto = "Você ainda não favoritou nenhum artigo.";
            } else if (tipo === "publicos") {
                texto = "Este usuário ainda não publicou artigos.";
            }

            exibirMensagem(texto, "vazio");
            return;
        }

        exibirMensagem("");

        artigos.forEach(function (artigo) {
            let card;

            if (tipo === "favoritos") {
                card = criarCartaoFavorito(artigo);
            } else {
                card = criarCartaoEscrito(
                    artigo,
                    tipo === "publicos"
                );
            }

            lista.appendChild(card);
        });
    }


    // Troca entre as abas do perfil próprio.
    function trocarAba(abaSelecionada) {
        document.querySelectorAll(".perfil-aba").forEach(function (aba) {
            const selecionada =
                aba.dataset.aba === abaSelecionada;

            aba.classList.toggle("ativa", selecionada);
            aba.setAttribute(
                "aria-selected",
                String(selecionada)
            );
        });

        if (abaSelecionada === "escritos") {
            exibirArtigos(artigosEscritos, "escritos");
        } else {
            exibirArtigos(artigosFavoritos, "favoritos");
        }
    }


    // Inicializa a página.
    async function carregarPerfil() {
        const parametros = new URLSearchParams(window.location.search);
        const idParametro = parametros.get("id");
        const token = localStorage.getItem("token");

        let usuarioLogado = null;
        let idUsuario;

        try {
            // Verifica se existe um usuário autenticado.
            if (token) {
                try {
                    usuarioLogado = await requisitarAPI(
                        `${API}/auth/me`,
                        token
                    );
                } catch (erro) {
                    localStorage.removeItem("token");
                    usuarioLogado = null;
                }
            }

            // Sem ID na URL, abre o perfil do usuário logado.
            if (!idParametro) {
                if (!usuarioLogado) {
                    window.location.href = "login.html";
                    return;
                }

                idUsuario = Number(usuarioLogado.iduser);

            } else {
                idUsuario = Number(idParametro);

                if (
                    !Number.isInteger(idUsuario) ||
                    idUsuario <= 0
                ) {
                    throw new Error("Identificador de perfil inválido.");
                }
            }

            const proprio = Boolean(
                usuarioLogado &&
                Number(usuarioLogado.iduser) === idUsuario
            );

            // Busca os dados públicos do perfil.
            const perfil = await requisitarAPI(
                `${API}/usuarios/${idUsuario}/perfil`
            );

            preencherPerfil(perfil, proprio);

            if (proprio) {
                // Exibe as abas somente no próprio perfil.
                abas.hidden = false;

                const [escritos, favoritos] = await Promise.all([
                    requisitarAPI(
                        `${API}/artigos/meus`,
                        token
                    ),
                    requisitarAPI(
                        `${API}/artigos/salvos`,
                        token
                    )
                ]);

                artigosEscritos = escritos;
                artigosFavoritos = favoritos;

                trocarAba("escritos");

            } else {
                // Visitantes veem somente os artigos publicados.
                abas.hidden = true;

                const artigos = await requisitarAPI(
                    `${API}/usuarios/${idUsuario}/artigos`
                );

                exibirArtigos(artigos, "publicos");
            }

        } catch (erro) {
            console.error("Erro ao carregar perfil:", erro);

            nome.textContent = "Perfil indisponível";

            descricao.textContent =
                "Não foi possível carregar as informações deste usuário.";

            totalArtigos.textContent = "—";

            exibirMensagem(
                erro.message || "Não foi possível carregar o perfil.",
                "erro"
            );
        }
    }


    // Eventos das abas.
    document.querySelectorAll(".perfil-aba").forEach(function (aba) {
        aba.addEventListener("click", function () {
            trocarAba(aba.dataset.aba);
        });
    });

    // Remove artigos dos favoritos diretamente pelo perfil.
    lista.addEventListener("click", async function (evento) {

        const botao = evento.target.closest(".btn-remover-salvo");

        if (!botao) return;

        const idArtigo = botao.dataset.idArtigo;
        const token = localStorage.getItem("token");

        if (!token) {
            window.location.href = "login.html";
            return;
        }

        // Evita cliques repetidos durante a requisição.
        botao.disabled = true;
        botao.textContent = "Removendo...";

        try {
            const resposta = await fetch(
                `${API}/artigos/salvar/${encodeURIComponent(idArtigo)}`,
                {
                    method: "DELETE",
                    headers: {
                        Authorization: `Bearer ${token}`
                    }
                }
            );

            const resultado = await resposta.json().catch(() => ({}));

            if (resposta.status === 401 || resposta.status === 403) {
                localStorage.removeItem("token");
                window.location.href = "login.html";
                return;
            }

            if (!resposta.ok) {
                throw new Error(
                    resultado.detail || "Não foi possível remover o favorito."
                );
            }

            // Atualiza a lista armazenada no JavaScript.
            artigosFavoritos = artigosFavoritos.filter(function (artigo) {
                return String(artigo.idart) !== String(idArtigo);
            });

            // Remove o cartão da página.
            const cartao = botao.closest(".card-artigo-salvo");

            if (cartao) {
                cartao.remove();
            }

            // Exibe a mensagem de lista vazia quando necessário.
            if (artigosFavoritos.length === 0) {
                exibirArtigos(artigosFavoritos, "favoritos");
            } else {
                mostrarNotificacao(
                    "Artigo removido dos favoritos.",
                    "sucesso"
                );
            }

        } catch (erro) {
            console.error("Erro ao remover favorito:", erro);

            botao.disabled = false;
            botao.textContent = "Remover dos favoritos";

            mostrarNotificacao(
                erro.message || "Não foi possível remover o favorito.",
                "aviso"
            );
        }
    });
    carregarPerfil();

})();