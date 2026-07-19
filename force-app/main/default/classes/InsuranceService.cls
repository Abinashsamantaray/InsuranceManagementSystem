public with sharing class InsuranceService {

    // Save Claim
    public static void saveClaim(
        String customerName,
        String policyNumber,
        Decimal claimAmount
    ) {

        Insurance_Claim__c claim = new Insurance_Claim__c();

        claim.Customer_Name__c = customerName;
        claim.Policy_Number__c = policyNumber;
        claim.Claim_Amount__c = claimAmount;

        insert claim;
    }

    // Update Claim
    public static void updateClaim(
        Id claimId,
        String customerName,
        String policyNumber,
        Decimal claimAmount
    ) {

        Insurance_Claim__c claim = new Insurance_Claim__c();

        claim.Id = claimId;
        claim.Customer_Name__c = customerName;
        claim.Policy_Number__c = policyNumber;
        claim.Claim_Amount__c = claimAmount;

        update claim;
    }

    // Get All Claims
    public static List<Insurance_Claim__c> getAllClaims() {

        return InsuranceSelector.getAllClaims();

    }

    // Search Claims using Dynamic SOQL
    public static List<Insurance_Claim__c> searchClaims(
        String customerName,
        String policyNumber
    ) {

        String query =
            'SELECT Id, Name, Customer_Name__c, ' +
            'Policy_Number__c, Claim_Amount__c, ' +
            'Claim_Status__c ' +
            'FROM Insurance_Claim__c ' +
            'WHERE Id != null';

        // Search by Customer Name
        if (String.isNotBlank(customerName)) {

            query +=
                ' AND Customer_Name__c LIKE \'%' +
                String.escapeSingleQuotes(customerName) +
                '%\'';

        }

        // Search by Policy Number
        if (String.isNotBlank(policyNumber)) {

            query +=
                ' AND Policy_Number__c = \'' +
                String.escapeSingleQuotes(policyNumber) +
                '\'';

        }

        System.debug('Dynamic SOQL Query: ' + query);

        return Database.query(query);

    }

}