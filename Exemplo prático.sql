-- Criação das tabelas
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATETIME,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Exemplo prático de transação
START TRANSACTION;

-- Inserindo um cliente
INSERT INTO cliente (id_cliente, nome) VALUES (1, 'João Silva');

-- Criando um ponto de salvamento após inserir o cliente
SAVEPOINT cliente_inserido;

-- Inserindo um pedido válido
INSERT INTO pedido (id_pedido, id_cliente, data_pedido) VALUES (101, 1, NOW());

-- Tentativa de inserir um pedido inválido (cliente não existente)
INSERT INTO pedido (id_pedido, id_cliente, data_pedido) VALUES (102, 999, NOW());

-- Reverter para o ponto de salvamento caso algo falhe
ROLLBACK TO SAVEPOINT cliente_inserido;

-- Confirmar as alterações feitas até o ponto de salvamento
COMMIT;

-- Consultar os resultados finais
SELECT * FROM cliente;
SELECT * FROM pedido;
