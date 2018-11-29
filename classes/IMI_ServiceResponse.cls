public class IMI_ServiceResponse {
    
    public class SMSResponse {
        public String code;
        public String description;
        public String transid;
    }
    
    public SMSResponse response;
    
    
    public static IMI_ServiceResponse parseSMSResponse(String json) {
        return (IMI_ServiceResponse) System.JSON.deserialize(json, IMI_ServiceResponse.class);
    }
}