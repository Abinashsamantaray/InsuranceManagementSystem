public with sharing class InsuranceClaimEventHandler {

    public static void afterInsert(
        List<InsuranceClaimEvent__e> events
    ) {

        System.debug('============= Platform Event Received =============');

        List<Claim_Event_History__c> historyList =
            new List<Claim_Event_History__c>();

        for (InsuranceClaimEvent__e eventObj : events) {

            System.debug('Claim Id : ' + eventObj.Claim_Id__c);

            System.debug('Customer Name : ' + eventObj.Customer_Name__c);

            System.debug('Policy Number : ' + eventObj.Policy_Number__c);

            System.debug('Claim Amount : ' + eventObj.Claim_Amount__c);

            System.debug('Claim Status : ' + eventObj.Claim_Status__c);

            Claim_Event_History__c history =
                new Claim_Event_History__c();

            history.Claim_Id__c = eventObj.Claim_Id__c;
            history.Customer_Name__c = eventObj.Customer_Name__c;
            history.Policy_Number__c = eventObj.Policy_Number__c;
            history.Claim_Amount__c = eventObj.Claim_Amount__c;
            history.Claim_Status__c = eventObj.Claim_Status__c;
            history.Event_Time__c = System.now();

            historyList.add(history);

        }

        if (!historyList.isEmpty()) {

            insert historyList;

            System.debug('Claim Event History Records Inserted : ' + historyList.size());

        }

    }

}