global class InsuranceClaimIterable
implements Iterable<InsuranceClaimWrapper> {

    /**
     * Returns an iterator over the insurance claims
     * received from the external API.
     */
    public Iterator<InsuranceClaimWrapper> iterator() {

        List<InsuranceClaimWrapper> claimList =
            InsuranceApiService.getClaims();

        return claimList.iterator();
    }

}