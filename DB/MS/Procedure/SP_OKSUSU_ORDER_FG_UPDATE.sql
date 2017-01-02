CREATE PROCEDURE [dbo].[SP_OKSUSU_ORDER_FG_UPDATE]      
(     
   @ORDER_NB          NVARCHAR(12),  
   @ORDER_FG          NVARCHAR(1)
)      
--WITH ENCRYPTION      
AS      
/*************************************************************************/      
--��    �� : īƮ DML
--�� �� �� : �� �� ��   
--�������� : 2016/10/25      
--�������� : 2016/10/25 : �ű�      
/*************************************************************************/      
BEGIN      
      
  SET NOCOUNT ON   
   
  UPDATE OKSUSU_ORDER
     SET ORDER_FG = @ORDER_FG
   WHERE ORDER_NB = @ORDER_NB  
    
  SET NOCOUNT OFF              
END
GO
