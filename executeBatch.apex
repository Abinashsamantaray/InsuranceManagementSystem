//Database.executeBatch(new InsuranceClaimBatch(), 5);
System.schedule(
    'Daily Insurance Batch',
    '0 0 2 * * ?',
    new InsuranceScheduler()
);