public with sharing class InsuranceClaimBatch implements Database.Batchable<SObject> {

    // Step 1: Fetch Pending Claims
    public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator([
            SELECT Id,
                   Customer_Name__c,
                   Policy_Number__c,
                   Claim_Amount__c,
                   Claim_Status__c
            FROM Insurance_Claim__c
            WHERE Claim_Status__c = 'Pending'
        ]);

    }

    // Step 2: Process Records
    public void execute(Database.BatchableContext bc,
                        List<Insurance_Claim__c> scope) {

        for (Insurance_Claim__c claim : scope) {

            // Business Rule:
            // Auto-approve claims below ₹10,000

            if (claim.Claim_Amount__c < 10000) {

                claim.Claim_Status__c = 'Approved';

            }

        }

        // Save updated records
        if (!scope.isEmpty()) {
            update scope;
        }

    }

    // Step 3: Finish Method
    public void finish(Database.BatchableContext bc) {

        System.debug('==========================================');
        System.debug('Insurance Claim Batch Completed Successfully');
        System.debug('==========================================');

    }

}