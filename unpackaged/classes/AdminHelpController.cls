public class AdminHelpController {
    
    public List<MetadataHelperClass.MetadataHelper> adminPrefs {get; set;}

    public AdminHelpController(){
        adminPrefs = new List<MetadataHelperClass.MetadataHelper>();
    }
}