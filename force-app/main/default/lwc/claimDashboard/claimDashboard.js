import { LightningElement, wire } from 'lwc';
import getAllClaims from '@salesforce/apex/InsuranceController.getAllClaims';
import updateClaim from '@salesforce/apex/InsuranceController.updateClaim';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const COLUMNS = [
    {
        label: 'Customer Name',
        fieldName: 'Customer_Name__c',
        type: 'text'
    },
    {
        label: 'Policy Number',
        fieldName: 'Policy_Number__c',
        type: 'text'
    },
    {
        label: 'Claim Amount',
        fieldName: 'Claim_Amount__c',
        type: 'currency'
    },
    {
        label: 'Status',
        fieldName: 'Claim_Status__c',
        type: 'text'
    }
];

export default class ClaimDashboard extends LightningElement {

    columns = COLUMNS;
    claims = [];
    error;
    selectedClaim;
    wiredClaimsResult;

    @wire(getAllClaims)
    wiredClaims(result) {

        this.wiredClaimsResult = result;

        const { data, error } = result;

        if (data) {

            this.claims = data;
            this.error = undefined;

            console.log('✅ Claims fetched successfully');
            console.log(this.claims);

        } else if (error) {

            this.error = error;
            this.claims = [];

            console.error('❌ Error while fetching claims');
            console.error(error);

        }

    }

    handleRowSelection(event) {

        const selectedRows = event.detail.selectedRows;

        if (selectedRows.length > 0) {

            this.selectedClaim = selectedRows[0];

            console.log('✅ Selected Claim');
            console.log(this.selectedClaim);

        }

    }

    async handleClaimAction(event) {

        try {

            await updateClaim({

                claimId: event.detail.claimId,
                customerName: this.selectedClaim.Customer_Name__c,
                policyNumber: this.selectedClaim.Policy_Number__c,
                claimAmount: this.selectedClaim.Claim_Amount__c,
                claimStatus: event.detail.action

            });

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Claim ' + event.detail.action + ' Successfully',
                    variant: 'success'
                })
            );

            await refreshApex(this.wiredClaimsResult);

        } catch (error) {

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: error.body?.message || error.message,
                    variant: 'error'
                })
            );

            console.error(error);

        }

    }

}