# DBA Challenge 20240802

## Descrição

Sistema de consultas PL/SQL para análise de dados da Bike Stores Inc, gerando insights comerciais para as equipes de Marketing e Comercial.

## Tecnologias Utilizadas

- **Linguagem**: Oracle PL/SQL
- **Banco de Dados**: Oracle Database
- **Ferramentas**: SQL*Plus / Oracle SQL Developer

## Como Instalar e Usar

### Pré-requisitos
- Oracle Database instalado
- Acesso ao banco de dados Bike Stores Inc
- SQL*Plus ou Oracle SQL Developer

### Passos para Execução

1. **Conectar ao banco de dados**:
   ```sql
   CONNECT username/password@database
   ```

2. **Habilitar saída de mensagens**:
   ```sql
   SET SERVEROUTPUT ON
   ```

3. **Executar o script**:
   ```sql
   @queries_plsql.sql
   ```

## Consultas Implementadas

1. **Clientes sem compras**: Identifica clientes que nunca realizaram pedidos
2. **Produtos não comprados**: Lista produtos que nunca foram vendidos
3. **Produtos sem estoque**: Mostra produtos esgotados em todas as lojas
4. **Vendas por marca/loja**: Agrupa vendas por marca e loja
5. **Funcionários sem pedidos**: Identifica funcionários não associados a pedidos

---

> This is a challenge by [Coodesh](https://coodesh.com/) 
