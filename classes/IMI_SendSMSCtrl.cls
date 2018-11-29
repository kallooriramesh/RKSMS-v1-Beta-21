with sharing global class IMI_SendSMSCtrl {
    
    public String message{get;set;}
    public String smsStatus{get;set;}
    public String smsStatusCode{get;set;}
    public Boolean isIMIUser{get;set;}
    public String selectedTo{get;set;}
    public Boolean isRequiredFieldsMissing{get;set;}
    public List<SelectOption> ToOptions{get;set;}
    public Contact con;
    
   
    
    public IMI_SendSMSCtrl(ApexPages.StandardController controller)
    {
       
        try
        {
            ToOptions= CommonUtility.getToSMSFields('Contact', 'RKSMS__To_SMS_Fields');
            this.con = (Contact)controller.getRecord();   
            if(toOptions.size()>0)
            {
                selectedTo = toOptions[0].getValue();
            }
        }
        catch(Exception ex)
        {
            System.debug('ERROR Exception in IMI_SendSMSCtrl.IMI_SendSMSCtrl()===========>'+ex); 
        }
        
        
    }
    public void sendSMS()
    {
        if(String.isNotEmpty(message) && con.get(selectedTo)!=null)
        { 
            isRequiredFieldsMissing = false;
            IMI_IntegrationUtility intgUtilObj = new IMI_IntegrationUtility();
            IMI_IntegrationResponse intgRes;
            try
            {
                intgRes = intgUtilObj.sendSMS(String.valueOf(con.get(selectedTo)),message);
                HttpResponse res = intgRes.res;
                IMI_ServiceResponse serviceRes= IMI_ServiceResponse.parseSMSResponse(res.getBody());
                if(res.getStatusCode() == 200)
                {
                    smsStatus = serviceRes.response.description;
                    smsStatusCode = serviceRes.response.code;
                    createLog(intgRes,con.id,message,serviceRes);
                }
                else
                {
                    smsStatus = 'Error occurred while sending the sms Please contact to admin.';
                    createLog(intgRes,con.id,message,serviceRes);
                }
                
            } 
            catch(Exception ex)
            {
                System.debug('ERROR Exception in IMI_SendSMSCtrl.sendSMS()===========>'+ex);
                if(IMI_Settings__c.getValues('LOG')!=null)
                {
                    if(IMI_Settings__c.getValues('LOG').IMI_Value__c == 'YES')
                    {
                        IMI_ExceptionLog.createExceptionLog(con.Id,ex,intgRes.req,intgRes.res);        
                    }
                }
            }
        }
        else
        {
            isRequiredFieldsMissing = true;
        }
        
    }
    
    public void getCurrentUserInfo()
    {
        try
        {
            Set<String> assignedIMIPermissionsets = new Set<String>();
            if(IMI_Settings__c.getValues('ADMIN PERMISSION SET')!=null)
            {
                if(IMI_Settings__c.getValues('ADMIN PERMISSION SET').IMI_Value__c!=null)
                {
                    assignedIMIPermissionsets.add(IMI_Settings__c.getValues('ADMIN PERMISSION SET').IMI_Value__c);    
                }
                
            }
            
            if(IMI_Settings__c.getValues('USER PERMISSION SET')!=null)
            {
                if(IMI_Settings__c.getValues('USER PERMISSION SET').IMI_Value__c!=null)
                {
                    assignedIMIPermissionsets.add(IMI_Settings__c.getValues('USER PERMISSION SET').IMI_Value__c);    
                }
                
            }
            
            if(assignedIMIPermissionsets.size()>0)
            {
                List<PermissionSetAssignment> userPermissionSets = [SELECT Id, PermissionSetId, AssigneeId 
                                                                    FROM PermissionSetAssignment
                                                                    WHERE AssigneeId=:Userinfo.getUserId() AND
                                                                    PermissionSet.Name IN :assignedIMIPermissionsets];
                if(userPermissionSets.size()>0)
                {
                    isIMIUser = true;
                }
                else
                {
                    isIMIUser = false;
                }    
            }
            
        }
        catch(Exception ex)
        {
            System.debug('ERROR Exception in IMI_SendSMSCtrl.getCurrentUserInfo()===========>'+ex);
        }
    }
    
    public void createLog(IMI_IntegrationResponse intgRes,String recordId,String message,IMI_ServiceResponse serviceRes)
    {
        try
        {
            if(IMI_Settings__c.getValues('LOG')!=null)
            {
                if(IMI_Settings__c.getValues('LOG').IMI_Value__c == 'YES')
                {
                    IMI_ExceptionLog.createSuccessLog(recordId,intgRes.req,intgRes.res,serviceRes);        
                }
            }
            
            
            if(IMI_Settings__c.getValues('ACTIVITY HISTORY')!=null)
            {
                if(IMI_Settings__c.getValues('ACTIVITY HISTORY').IMI_Value__c == 'YES')
                {
                    IMI_ExceptionLog.createActivityLog(recordId,message);        
                }
            }    
        }
        catch(Exception ex)
        {
            System.debug('ERROR Exception in IMI_SendSMSCtrl.createLog()===========>'+ex);
        }
        
    }
    
    public void handleSelectedPhone()
    {
        System.debug('Selected Phone Type....'+selectedTo);
    }
}