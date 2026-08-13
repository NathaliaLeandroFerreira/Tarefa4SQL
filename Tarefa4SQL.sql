create table Artista(
  nome varchar(30) NOT NULL,
  idA int primary key auto_increment
);
create table Cliente(
nomeC varchar(30) NOT NULL,
  idC int primary key auto_increment
);
create table Servico (
titulo varchar(100) NOT NULL,
  preco int not null,
  idS int primary key auto_increment,
  idAE int,
   FOREIGN key (idAE) references Artista(idA),
  idCE int,
 foreign key (idCE) references Cliente(idC),
  statusConclusao varchar(30) default 'Progresso'
);
INSERT INTO Artista (nome) VALUES ('Ana'),('Marcos'),('Beatriz'),('Pietro');
INSERT INTO Cliente (nomeC) VALUES ('Carlos'),('Mariana'),('Fernando');
iNSERT INTO Servico (titulo, preco, idAE, idCE) VALUES ('Ilustração Digital', 250, 1, 1),('Design de Logotipo', 400, 1, 2),('Animação 2D', 800, 2, 2),('Modelagem 3D', 1200, 3, 3);

 /*   alterando colunas em uma tabela já criada */ 
alter table Artista add column disponibilidade varchar(30) default 'Disponivel';
alter table Servico modify column preco decimal(10,2); 

 /*  deletando linhas de uma tabela por uma condição*/ 
delete from Servico where preco <300;


 /*   consultas */ 

/*1 consulta - Desempenho dos Artistas*/


SELECT Artista.nome,COALESCE(SUM(Servico.preco), 0) AS total,
  CASE 
        WHEN COALESCE(SUM(Servico.preco), 0) < 600 THEN 'prejuizo'
        ELSE 'Lucro' 
    END AS Desempenho
FROM Artista LEFT JOIN Servico ON Artista.idA = Servico.idAE GROUP BY Artista.idA, Artista.nome;

/*2 consulta - quem presta mais serviços*/

select Artista.nome,Count(Servico.preco) as TotalDeServicoFeitos
from Artista left join Servico on Artista.idA = Servico.idAE group by Artista.nome;

/*3 consulta - que artistas estao prestando que serviços a quais clientes  */

select Artista.nome,Cliente.nomeC,Servico.titulo,Servico.preco,Servico.statusConclusao
from Artista join Servico on Artista.idA = Servico.idAE join Cliente on Servico.idCE = Cliente.idC;

