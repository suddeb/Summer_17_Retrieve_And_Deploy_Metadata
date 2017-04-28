public class AdminHelpController {
    
    public List<MetadataHelperClass.MetadataHelper> adminPrefs {get; 
                                                                set {adminPrefs = new MetadataHelperClass().fetchTheAdminPreferences();}
                                                               }

    public AdminHelpController(){
        adminPrefs = new List<MetadataHelperClass.MetadataHelper>();
    }

    public void updatePreference(){
        System.Debug('--++-- Inside updatePreference');

        for(MetadataHelperClass.MetadataHelper single : adminPrefs){
            System.Debug('--++-- Label: ' + single.name + ' isEnabled: ' + single.isEnabled);
        }

        new MetadataHelperClass().updatePrefereces(adminPrefs);
    }
}