trigger InsuranceClaimTrigger on Insurance_Claim__c (
    before insert,
    before update,
    after insert
) {

    // BEFORE INSERT
    if (Trigger.isBefore && Trigger.isInsert) {
        InsuranceClaimTriggerHandler.beforeInsert(Trigger.new);
    }

    // BEFORE UPDATE
    if (Trigger.isBefore && Trigger.isUpdate) {
        InsuranceClaimTriggerHandler.beforeUpdate(
            Trigger.new,
            Trigger.oldMap
        );
    }

    // AFTER INSERT
    if (Trigger.isAfter && Trigger.isInsert) {
        InsuranceClaimTriggerHandler.afterInsert(Trigger.new);
    }

}