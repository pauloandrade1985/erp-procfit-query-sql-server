DECLARE @PRODUTO            NUMERIC(15) = CASE WHEN ISNUMERIC(94920) = 1 THEN (94920) ELSE NULL END
DECLARE @DATA_INICIO        DATE = '01/04/2022'
DECLARE @DATA_FINAL         DATE = '30/04/2022'

IF OBJECT_ID('tempdb..#SOLICITACAO_PRECO') is not null DROP TABLE #SOLICITACAO_PRECO

SELECT  A.BIC_ALTERACAO_PRECO                                                          AS [ID_CONTROLE],
        C.NOME                                                                         AS COMPRADOR,
        CONVERT(VARCHAR,A.DATA_PREVISAO,103)                                           AS [PREVISAO_ALTERACAO],
        ISNULL(CONVERT(VARCHAR,A.DATA_ALTERACAO,103),'')                               AS [DATA_ALTERAÇÃO],
        A.CONFIRMA_PRICING                                                             AS [STATUS],
        B.PRODUTO                                                                      AS PRODUTO,
        B.DESCRICAO                                                                    AS [DESCRICAO],
        B.EAN                                                                          AS [EAN],
        B.MARCA                                                                        AS MARCA,
        B.PRECO_VENDA                                                                  AS [PRECO_ATUAL],
        B.PRECO_SOLICITADO                                                             AS [PRECO_SOLICITADO],
        B.MARGEM_ATUAL                                                                 AS [MARGEM_ATUAL],
        B.MARGEM_SOLICITADA                                                            AS [MARGEM_SOLICITADA],
        IIF(PRECO_VENDA > PRECO_SOLICITADO,'BAIXAR PREÇO','AUMENTAR PREÇO')            AS [STATUS_PRECO],
        B.SITUACAO_SOLICITADA                                                          AS [STATUS_PRODUTO],
        A.OBSERVACAO                                                                   AS [OBSERVACAO]
       INTO #SOLICITACAO_PRECO
    FROM BIC_ALTERACOES_PRECOS                A WITH(NOLOCK)
        JOIN BIC_ALTERACOES_PRECOS_PRODUTOS   B WITH(NOLOCK) ON A.BIC_ALTERACAO_PRECO = B.BIC_ALTERACAO_PRECO
        JOIN COMPRADORES                      C WITH(NOLOCK) ON A.COMPRADOR = C.COMPRADOR
    WHERE A.DATA_ATUAL >= @DATA_INICIO AND
          A.DATA_ATUAL <= @DATA_FINAL AND 
          (B.PRODUTO = @PRODUTO OR @PRODUTO IS NULL)
    ORDER BY B.DESCRICAO ASC     
   
SELECT * FROM #SOLICITACAO_PRECO