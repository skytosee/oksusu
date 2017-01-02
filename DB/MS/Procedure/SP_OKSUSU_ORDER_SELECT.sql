CREATE PROCEDURE [dbo].[SP_OKSUSU_ORDER_SELECT]        
(       
   @ID       NVARCHAR(20),
   @ORDER_NB NVARCHAR(12)
)        
--WITH ENCRYPTION        
AS        
/*************************************************************************/        
--��    �� : �ֹ� ��ȸ ( OKSUSU )    
--�� �� �� : �� �� ��     
--�������� : 2016/10/25        
--�������� : 2016/10/25 : �ű�        
/*************************************************************************/        
BEGIN        
        
    SET NOCOUNT ON     
        
    SELECT O.ORDER_NB,
           O.ITEM_CD,
           O.ITEM_NM,
           ISNULL(O.ITEM_QT, 0) AS ITEM_QT,
           ISNULL(O.ITEM_AM, 0) AS ITEM_AM,       
           O.NAME,
           O.PHONE,
           O.ZIP,
           O.ADDR,
           O.INSERT_DT,
           O.ORDER_FG,
           CASE WHEN ISNULL(O.ORDER_FG, '0') = '0' THEN '�ֹ�'
                WHEN ISNULL(O.ORDER_FG, '0') = '1' THEN '����'
                WHEN ISNULL(O.ORDER_FG, '0') = '2' THEN '���'
                WHEN ISNULL(O.ORDER_FG, '0') = '3' THEN '�Ϸ�'
                ELSE '' END AS STATE_NM, 
           CASE WHEN ISNULL(O.ORDER_FG, '0') = '0' THEN 'todo'
                WHEN ISNULL(O.ORDER_FG, '0') = '1' THEN 'ok'
                WHEN ISNULL(O.ORDER_FG, '0') = '2' THEN 'in-progress'
                WHEN ISNULL(O.ORDER_FG, '0') = '3' THEN 'done'
                ELSE '' END AS [status],           
           CASE WHEN ISNULL(O.ORDER_FG, '0') = '0' THEN 'red'
                WHEN ISNULL(O.ORDER_FG, '0') = '1' THEN 'orange'
                WHEN ISNULL(O.ORDER_FG, '0') = '2' THEN 'blue'
                WHEN ISNULL(O.ORDER_FG, '0') = '3' THEN 'green'
                ELSE '' END AS color,    
           CONVERT(INT, RIGHT(O.ORDER_NB, 10)) as id,
           O.ORDER_NB as title,
           O.ITEM_NM as [description],
           dbo.UFN_ADD_COMMA(CONVERT(NVARCHAR, ISNULL(O.ITEM_AM, 0))) + ' ��' AS am          
      FROM OKSUSU_ORDER AS O           
     WHERE ( ISNULL(@ID, '') = '' OR O.ID = @ID ) 
       AND ( ISNULL(@ORDER_NB, '') = '' OR O.ORDER_NB = @ORDER_NB ) 
       
    SET NOCOUNT OFF          
        
END        
  

GO