CREATE PROCEDURE [dbo].[SP_OKSUSU_LOGIN]    
(   
	   @LOGIN_ID       NVARCHAR(20),           -- 로그인ID      
    @LOGIN_PW       NVARCHAR(80)            -- 비밀번호      
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
    
    DECLARE @RESULT NVARCHAR(10)      
    
    -- 사용자 ID가 존재하는지 검사      
    IF(NOT EXISTS (SELECT 1 FROM OKSUSU_USER WHERE ID = @LOGIN_ID))      
    BEGIN      
        SET @RESULT = 'WRONG_ID'  
        SELECT @RESULT AS RESULT    
        RETURN      
    END      
          
    -- 비밀번호가 맞는지 검사      
    IF(NOT EXISTS (SELECT 1 FROM OKSUSU_USER WHERE ID = @LOGIN_ID AND [PASSWORD] = @LOGIN_PW ) )      
    BEGIN      
        SET @RESULT = 'WRONG_PW'  
        SELECT @RESULT AS RESULT    
        RETURN      
    END          
          
    SET @RESULT = 'OK'      
    
    SELECT @RESULT AS RESULT,
           *
      FROM OKSUSU_USER 	 
     WHERE ID = @LOGIN_ID
      AND [PASSWORD] = @LOGIN_PW
  
    SET NOCOUNT OFF      
    
END    
GO


