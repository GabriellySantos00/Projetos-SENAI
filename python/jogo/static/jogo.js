let scene, camera, renderer;
let carro, pista;

let obstaculos = [];
let predios = [];
let linhas = [];
let rampas = [];

let jogoAtivo = false;
let pontos = 0;
let velocidade = 0.35;
let direcao = 0;

let pulando = false;
let alturaPulo = 0;
let velocidadePulo = 0;

let texturaPlayer, texturaInimigo;

const teclas = {};

document.addEventListener("keydown", (e) => {
    teclas[e.key.toLowerCase()] = true;
});

document.addEventListener("keyup", (e) => {
    teclas[e.key.toLowerCase()] = false;
});

function init() {
    scene = new THREE.Scene();
    scene.background = new THREE.Color(0x02040a);
    scene.fog = new THREE.Fog(0x02040a, 12, 70);

    camera = new THREE.PerspectiveCamera(
        70,
        window.innerWidth / window.innerHeight,
        0.1,
        1000
    );

    camera.position.set(0, 5, 9);
    camera.lookAt(0, 0, -8);

    renderer = new THREE.WebGLRenderer({ antialias: true });
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setPixelRatio(window.devicePixelRatio);

    document.getElementById("game").appendChild(renderer.domElement);

    const loader = new THREE.TextureLoader();
    texturaPlayer = loader.load("/static/carro-player.png");
    texturaInimigo = loader.load("/static/carro-inimigo.png");

    criarLuzes();
    criarPista();
    criarCarro();
    criarCidade();

    animate();
}

function criarLuzes() {
    const luzAmbiente = new THREE.AmbientLight(0x6688ff, 0.7);
    scene.add(luzAmbiente);

    const luzFrontal = new THREE.DirectionalLight(0xffffff, 1.4);
    luzFrontal.position.set(0, 8, 8);
    scene.add(luzFrontal);

    const neonAzul = new THREE.PointLight(0x00ccff, 4, 25);
    neonAzul.position.set(-5, 3, 0);
    scene.add(neonAzul);

    const neonRosa = new THREE.PointLight(0xff33cc, 4, 25);
    neonRosa.position.set(5, 3, -5);
    scene.add(neonRosa);
}

function criarPista() {
    const geo = new THREE.BoxGeometry(8, 0.1, 120);

    const mat = new THREE.MeshStandardMaterial({
        color: 0x111318,
        roughness: 0.35,
        metalness: 0.35
    });

    pista = new THREE.Mesh(geo, mat);
    pista.position.z = -35;
    scene.add(pista);

    for (let i = 0; i < 30; i++) {
        const linhaGeo = new THREE.BoxGeometry(0.18, 0.04, 2.5);
        const linhaMat = new THREE.MeshStandardMaterial({
            color: 0xffffff,
            emissive: 0xffffff,
            emissiveIntensity: 0.7
        });

        const linha = new THREE.Mesh(linhaGeo, linhaMat);
        linha.position.set(0, 0.08, -i * 5);
        scene.add(linha);
        linhas.push(linha);
    }

    criarNeonLateral(-4.2, 0x0066ff);
    criarNeonLateral(4.2, 0xff00cc);
}

function criarNeonLateral(x, cor) {
    for (let i = 0; i < 30; i++) {
        const geo = new THREE.BoxGeometry(0.12, 0.08, 3);

        const mat = new THREE.MeshStandardMaterial({
            color: cor,
            emissive: cor,
            emissiveIntensity: 1.8
        });

        const neon = new THREE.Mesh(geo, mat);
        neon.position.set(x, 0.15, -i * 5);

        scene.add(neon);
        linhas.push(neon);
    }
}

