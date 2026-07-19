public with sharing class InsuranceController {
    // Save Claim
    @AuraEnabled
    public static void saveClaim(
        String customerName,
        String policyNumber,
        Decimal claimAmount
    ) {

        InsuranceService.saveClaim(
            customerName,
            policyNumber,
            claimAmount
        );

    }

    // Update Claim
    @AuraEnabled
    public static void updateClaim(
        Id claimId,
        String customerName,
        String policyNumber,
        Decimal claimAmount
    ) {

        InsuranceService.updateClaim(
            claimId,
            customerName,
            policyNumber,
            claimAmount
        );

    }

    // Get All Claims
    @AuraEnabled(cacheable=true)
    public static List<Insurance_Claim__c> getAllClaims() {

        return InsuranceService.getAllClaims();

    }

    // Search Claims using Customer Name and Policy Number
    @AuraEnabled(cacheable=true)
    public static List<Insurance_Claim__c> searchClaims(
        String customerName,
        String policyNumber
    ) {

        return InsuranceService.searchClaims(
            customerName,
            policyNumber
        );

    }

}