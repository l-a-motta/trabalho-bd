INSERT INTO public.Destino VALUES ('Brasil','Bauru', 'Desc teste', 'Português','Temperado');
INSERT INTO public.Destino VALUES ('Brasil','São Paulo', 'Locomotiva do Brasil', 'Português','Temperado');
INSERT INTO public.Destino VALUES ('Inglaterra','Londres', 'Desc teste 2', 'Ingles britanico','Frio');
INSERT INTO public.Destino VALUES ('México','Cidade do México', 'Desc teste 3', 'Espanhol Mexicano','Quente');

INSERT INTO public.destinotags VALUES ('Brasil','Bauru','BR');
INSERT INTO public.destinotags VALUES ('Brasil','São Paulo','Tag 2');
INSERT INTO public.destinotags VALUES ('México','Cidade do México','Tag 3');

INSERT INTO public.aeroporto VALUES (DEFAULT, 'Brasil','Bauru','Geisel','Rua 1',180,17033690,'Aeroporto de Bauru');

INSERT INTO public.voo VALUES (911, 1, 1, '2017-03-14', '2017-03-15', 01, 02);