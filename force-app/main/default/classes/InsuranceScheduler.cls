public with sharing class InsuranceScheduler implements Schedulable {

    public void execute(SchedulableContext sc) {

        // Start the Batch Apex Job
        Database.executeBatch(
            new InsuranceClaimBatch(),
            200
        );

    }

}