CREATE DATABASE projeto_escola;

CREATE TABLE endereco(
	id INT PRIMARY KEY AUTO_INCREMENT,
	rua VARCHAR(50) NOT NULL,
	numero VARCHAR(10) NOT null,
	bairro VARCHAR(50) NOT null,
	cep VARCHAR(8) NOT NULL,
	cidade VARCHAR(50) NOT NULL,
	estado VARCHAR(50) NOT NULL,
	pais VARCHAR(50) NOT NULL
);

INSERT INTO endereco (rua, numero, bairro, cep, cidade, estado, pais)
	VALUES('cachoeira', '78', 'inacio', '21458745', 'São Paulo', 'SP', 'Brasil');
	
INSERT INTO endereco (rua, numero, bairro, cep, cidade, estado, pais)
	VALUES('uva', '08', 'lata velha', '58974632', 'Guarulhos', 'PR', 'Brasil');

INSERT INTO endereco (rua, numero, bairro, cep, cidade, estado, pais)
	VALUES('pedro', '100', 'braz cubas', '85967412', 'mogi', 'SP', 'Brasil');
	
INSERT INTO endereco (rua, numero, bairro, cep, cidade, estado, pais)
	VALUES('acaju', '212', 'Xepa', '21369874', 'rio', 'MG', 'Brasil');	

INSERT INTO endereco (rua, numero, bairro, cep, cidade, estado, pais)
	VALUES('gomes', '859', 'maia', '87412369', 'fazenda', 'PR', 'Brasil');
	
INSERT INTO endereco (rua, numero, bairro, cep, cidade, estado, pais)
	VALUES('pedro chaves', '12', 'preste maia', '23145678', 'corinthias', 'SP', 'Brasil');


CREATE TABLE aluno(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(20) NOT NULL,
	dataNasc DATE NOT NULL,
	email VARCHAR(100) NOT NULL,
	ra VARCHAR(20) UNIQUE,
	telefone VARCHAR(11) NOT NULL,
	id_endereco INT,
	FOREIGN KEY (id_endereco) REFERENCES endereco(id)
);

INSERT INTO aluno (nome, dataNasc, email, ra, telefone,)
	VALUES('fernando', 1987/08/12, 'fernando345@gmail.com', '8745213', '119874536', 1 );

INSERT INTO aluno (nome, dataNasc, email, ra, telefone,)
	VALUES('nanda', 2010/07/12, 'nanda345@gmail.com', '40028922', '114789455', 2 );
	
INSERT INTO aluno (nome, dataNasc, email, ra, telefone,)
	VALUES('bruno', 2010/08/13, 'bruno123@gmail.com', '85544796', '119874897', 3 );
	
INSERT INTO aluno (nome, dataNasc, email, ra, telefone,)
	VALUES('carla', 2000/02/28, 'carla2018@gmail.com', '5213697', '11949014387', 5 );
	
INSERT INTO aluno (nome, dataNasc, email, ra, telefone,)
	VALUES('gustavo', 1997/02/02, 'gustavo865@gmail.com', '28974563', '118412588', 4 );
	
INSERT INTO aluno (nome, dataNasc, email, ra, telefone,)
	VALUES('ester', 2001/05/12, 'esters2@gmail.com', '17412333', '258712223', 3 );
	
INSERT INTO aluno (nome, dataNasc, email, ra, telefone,)
	VALUES('perla', 2001/04/02, 'perla78@gmail.com', '96325874', '558796314', 6 );

CREATE TABLE matricula(
	id INT PRIMARY KEY AUTO_INCREMENT,
	data_matricula date NOT NULL,
	id_aluno INT,
	FOREIGN KEY (id_aluno) REFERENCES aluno(id)
);

CREATE TABLE escola(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	cnpj VARCHAR(14) UNIQUE,
	telefone VARCHAR(11) NOT NULL,
	email VARCHAR(100) NOT NULL,
	id_endereco INT,
	id_diretor INT,
	FOREIGN KEY (id_endereco) REFERENCES endereco(id),
	FOREIGN KEY (id_diretor) REFERENCES diretor(id)
);

