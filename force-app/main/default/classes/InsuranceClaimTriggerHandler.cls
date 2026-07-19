public with sharing class InsuranceClaimTriggerHandler {

    // BEFORE INSERT
    public static void beforeInsert(List<Insurance_Claim__c> claimList) {

        Set<String> policyNumbers = new Set<String>();

        for (Insurance_Claim__c claim : claimList) {

            // Default Status
            if (String.isBlank(claim.Claim_Status__c)) {
                claim.Claim_Status__c = 'Pending';
            }

            if (claim.Policy_Number__c != null) {
                policyNumbers.add(claim.Policy_Number__c);
            }
        }

        if (!policyNumbers.isEmpty()) {

            List<Insurance_Claim__c> existingClaims =
                InsuranceSelector.getClaimsByPolicyNumbers(policyNumbers);

            Map<String, Insurance_Claim__c> existingPolicyMap =
                new Map<String, Insurance_Claim__c>();

            for (Insurance_Claim__c existing : existingClaims) {
                existingPolicyMap.put(existing.Policy_Number__c, existing);
            }

            for (Insurance_Claim__c claim : claimList) {

                if (existingPolicyMap.containsKey(claim.Policy_Number__c)) {
                    claim.addError('Policy Number already exists.');
                }

            }
        }
    }

    // BEFORE UPDATE
    public static void beforeUpdate(
        List<Insurance_Claim__c> newClaims,
        Map<Id, Insurance_Claim__c> oldMap
    ) {

        for (Insurance_Claim__c claim : newClaims) {

            Insurance_Claim__c oldClaim = oldMap.get(claim.Id);

            // Validation 1
            if (oldClaim.Claim_Status__c == 'Approved') {
                claim.addError('Approved Claims cannot be modified.');
            }

            // Validation 2
            if (
                oldClaim.Claim_Status__c == 'Approved' &&
                claim.Claim_Amount__c < oldClaim.Claim_Amount__c
            ) {

                claim.addError(
                    'Claim Amount cannot be reduced after approval.'
                );

            }

        }

    }

    // AFTER INSERT
    public static void afterInsert(List<Insurance_Claim__c> newClaims) {

        List<Id> claimIds = new List<Id>();

        for (Insurance_Claim__c claim : newClaims) {
            claimIds.add(claim.Id);
        }

        System.enqueueJob(new InsuranceQueueable(claimIds));

    }

}