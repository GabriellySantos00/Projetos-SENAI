/**
 * Arquivo de Scripts do Projeto - Controle de Finanças
 * Focado em animações nativas de alta performance (Vanilla JS)
 */

document.addEventListener("DOMContentLoaded", () => {
    // 1. EFEITO DE ESCRITA (Typing Effect)
    const tituloElemento = document.querySelector(".efeito-escrita");
    if (tituloElemento) {
        const textoOriginal = tituloElemento.innerText;
        tituloElemento.innerText = ""; // Limpa o texto para iniciar o efeito
        let i = 0;
        
        function escrever() {
            if (i < textoOriginal.length) {
                tituloElemento.innerText += textoOriginal.charAt(i);
                i++;
                setTimeout(escrever, 50); // Velocidade da escrita (em milissegundos)
            }
        }
        // Inicia a escrita após um pequeno delay para suavidade
        setTimeout(escrever, 200);
    }

    // 2. ANIMAÇÃO DE SURGIMENTO DE BAIXO (Fade-In-Up) com Delay Dinâmico
    const elementosParaAnimar = document.querySelectorAll(".animar-entrada");
    
    elementosParaAnimar.forEach((elemento, index) => {
        // Aplica um delay incremental para cada elemento surgir um após o outro (efeito cascata)
        elemento.style.animationDelay = `${(index + 1) * 0.15}s`;
        elemento.classList.add("executar-animacao");
    });
});