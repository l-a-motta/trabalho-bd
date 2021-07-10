-- Inserts de Destino
-- Pais VARCHAR(30), Cidade VARCHAR(30), Descricao VARCHAR(180), Idioma VARCHAR(30) NOT NULL, Clima VARCHAR(30)
INSERT INTO public.Destino VALUES ('Brasil','Bauru', 'Desc teste 1', 'Português','Temperado');
INSERT INTO public.Destino VALUES ('Brasil','São Paulo', '', 'Português','Temperado');
INSERT INTO public.Destino VALUES ('Brasil','Rio De Janeiro', '', 'Português','Tropical');
INSERT INTO public.Destino VALUES ('Inglaterra','Londres', 'Desc teste 2', 'Inglês Britânico','Frio');
INSERT INTO public.Destino VALUES ('México','Cidade Do México', 'Desc teste 3', 'Espanhol Mexicano','Tropical');
INSERT INTO public.Destino VALUES ('França','Paris', '', 'Francês','Frio');
INSERT INTO public.Destino VALUES ('Alemanha','Frankfurt', 'Desc teste 4', 'Alemão','Frio');

-- Inserts de DestinoTags
-- PK FK Pais VARCHAR(30), PK FK Cidade VARCHAR(30), PK Tag VARCHAR(30)
INSERT INTO public.DestinoTags VALUES ('Brasil','Bauru','Lanche');
INSERT INTO public.DestinoTags VALUES ('Brasil','São Paulo','Urbano');
INSERT INTO public.DestinoTags VALUES ('Brasil','São Paulo','Metrópole');
INSERT INTO public.DestinoTags VALUES ('Brasil','São Paulo','Turismo');
INSERT INTO public.DestinoTags VALUES ('França','Paris','Metrópole');

-- Inserts de Aeroporto
-- PK CodIATA INT, FK Pais VARCHAR(30) NOT NULL, FK Cidade VARCHAR(30) NOT NULL, Bairro VARCHAR(30) NOT NULL, Rua VARCHAR(30) NOT NULL, Numero VARCHAR(30) NOT NULL, CEP CHAR(9) NOT NULL, Nome VARCHAR(30) NOT NULL
INSERT INTO public.Aeroporto VALUES (111, 'Brasil','Bauru','Geisel','Rua 1','123','17033690','Aeroporto do Geisel');
INSERT INTO public.Aeroporto VALUES (222, 'Brasil','São Paulo','Centro ','Rua 2','321','17033691','Aeroporto do Centro');
INSERT INTO public.Aeroporto VALUES (333, 'Inglaterra','Londres','Greenwich','Rua 3','456','17033-692','Aeroporto de Greenwich');
INSERT INTO public.Aeroporto VALUES (444, 'Inglaterra','Londres','Holland Park','Rua 4','654','17033-693','Aeroporto de Holland Park');
INSERT INTO public.Aeroporto VALUES (555, 'Inglaterra','Londres','Westminster','Rua 5','789','17033694','Aeroporto de Westminster');
INSERT INTO public.Aeroporto VALUES (666, 'Alemanha','Frankfurt','Hauptbahnhof','Rua 6','987','17033695','Aeroporto de Hauptbahnhof');

-- Inserts de Voo
-- PK Nro INT, FK Aeroporto_Origem INT NOT NULL, FK Aeroporto_Destino INT NOT NULL, Data_Partida TIMESTAMP NOT NULL, Data_Chegada TIMESTAMP NOT NULL, Portao_Embarque VARCHAR(30) NOT NULL, Portao_Desembarque VARCHAR(30) NOT NULL
INSERT INTO public.Voo VALUES (101, 111, 222, '2017-03-14', '2017-03-15', 'E126', 'S213');
INSERT INTO public.Voo VALUES (102, 111, 222, '2017-03-14', '2017-03-15', 'E526', 'S432');
INSERT INTO public.Voo VALUES (103, 111, 555, '2017-03-14', '2017-03-16', 'E625', 'S251');
INSERT INTO public.Voo VALUES (201, 222, 111, '2017-03-15', '2017-03-17', 'E413', 'S281');
INSERT INTO public.Voo VALUES (202, 222, 666, '2017-03-15', '2017-04-10', 'E272', 'S453');
INSERT INTO public.Voo VALUES (601, 666, 444, '2021-01-04', '2021-01-15', 'E192', 'S261');
INSERT INTO public.Voo VALUES (602, 666, 444, '2021-01-04', '2021-01-15', 'E272', 'S675');
INSERT INTO public.Voo VALUES (603, 666, 444, '2021-01-21', '2021-01-22', 'E635', 'S291');

