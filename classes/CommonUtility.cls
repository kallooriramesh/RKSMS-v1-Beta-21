public class CommonUtility {
    
    public static List<SelectOption> getToSMSFields(String objectName,String fieldSetName)
    {
        List<SelectOption> options = new List<SelectOption>();
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe();
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(objectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);
        for(Schema.FieldSetMember fieldSetMemberObj : fieldSetObj.getFields())
        {
            if(isFieldAccessible(objectName,fieldSetMemberObj.getFieldPath()))
            {
                options.add(new SelectOption(fieldSetMemberObj.getFieldPath(),fieldSetMemberObj.getLabel()));                
            }
        }
        return options;
    }
    public static Boolean isFieldAccessible(String objectName,String fieldName)
    {
        if(Schema.getGlobalDescribe().get(objectName)!=null)
        {
            SObjectType sObjectType = Schema.getGlobalDescribe().get(objectName);
            Map<String,Schema.SObjectField> fields = sObjectType.getDescribe().fields.getMap();
            if(fields.get(fieldName)!=null)
            {
                Schema.DescribeFieldResult fieldDesribe = fields.get(fieldName).getDescribe();
                return fieldDesribe.isAccessible();    
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
        
    }
}