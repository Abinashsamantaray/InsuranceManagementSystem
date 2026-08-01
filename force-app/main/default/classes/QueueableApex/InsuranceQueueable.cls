public with sharing class InsuranceQueueable implements Queueable, Database.AllowsCallouts {

    private List<Id> claimIds;

    // Constructor
    public InsuranceQueueable(List<Id> claimIds) {
        this.claimIds = claimIds;
    }

    // Executes asynchronously
    public void execute(QueueableContext context) {

        if (claimIds != null && !claimIds.isEmpty()) {

            InsurancePdfService.generateClaimPdf(claimIds);

        }

    }

}