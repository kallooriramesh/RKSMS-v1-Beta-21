@isTest(SeeAllData=false)
public class IMI_HomeCtrlTest {
    
    private static testMethod void testgetCurrentUserInfo()
    {
        setupData();
        IMI_HomeCtrl imiCtrl = new IMI_HomeCtrl();
        imiCtrl.getCurrentUserInfo();
        System.assertNotEquals(null, imiCtrl);
    }
    
    private static testMethod void testupdateIMIKeyInfo()
    {
        setupData();
        IMI_HomeCtrl imiCtrl = new IMI_HomeCtrl();
        imiCtrl.IMIKEY ='123123';
        imiCtrl.updateIMIKeyInfo();
        System.assertEquals(imiCtrl.IMIKEY, '123123');
    }
    private static testMethod void testupdateSettings()
    {
        setupData();
        IMI_HomeCtrl imiCtrl = new IMI_HomeCtrl();
        imiCtrl.updateSettings();
        System.assertNotEquals(null, imiCtrl);
        
    }
    private static testMethod void testcloseKeySettings()
    {
        IMI_HomeCtrl imiCtrl = new IMI_HomeCtrl();
        imiCtrl.closeKeySettings();
        System.assertNotEquals(null, imiCtrl);
        
    }
    private static testMethod void testcloseLogSettings()
    {
        IMI_HomeCtrl imiCtrl = new IMI_HomeCtrl();
        imiCtrl.closeLogSettings();
        System.assertNotEquals(null, imiCtrl);
        
    }
    
    
    
    public static testMethod void setupData()
    {
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
        System.assertNotEquals(0,settings.size());
    }
}