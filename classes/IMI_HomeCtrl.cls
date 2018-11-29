with sharing global class IMI_HomeCtrl {
    
    public Boolean isIMIAdmin{get;set;}
    public Boolean isIMIKeyUpdated{get;set;}
    public Boolean isSettingsUpdated{get;set;}
    public String IMIKEY{get;set;}
    public String IMIKEYERROR{get;set;}
    public Boolean checkAcitivityLog{get;set;}
    public Boolean checkLog{get;set;}
    
    public IMI_HomeCtrl()
    {
        loadDefaultSettings();
    }
    public void getCurrentUserInfo()
    {
        List<PermissionSetAssignment> userPermissionSets = [SELECT Id, PermissionSetId, AssigneeId 
                                                            FROM PermissionSetAssignment
                                                            WHERE AssigneeId=:Userinfo.getUserId() AND
                                                            PermissionSet.Name='IMI_Admin'];
        if(userPermissionSets.size()>0)
        {
            isIMIAdmin = true;
        }
        else
        {
            isIMIAdmin = false;
        }
    }
    
    public void updateIMIKeyInfo()
    {
        System.debug('================>'+String.isNotEmpty(IMIKEY));
        if(String.isNotEmpty(IMIKEY))
        {
            IMIKEYERROR =null;
            if(IMI_Settings__c.getValues('KEY')!=null)
            {
                try
                {
                    IMI_Settings__c imiKeydetails = IMI_Settings__c.getValues('KEY');
                    imiKeydetails.IMI_Value__c = IMIKEY;
                    update imiKeydetails;  
                    isIMIKeyUpdated = true;
                }
                catch(Exception ex)
                {
                    isIMIKeyUpdated = false;
                }
            }    
        }
        else
        {
            IMIKEYERROR = 'Please enter key value';
        }
    }
    
    public void updateSettings()
    {
        if(IMI_Settings__c.getValues('ACTIVITY HISTORY')!=null && IMI_Settings__c.getValues('LOG')!=null)
        {
            List<IMI_Settings__c> updateSetting = new List<IMI_Settings__c>();
            IMI_Settings__c logDetails = IMI_Settings__c.getValues('LOG');
            if(checkLog)
            {
                logDetails.IMI_Value__c = 'YES';
            }
            else
            {
                logDetails.IMI_Value__c = 'NO';
            }
            
            IMI_Settings__c activityDetails = IMI_Settings__c.getValues('ACTIVITY HISTORY');
            
            if(checkAcitivityLog)
            {
                activityDetails.IMI_Value__c = 'YES';
            }
            else
            {
                activityDetails.IMI_Value__c = 'NO';
            }
            updateSetting.add(logDetails);
            updateSetting.add(activityDetails);
            update updateSetting;
            isSettingsUpdated = true;
        }
    }
    
    public void closeKeySettings()
    {
        IMIKEY =null;
        isIMIKeyUpdated = false;
        
    }
    
    public void closeLogSettings()
    {
        loadDefaultSettings();
        isSettingsUpdated = false;
        
    }
    
    public void loadDefaultSettings()
    {
        if(IMI_Settings__c.getValues('ACTIVITY HISTORY')!=null)
        {
            IMI_Settings__c activityDetails = IMI_Settings__c.getValues('ACTIVITY HISTORY');
            if(activityDetails.IMI_Value__c == 'YES')
            {
                checkAcitivityLog = true;
            }
            else
            {
                checkAcitivityLog = false;
            }
        }
        
         
        if(IMI_Settings__c.getValues('LOG')!=null)
        {
            IMI_Settings__c logDetails = IMI_Settings__c.getValues('LOG');
            if(logDetails.IMI_Value__c == 'YES')
            {
                checkLog = true;
            }
            else
            {
                checkLog = false;
            }
        }
    }
    
}