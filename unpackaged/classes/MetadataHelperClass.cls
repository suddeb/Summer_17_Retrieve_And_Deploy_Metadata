public class MetadataHelperClass {
    private List<Metadata.Metadata> getMetadataInformation(){
        List<String> componentNameList = new List<String>{'Admin_Preference__mdt.Process_Builder_Preference','Admin_Preference__mdt.Trigger_Preference','Admin_Preference__mdt.Validation_Rule_Preference','Admin_Preference__mdt.Workflow_Preference'};
        
        List<Metadata.Metadata> components = Metadata.Operations.retrieve(Metadata.MetadataType.CustomMetadata, componentNameList);
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

    public void updatePrefereces(List<MetadataHelper> all){
        for(MetadataHelper single : all){
            Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
            customMetadata.fullName = single.getFullName();
            customMetadata.label = single.name;

            Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
            customField.field = 'Enabled__c';
            customField.value = single.isEnabled;

            customMetadata.values.add(customField);

            Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
            mdContainer.addMetadata(customMetadata);

            MyDeployCallback callback = new MyDeployCallback();

            // Enqueue custom metadata deployment
            Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
        }
    }

    public class MetadataHelper{
        public String name {get;set;}
        public Boolean isEnabled {get;set;}

        public MetadataHelper(String name, Boolean isEnabled){
            this.name = name;
            this.isEnabled = isEnabled;
        }

        public String getFullName(){
            String fullName = 'Admin_Preference__mdt.';
            if(name.equalsIgnoreCase('Process Builder Preference')){
                fullName = fullName + 'Process_Builder_Preference';
            }else if(name.equalsIgnoreCase('Trigger Preference')){
                fullName = fullName + 'Trigger_Preference';
            }else if(name.equalsIgnoreCase('Validation Rule Preference')){
                fullName = fullName + 'Validation_Rule_Preference';
            }else if(name.equalsIgnoreCase('Workflow Preference')){
                fullName = fullName + 'Workflow_Preference';
            }
            return fullName;
        }
    }
}