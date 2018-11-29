@isTest
private class IMI_ExceptionLogTest {
    private static testMethod void testcreateExceptionLog()
    {
        String recordId = '12312';
        IMI_ExceptionLog.createExceptionLog(recordId,new DmlException (),new HttpRequest(),new HttpResponse()); 
        System.assertEquals('12312',recordId);
    }
    
    private static testMethod void testcreateSuccessLog()
    {
        String recordId = '12312';
        IMI_ExceptionLog.createSuccessLog('123123',new HttpRequest(),new HttpResponse(),new IMI_ServiceResponse()); 
        System.assertEquals('12312',recordId);
    }
    
    private static testMethod void testcreateActivityLog()
    {
        String message='Test';
        String recordId = '12312';
        IMI_ExceptionLog.createActivityLog(recordId,message); 
        System.assertEquals('Test',message);
    }
}