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
INSERT INTO public.Aeroporto VALUES (111, 'Brasil','Bauru','Geisel','Rua 1',123,'17033690','Aeroporto do Geisel');
INSERT INTO public.Aeroporto VALUES (222, 'Brasil','São Paulo','Centro ','Rua 2',321,'17033691','Aeroporto do Centro');
INSERT INTO public.Aeroporto VALUES (333, 'Inglaterra','Londres','Greenwich','Rua 3',456,'17033-692','Aeroporto de Greenwich');
INSERT INTO public.Aeroporto VALUES (444, 'Inglaterra','Londres','Holland Park','Rua 4',654,'17033-693','Aeroporto de Holland Park');
INSERT INTO public.Aeroporto VALUES (555, 'Inglaterra','Londres','Westminster','Rua 5',789,17033694,'Aeroporto de Westminster');
INSERT INTO public.Aeroporto VALUES (666, 'Alemanha','Frankfurt','Hauptbahnhof','Rua 6',987,17033695,'Aeroporto de Hauptbahnhof');

-- Inserts de Voo
-- Nro INT, Aeroporto_Origem INT NOT NULL, Aeroporto_Destino INT NOT NULL, Data_Partida TIMESTAMP NOT NULL, Data_Chegada TIMESTAMP NOT NULL, Portao_Embarque VARCHAR(30) NOT NULL, Portao_Desembarque VARCHAR(30) NOT NULL
--INSERT INTO public.voo VALUES (911, 1, 1, '2017-03-14', '2017-03-15', 01, 02);