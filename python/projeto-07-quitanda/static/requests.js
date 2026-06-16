const API_URL = "http://127.0.0.1:5000/api/produtos";

// Carrega a lista automaticamente ao abrir a página
document.addEventListener("DOMContentLoaded", listar_produtos);

// 1. GET - Buscar e listar os produtos na tabela
function listar_produtos() {
    fetch(API_URL)
        .then(response => response.json())
        .then(produtos => {
            const tbody = document.getElementById("tabela-produtos");
            tbody.innerHTML = ""; // Limpa a tabela antes de preencher

            if (produtos.length === 0) {
                tbody.innerHTML = `<tr><td colspan="6" class="text-center text-muted py-4">Nenhum produto cadastrado no estoque.</td></tr>`;
                return;
            }

            produtos.forEach(p => {
                tbody.innerHTML += `
                    <tr>
                        <td><span class="badge bg-light text-dark border">#${p.id}</span></td>
                        <td class="fw-medium">${p.nome}</td>
                        <td>${p.marca}</td>
                        <td class="text-end fw-semibold">R$ ${parseFloat(p.preco).toFixed(2)}</td>
                        <td class="text-end">${p.quantidade}</td>
                        <td class="text-center">
                            <button class="btn btn-action btn-outline-primary me-1" onclick="preparar_edicao(${JSON.stringify(p).replace(/"/g, '&quot;')})">Editar</button>
                            <button class="btn btn-action btn-outline-danger" onclick="deletar_produto(${p.id})">Excluir</button>
                        </td>
                    </tr>
                `;
            });
        })
        .catch(error => exibir_mensagem("Erro ao buscar os produtos do servidor.", "danger"));
}

// 2. POST ou PUT - Gravar ou Atualizar Dados
function gravar_dados() {
    const id = document.getElementById("id").value;
    const nome = document.getElementById("nome").value;
    const marca = document.getElementById("marca").value;
    const preco = document.getElementById("preco").value;
    const quantidade = document.getElementById("quantidade").value;

    if (!nome || !marca || !preco || !quantidade) {
        exibir_mensagem("Por favor, preencha todos os campos obrigatórios.", "warning");
        return;
    }

    const produtoDados = { nome, marca, preco: parseFloat(preco), quantidade: parseInt(quantidade) };
    const url = id ? `${API_URL}/${id}` : API_URL;
    const método = id ? "PUT" : "POST";

    // UX Sênior: Feedback de Loading e trava cliques duplos
    const btn = document.getElementById("btn-salvar");
    btn.disabled = true;
    btn.innerHTML = `<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Processando...`;

    fetch(url, {
        method: método,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(produtoDados)
    })
    .then(response => {
        if (!response.ok) throw new Error();
        return response.json();
    })
    .then(data => {
        exibir_mensagem(data.mensagem, "success");
        limpar_formulario();
        listar_produtos(); // Atualiza a tabela imediatamente
    })
    .catch(() => exibir_mensagem("Ocorreu um erro ao processar a operação.", "danger"))
    .finally(() => {
        // Restaura o botão ao normal
        btn.disabled = false;
        btn.innerHTML = "Salvar Produto";
    });
}

// 3. DELETE - Excluir Produto
function deletar_produto(id) {
    if (confirm("Tem certeza que deseja remover este produto do estoque?")) {
        fetch(`${API_URL}/${id}`, { method: "DELETE" })
            .then(response => response.json())
            .then(data => {
                exibir_mensagem(data.mensagem, "success");
                listar_produtos();
            })
            .catch(() => exibir_mensagem("Erro ao tentar deletar o produto.", "danger"));
    }
}

// Auxiliar: Coloca os dados da linha nos inputs para edição (UX)
function preparar_edicao(produto) {
    document.getElementById("id").value = produto.id;
    document.getElementById("nome").value = produto.nome;
    document.getElementById("marca").value = produto.marca;
    document.getElementById("preco").value = produto.preco;
    document.getElementById("quantidade").value = produto.quantidade;

    const btn = document.getElementById("btn-salvar");
    btn.innerHTML = "Atualizar Produto";
    btn.className = "btn btn-primary-custom w-100 btn-warning-edit"; // Destaca que mudou o modo
    window.scrollTo({ top: 0, behavior: 'smooth' }); // Sobe a página com suavidade
}

// Auxiliar: Limpar formulário e resets estruturais
function limpar_formulario() {
    document.getElementById("id").value = "";
    document.getElementById("nome").value = "";
    document.getElementById("marca").value = "";
    document.getElementById("preco").value = "";
    document.getElementById("quantidade").value = "";
    document.getElementById("btn-salvar").innerHTML = "Salvar Produto";
}

// Auxiliar: Exibir mensagens flutuantes temporárias (Feedback UX)
function exibir_mensagem(texto, tipo) {
    const box = document.getElementById("mensagem");
    box.className = `alert mt-3 alert-${tipo}`;
    box.innerHTML = texto;
    
    // Remove o efeito sumido do Bootstrap
    box.classList.remove("d-none");
    
    // Auto-oculta o alerta após 4 segundos para limpar a tela
    setTimeout(() => {
        box.classList.add("d-none");
    }, 4000);
}