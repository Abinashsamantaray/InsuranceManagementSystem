@IsTest
global class InsuranceApiCalloutMock implements HttpCalloutMock {

    global HttpResponse respond(HttpRequest request) {

        HttpResponse response = new HttpResponse();

        response.setStatusCode(200);

        response.setHeader(
            'Content-Type',
            'application/json'
        );

        response.setBody(
            '[' +
            '{' +
            '"customerName":"Rahul Sharma",' +
            '"policyNumber":"POL1001",' +
            '"claimAmount":15000,' +
            '"claimDate":"2026-07-20",' +
            '"claimStatus":"Pending"' +
            '},' +
            '{' +
            '"customerName":"Anita Das",' +
            '"policyNumber":"POL1002",' +
            '"claimAmount":8500,' +
            '"claimDate":"2026-07-19",' +
            '"claimStatus":"Pending"' +
            '}' +
            ']'
        );

        return response;
    }

}