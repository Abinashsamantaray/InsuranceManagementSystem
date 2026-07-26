public with sharing class InsuranceApiBatch
    implements Database.Batchable<InsuranceClaimWrapper>,
               Database.AllowsCallouts {

    /**
     * Retrieves insurance claims from the external API.
     */
    public Iterable<InsuranceClaimWrapper> start(Database.BatchableContext bc) {

        System.debug('===== Insurance API Batch Started =====');

        return new InsuranceClaimIterable();
    }

    /**
     * Processes the insurance claims received from the API.
     */
    public void execute(
        Database.BatchableContext bc,
        List<InsuranceClaimWrapper> scope
    ) {

        List<Insurance_Claim__c> claimRecords =
            new List<Insurance_Claim__c>();

        for (InsuranceClaimWrapper claim : scope) {

            Insurance_Claim__c insuranceClaim =
                new Insurance_Claim__c();

            insuranceClaim.Customer_Name__c =
                claim.customerName;

            insuranceClaim.Policy_Number__c =
                claim.policyNumber;

            insuranceClaim.Claim_Amount__c =
                claim.claimAmount;

            insuranceClaim.Claim_Date__c =
                claim.claimDate;

            insuranceClaim.Claim_Status__c =
                claim.claimStatus;

            claimRecords.add(insuranceClaim);
        }

        if (!claimRecords.isEmpty()) {

            insert claimRecords;

            System.debug(
                'Inserted Claims : ' +
                claimRecords.size()
            );
        }
    }

    /**
     * Executes after the batch completes.
     */
    public void finish(Database.BatchableContext bc) {

        System.debug(
            '===== Insurance API Batch Completed ====='
        );
    }
}