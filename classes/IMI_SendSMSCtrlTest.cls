@isTest(SeeAllData=false)
private class IMI_SendSMSCtrlTest {
    private static testMethod void testsendSMS()
    {
        IMI_HomeCtrlTest.setupData();
        Contact con = new Contact();
        con.LastName = 'IMI TEST';
        con.Phone = '9999999';
        insert con;
        ApexPages.StandardController sc = new ApexPages.StandardController(con);
        IMI_SendSMSCtrl sendCtrl = new IMI_SendSMSCtrl(sc);
        sendCtrl.selectedTo = 'Phone';
        sendCtrl.message = 'Test';
        sendCtrl.sendSMS(); 
        sendCtrl.getCurrentUserInfo();
        System.assertEquals('Test',sendCtrl.message);
    }
    
}