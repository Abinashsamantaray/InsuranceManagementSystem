@IsTest
private class InsuranceApiBatchTest {

    @IsTest
    static void testInsuranceApiBatch() {

        // Register Mock Response
        Test.setMock(HttpCalloutMock.class, new InsuranceApiCalloutMock());

        Test.startTest();

        Database.executeBatch(new InsuranceApiBatch(), 200);

        Test.stopTest();

        // Verify records inserted
        List<Insurance_Claim__c> claims = [
            SELECT Id,
                   Customer_Name__c,
                   Policy_Number__c,
                   Claim_Amount__c,
                   Claim_Status__c,
                   Claim_Date__c
            FROM Insurance_Claim__c
        ];

        System.assertEquals(
            2,
            claims.size(),
            'Two claim records should be inserted.'
        );

        System.assertEquals(
            'Rahul Sharma',
            claims[0].Customer_Name__c
        );

        System.assertEquals(
            'Pending',
            claims[0].Claim_Status__c
        );
    }

}