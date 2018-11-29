@IsTest
public class IMI_ServiceResponseTest {
    static testMethod void testParse() {
        String json = '{\"response\":{\"code\":\"7001\",\"description\":\"Authentication failed.\",\"transid\":\"ceca010d-8e18-4b79-92dd-2717358a287b\"}}';
        IMI_ServiceResponse obj = IMI_ServiceResponse.parseSMSResponse(json);
        System.assert(obj != null); 
    }
}