function criarCarro() {
    carro = new THREE.Group();

    const baseMat = new THREE.MeshStandardMaterial({
        color: 0x111827,
        metalness: 0.7,
        roughness: 0.25
    });

    const base = new THREE.Mesh(
        new THREE.BoxGeometry(1.8, 0.35, 3.2),
        baseMat
    );
    base.position.y = 0.28;
    carro.add(base);

    const imagemMat = new THREE.MeshBasicMaterial({
        map: texturaPlayer,
        transparent: true
    });

    const imagem = new THREE.Mesh(
        new THREE.PlaneGeometry(2.2, 3.6),
        imagemMat
    );

    imagem.rotation.x = -Math.PI / 2;
    imagem.position.y = 0.5;
    carro.add(imagem);

    const rodaMat = new THREE.MeshStandardMaterial({ color: 0x050505 });

    const rodas = [
        [-0.95, 0.25, -1],
        [0.95, 0.25, -1],
        [-0.95, 0.25, 1],
        [0.95, 0.25, 1]
    ];

    rodas.forEach(pos => {
        const roda = new THREE.Mesh(
            new THREE.CylinderGeometry(0.28, 0.28, 0.22, 24),
            rodaMat
        );
        roda.rotation.z = Math.PI / 2;
        roda.position.set(pos[0], pos[1], pos[2]);
        carro.add(roda);
    });

    scene.add(carro);
    carro.position.set(0, 0, 3);
}

function criarCidade() {
    for (let i = 0; i < 45; i++) {
        criarPredio(-7 - Math.random() * 10, -i * 4);
        criarPredio(7 + Math.random() * 10, -i * 4);
    }
}

function criarPredio(x, z) {
    const altura = 3 + Math.random() * 12;

    const geo = new THREE.BoxGeometry(
        2 + Math.random() * 2,
        altura,
        2 + Math.random() * 3
    );

    const mat = new THREE.MeshStandardMaterial({
        color: 0x080b12,
        roughness: 0.5,
        metalness: 0.2
    });

    const predio = new THREE.Mesh(geo, mat);
    predio.position.set(x, altura / 2, z);

    scene.add(predio);
    predios.push(predio);

    for (let j = 0; j < 4; j++) {
        const luzGeo = new THREE.BoxGeometry(0.25, 0.18, 0.03);
        const cor = Math.random() > 0.5 ? 0x00ccff : 0xff33cc;

        const luzMat = new THREE.MeshStandardMaterial({
            color: cor,
            emissive: cor,
            emissiveIntensity: 1.4
        });

        const luz = new THREE.Mesh(luzGeo, luzMat);
        luz.position.set(x > 0 ? -1.01 : 1.01, 1 + j * 0.7, 0.9);

        predio.add(luz);
    }
}

function criarObstaculo() {
    const faixas = [-2.4, 0, 2.4];
    const x = faixas[Math.floor(Math.random() * faixas.length)];

    const obs = new THREE.Group();

    const base = new THREE.Mesh(
        new THREE.BoxGeometry(1.8, 0.35, 3.2),
        new THREE.MeshStandardMaterial({
            color: 0x151515,
            metalness: 0.6,
            roughness: 0.3
        })
    );
    base.position.y = 0.28;
    obs.add(base);

    const imagem = new THREE.Mesh(
        new THREE.PlaneGeometry(2.2, 3.6),
        new THREE.MeshBasicMaterial({
            map: texturaInimigo,
            transparent: true
        })
    );

    imagem.rotation.x = -Math.PI / 2;
    imagem.position.y = 0.5;
    obs.add(imagem);

    obs.position.set(x, 0, -65);

    scene.add(obs);
    obstaculos.push(obs);
}

function criarRampa() {
    const faixas = [-2.4, 0, 2.4];
    const x = faixas[Math.floor(Math.random() * faixas.length)];

    const geo = new THREE.BoxGeometry(2.5, 0.5, 4);

    const mat = new THREE.MeshStandardMaterial({
        color: 0x555555,
        metalness: 0.6,
        roughness: 0.4
    });

    const rampa = new THREE.Mesh(geo, mat);
    rampa.rotation.x = 0.3;
    rampa.position.set(x, 0.25, -70);

    const neonGeo = new THREE.BoxGeometry(0.08, 0.08, 4);

    const neonMat = new THREE.MeshStandardMaterial({
        color: 0xff00cc,
        emissive: 0xff00cc,
        emissiveIntensity: 2
    });

    const neonEsquerdo = new THREE.Mesh(neonGeo, neonMat);
    neonEsquerdo.position.set(-1.25, 0.15, 0);

    const neonDireito = new THREE.Mesh(neonGeo, neonMat);
    neonDireito.position.set(1.25, 0.15, 0);

    rampa.add(neonEsquerdo);
    rampa.add(neonDireito);

    scene.add(rampa);
    rampas.push(rampa);
}

