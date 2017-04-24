public class AdminHelpController {
    
    public List<MetadataHelperClass.MetadataHelper> adminPrefs {get; 
                                                                set {adminPrefs = new MetadataHelperClass().fetchTheAdminPreferences();}
                                                               }

    public AdminHelpController(){
        adminPrefs = new List<MetadataHelperClass.MetadataHelper>();
        //adminPrefs = new MetadataHelperClass().fetchTheAdminPreferences();
    }

    public void updatePreference(){
        System.Debug('--++-- Inside updatePreference');
    }
}