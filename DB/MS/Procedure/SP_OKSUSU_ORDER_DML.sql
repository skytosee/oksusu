CREATE PROCEDURE [dbo].[SP_OKSUSU_ORDER_DML]      
(     
   @DML_FG            NVARCHAR(1),
   @ID                NVARCHAR(20),
   @ORDER_NB          NVARCHAR(12),
   @ITEM_CD           NVARCHAR(1000), 
   @ITEM_NM           NVARCHAR(1000), 
   @ITEM_QT           NUMERIC(18,0),
   @ITEM_AM           NUMERIC(18,0),
   @NAME              NVARCHAR(100), 
   @PHONE             NVARCHAR(20),
   @ZIP               NVARCHAR(10),
   @ADDR              NVARCHAR(300),
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
  
  IF (@DML_FG = 'I')
  BEGIN
     DECLARE @DT NVARCHAR(8)
     SET @DT = CONVERT(NVARCHAR(8),GETDATE(),112)
   
     SET @ORDER_NB = ''
     EXEC USP_GET_INV_KEY_NB 'LSO', 'SO_NB', '0000', 'SO', @DT, @ORDER_NB OUTPUT

     INSERT INTO OKSUSU_ORDER ( ID, ORDER_NB, ITEM_CD, ITEM_NM, ITEM_QT,
                                ITEM_AM, NAME, PHONE, ZIP, ADDR,
                                ORDER_FG, INSERT_DT )
           VALUES ( @ID, @ORDER_NB, @ITEM_CD, @ITEM_NM, @ITEM_QT,
                    @ITEM_AM, @NAME, @PHONE, @ZIP, @ADDR,
                    @ORDER_FG, GETDATE() )      
  END
  ELSE IF (@DML_FG = 'U')
  BEGIN
    UPDATE OKSUSU_ORDER
       SET ITEM_NM = @ITEM_NM,
           ORDER_FG = @ORDER_FG
     WHERE ORDER_NB = @ORDER_NB  
  END
  ELSE IF (@DML_FG = 'D')
  BEGIN
    IF ( ISNULL(@ORDER_NB, '' ) = '' )
    BEGIN
      SELECT @ORDER_NB = MAX(ORDER_NB)
        FROM OKSUSU_ORDER
       WHERE ID = @ID
    END 
  
    DELETE OKSUSU_ORDER
     WHERE ID = @ID
       AND ORDER_NB = @ORDER_NB  
  END
  
   
  SET NOCOUNT OFF              
END
GO