function moverCarro() {
    direcao = 0;

    if (teclas["a"] || teclas["arrowleft"]) {
        direcao = -1;
    }

    if (teclas["d"] || teclas["arrowright"]) {
        direcao = 1;
    }

    carro.position.x += direcao * 0.18;
    carro.position.x = Math.max(-3, Math.min(3, carro.position.x));

    carro.rotation.z = -direcao * 0.18;
}

function atualizarMundo() {
    const mov = velocidade;

    linhas.forEach(linha => {
        linha.position.z += mov;

        if (linha.position.z > 8) {
            linha.position.z = -120;
        }
    });

    predios.forEach(predio => {
        predio.position.z += mov * 0.9;

        if (predio.position.z > 12) {
            predio.position.z = -170;
        }
    });

    obstaculos.forEach(obs => {
        obs.position.z += mov;
    });

    rampas.forEach(rampa => {
        rampa.position.z += mov;
    });

    obstaculos = obstaculos.filter(obs => {
        if (obs.position.z > 8) {
            scene.remove(obs);
            return false;
        }

        return true;
    });

    rampas = rampas.filter(rampa => {
        if (rampa.position.z > 8) {
            scene.remove(rampa);
            return false;
        }

        return true;
    });
}

function verificarColisao() {
    if (pulando) return;

    obstaculos.forEach(obs => {
        const distanciaX = Math.abs(carro.position.x - obs.position.x);
        const distanciaZ = Math.abs(carro.position.z - obs.position.z);

        if (distanciaX < 1.2 && distanciaZ < 1.8) {
            finalizarJogo();
        }
    });
}

function verificarRampas() {
    rampas.forEach(rampa => {
        const distanciaX = Math.abs(carro.position.x - rampa.position.x);
        const distanciaZ = Math.abs(carro.position.z - rampa.position.z);

        if (distanciaX < 1.2 && distanciaZ < 1.6 && !pulando) {
            pulando = true;
            velocidadePulo = 0.22;
            pontos += 200;
        }
    });
}

function animarPulo() {
    if (pulando) {
        alturaPulo += velocidadePulo;
        velocidadePulo -= 0.012;

        if (alturaPulo <= 0) {
            alturaPulo = 0;
            pulando = false;
        }
    }

    carro.position.y = 0.12 + alturaPulo;
    carro.scale.set(1 + alturaPulo * 0.25, 1 + alturaPulo * 0.25, 1);
}

function atualizarHUD() {
    pontos += Math.floor(velocidade * 10);
    velocidade += 0.0008;

    document.getElementById("pontos").textContent = pontos;
    document.getElementById("velocidade").textContent = velocidade.toFixed(1);
}

function iniciarJogo() {
    jogoAtivo = true;
    pontos = 0;
    velocidade = 0.35;

    carro.position.x = 0;
    carro.position.y = 0.12;
    carro.rotation.z = 0;
    carro.scale.set(1, 1, 1);

    pulando = false;
    alturaPulo = 0;
    velocidadePulo = 0;

    obstaculos.forEach(obs => scene.remove(obs));
    obstaculos = [];

    rampas.forEach(rampa => scene.remove(rampa));
    rampas = [];

    document.getElementById("pontos").textContent = 0;
    document.getElementById("velocidade").textContent = "1.0";
}

setInterval(() => {
    if (jogoAtivo) {
        if (Math.random() > 0.75) {
            criarRampa();
        } else {
            criarObstaculo();
        }
    }
}, 1200);

function finalizarJogo() {
    if (!jogoAtivo) return;

    jogoAtivo = false;

    const nome = prompt(`Fim de jogo! Pontuação: ${pontos}\nDigite seu nome:`);

    if (nome) {
        fetch("/salvar", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nome: nome,
                pontos: pontos
            })
        }).then(() => {
            window.location.reload();
        });
    }
}

function animate() {
    requestAnimationFrame(animate);

    if (jogoAtivo) {
        moverCarro();
        atualizarMundo();

        verificarColisao();
        verificarRampas();
        animarPulo();

        atualizarHUD();

        camera.position.x += (carro.position.x * 0.35 - camera.position.x) * 0.04;
        camera.lookAt(carro.position.x * 0.25, 0.5, -8);
    }

    renderer.render(scene, camera);
}

window.addEventListener("resize", () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();

    renderer.setSize(window.innerWidth, window.innerHeight);
});

init();