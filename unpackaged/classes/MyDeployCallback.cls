public class MyDeployCallback implements Metadata.DeployCallback {
    public void handleResult(Metadata.DeployResult result,
                             Metadata.DeployCallbackContext context) {
        if (result.status == Metadata.DeployStatus.Succeeded) {
            System.Debug('--++-- Deployment is successful');
        } else {
           System.Debug('--++-- Deployment failed with status: ' + result.status + ' with error message: ' + result.errorMessage);
        }
    }
}