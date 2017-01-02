CREATE PROCEDURE [dbo].[SP_OKSUSU_ITEM_SELECT]      
(     
   @TYPE     NVARCHAR(10),
   @VIEW_YN  NVARCHAR(1)
)      
--WITH ENCRYPTION      
AS      
/*************************************************************************/      
--설    명 : 로그인 체크 및 로그인 사원 정보 조회 ( OKSUSU )  
--수 정 자 : 박 영 웅   
--수정일자 : 2016/10/25      
--수정내역 : 2016/10/25 : 신규      
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


