--Você é um professor e deseja identificar o aluno que obteve a maior nota em sua disciplina.
--Você tem duas tabelas em seu banco de dados: "Alunos" e "Notas". A tabela "Notas" registra as 
--notas dos alunos em sua disciplina. Seu desafio é encontrar o aluno com a maior nota.
--Tabela "Alunos":
--
--ID_aluno (chave primária)
--Nome
--Curso
--Tabela "Notas":
--ID_nota (chave primária)
--ID_aluno (chave estrangeira)
--Nota
--Seu desafio é criar uma consulta SQL que retorne o nome do aluno que obteve a maior nota em sua disciplina.

CREATE TABLE alunos (
id_aluno int PRIMARY key,
  nome varchar (100),
  curso varchar(100)
);
CREATE TABLE notas (
  id_nota int PRIMARY key,
  id_aluno int,
  nota float,
  FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)
);
INSERT INTO alunos (id_aluno, nome, curso) VALUES
(1, 'Carlos Mendes', 'Análise e Desenvolvimento de Sistemas'),
(2, 'João Silva', 'Administração'),
(3, 'Mariana Souza', 'Ciência da Computação'),
(4, 'Ana Costa', 'Engenharia de Software'),
(5, 'Pedro Oliveira', 'Sistemas de Informação');
INSERT INTO notas (id_nota, id_aluno, nota) VALUES
(1, 1, 8.5),
(2, 2, 7.0),
(3, 3, 9.2),
(4, 4, 6.5),
(5, 5, 8.0);

SELECT nome FROM alunos WHERE id_aluno = 
(SELECT id_aluno from notas where nota = (SELECT max(nota) from notas));


