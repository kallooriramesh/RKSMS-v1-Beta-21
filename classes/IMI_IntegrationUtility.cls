with sharing public class IMI_IntegrationUtility {
    //Public  String APIKEY = '1929c01d-bb07-11e8-bf0b-0213261164bb-1';
    public  IMI_IntegrationResponse sendSMS(String toNumber,String smsText)
    {
        IMI_IntegrationResponse intgRes = new IMI_IntegrationResponse();
        IMI_Settings__c endPoint;
        IMI_Settings__c imiKeydetails;
        String EndPointURL;
        String APIKEY;
        if(IMI_Settings__c.getValues('ENDPOINT')!=null)
        {
            endPoint = IMI_Settings__c.getValues('ENDPOINT');
            EndPointURL= endPoint.IMI_Value__c+'messaging'; 
        }
        
        if(IMI_Settings__c.getValues('KEY')!=null)
        {
            imiKeydetails = IMI_Settings__c.getValues('KEY'); 
            APIKEY = imiKeydetails.IMI_Value__c;
        }
           
        
        IMI_IntegrationRequestUtility reqObj = new IMI_IntegrationRequestUtility();
        String jsonRequest = reqObj.getSMSJSONRequest(toNumber, smsText);
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(EndPointURL);
        req.setBody(jsonRequest);
        req.setMethod('POST');
        req.setHeader('key',APIKEY);
        req.setHeader('content-type','application/json');
        HttpResponse res ;
        if(Test.isRunningTest())
        {
            res = new HttpResponse();
            res.setBody('{"response":{"code":"7001","description":"Authentication failed.","transid":"6316c4ee-1091-4ca0-baa6-98853a150062"}}');
            res.setStatusCode(200);
        }
        else
        {
            res = h.send(req);    
        }
        intgRes.req = req;
        intgRes.res = res;
        return intgRes;
    }
    
}