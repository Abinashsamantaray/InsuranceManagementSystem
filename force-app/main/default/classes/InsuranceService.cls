public with sharing class InsuranceService {

    // =====================================================
    // Save Claim
    // =====================================================
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


    // =====================================================
    // Update Claim
    // =====================================================
    public static void updateClaim(
        Id claimId,
        String customerName,
        String policyNumber,
        Decimal claimAmount,
        String claimStatus
    ) {

        Insurance_Claim__c claim = new Insurance_Claim__c();

        claim.Id = claimId;
        claim.Customer_Name__c = customerName;
        claim.Policy_Number__c = policyNumber;
        claim.Claim_Amount__c = claimAmount;
        claim.Claim_Status__c = claimStatus;

        update claim;

        // Publish Platform Event ONLY for Approved/Rejected
        if (claimStatus == 'Approved' ||
            claimStatus == 'Rejected') {

            publishClaimEvent(claim.Id);

        }

    }


    // =====================================================
    // Get All Claims
    // =====================================================
    public static List<Insurance_Claim__c> getAllClaims() {

        return InsuranceSelector.getAllClaims();

    }


    // =====================================================
    // Search Claims
    // =====================================================
    public static List<Insurance_Claim__c> searchClaims(
        String customerName,
        String policyNumber
    ) {

        String query =
            'SELECT Id, Name, Customer_Name__c,' +
            ' Customer_Name__c,' +
            ' Policy_Number__c,' +
            ' Claim_Amount__c,' +
            ' Claim_Status__c ' +
            'FROM Insurance_Claim__c ' +
            'WHERE Id != null';

        if (String.isNotBlank(customerName)) {

            query +=
                ' AND Customer_Name__c LIKE \'%' +
                String.escapeSingleQuotes(customerName) +
                '%\'';

        }

        if (String.isNotBlank(policyNumber)) {

            query +=
                ' AND Policy_Number__c = \'' +
                String.escapeSingleQuotes(policyNumber) +
                '\'';

        }

        return Database.query(query);

    }


    // =====================================================
    // Publish Platform Event
    // =====================================================
    public static void publishClaimEvent(Id claimId) {

        Insurance_Claim__c claim = [

            SELECT Id,
                   Customer_Name__c,
                   Policy_Number__c,
                   Claim_Amount__c,
                   Claim_Status__c
            FROM Insurance_Claim__c
            WHERE Id = :claimId
            LIMIT 1

        ];

        InsuranceClaimEvent__e eventObj =
            new InsuranceClaimEvent__e();

        eventObj.Claim_Id__c = claim.Id;
        eventObj.Customer_Name__c = claim.Customer_Name__c;
        eventObj.Policy_Number__c = claim.Policy_Number__c;
        eventObj.Claim_Amount__c = claim.Claim_Amount__c;
        eventObj.Claim_Status__c = claim.Claim_Status__c;

        Database.SaveResult result =
            EventBus.publish(eventObj);

        if (!result.isSuccess()) {

            for (Database.Error err : result.getErrors()) {

                System.debug('Platform Event Error : ' +
                    err.getMessage());

            }

        }

    }

}