-- Inserts de VooAssentos
-- PK FK Voo INT, PK Assentos VARCHAR(30)
INSERT INTO public.VooAssentos VALUES (101, 1);
INSERT INTO public.VooAssentos VALUES (101, 2);
INSERT INTO public.VooAssentos VALUES (101, 3);
--
INSERT INTO public.VooAssentos VALUES (102, 1);
INSERT INTO public.VooAssentos VALUES (102, 2);
INSERT INTO public.VooAssentos VALUES (102, 3);
--
INSERT INTO public.VooAssentos VALUES (103, 1);
INSERT INTO public.VooAssentos VALUES (103, 2);
INSERT INTO public.VooAssentos VALUES (103, 3);
--
INSERT INTO public.VooAssentos VALUES (201, 1);
INSERT INTO public.VooAssentos VALUES (201, 2);
INSERT INTO public.VooAssentos VALUES (201, 3);
--
INSERT INTO public.VooAssentos VALUES (202, 1);
INSERT INTO public.VooAssentos VALUES (202, 2);
INSERT INTO public.VooAssentos VALUES (202, 3);
--
INSERT INTO public.VooAssentos VALUES (601, '1A');
INSERT INTO public.VooAssentos VALUES (601, '1B');
INSERT INTO public.VooAssentos VALUES (601, '2B');
--
INSERT INTO public.VooAssentos VALUES (602, 99);
INSERT INTO public.VooAssentos VALUES (602, 100);
--
INSERT INTO public.VooAssentos VALUES (603, 'A');
INSERT INTO public.VooAssentos VALUES (603, 'B');

-- Inserts de Cliente
-- CPF CHAR(14), Tipo VARCHAR(30) NOT NULL, Nome VARCHAR(30) NOT NULL, Email VARCHAR(30) NOT NULL, Telefone VARCHAR(30) NOT NULL, Pais VARCHAR(30) NOT NULL, Cidade VARCHAR(30) NOT NULL, Bairro VARCHAR(30) NOT NULL, Rua VARCHAR(30) NOT NULL, Numero VARCHAR(30) NOT NULL, CEP CHAR(9) NOT NULL, Genero VARCHAR(30) NOT NULL, Religiao VARCHAR(30) NOT NULL, MBTI CHAR(4) NOT NULL,
INSERT INTO public.Cliente VALUES ('111.222.333-45', 'Normal', 'Fulano de Tal', 'email@email.com', '55 14 991234561', 'Brasil', 'Bauru', 'Geisel', 'Rua 1', '123-10', '123456-22', 'Masc', 'Judeu', 'ENTJ');
INSERT INTO public.Cliente VALUES ('111.222.333-46', 'Normal', 'Ciclano de Tal', 'email2@email.com', '55 12 991234562', 'Brasil', 'Bauru', 'Geisel', 'Rua 1', '123-20', '123456-11', 'Masc', 'Judeu', 'INTJ');
INSERT INTO public.Cliente VALUES ('111.222.333-47', 'Normal', 'Fulano de Acolá', 'email3@email.com', '55 12 99123-4563', 'Inglaterra','Londres','Westminster','Rua 5', '999-0', '123456-72', 'Fem', 'Agnostico', 'ENTP');
INSERT INTO public.Cliente VALUES ('111.222.333-48', 'Premium', 'Ciclano de Acolá', 'email4@email.com', '55 13 99123-4564', 'Inglaterra','Londres','Westminster','Rua 5', '999-0', '123456-71', 'Fem', 'Ateu', 'ENTJ');
INSERT INTO public.Cliente VALUES ('111.222.333-49', 'Premium', 'José Silva', 'email5@email.com', '55 13 99123-4565', 'Brasil', 'São Paulo', 'Centro', 'Rua 2', '321','17033691', 'Masc', 'Ateu', 'INTJ');
INSERT INTO public.Cliente VALUES ('111.222.333-50', 'Premium', 'Maria Silva', 'email5@email.com', '55 15 99123-4566', 'Brasil', 'São Paulo', 'Centro', 'Rua 2', '321','17033691', 'Fem', 'Crista', 'ENTP');

-- Inserts de Embarque
-- Voo INT,	Cliente CHAR(14),Assento INT,
INSERT INTO public.Embarque VALUES (101, '111.222.333-45', 1);
INSERT INTO public.Embarque VALUES (101, '111.222.333-46', 2);
INSERT INTO public.Embarque VALUES (101, '111.222.333-47', 3);
--
INSERT INTO public.Embarque VALUES (201, '111.222.333-48', 1);
--
INSERT INTO public.Embarque VALUES (601, '111.222.333-49', '1A');
INSERT INTO public.Embarque VALUES (601, '111.222.333-50', '1B');