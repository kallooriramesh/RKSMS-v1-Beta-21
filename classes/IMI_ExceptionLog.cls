with sharing global class IMI_ExceptionLog {
    public static void createExceptionLog(String recordId,Exception ex,HttpRequest req,HttpResponse res)
    {
        try
        {
            IMI_Log__c log = new IMI_Log__c();
            log.Record_Id__c = recordId;
            log.Error_Message__c = ex.getMessage();
            log.Error_Description__c = ex.getCause()+'\n'+ex.getLineNumber()+'\n'+ex.getStackTraceString()+'\n'+ex.getTypeName();
            insert log;    
        }
        catch(Exception e)
        {
            
        } 
    }
    
    public static void createSuccessLog(String recordId,HttpRequest req,HttpResponse res,IMI_ServiceResponse serviceRes)
    {
        try
        {
            IMI_Log__c log = new IMI_Log__c();
            log.Record_Id__c = recordId;
            log.HTTP_Request__c = req.getBody();
            log.HTTP_Response__c = res.getBody();
            log.HTTP_Status_Code__c = String.valueOf(res.getStatusCode());
            log.HTTP_Status_Message__c = res.getStatus();
            log.HTTP_Method__c = req.getMethod();
            log.Integration_Status_Code__c = serviceRes.response.code;
            log.Integration_Status_Message__c = serviceRes.response.description;
            log.Integration_Transaction_ID__c = serviceRes.response.transid;
            insert log;    
        }
        catch(Exception e)
        {
            
        }
    }
    
    public static void createActivityLog(String recordId,String message)
    {
        try
        {
            Task t = new Task();
            t.OwnerId = Userinfo.getUserId();
            t.Subject = 'Sms sent successfully';
            t.Description = message;
            t.Status = 'Completed';
            t.Priority = 'Normal';
            t.WhoId = recordId;
            insert t;    
        }
        catch(Exception ex)
        {
            
        }
    }
}