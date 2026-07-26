public with sharing class InsuranceApiService {

    /**
     * Calls external REST API and returns
     * Insurance Claim data.
     */
    public static List<InsuranceClaimWrapper> getClaims() {

        List<InsuranceClaimWrapper> claims =
            new List<InsuranceClaimWrapper>();

        try {

            // Create HTTP objects
            Http http = new Http();
            HttpRequest request = new HttpRequest();

            // Named Credential Endpoint
            request.setEndpoint('https://device-wanting-aim.ngrok-free.dev/api/claims');

            request.setMethod('GET');

            request.setHeader('Content-Type', 'application/json');
            request.setTimeout(120000);

            // Send Request
            HttpResponse response = http.send(request);

            // Success
            if(response.getStatusCode() == 200){

                claims =
                    (List<InsuranceClaimWrapper>)
                    JSON.deserialize(
                        response.getBody(),
                        List<InsuranceClaimWrapper>.class
                    );

                System.debug('Claims Received : ' + claims.size());

                return claims;

            }

            // API Error
            System.debug(
                'API Error : '
                + response.getStatusCode()
                + ' '
                + response.getBody()
            );

        }
        catch(Exception ex){

            System.debug(
                'Callout Exception : '
                + ex.getMessage()
            );

        }

        return claims;
    }

}