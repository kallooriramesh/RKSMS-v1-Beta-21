@isTest
public class IMI_SettingsTest {
    @isTest
    static void testInstallScript() {
        IMI_Settings postinstall = new IMI_Settings();
        Test.testInstall(postinstall, null);
        Test.testInstall(postinstall, new Version(1,0), true);
        System.assertNotEquals(null,postinstall);
    }
}