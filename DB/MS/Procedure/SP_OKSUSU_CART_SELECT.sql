CREATE PROCEDURE [dbo].[SP_OKSUSU_CART_SELECT]        
(       
   @ID       NVARCHAR(20)
)        
--WITH ENCRYPTION        
AS        
/*************************************************************************/        
--��    �� : īƮ ��ȸ ( OKSUSU )    
--�� �� �� : �� �� ��     
--�������� : 2016/10/25        
--�������� : 2016/10/25 : �ű�        
/*************************************************************************/        
BEGIN        
        
    SET NOCOUNT ON     
        
    SELECT I.ITEM_CD,
           I.ITEM_NM,
           I.ITEM_DC,
           ISNULL(I.ORIGINAL_IMG_NAME, '') AS ORIGINAL_IMG_NAME,
           ISNULL(I.STORED_IMG_NAME, '') AS STORED_IMG_NAME,
           I.GOOD,
           C.INSERT_DT,
           ISNULL(I.PRICE, 0) AS PRICE,
           ISNULL(C.ITEM_QT, 0) AS ITEM_QT,
           ISNULL(I.PRICE, 0) * ISNULL(C.ITEM_QT, 0) AS ITEM_AM,      
           I.ITEM_TYPE,
           I.VIEW_YN,
           'checked' AS CHECK_YN 
      FROM OKSUSU_CART AS C
           LEFT OUTER JOIN OKSUSU_ITEM AS I
                        ON C.ITEM_CD = I.ITEM_CD  
     WHERE ( ISNULL(@ID, '') = '' OR C.ID = @ID ) 
      
    SET NOCOUNT OFF          
        
END        
  

GO