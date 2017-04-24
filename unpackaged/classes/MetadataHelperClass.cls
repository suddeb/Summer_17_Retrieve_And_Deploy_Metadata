public class MetadataHelperClass {
    private List<Metadata.Metadata> getMetadataInformation(){
        //Create List of Metadata Components with their full name
        List<String> componentNameList = new List<String>{'Admin_Preference__mdt.Process_Builder_Preference','Admin_Preference__mdt.Trigger_Preference','Admin_Preference__mdt.Validation_Rule_Preference','Admin_Preference__mdt.Workflow_Preference'};
        
        //Retrieve the Metadata
        List<Metadata.Metadata> components = Metadata.Operations.retrieve(Metadata.MetadataType.CustomMetadata, componentNameList);

    
        //Looping through the Metadata to get the values
        /*
        for(Metadata.Metadata singleComponent : components){
            Metadata.CustomMetadata customMetadataRecord = (Metadata.CustomMetadata)singleComponent;
            System.Debug('Label: ' + customMetadataRecord.label);
            
            for(Metadata.CustomMetadataValue singleCustomMetadataVale : customMetadataRecord.values){
                System.Debug('Field: ' + singleCustomMetadataVale.field + ' Value: ' + singleCustomMetadataVale.value);
            }
        }*/
        return components;
    }

    private List<MetadataHelper> prepareMetadataHelpers(List<Metadata.Metadata> components){
        List<MetadataHelper> allMetadataHelpers = new List<MetadataHelper>();
        for(Metadata.Metadata singleComponent : components){
            Metadata.CustomMetadata customMetadataRecord = (Metadata.CustomMetadata)singleComponent;
            String label = customMetadataRecord.label;
            Boolean isEnabled = false;
            for(Metadata.CustomMetadataValue singleCustomMetadataVale : customMetadataRecord.values){
                if(singleCustomMetadataVale.field.equalsIgnoreCase('Enabled__c')){
                    isEnabled = (Boolean)singleCustomMetadataVale.value;
                }
            }

            allMetadataHelpers.add(new MetadataHelper(label, isEnabled));
        }
        return allMetadataHelpers;
    }

    public List<MetadataHelper> fetchTheAdminPreferences(){
        List<Metadata.Metadata> components = getMetadataInformation();
        return prepareMetadataHelpers(components);
    }

    public class MetadataHelper{
        public String name {get;set;}
        public Boolean isEnabled {get;set;}

        public MetadataHelper(String name, Boolean isEnabled){
            this.name = name;
            this.isEnabled = isEnabled;
        }
    }
}