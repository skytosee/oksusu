CREATE PROCEDURE [dbo].[SP_OKSUSU_LOGIN]    
(   
	@LOGIN_ID       NVARCHAR(20),           -- �α���ID      
    @LOGIN_PW       NVARCHAR(80)            -- ��й�ȣ      
)    
--WITH ENCRYPTION    
AS    
/*************************************************************************/    
--��    �� : �α��� üũ �� �α��� ��� ���� ��ȸ ( OKSUSU )
--�� �� �� : �� �� �� 
--�������� : 2016/10/25    
--�������� : 2016/10/25 : �ű�    
/*************************************************************************/    
BEGIN    
    
    SET NOCOUNT ON 
    
    DECLARE @RESULT NVARCHAR(10)      
    
    -- ����� ID�� �����ϴ��� �˻�      
    IF(NOT EXISTS (SELECT 1 FROM OKSUSU_USER WHERE ID = @LOGIN_ID))      
    BEGIN      
        SET @RESULT = 'WRONG_ID'  
        SELECT @RESULT AS RESULT    
        RETURN      
    END      
          
    -- ��й�ȣ�� �´��� �˻�      
    IF(NOT EXISTS (SELECT 1 FROM OKSUSU_USER WHERE ID = @LOGIN_ID AND [PASSWORD] = @LOGIN_PW ) )      
    BEGIN      
        SET @RESULT = 'WRONG_PW'  
        SELECT @RESULT AS RESULT    
        RETURN      
    END          
          
    SET @RESULT = 'OK'      
    
    SELECT @RESULT AS RESULT,
           U.*,
           CONVERT(NVARCHAR, C.CARTCOUNT) AS CARTCOUNT
      FROM OKSUSU_USER AS U
           LEFT OUTER JOIN ( SELECT ID, COUNT(ITEM_CD) AS CARTCOUNT
                               FROM OKSUSU_CART
                              GROUP BY ID ) AS C
                        ON U.ID = C.ID
     WHERE U.ID = @LOGIN_ID
       AND U.[PASSWORD] = @LOGIN_PW
  
    SET NOCOUNT OFF      
    
END    
GO