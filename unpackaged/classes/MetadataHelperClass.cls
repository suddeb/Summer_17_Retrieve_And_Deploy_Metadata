public class MetadataHelperClass {
    public void getMetadataInformation(){
        //Create List of Metadata Components with their full name
        List<String> componentNameList = new List<String>{'Admin_Preference__mdt.Process_Builder_Preference','Admin_Preference__mdt.Trigger_Preference','Admin_Preference__mdt.Validation_Rule_Preference','Admin_Preference__mdt.Workflow_Preference'};
        
        //Retrieve the Metadata
        List<Metadata.Metadata> components = Metadata.Operations.retrieve(Metadata.MetadataType.CustomMetadata, componentNameList);

        //Looping through the Metadata to get the values
        for(Metadata.Metadata singleComponent : components){
            Metadata.CustomMetadata customMetadataRecord = (Metadata.CustomMetadata)singleComponent;
            System.Debug('Label: ' + customMetadataRecord.label);
            
            for(Metadata.CustomMetadataValue singleCustomMetadataVale : customMetadataRecord.values){
                System.Debug('Field: ' + singleCustomMetadataVale.field + ' Value: ' + singleCustomMetadataVale.value);
            } 
        }
    }

    public class MetadataHelper{
        public String name {get;set;}
        public Boolean isEnabled {get;set;}
    }
}