CREATE TABLE cod_escolaMatricula(
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_matricula INT,
	id_escola INT,
	FOREIGN KEY (id_matricula) REFERENCES matricula(id),
	FOREIGN KEY (id_escola) REFERENCES escola(id)
);

CREATE TABLE curso(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(20) NOT NULL,
	informacoes VARCHAR(200) NOT NULL,
	carga_horaria VARCHAR(11) NOT NULL,
	conclusao DATE NOT NULL
);

CREATE TABLE cod_escolaCurso(
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_curso INT,
	id_escola INT,
	FOREIGN KEY (id_curso) REFERENCES curso(id),
	FOREIGN KEY (id_escola) REFERENCES escola(id)
);

CREATE TABLE diretor(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(20) NOT NULL,
	telefone VARCHAR(11) NOT NULL,
	email VARCHAR(100) NOT NULL,
	id_endereco INT,
	FOREIGN KEY (id_endereco) REFERENCES endereco(id)
);

CREATE TABLE professor(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(20) NOT NULL,
	cod_professor VARCHAR(14) NOT NULL,
	materia VARCHAR(10) NOT NULL,
	telefone VARCHAR(11) NOT NULL,
	email VARCHAR(100) NOT NULL,
	id_diretor INT,
	id_endereco INT,
	FOREIGN KEY (id_diretor) REFERENCES diretor(id),
	FOREIGN KEY (id_endereco) REFERENCES endereco(id)
);

CREATE TABLE cod_cursoProfessor(
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_curso INT,
	id_professor INT,
	FOREIGN KEY (id_curso) REFERENCES curso(id),
	FOREIGN KEY (id_professor) REFERENCES professor(id)
);


SELECT a.nome, a.ra, m.data_matricula, e.nome FROM aluno a
	JOIN matricula m
	ON m.id_aluno = a.id
	JOIN cod_escolamatricula cem
	ON m.id = cem.id_matricula
	JOIN escola e
	ON e.id = cem.id_escola;


SELECT e.nome, c.nome, c.informacoes, c.carga_horaria FROM escola e
	JOIN cod_escolacurso cec
	ON  cec.id_escola = e.id
	JOIN curso c 
	ON cec.id_curso = c.id;
	
	
SELECT e.nome, d.nome, p.nome FROM escola e
	JOIN diretor d
	ON e.id_diretor = d.id
	JOIN professor p
	ON p.id_diretor = d.id;
	
	
SELECT a.nome, e.rua, e.numero, e.bairro, e.cep, e.estado, e.pais FROM aluno a 
	JOIN endereco e
	ON a.id_endereco = e.id;	
	

SELECT a.nome, m.data_matricula, e.nome, c.nome FROM aluno a
	JOIN matricula m
	ON m.id_aluno = a.id
	JOIN cod_escolamatricula cme 
	ON cme.id_matricula = m.id
	JOIN escola e
	ON cme.id_escola = e.id
	JOIN cod_escolacurso cec
	ON cec.id_escola = e.id
	JOIN curso c
	ON cec.id_curso = c.id;
	
SELECT a.nome, a.dataNasc FROM aluno a
	WHERE a.dataNasc <= '2003/01/01'; 
 
	
SELECT c.nome, c.carga_horaria, c.conclusao FROM curso c
	WHERE c.carga_horaria > "200 horas";
	

SELECT a.nome, e.cidade, e.estado FROM aluno a
	JOIN endereco e
	ON a.id_endereco = e.id;


SELECT * FROM endereco;
SELECT * FROM aluno;
SELECT * FROM matricula;
SELECT * FROM escola;
SELECT * FROM cod_escolamatricula;
SELECT * FROM curso;
SELECT * FROM cod_escolacurso;
SELECT * FROM diretor;
SELECT * FROM professor;
SELECT * FROM cod_cursoProfessor;