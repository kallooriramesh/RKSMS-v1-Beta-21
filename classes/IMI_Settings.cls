global  class IMI_Settings implements InstallHandler{
    
    global void onInstall(InstallContext context) {
        if(context.previousVersion() == null) {
            List<IMI_Settings__c> settings = new List<IMI_Settings__c>();
            IMI_Settings__c key = new IMI_Settings__c();
            key.Name = 'KEY';
            key.IMI_Value__c = '123123';
            
            
            IMI_Settings__c endpoint = new IMI_Settings__c();
            endpoint.Name = 'ENDPOINT';
            endpoint.IMI_Value__c = 'https://api.imiconnect.io/resources/v1/';
            
            
            IMI_Settings__c log = new IMI_Settings__c();
            log.Name = 'LOG';
            log.IMI_Value__c = 'YES';
            
            IMI_Settings__c activity = new IMI_Settings__c();
            activity.Name = 'ACTIVITY HISTORY';
            activity.IMI_Value__c = 'YES';
            
            IMI_Settings__c adminPermissionSet = new IMI_Settings__c();
            adminPermissionSet.Name = 'ADMIN PERMISSION SET';
            adminPermissionSet.IMI_Value__c = 'IMI_Admin';
            
            
            IMI_Settings__c userPermissionSet = new IMI_Settings__c();
            userPermissionSet.Name = 'USER PERMISSION SET';
            userPermissionSet.IMI_Value__c = 'IMI_User';
            
            settings.add(key);
            settings.add(endpoint);
            settings.add(log);
            settings.add(activity);
            settings.add(adminPermissionSet);
            settings.add(userPermissionSet);
            insert settings;
        }
    }
}