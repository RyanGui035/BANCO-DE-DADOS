DROP DATABASE Biblio;

CREATE SCHEMA IF NOT EXISTS Biblio DEFAULT CHARACTER SET utf8;
USE Biblio;


CREATE TABLE IF NOT EXISTS Livro(
id_livro INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
titulo_livro VARCHAR (100) NOT NULL
)ENGINE=InnoDB;

INSERT INTO livro(titulo_livro)
		   VALUES("Bagagem"),
				 ("O Cortiço"), 
				 ("Lira dos Vinte Anos"),
				 ("Quarud"),
                 ("O Tronco"),
                 ("A escrava Isaura"),
                 ("O Pagador de Promessas"),
                 ("O que é isso, Companheiro"),
                 ("Vidas Secas"),
                 ("Grande Sertão Veredas");

CREATE TABLE IF NOT EXISTS usuario(
id_usuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome_usuario VARCHAR (100) NOT NULL,
email_usuario VARCHAR(250),
dat_nasc_usuario DATE,
quant_emprest_usuario INT NOT NULL DEFAULT 0)
ENGINE=InnoDB;

INSERT INTO usuario(nome_usuario, email_usuario, dat_nasc_usuario)
		   VALUES("João Silva", "joao@email.com", "1992-08-09"),
           ("Maria Mota", "maria@provedor.net", "1984-05-17"),
           ("Eduardo  Cançado", "edu@email.com", "1996-02-23"),
		   ("Silvia Alencar", "silvia@provedor.net", "1973-09-20"),
           ("Gabriela Medeiros", "gabi@provedor.net", "1993-01-10"),
           ("Karina Silva", "karin@email.com", "1995-03-25");


CREATE TABLE IF NOT EXISTS biblio.emprestimo (
id_emprestimo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
usuario_id_usuario INT NOT NULL,
livro_id_livro INT NOT NULL,
data_emprestimo DATE,
data_devolucao DATE,
data_entrega DATE,
FOREIGN KEY (usuario_id_usuario) REFERENCES usuario(id_usuario),
FOREIGN KEY (livro_id_livro) REFERENCES livro(id_livro)
)ENGINE = InnoDB;


INSERT INTO biblio.emprestimo (usuario_id_usuario, livro_id_livro, data_emprestimo, data_devolucao, data_entrega)
                VALUES(1, 4, "2014-07-15", "2014-08-15", "2014-08-10"),
                      (3, 2, "2014-08-22", "2014-09-22", "2014-09-21"),
                      (2, 6, "2014-08-22", "2014-09-22", null),
                      (2, 8, "2014-09-21", "2014-10-21", null),
                      (1, 10, "2014-09-23", "2014-10-23", "2014-09-29"),
                      (4, 2, "2014-09-23", "2014-10-23", null),
                      (4, 7, "2014-09-23", "2014-10-23", null),
                      (5, 3, "2014-09-24", "2014-10-24", null),
                      (5, 9, "2014-09-24", "2014-10-24", null),
					  (5, 1, "2014-09-24", "2014-10-24", null),
                      (6, 3, "2014-09-01", "2014-10-01", "2014-09-30");
                      
                      
DELIMITER $$
CREATE PROCEDURE cadastrar_emprestimo(
    IN usuario_id INT,
    IN livro_id INT)
BEGIN
    SET @dt_emprestimo = CURDATE();
    SET @dt_devolucao = ADDDATE(@dt_emprestimo, 30);
    INSERT INTO emprestimo (usuario_id_usuario, livro_id_livro, data_emprestimo, data_devolucao)
    VALUES (usuario_id, livro_id, @dt_emprestimo, @dt_devolucao);
    UPDATE usuario
    SET quant_emprest_usuario = quant_emprest_usuario + 1
    WHERE id_usuario = usuario_id;
    SELECT "Sucesso" AS mensagem;
END $$

DELIMITER ;

CALL cadastrar_emprestimo(1, 5);

SELECT * FROM emprestimo;

