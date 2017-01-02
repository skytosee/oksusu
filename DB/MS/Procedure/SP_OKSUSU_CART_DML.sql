CREATE PROCEDURE [dbo].[SP_OKSUSU_CART_DML]      
(     
   @DML_FG            NVARCHAR(1),
   @ID                NVARCHAR(20),
   @ITEM_CD           NVARCHAR(10), 
   @ITEM_QT           NUMERIC(18,0)
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
  
  IF (@DML_FG = 'I')
  BEGIN
    IF NOT EXISTS ( SELECT 1 FROM OKSUSU_CART WHERE ID = @ID AND ITEM_CD = @ITEM_CD )
    BEGIN 
      INSERT INTO OKSUSU_CART ( ID, ITEM_CD, INSERT_DT, ITEM_QT )
           VALUES ( @ID, @ITEM_CD, GETDATE(), @ITEM_QT )      
    END
    ELSE
    BEGIN
      UPDATE OKSUSU_CART
         SET ITEM_QT = ISNULL(ITEM_QT, 0) + ISNULL(@ITEM_QT, 0)
       WHERE ID = @ID
         AND ITEM_CD = @ITEM_CD  
    END  
  END
  ELSE IF (@DML_FG = 'U')
  BEGIN
    UPDATE OKSUSU_CART
       SET ITEM_QT = @ITEM_QT
     WHERE ID = @ID
       AND ITEM_CD = @ITEM_CD  
  END
  ELSE IF (@DML_FG = 'D')
  BEGIN
    DELETE OKSUSU_CART
     WHERE ID = @ID
       AND ITEM_CD = @ITEM_CD  
  END
  
   
  SET NOCOUNT OFF              
END      


GO
