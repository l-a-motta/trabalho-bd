-- AVISOS:
-- Consideramos que strings pequenas possuem no maximo 30 caracteres, medias 50 e grandes 180 (o tamanho de um tweet) 

/*
	Alguns comentarios estao marcados por tags. Segue a lista de tags:
		TODO		Questoes a serem resolvidas
		//			Questoes que eram TODO, mas ja foram resolvidas
		!			Avisos importantes
		?			Curiosidades e outros
*/

-- Use a linha comentada abaixo quiser o codigo SQL para dropar todas as tabelas. Basta executar numa query dentro do banco desejado
-- select 'drop table if exists "' || tablename || '" cascade;' from pg_tables where schemaname = 'public';

CREATE TABLE IF NOT EXISTS Destino (
	
	/*    ATRIBUTOS    */
	Pais VARCHAR(30),
	Cidade VARCHAR(30),
	Descricao VARCHAR(180),
	Idioma VARCHAR(30) NOT NULL,
	Clima VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_Destino PRIMARY KEY(Pais, Cidade)
	
	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS DestinoTags (
	
	/*    ATRIBUTOS    */
	Pais VARCHAR(30),
	Cidade VARCHAR(30),
	Tag VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_DestinoTag PRIMARY KEY(Pais, Cidade, Tag),
	CONSTRAINT FK_DestinoTag FOREIGN KEY (Pais, Cidade) REFERENCES Destino(Pais, Cidade) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se o destino for deletado, nao faz sentido manter as associações das tags dele

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Aeroporto (
	
	/*    ATRIBUTOS    */
	CodIATA INT,
	Pais VARCHAR(30) NOT NULL,
	Cidade VARCHAR(30) NOT NULL,
	Bairro VARCHAR(30) NOT NULL,
	Rua VARCHAR(30) NOT NULL,
	Numero INT NOT NULL,
	CEP CHAR(9) NOT NULL,-- Um CEP tem no maximo nove caracteres (00000-000)
	Nome VARCHAR(30) NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_Aeroporto PRIMARY KEY(CodIATA),
	CONSTRAINT FK_AeroportoDestino FOREIGN KEY (Pais, Cidade) REFERENCES Destino(Pais, Cidade) ON DELETE CASCADE ON UPDATE CASCADE,
	-- Um aeroporto nao pode existir independente de um destino, ele precisa estar fixado em um local geografico
	CONSTRAINT UC_Aeroporto UNIQUE(Pais, Cidade, Bairro, Rua, Numero)
	-- A chave secundária vale para diferenciarmos os Aeroportos, uma vez que não existem dois Aeroportos no mesmo exato local

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Voo (
	
	/*    ATRIBUTOS    */
	Nro INT,-- // Deveria ser SERIAL? NAO, ESSE EH O NUMERO DO VOO ATRIBUIDO PELAS EMPRESAS, JA EH UNICO
	Aeroporto_Origem INT NOT NULL,
	Aeroporto_Destino INT NOT NULL,
	Data_Partida TIMESTAMP NOT NULL,
	Data_Chegada TIMESTAMP NOT NULL,-- Ambos sao TIMESTAMPS, para ja tratar o horario de um voo
	Portao_Embarque VARCHAR(30) NOT NULL,
	Portao_Desembarque VARCHAR(30) NOT NULL,-- Ambos são VARCHARs pois alguns aeroportos usam caracteres alfanumericos nos seus portoes
	
	/*    KEYS    */
	CONSTRAINT PK_Voo PRIMARY KEY(Nro),
	CONSTRAINT FK_VooOrigem FOREIGN KEY (Aeroporto_Origem) REFERENCES Aeroporto(CodIATA) ON DELETE CASCADE ON UPDATE CASCADE,
	-- A FK de origem deve ser deletada se o aeroporto for deletado, ja que um voo depende necessariamente do aeroporto que o planejou
	CONSTRAINT FK_VooDestino FOREIGN KEY (Aeroporto_Destino) REFERENCES Aeroporto(CodIATA) ON DELETE CASCADE ON UPDATE CASCADE,
    -- A FK de destino deve ser deletada se o aeroporto for deletado, ja que um voo depende necessariamente do aeroporto que o recebera

	/*    CHECKS    */
	CONSTRAINT CK_Data CHECK (Data_Partida < Data_Chegada)
	-- E impossivel a data de chegada ser antes da de partida
	-- // Na verdade e possivel sim, se ele pegar um voo e for contra os fuso horarios. Discutir isso 
	-- RESOLVIDO: Por ser um TIMESTAMP, mudancas de fuso horario ja sao tratadas, logo nao pode mesmo ter uma data inicial menor que a final
	
);

CREATE TABLE IF NOT EXISTS VooAssentos (

	/*    ATRIBUTOS    */
	Voo INT,-- // Deveria ser SERIAL? NAO, ESSE EH O NUMERO DO VOO ATRIBUIDO PELAS EMPRESAS, JA EH UNICO
	Assentos VARCHAR(4),-- Nome identificador do assento. Nao achamos viavel um Aviao com mais de 9999 assentos
	
	/*    KEYS    */
	CONSTRAINT PK_VooAssentos PRIMARY KEY(Voo, Assentos),
	CONSTRAINT FK_VooAssentos FOREIGN KEY(Voo) REFERENCES Voo(Nro) ON DELETE CASCADE ON UPDATE CASCADE
	-- E impossivel existirem assentos nao associados a um voo
	
	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Cliente (
	/*    ATRIBUTOS    */
	CPF CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	Tipo VARCHAR(30) NOT NULL,-- // Tem muitas entradas que repetem essas informacoes pessoais, Tipo, Nome, Email, etc
	Nome VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL,
	Telefone VARCHAR(30) NOT NULL,
	Pais VARCHAR(30) NOT NULL,-- // Tem muitas entradas que repetem essas informacoes geograficas, Pais, Bairro, Cidade, etc
	Cidade VARCHAR(30) NOT NULL,
	Bairro VARCHAR(30) NOT NULL,
	Rua VARCHAR(30) NOT NULL,
	Numero VARCHAR(30) NOT NULL,
	CEP CHAR(9) NOT NULL,-- Um CEP tem no maximo nove caracteres (00000-000)
	Genero VARCHAR(30) NOT NULL,
	Religiao VARCHAR(30),
	MBTI CHAR(4),-- O indice MBTI so precisa de quatro caracteres para ser identificado (AAAA)

	/*    KEYS    */
	CONSTRAINT PK_Cliente PRIMARY KEY(CPF)

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS ClienteCondicoesMedicas (
	/*    ATRIBUTOS    */
	Cliente CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	CondicoesMedicas VARCHAR(180),
	/*    KEYS    */
	CONSTRAINT PK_ClienteCondicoesMedicas PRIMARY KEY(Cliente, CondicoesMedicas)

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Embarque (
	/*    ATRIBUTOS    */
	Voo INT,
	Assento VARCHAR(4),
	Cliente CHAR(14),
	
	/*    KEYS    */
	-- Vale notar que Embarque esta conectado a VooAssentos, e nao a Voo em si
	CONSTRAINT PK_Embarque PRIMARY KEY(Voo, Assento, Cliente),
	CONSTRAINT FK_EmbarqueVooAssentos FOREIGN KEY(Voo, Assento) REFERENCES VooAssentos(Voo, Assentos) ON DELETE CASCADE ON UPDATE CASCADE,-- // Falar com a monitora se e valido ter foreign key de foreign key SEM PROBLEMA
	CONSTRAINT FK_EmbarqueCliente FOREIGN KEY(Cliente) REFERENCES Cliente(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	-- Para que ocorra um embarque, tanto um Voo quanto um Cliente precisam necessariamente existir

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Estadia (
	/*    ATRIBUTOS    */
	ID SERIAL,
	Pais VARCHAR(30) NOT NULL,
	Cidade VARCHAR(30) NOT NULL,
	Bairro VARCHAR(30) NOT NULL,
	Rua VARCHAR(30) NOT NULL,
	Numero VARCHAR(30) NOT NULL,
	CEP CHAR(9) NOT NULL,-- Um CEP tem no maximo nove caracteres (00000-000)
	Nome VARCHAR(30) NOT NULL,
	Nro_Quartos INT,-- // O que e exatamente isso? TOTAL DE QUARTOS NA ESTADIA
	
	/*    KEYS    */
	CONSTRAINT PK_Estadia PRIMARY KEY(ID),
	CONSTRAINT FK_EstadiaDestino FOREIGN KEY (Pais, Cidade) REFERENCES Destino(Pais, Cidade) ON DELETE CASCADE ON UPDATE CASCADE,
	-- Uma Estadia nao pode existir independente de um destino, ela precisa estar fixada em um local geografico
	CONSTRAINT UC_Estadia UNIQUE(Pais, Cidade, Bairro, Rua, Numero)
	-- A chave secundária vale para diferenciarmos os locais das Estadias, uma vez que não existem duas Estadias diferentes no mesmo exato local
	
	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Hospedagem (
	/*    ATRIBUTOS    */
	Estadia INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Cliente CHAR(14),
	Quarto VARCHAR(4) NOT NULL,-- Apesar do total de quartos estar marcado em INT, o quarto em si pode ter letras na sua designacao ('B12','B13')
	Valor NUMERIC(11,3) NOT NULL,-- Aceitamos numeros com tres casas decimais de precisao, num maximo de preço igual a 999 999 999,999. Por ser internacional, algumas entidades usam a terceira casa decimal para centavos
	Data_Inicio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,-- Caso nao ofereca data de inicio, assumimos que a data e valida naquele exato momento
	Data_Fim TIMESTAMP NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_Hospedagem PRIMARY KEY(Estadia, Cliente, Quarto),
	CONSTRAINT FK_HospedagemEstadia FOREIGN KEY (Estadia) REFERENCES Estadia(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_HospedagemCliente FOREIGN KEY (Cliente) REFERENCES Cliente(CPF) ON DELETE CASCADE ON UPDATE CASCADE,
	-- Uma Hospedagem nao pode existir sem termos tanto Estadia quanto Cliente, logo CASCADE ao perder ou autalizar qualquer um
	
	/*    CHECKS    */
	CONSTRAINT CK_Hospedagem CHECK (Data_Inicio < Data_Fim)
	-- E impossivel a data inicial ser antes da data final
	
);

CREATE TABLE IF NOT EXISTS LocalT (
	/*    ATRIBUTOS    */
	ID SERIAL,
	Pais VARCHAR(30) NOT NULL,
	Cidade VARCHAR(30) NOT NULL,
	Bairro VARCHAR(30) NOT NULL,
	Rua VARCHAR(30) NOT NULL,
	Numero VARCHAR(30) NOT NULL,
	Complemento VARCHAR(30),-- Nao e obrigatorio um complemento
	CEP CHAR(9) NOT NULL,-- Um CEP tem no maximo nove caracteres (00000-000)
	Nome VARCHAR(30) NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_Local PRIMARY KEY(ID),
	CONSTRAINT FK_LocalDestino FOREIGN KEY (Pais, Cidade) REFERENCES Destino(Pais, Cidade) ON DELETE CASCADE ON UPDATE CASCADE,
	-- Um Local nao pode existir independente de um destino, ele precisa estar fixado em um local geografico
	CONSTRAINT UC_Local UNIQUE(Pais, Cidade, Bairro, Rua, Numero, Complemento)
	-- A chave secundária vale para diferenciarmos os Locais, uma vez que não existem dois Locais exatamente iguais

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS LocalTipo (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Tipo VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_LocalTipo PRIMARY KEY(LocalT, Tipo),
	CONSTRAINT FK_LocalTipoLocal FOREIGN KEY (LocalT) REFERENCES LocalT(ID) ON DELETE CASCADE ON UPDATE CASCADE
	-- Um Tipo de um Local nao pode existir independente de um Local
	
	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Transporte (
	/*    ATRIBUTOS    */
	Cod_Linha VARCHAR(30),
	Tipo VARCHAR(30) NOT NULL,
	Local_Origem INT NOT NULL,-- Foreign Keys em SERIAL sao na verdade INTs
	Local_Destino INT NOT NULL,
	Horario_Ida TIMESTAMP NOT NULL,
	Horario_Chegada TIMESTAMP NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_Transporte PRIMARY KEY(Cod_Linha),
	CONSTRAINT FK_TransporteOrigem FOREIGN KEY (Local_Origem) REFERENCES LocalT(ID) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT FK_TransporteDestino FOREIGN KEY (Local_Destino) REFERENCES LocalT(ID) ON DELETE SET NULL ON UPDATE CASCADE,
	-- E interessante mantermos os dados de um Transporte mesmo se perdermos o dado de um Local
	CONSTRAINT UC_Transporte UNIQUE(Local_Origem, Local_Destino, Horario_Ida, Horario_Chegada),

	/*    CHECKS    */
	CONSTRAINT CK_DataTransporte CHECK (Horario_Ida < Horario_Chegada)
	-- E impossivel a data de chegada ser antes da de ida
	
);

CREATE TABLE IF NOT EXISTS PontoTransporte (
	/*    ATRIBUTOS    */
	Transporte VARCHAR(30),
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Horario TIMESTAMP NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_PontoTransporte PRIMARY KEY(Transporte, LocalT),
	CONSTRAINT FK_PontoTransporteTransporte FOREIGN KEY (Transporte) REFERENCES Transporte(Cod_linha) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_PontoTransporteLocal FOREIGN KEY (LocalT) REFERENCES LocalT(ID) ON DELETE CASCADE ON UPDATE CASCADE

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Organizador (
	/*    ATRIBUTOS    */
	CPF CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	CNPJ CHAR(18),-- Um CNPJ tem no maximo 14 caracteres (XX.XXX.XXX/0001-XX)
	-- Salvamos mais espaços com um CNPJ como chave secundaria no caso de um organizador nao ter CNPJ
	-- ? Outra alternativa: Fazer a entidade Companhia, entidade propria com tabela propria
	-- ? Teria que evitar o caso de organizador ser somente pessoa fisica, sem CNPJ. É uma opção
	-- TODO Detalhar mais o tipo de organizador no doc
	Tipo VARCHAR(30) NOT NULL,
	Nome VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL,
	Telefone VARCHAR(30) NOT NULL,
	Pais VARCHAR(30) NOT NULL,
	Cidade VARCHAR(30) NOT NULL,
	Bairro VARCHAR(30) NOT NULL,
	Rua VARCHAR(30) NOT NULL,
	Numero VARCHAR(30) NOT NULL,
	CEP CHAR(9) NOT NULL,-- Um CEP tem no maximo nove caracteres (00000-000)
	Nome_Social VARCHAR(30),
	Telefone_Empresa VARCHAR(30),-- Existe muita variacao de telefone no mundo para especificarmos um numero menor
	Email_Empresa VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_Organizador PRIMARY KEY(CPF),
	CONSTRAINT UC_Organizador UNIQUE(CNPJ)

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS OrganizadorTiposAtuacao (
	/*    ATRIBUTOS    */
	Organizador CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	Tipos_Atuacao VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_Organizador_ PRIMARY KEY(Organizador, Tipos_Atuacao),
	CONSTRAINT FK_OrganizadorTiposAtuacao FOREIGN KEY (Organizador) REFERENCES Organizador(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS OrganizadorRecomendacao (
	/*    ATRIBUTOS    */
	Organizador CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	Recomendacao VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_OrganizadorRecomendacao PRIMARY KEY(Organizador, Recomendacao),
	CONSTRAINT FK_OrganizadorRecomendacao FOREIGN KEY (Organizador) REFERENCES Organizador(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Evento (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Data_Fim TIMESTAMP NOT NULL,
	Organizador CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	-- // Certeza que organizador pode ser NULL? SIM, EVENTO SEM ORGANIZADOR SALVO NO DB
	Descricao VARCHAR(180),
	Valor NUMERIC(11,3),-- Aceitamos numeros com tres casas decimais de precisao, num maximo de preço igual a 999 999 999,999. Por ser internacional, algumas entidades usam a terceira casa decimal para centavos
	-- Pode ser NULL no caso de eventos de graça, sem qualquer tipo de cobrança na sua duração

	/*    KEYS    */
	CONSTRAINT PK_Evento PRIMARY KEY(LocalT, Data_Inicio),
	CONSTRAINT FK_EventoLocal FOREIGN KEY (LocalT) REFERENCES LocalT(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	-- Nao existe evento se nao tivermos um local para ele, logo CASCADE
	

	/*    CHECKS    */
	CONSTRAINT CK_Evento CHECK (Data_Inicio < Data_Fim)
	-- E impossivel a data inicial ser antes da data final
	-- Por termos uma PK que vai ser referenciada ja com o check, nao precisamos fazer esse check para todas as outras tabelas que vao referenciar esta
	
);

CREATE TABLE IF NOT EXISTS EventoCategoria (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Categoria VARCHAR(30),

	/*    KEYS    */
	CONSTRAINT PK_EventoCategoria PRIMARY KEY(LocalT, Data_Inicio, Categoria),
	CONSTRAINT FK_EventoCategoriaEvento FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Evento(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Nao faz sentido guardar a categoria de um local que nao existe mais, CASCADE

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Participacao (
	/*    ATRIBUTOS    */
	Cliente CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,

	/*    KEYS    */
	CONSTRAINT PK_Participacao PRIMARY KEY(Cliente, LocalT, Data_Inicio),
	CONSTRAINT FK_ParticipacaoCliente FOREIGN KEY (Cliente) REFERENCES Cliente(CPF) ON DELETE SET NULL ON UPDATE CASCADE,
	-- Pode ser util guardar as participacoes, mesmo se perdemos os dados de um cliente. Se um cliente for removido, ele nao deixa de ter participado magicamente do um evento
	CONSTRAINT FK_ParticipacaoEvento FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Evento(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Nao seria util, no entanto, guardar as participacoes de um local que nao esta mais conosco

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS AvaliacaoEvento (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	DataA TIMESTAMP,
	Cliente CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	Estrelas INT NOT NULL,-- So precisamos de um caractere de numero de estrelas, mas para podermos fazer operacoes com isso mais facilmente, escolhemos o INT
	Descricao VARCHAR(180),
	

	/*    KEYS    */
	-- Vale notar que AvaliacaoEvento esta conectada a Participacao, e nao diretamente a Evento
	CONSTRAINT PK_AvaliacaoEvento PRIMARY KEY(LocalT, Data_Inicio, DataA, Cliente),
	CONSTRAINT FK_AvaliacaoEventoParticipacao FOREIGN KEY (Cliente, LocalT, Data_Inicio) REFERENCES Participacao(Cliente, LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE,-- // Se participacao poder ficar NULL, vai dar conflito de semantica aqui visto q precisamos remover a avaliacao se perdermos a participacao
	-- POSSIBILIDADE: Decidimos seguir as novas normas de Lei de Proteção de Dados e remover todas as interações de um usuário do sistema ao perdermos os dados do usuário
	-- Se a participacao for removida, nao iremos guardar a avaliacao, para manter tudo justo
	CONSTRAINT FK_AvaliacaoEventoCliente FOREIGN KEY (Cliente) REFERENCES Cliente(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se um cliente for removido, a mesma logica segue
	
	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Guia (
	/*    ATRIBUTOS    */
	CPF CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	Tipo VARCHAR(30) NOT NULL,
	Nome VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL,
	Telefone VARCHAR(30) NOT NULL,
	Pais VARCHAR(30) NOT NULL,
	Cidade VARCHAR(30) NOT NULL,
	Bairro VARCHAR(30) NOT NULL,
	Rua VARCHAR(30) NOT NULL,
	Numero VARCHAR(30) NOT NULL,
	CEP CHAR(9) NOT NULL,-- Um CEP tem no maximo nove caracteres (00000-000)
	Naturalidade VARCHAR(30) NOT NULL,
	Descricao VARCHAR(180),-- Existe muita variacao de telefone no mundo para especificarmos um numero menor
	Formacao VARCHAR(50) NOT NULL,
	Pagamento VARCHAR(30) NOT NULL,
	-- // Pagamento é a forma de pagamento, ou o preco estatico do guia? FALAR MONITORA
	-- Originalmente, Pagamento referia-se a taxa por hora. No momento, refere-se ao tipo de pagamento
	MBTI CHAR(4),-- O indice MBTI so precisa de quatro caracteres para ser identificado (AAAA)

	/*    KEYS    */
	CONSTRAINT PK_Guia PRIMARY KEY(CPF)
	
	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS GuiaTiposAtuacao (
	/*    ATRIBUTOS    */
	Guia CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	TiposAtuacao VARCHAR(30) DEFAULT 'Turismo',-- Achamos que turismo e uma atuacao suficientemente generica para um guia, entao deixamos como caso DEFAULT
	
	/*    KEYS    */
	CONSTRAINT PK_GuiaTiposAtuacao PRIMARY KEY(Guia, TiposAtuacao),
	CONSTRAINT FK_GuiaTiposAtuacaoGuia FOREIGN KEY (Guia) REFERENCES Guia(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se nao tem guia, nao tem os tipos de atuacao dele, CASCADE

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Orientacao (
	/*    ATRIBUTOS    */
	Guia CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	Cliente CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	
	/*    KEYS    */
	CONSTRAINT PK_Orientacao PRIMARY KEY(Guia, Cliente),
	CONSTRAINT FK_OrientacaoGuia FOREIGN KEY (Guia) REFERENCES Guia(CPF) ON DELETE CASCADE ON UPDATE CASCADE,
	-- Se nao tem mais o guia, a orientacao deve ser removida, CASCADE
	CONSTRAINT FK_OrientacaoCliente FOREIGN KEY (Cliente) REFERENCES Cliente(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se nao tem mais o cliente, a orientacao deve ser removida, CASCADE

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS AvaliacaoGuia (
	/*    ATRIBUTOS    */
	Data_Avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,-- Assumimos que se nao houver uma data customizada, a avaliacao foi feita no mesmo momento de submissao da tupla
	-- // Temos um problema de que um Cliente pode spammar avaliacoes se nao tivermos outro dado para associar avaliacaoguia com orientacao, tipo uma data 
	-- RESOLVIDO: A Data_Avaliacao eh inserida pelo sistema, e faz jus a data que o cliente foi guiado pelo guia. A aplicacao nao permite spam, nesse caso.
	Guia CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	Cliente CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	Estrelas INT NOT NULL,-- So precisamos de um caractere de numero de estrelas, mas para podermos fazer opercoes com isso mais facilmente, escolhemos o INT
	Descricao VARCHAR(180),
	
	
	/*    KEYS    */
	-- Vale notar que AvaliacaoGuia esta conectada a Orientacao, e nao diretamente a Guia
	CONSTRAINT PK_AvaliacaoGuia PRIMARY KEY(Data_Avaliacao, Guia, Cliente),
	CONSTRAINT FK_AvaliacaoGuiaOrientacao FOREIGN KEY (Guia, Cliente) REFERENCES Orientacao(Guia, Cliente) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se nao tem mais a orientacao, a avalicao do guia deve ser removida, CASCADE
	
	/*    CHECKS    */

);

-- ! TABELAS DE ESPECIALIZACAO DE EVENTO

CREATE TABLE IF NOT EXISTS FestivalGastronomico (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Tipo_Comida_Bebida VARCHAR(180) NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_FestivalGastronomico PRIMARY KEY(LocalT, Data_Inicio),
	CONSTRAINT FK_FestivalGastronomicoEvento FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Evento(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Evento e o evento especifico sao intrinsicamente ligados, sempre deve ser CASCADE

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS GastroGuia (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Guia CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	
	/*    KEYS    */
	CONSTRAINT PK_GastroGuia PRIMARY KEY(LocalT, Data_Inicio, Guia),-- Colocamos Guia na chave primaria para podermos ter mais de um guia por evento
	CONSTRAINT FK_GastroGuiaFestivalGastronomico FOREIGN KEY (LocalT, Data_Inicio) REFERENCES FestivalGastronomico(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_GastroGuiaGuia FOREIGN KEY (Guia) REFERENCES Guia(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se nao tem mais o festival, nao faz sentido termos uma tupla de guia para esse festival, CASCADE

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Showt (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Genero_Musical VARCHAR(180) NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_Showt PRIMARY KEY(LocalT, Data_Inicio),
	CONSTRAINT FK_ShowtEvento FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Evento(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Evento e o evento especifico sao intrinsicamente ligados, sempre deve ser CASCADE
	
	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS ShowArtistas (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Artista VARCHAR(50) NOT NULL,
	
	
	/*    KEYS    */
	CONSTRAINT PK_ShowArtistas PRIMARY KEY(LocalT, Data_Inicio, Artista),-- Colocamos Artista na chave primaria para podermos ter mais de um artista por evento
	CONSTRAINT FK_ShowArtistasShowt FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Showt(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se nao tem mais o show, nao faz sentido termos uma tupla de show artista, CASCADE
	

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Festa (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Tipo VARCHAR(180) NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_Festa PRIMARY KEY(LocalT, Data_Inicio),
	CONSTRAINT FK_FestaEvento FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Evento(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Evento e o evento especifico sao intrinsicamente ligados, sempre deve ser CASCADE

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Esporte (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Tipo VARCHAR(180) NOT NULL,
	
	
	/*    KEYS    */
	CONSTRAINT PK_Esporte PRIMARY KEY(LocalT, Data_Inicio),
	CONSTRAINT FK_EsporteEvento FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Evento(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Evento e o evento especifico sao intrinsicamente ligados, sempre deve ser CASCADE
	

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS EsporteParticipantes (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Participantes VARCHAR(50) NOT NULL,
	
	
	/*    KEYS    */
	CONSTRAINT PK_EsporteParticipantes PRIMARY KEY(LocalT, Data_Inicio, Participantes),-- Colocamos Participantes na chave primaria para podermos ter mais de um participante por evento
	CONSTRAINT FK_EsporteParticipantesEsporte FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Esporte(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se nao tem mais o esporte, nao faz sentido termos uma tupla de esporte Participantes, CASCADE

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS PasseioTuristicoTour (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Tipo VARCHAR(180) NOT NULL,
	Guia CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	
	/*    KEYS    */
	CONSTRAINT PK_PasseioTuristicoTour PRIMARY KEY(LocalT, Data_Inicio),
	CONSTRAINT FK_PasseioTuristicoTour FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Evento(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE,
	-- Evento e o evento especifico sao intrinsicamente ligados, sempre deve ser CASCADE
	CONSTRAINT FK_PasseioTuristicoTourGuia FOREIGN KEY (Guia) REFERENCES Guia(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se nao tem mais o passeio, nao faz sentido termos uma tupla de guia para esse expo, CASCADE

	
	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS PasseioRota (
	/*    ATRIBUTOS    */
	Local_Inicio INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Local_Final INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Horario TIME,-- Aceitamos nao ter horario fixo, pode ser rotacional, entao pode ser NULL
	
	/*    KEYS    */
	CONSTRAINT PK_PasseioRota PRIMARY KEY(Local_Inicio, Data_Inicio, Local_Final),
	CONSTRAINT FK_PasseioRotaPasseioTuristicoTour FOREIGN KEY (Local_Inicio, Data_Inicio) REFERENCES PasseioTuristicoTour(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE,
	-- Evento e o evento especifico sao intrinsicamente ligados, sempre deve ser CASCADE
	CONSTRAINT FK_PasseioRotaLocalFinal FOREIGN KEY (Local_Final) REFERENCES LocalT(ID) ON DELETE CASCADE ON UPDATE CASCADE
	-- Tambem deletamos a rota se o local final dela de repente sumir. Entao pedimos que insira uma nvoa rota

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Filme (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Titulo VARCHAR(180) NOT NULL,
	Genero VARCHAR(50) NOT NULL,
	Ano_Lancamento TIMESTAMP NOT NULL,
	Duracao TIME NOT NULL,-- Usamos TIME somente para as horas do filme, nao precisa de dia aqui
	
	
	/*    KEYS    */
	CONSTRAINT PK_Filme PRIMARY KEY(LocalT, Data_Inicio),
	CONSTRAINT FK_FilmeEvento FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Evento(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Evento e o evento especifico sao intrinsicamente ligados, sempre deve ser CASCADE
	

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS FilmeAtores (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Ator VARCHAR(180) NOT NULL,-- A ideia e termos somente os atores mais prominentes (normalmente tres) escritos por extenso, nada muito complexo
	
	/*    KEYS    */
	CONSTRAINT PK_FilmeAtores PRIMARY KEY(LocalT, Data_Inicio, Ator),-- Colocamos Ator na chave primaria para podermos ter mais de um ator por evento
	CONSTRAINT FK_FilmeAtoresFilme FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Filme(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se nao tem mais o Filme, nao faz sentido termos uma tupla de Filme Ator, CASCADE

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS ExposicaoArte (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Nome VARCHAR(180) NOT NULL,
	Tema VARCHAR(180) NOT NULL,
	
	
	/*    KEYS    */
	CONSTRAINT PK_ExposicaoArte PRIMARY KEY(LocalT, Data_Inicio),
	CONSTRAINT FK_ExposicaoArte FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Evento(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Evento e o evento especifico sao intrinsicamente ligados, sempre deve ser CASCADE
	

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS ExposicaoArtistas (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Artista VARCHAR(180) NOT NULL,-- A ideia e termos somente os Artista mais prominentes (normalmente tres) escritos por extenso, nada muito complexo
	
	/*    KEYS    */
	CONSTRAINT PK_ExposicaoArtistas PRIMARY KEY(LocalT, Data_Inicio, Artista),
	CONSTRAINT FK_ExposicaoArtistasExposicaoArte FOREIGN KEY (LocalT, Data_Inicio) REFERENCES ExposicaoArte(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se nao tem mais o ExposicaoArte, nao faz sentido termos uma tupla de ExposicaoArte Artista, CASCADE

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS ExpoGuia (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Guia CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	
	/*    KEYS    */
	CONSTRAINT PK_ExpoGuia PRIMARY KEY(LocalT, Data_Inicio, Guia),-- Colocamos Guia na chave primaria para podermos ter mais de um guia por evento
	CONSTRAINT FK_ExpoGuiaExposicaoArte FOREIGN KEY (LocalT, Data_Inicio) REFERENCES ExposicaoArte(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_ExpoGuiaGuia FOREIGN KEY (Guia) REFERENCES Guia(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se nao tem mais o expo, nao faz sentido termos uma tupla de guia para esse expo, CASCADE

	/*    CHECKS    */

);

-- ? Percebi que essas tabelas ExpoGuia e GastorGuia podem ser simplificadas com uma tabela so, EventoGuia, e colocar os eventos la. 
-- ? So precisaria de LocalT e Data_Inicio entao acho valido que qualquer evento tecnicamente pode ter um guia. 
-- ? Contudo, perderiamos a informacao de qual tipo de evento (filme, festa, esporte, etc) exatamente o Guia estaria guiando, so saberiamos o Evento em si que o Guia esta guiando

CREATE TABLE IF NOT EXISTS Espetaculo (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Titulo VARCHAR(180) NOT NULL,
	Genero VARCHAR(180) NOT NULL,
	Duracao TIME NOT NULL,-- Usamos TIME somente para as horas do filme, nao precisa de dia aqui
	
	/*    KEYS    */
	CONSTRAINT PK_Espetaculo PRIMARY KEY(LocalT, Data_Inicio),
	CONSTRAINT FK_Espetaculo FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Evento(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Evento e o evento especifico sao intrinsicamente ligados, sempre deve ser CASCADE
	

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS EspetaculoArtistas (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Artista VARCHAR(180) NOT NULL,-- A ideia e termos somente os Artista mais prominentes (normalmente tres) escritos por extenso, nada muito complexo
	
	/*    KEYS    */
	CONSTRAINT PK_EspetaculoArtista PRIMARY KEY(LocalT, Data_Inicio, Artista),-- Colocamos artista na chave primaria para podermos ter mais de um artista por evento
	CONSTRAINT FK_EspetaculoArtistaEspetaculo FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Espetaculo(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se nao tem mais o Espetaculo, nao faz sentido termos uma tupla de Espetaculo Artista, CASCADE

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS CelebracaoReligiosa (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Religiao VARCHAR(180) NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_CelebracaoReligiosa PRIMARY KEY(LocalT, Data_Inicio),
	CONSTRAINT FK_CelebracaoReligiosaEvento FOREIGN KEY (LocalT, Data_Inicio) REFERENCES Evento(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE
	-- Evento e o evento especifico sao intrinsicamente ligados, sempre deve ser CASCADE
	

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS ReligioGuia (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Data_Inicio TIMESTAMP,
	Guia CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	
	/*    KEYS    */
	CONSTRAINT PK_ReligioGuia PRIMARY KEY(LocalT, Data_Inicio, Guia),-- Colocamos Guia na chave primaria para podermos ter mais de um guia por evento
	CONSTRAINT FK_ReligioGuiaCelebracaoReligiosa FOREIGN KEY (LocalT, Data_Inicio) REFERENCES CelebracaoReligiosa(LocalT, Data_Inicio) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_ReligioGuiaGuia FOREIGN KEY (Guia) REFERENCES Guia(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se nao tem mais a celebracao religio, nao faz sentido termos uma tupla de guia para essa religio, CASCADE

	/*    CHECKS    */

);