CREATE PROCEDURE [dbo].[SP_OKSUSU_ORDER_FG_UPDATE]      
(     
   @ORDER_NB          NVARCHAR(12),  
   @ORDER_FG          NVARCHAR(1)
)      
--WITH ENCRYPTION      
AS      
/*************************************************************************/      
--설    명 : 카트 DML
--수 정 자 : 박 영 웅   
--수정일자 : 2016/10/25      
--수정내역 : 2016/10/25 : 신규      
/*************************************************************************/      
BEGIN      
      
  SET NOCOUNT ON   
   
  UPDATE OKSUSU_ORDER
     SET ORDER_FG = @ORDER_FG
   WHERE ORDER_NB = @ORDER_NB  
    
  SET NOCOUNT OFF              
END
GO
