DROP DATABASE bd_aulas_procedures;

CREATE SCHEMA IF NOT EXISTS bd_aulas_procedures DEFAULT CHARACTER SET utf8;
USE bd_aulas_procedures;

/*Criando tabela Pais*/

CREATE TABLE pais(
id_pais INT NOT NULL AUTO_INCREMENT,
nome_pais VARCHAR (200) NOT NULL,
PRIMARY KEY (id_pais)
)ENGINE=InnoDB;

INSERT INTO pais VALUES (NULL, "BRASIL"),
						(NULL, "CHILE"),
                        (NULL, "ARGENTINA"),
                        (NULL, "BOLIVIA"),
						(NULL, "URUGUAI");


DELIMITER $$
DROP PROCEDURE IF EXISTS listar_paises $$
CREATE PROCEDURE listar_paises (IN id INT)
BEGIN
  IF (id IS NULL) THEN
  SELECT * FROM pais;
  ELSE
  SELECT * FROM pais WHERE id_pais = id;
  END IF;
  END $$
  DELIMITER ;
  
  /*CHAMANDO PROCEDURE*/
  
  CALL listar_paises(NULL);
  
  CALL listar_paises(1);




  CALL Verificar_Quantidade_Pais(@total);
  SELECT @total;
  
  DELIMITER $$
  CREATE PROCEDURE Verificar_Quantidade_Pais (OUT quantidade INT)
  BEGIN
    SELECT COUNT(*) INTO Quantidade FROM Pais;
  END$$
  DELIMITER ;
  
  
  
  
   DELIMITER $$
  CREATE PROCEDURE Selecionar_Paises (IN quantidade INT)
  BEGIN
    SELECT * FROM Pais
    LIMIT quantidade;
  END$$
  DELIMITER ;
  
  
  CALL Selecionar_Paises (4);
  
  DELIMITER $$
  CREATE PROCEDURE Selecionar_Paises_Iniciando_Com (IN letra VARCHAR(1))
  BEGIN

    SELECT * FROM pais WHERE nome_pais LIKE CONCAT (letra,'%');
  END$$
  DELIMITER ;
  
  CALL Selecionar_Paises_Iniciando_Com('A');
  
  
  