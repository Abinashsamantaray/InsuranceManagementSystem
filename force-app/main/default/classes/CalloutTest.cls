public with sharing class CalloutTest {

    public static void testCallout() {

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://device-wanting-aim.ngrok-free.dev/api/claims');
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        req.setTimeout(120000);

        Http http = new Http();
        HttpResponse res;

        try {
            res = http.send(req);
            System.debug('Status Code: ' + res.getStatusCode());
            System.debug('Response Body: ' + res.getBody());
        } catch (CalloutException ce) {
            System.debug('Callout error: ' + ce.getMessage());
        }
    }
}