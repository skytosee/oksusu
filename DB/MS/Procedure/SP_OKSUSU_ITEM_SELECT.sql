CREATE PROCEDURE [dbo].[SP_OKSUSU_ITEM_SELECT]      
(     
   @TYPE     NVARCHAR(10),
   @VIEW_YN  NVARCHAR(1)
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
      
    SELECT ITEM_CD AS id,
           *
      FROM OKSUSU_ITEM     
     WHERE ( ISNULL(@TYPE, '') = '' OR ITEM_TYPE = @TYPE )  
       AND ( ISNULL(@VIEW_YN, '') = '' OR VIEW_YN = @VIEW_YN )
    
    SET NOCOUNT OFF        
      
END      


GO


