USE app_filmes;

CREATE DATABASE diario_filmes;

USE diario_filmes;

CREATE TABLE filmes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    genero VARCHAR(50) NOT NULL,
    plataforma VARCHAR(50),
    status VARCHAR(30),
    nota INT,
    comentario TEXT
);
SELECT * FROM filmes;