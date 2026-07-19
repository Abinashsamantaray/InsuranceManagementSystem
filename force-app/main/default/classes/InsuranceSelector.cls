public with sharing class InsuranceSelector {

    // Get all claims
    public static List<Insurance_Claim__c> getAllClaims() {

        return [
            SELECT Id,
                   Name,
                   Customer_Name__c,
                   Policy_Number__c,
                   Claim_Amount__c,
                   Claim_Status__c
            FROM Insurance_Claim__c
            ORDER BY CreatedDate DESC
        ];
    }

    // Search claims by customer name
    public static List<Insurance_Claim__c> searchClaims(String customerName) {

        return [
            SELECT Id,
                   Name,
                   Customer_Name__c,
                   Policy_Number__c,
                   Claim_Amount__c,
                   Claim_Status__c
            FROM Insurance_Claim__c
            WHERE Customer_Name__c LIKE :('%' + customerName + '%')
            ORDER BY CreatedDate DESC
        ];

    }

    // Get existing claims by Policy Number
    public static List<Insurance_Claim__c> getClaimsByPolicyNumbers(
        Set<String> policyNumbers
    ) {

        return [
            SELECT Id,
                   Policy_Number__c
            FROM Insurance_Claim__c
            WHERE Policy_Number__c IN :policyNumbers
        ];

    }

}