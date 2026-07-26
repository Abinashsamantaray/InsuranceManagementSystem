public with sharing class InsuranceScheduler implements Schedulable {

    public void execute(SchedulableContext sc) {

        // Execute Existing Claim Processing Batch
        Database.executeBatch(
            new InsuranceClaimBatch(),
            200
        );

        // Execute External API Import Batch
        Database.executeBatch(
            new InsuranceApiBatch(),
            200
        );

    }

}