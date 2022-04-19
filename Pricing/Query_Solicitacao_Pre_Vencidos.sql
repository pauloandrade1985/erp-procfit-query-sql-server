SELECT A.AUTORIZACAO_SOLICITACAO_PREVENCIDO              AS AUTORIZACAO,
	   B.LOJA                                            AS LOJA,
	   B.PRODUTO                                         AS PRODUTO,
	   C.DESCRICAO                                       AS DESCRICAO,
	   B.QUANTIDADE                                      AS QUANTIDADE,
	   B.CUSTO                                           AS CUSTO,
	   B.PRECO_MAXIMO                                    AS PRECO_MAXIMO,
	   B.DESCONTO                                        AS DESCONTO,
	   B.PRECO_VENDA                                     AS PRECO_VENDA,
	   B.LOTE                                            AS LOTE,
	   CONVERT(VARCHAR,B.VALIDADE,103)                   AS VALIDADE,
	   CASE CONFIRMAR WHEN 'S' THEN 'SIM' ELSE 'NÃO' END AS CONFIRMADA

	FROM AUTORIZACOES_SOLICITACOES_PREVENCIDOS			     A WITH(NOLOCK)
		JOIN AUTORIZACOES_SOLICITACOES_PREVENCIDOS_ITENS	 B WITH(NOLOCK) ON A.AUTORIZACAO_SOLICITACAO_PREVENCIDO = B.AUTORIZACAO_SOLICITACAO_PREVENCIDO
		JOIN PRODUTOS                                        C WITH(NOLOCK) ON B.PRODUTO = C.PRODUTO
	WHERE A.CONFIRMAR = 'S' AND A.DESCONSIDERAR_DEMANDA = 'N' AND B.AUTORIZADO = 'S'
ORDER BY B.VALIDADE




