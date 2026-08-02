trigger InsuranceClaimEventTrigger on InsuranceClaimEvent__e (after insert) {

    InsuranceClaimEventHandler.afterInsert(Trigger.New);

}