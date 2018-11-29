with sharing public class IMI_IntegrationRequestUtility {

    public  string getSMSJSONRequest(String toNumber,String smsText)
    {
       String jsonReq = '{ "deliverychannel":"sms", '+
           '"channels":{ '+
           '"sms":{'+
           ' "text":"'+smsText+'",'+
           ' "senderid":"CONNCT" } },'+
           ' "destination":[ { '+
           '"msisdn":["'+toNumber+'"] } ] }';
        return jsonReq;
    }
}