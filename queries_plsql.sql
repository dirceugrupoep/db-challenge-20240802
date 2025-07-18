-- ###############################################
-- DBA Challenge 20240802 - Consultas em PL/SQL
-- Autor: Dirceu Silva
-- Linguagem: Oracle PL/SQL
-- Objetivo: Gerar insights comerciais para a base Bike Stores Inc.
-- ###############################################

-- 1. Clientes que nunca realizaram uma compra
-- Estratégia: LEFT JOIN implícito via NOT EXISTS
DECLARE
    v_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== 1. CLIENTES QUE NUNCA REALIZARAM UMA COMPRA ===');
    
    FOR cliente_rec IN (
        SELECT *
        FROM customers c
        WHERE NOT EXISTS (
            SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id
        )
    ) LOOP
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE('Cliente ID: ' || cliente_rec.customer_id || 
                            ' - Nome: ' || cliente_rec.first_name || ' ' || cliente_rec.last_name);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Total de clientes sem compras: ' || v_count);
    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- 2. Produtos que nunca foram comprados
-- Estratégia: NOT EXISTS sobre a tabela de itens de pedido
DECLARE
    v_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== 2. PRODUTOS QUE NUNCA FORAM COMPRADOS ===');
    
    FOR produto_rec IN (
        SELECT *
        FROM products p
        WHERE NOT EXISTS (
            SELECT 1 FROM order_items oi WHERE oi.product_id = p.product_id
        )
    ) LOOP
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE('Produto ID: ' || produto_rec.product_id || 
                            ' - Nome: ' || produto_rec.product_name);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Total de produtos não comprados: ' || v_count);
    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- 3. Produtos sem estoque em nenhuma loja
-- Estratégia: Exclui todos com quantity > 0 para garantir esgotado em todas as lojas
DECLARE
    v_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== 3. PRODUTOS SEM ESTOQUE EM NENHUMA LOJA ===');
    
    FOR produto_rec IN (
        SELECT p.*
        FROM products p
        WHERE NOT EXISTS (
            SELECT 1 FROM stocks s WHERE s.product_id = p.product_id AND s.quantity > 0
        )
    ) LOOP
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE('Produto ID: ' || produto_rec.product_id || 
                            ' - Nome: ' || produto_rec.product_name);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Total de produtos sem estoque: ' || v_count);
    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- 4. Quantidade de vendas por marca por loja
-- Estratégia: JOIN entre orders, items, products, brands e stores; contagem por grupo
DECLARE
    v_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== 4. QUANTIDADE DE VENDAS POR MARCA POR LOJA ===');
    
    FOR venda_rec IN (
        SELECT 
            s.store_name,
            b.brand_name,
            COUNT(*) AS total_vendas
        FROM orders o
        JOIN order_items oi ON o.order_id = oi.order_id
        JOIN products p ON oi.product_id = p.product_id
        JOIN brands b ON p.brand_id = b.brand_id
        JOIN stores s ON o.store_id = s.store_id
        GROUP BY s.store_name, b.brand_name
        ORDER BY s.store_name, b.brand_name
    ) LOOP
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE('Loja: ' || venda_rec.store_name || 
                            ' | Marca: ' || venda_rec.brand_name || 
                            ' | Total Vendas: ' || venda_rec.total_vendas);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Total de combinações loja-marca: ' || v_count);
    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- 5. Funcionários que não estão associados a nenhum pedido
-- Estratégia: NOT EXISTS em cima da orders para garantir ausência de vínculo
DECLARE
    v_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== 5. FUNCIONÁRIOS QUE NÃO ESTÃO ASSOCIADOS A NENHUM PEDIDO ===');
    
    FOR funcionario_rec IN (
        SELECT *
        FROM staffs st
        WHERE NOT EXISTS (
            SELECT 1 FROM orders o WHERE o.staff_id = st.staff_id
        )
    ) LOOP
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE('Funcionário ID: ' || funcionario_rec.staff_id || 
                            ' - Nome: ' || funcionario_rec.first_name || ' ' || funcionario_rec.last_name);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Total de funcionários sem pedidos: ' || v_count);
    DBMS_OUTPUT.PUT_LINE('');
END;
/
