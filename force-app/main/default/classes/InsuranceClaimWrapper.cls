public with sharing class InsuranceClaimWrapper {

    // Customer Name
    public String customerName;

    // Policy Number
    public String policyNumber;

    // Claim Amount
    public Decimal claimAmount;

    // Claim Date
    public Date claimDate;

    // Claim Status
    public String claimStatus;

    // Default Constructor
    public InsuranceClaimWrapper() {
    }

    // Parameterized Constructor
    public InsuranceClaimWrapper(
        String customerName,
        String policyNumber,
        Decimal claimAmount,
        Date claimDate,
        String claimStatus
    ) {
        this.customerName = customerName;
        this.policyNumber = policyNumber;
        this.claimAmount = claimAmount;
        this.claimDate = claimDate;
        this.claimStatus = claimStatus;
    }
}