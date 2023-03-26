create schema pgdom;
create schema pgadmin;
create schema pgecommerce;
create schema pgrh;

CREATE TABLE pgdom.funcao (
  id SERIAL PRIMARY KEY,
  descricao character varying(100),
  data_cadastro date
);

INSERT INTO pgdom.funcao (descricao, data_cadastro) VALUES('VENDEDOR', CURRENT_DATE);
INSERT INTO pgdom.funcao (descricao, data_cadastro) VALUES('ADMINISTRADOR', CURRENT_DATE);

CREATE TABLE pgdom.tipo_produto (
  id SERIAL PRIMARY KEY,
  descricao character varying(100),
  data_cadastro date
);

INSERT INTO pgdom.tipo_produto (descricao, data_cadastro) VALUES('DIGITAL', CURRENT_DATE);
INSERT INTO pgdom.tipo_produto (descricao, data_cadastro) VALUES('FÍSICO', CURRENT_DATE);
INSERT INTO pgdom.tipo_produto (descricao, data_cadastro) VALUES('SERVIÇO', CURRENT_DATE);

CREATE TABLE pgrh.funcionario (
  id SERIAL PRIMARY KEY,
  nome character varying(100),
  cpf character varying(14),
  status INTEGER,
  data_cadastro date,
  id_funcao INTEGER REFERENCES pgdom.funcao(id)
);

INSERT INTO pgrh.funcionario (nome, cpf, status, data_cadastro, id_funcao) VALUES('Pedro Vendedor', '000.000.000-00', 1, CURRENT_DATE, 1);
INSERT INTO pgrh.funcionario (nome, cpf, status, data_cadastro, id_funcao) VALUES('João Admin', '111.111.111-11', 1, CURRENT_DATE, 2);

CREATE TABLE pgadmin.usuario (
  id SERIAL PRIMARY KEY,
  login character varying(50),
  senha character varying(20),
  status INTEGER,
  data_cadastro date,
  id_funcionario INTEGER REFERENCES pgrh.funcionario(id)
);

INSERT INTO pgadmin.usuario (login, senha, status, data_cadastro, id_funcionario) VALUES('000.000.000-00', 'abc', 1, CURRENT_DATE, 1);
INSERT INTO pgadmin.usuario (login, senha, status, data_cadastro, id_funcionario) VALUES('111.111.111-11', 'abc', 1, CURRENT_DATE, 2);

CREATE TABLE pgecommerce.produto (
  id SERIAL PRIMARY KEY,
  descricao character varying(200),
  ncm character varying(20),
  quantidade_estoque INTEGER,
  data_cadastro date,
  valor numeric(19,4) NOT NULL,
  id_tipo_produto INTEGER REFERENCES pgdom.tipo_produto(id)
);

INSERT INTO pgecommerce.produto (descricao, ncm, quantidade_estoque, data_cadastro, id_tipo_produto, valor) 
VALUES('GTA V', '123', 10, CURRENT_DATE, 1, 80);
INSERT INTO pgecommerce.produto (descricao, ncm, quantidade_estoque, data_cadastro, id_tipo_produto, valor) 
VALUES('NFS 2', '00000', 10, CURRENT_DATE, 1, 55);
INSERT INTO pgecommerce.produto (descricao, ncm, quantidade_estoque, data_cadastro, id_tipo_produto, valor) 
VALUES('Fortnite', '1111', 10, CURRENT_DATE, 1, 70);


CREATE TABLE pgecommerce.venda (
  id SERIAL PRIMARY KEY,
  observacao character varying(200),
  valor_total numeric(19,4) NOT NULL,
  data_cadastro date,
  id_usuario_vendedor INTEGER REFERENCES pgadmin.usuario(id)
);

CREATE TABLE pgecommerce.venda_item (
  id SERIAL PRIMARY KEY,
  quantidade INTEGER,
  id_produto INTEGER REFERENCES pgecommerce.produto(id),
  id_venda INTEGER REFERENCES pgecommerce.venda(id)
);

INSERT INTO pgecommerce.venda (observacao, valor_total, data_cadastro, id_usuario_vendedor) VALUES('', 150, CURRENT_DATE, 1);
INSERT INTO pgecommerce.venda_item(quantidade, id_produto, id_venda) VALUES(1, 1, 1);
INSERT INTO pgecommerce.venda_item(quantidade, id_produto, id_venda) VALUES(1, 2, 1);