-- Inserts de Destino
-- Pais VARCHAR(30), Cidade VARCHAR(30), Descricao VARCHAR(180), Idioma VARCHAR(30) NOT NULL, Clima VARCHAR(30)
INSERT INTO public.Destino VALUES ('Brasil','Bauru', 'Desc teste', 'Português','Temperado');
INSERT INTO public.Destino VALUES ('Inglaterra','Londres', 'Desc teste 2', 'Ingles britanico','Frio');
INSERT INTO public.Destino VALUES ('México','Cidade do México', 'Desc teste 3', 'Espanhol Mexicano','Quente');
INSERT INTO public.Destino VALUES ('Brasil','São Paulo', 'Locomotiva do Brasil', 'Português','Temperado');

-- Inserts de DestinoTags
-- Pais VARCHAR(30), Cidade VARCHAR(30), Tag VARCHAR(30)
INSERT INTO public.destinotags VALUES ('Brasil','Bauru','Tag 1');
INSERT INTO public.destinotags VALUES ('Brasil','São Paulo','Tag 2');
INSERT INTO public.destinotags VALUES ('México','Cidade do México','Tag 3');

-- Inserts de Aeroporto
-- ID SERIAL, Pais VARCHAR(30) NOT NULL, Cidade VARCHAR(30) NOT NULL, Bairro VARCHAR(30) NOT NULL, Rua VARCHAR(30) NOT NULL, Numero VARCHAR(30) NOT NULL, CEP CHAR(9) NOT NULL, Nome VARCHAR(30) NOT NULL
INSERT INTO public.aeroporto VALUES (111, 'Brasil','Bauru','Geisel','Rua 1',123,17033690,'Aeroporto de Bauru');
INSERT INTO public.aeroporto VALUES (222, 'Brasil','Sao Paulo','Centro ','Rua 2',321,17033691,'Aeroporto de Sao Paulo');
INSERT INTO public.aeroporto VALUES (333, 'Inglaterra','Londres','Wessex','Rua 3',456,17033692,'Aeroporto de Londres');

-- Inserts de Voo
-- Nro INT, Aeroporto_Origem INT NOT NULL, Aeroporto_Destino INT NOT NULL, Data_Partida TIMESTAMP NOT NULL, Data_Chegada TIMESTAMP NOT NULL, Portao_Embarque VARCHAR(30) NOT NULL, Portao_Desembarque VARCHAR(30) NOT NULL
INSERT INTO public.voo VALUES (911, 1, 1, '2017-03-14', '2017-03-15', 01, 02);