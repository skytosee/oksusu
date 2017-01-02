CREATE PROCEDURE [dbo].[SP_OKSUSU_ITEM_DML]      
(     
   @DML_FG            NVARCHAR(1),
   @ITEM_CD           NVARCHAR(10), 
   @ITEM_NM           NVARCHAR(50), 
   @ITEM_DC           NVARCHAR(1000), 
   @ORIGINAL_IMG_NAME NVARCHAR(260), 
   @STORED_IMG_NAME   NVARCHAR(40),
   @GOOD              INT,
   @PRICE             NUMERIC(18,0),
   @ITEM_TYPE         NVARCHAR(10),
   @VIEW_YN           NVARCHAR(1),
   @INSERT_ID         NVARCHAR(30)
)      
--WITH ENCRYPTION      
AS      
/*************************************************************************/      
--설    명 : 품목 DML
--수 정 자 : 박 영 웅   
--수정일자 : 2016/10/25      
--수정내역 : 2016/10/25 : 신규      
/*************************************************************************/      
BEGIN      
      
  SET NOCOUNT ON   
  
  IF (@DML_FG = 'I')
  BEGIN
    INSERT INTO OKSUSU_ITEM ( ITEM_CD, ITEM_NM, ITEM_DC, ORIGINAL_IMG_NAME, STORED_IMG_NAME,
                              GOOD, INSERT_DT, INSERT_ID, PRICE, ITEM_TYPE,
                              VIEW_YN )
         VALUES ( @ITEM_CD, @ITEM_NM, @ITEM_DC, @ORIGINAL_IMG_NAME, @STORED_IMG_NAME,
                  @GOOD, GETDATE(), @INSERT_ID, @PRICE, @ITEM_TYPE,
                  CASE WHEN ISNULL(@VIEW_YN, 't') = 'f' then '' ELSE ISNULL(@VIEW_YN, 't') END )           
  END
  ELSE IF (@DML_FG = 'U')
  BEGIN
    UPDATE OKSUSU_ITEM
       SET ITEM_CD = @ITEM_CD, 
           ITEM_NM = @ITEM_NM,
           ITEM_DC = @ITEM_DC,
           ORIGINAL_IMG_NAME = @ORIGINAL_IMG_NAME,
           STORED_IMG_NAME = @STORED_IMG_NAME,
           GOOD = @GOOD,                     
           PRICE = @PRICE, 
           ITEM_TYPE = @ITEM_TYPE,
           VIEW_YN = CASE WHEN ISNULL(@VIEW_YN, 't') = 'f' then '' ELSE ISNULL(@VIEW_YN, 't') END
     WHERE ITEM_CD = @ITEM_CD
  END
  ELSE IF (@DML_FG = 'D')
  BEGIN
    DELETE OKSUSU_ITEM
     WHERE ITEM_CD = @ITEM_CD  
  END
  
   
  SET NOCOUNT OFF              
END      


GO
