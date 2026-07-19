import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import saveClaim from '@salesforce/apex/InsuranceController.saveClaim';
import updateClaim from '@salesforce/apex/InsuranceController.updateClaim';
import getAllClaims from '@salesforce/apex/InsuranceController.getAllClaims';
import searchClaims from '@salesforce/apex/InsuranceController.searchClaims';

// Datatable Columns
const CLAIM_COLUMNS = [
    { label: 'Claim Number', fieldName: 'Name' },
    { label: 'Customer Name', fieldName: 'Customer_Name__c' },
    { label: 'Policy Number', fieldName: 'Policy_Number__c' },
    { label: 'Claim Amount', fieldName: 'Claim_Amount__c', type: 'currency' },
    { label: 'Status', fieldName: 'Claim_Status__c' },
    {
        type: 'button',
        typeAttributes: {
            label: 'Edit',
            name: 'edit',
            variant: 'brand'
        }
    }
];

export default class InsuranceClaim extends LightningElement {

    @track customerName = '';
    @track policyNumber = '';
    @track claimAmount = '';

    @track isEditMode = false;

    // Search Fields
    @track searchCustomerName = '';
    @track searchPolicyNumber = '';

    @track displayedClaims = [];

    selectedClaimId;

    columns = CLAIM_COLUMNS;

    wiredClaimsResult;

    @wire(getAllClaims)
    wiredClaims(result) {

        this.wiredClaimsResult = result;

        if (result.data) {
            this.displayedClaims = result.data;
        }

        if (result.error) {

            const message =
                result.error?.body?.message || 'Unknown error occurred';

            this.showToast(
                'Error',
                `Error Loading Claims: ${message}`,
                'error'
            );
        }
    }

    get claims() {
        return this.displayedClaims;
    }

    handleChange(event) {

        const field = event.target.dataset.field;
        const value = event.target.value;

        this[field] = value;
    }

    // Edit Button
    handleRowAction(event) {

        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === 'edit') {

            this.selectedClaimId = row.Id;

            this.customerName = row.Customer_Name__c;
            this.policyNumber = row.Policy_Number__c;
            this.claimAmount = row.Claim_Amount__c;

            this.isEditMode = true;
        }
    }

    validateFields() {

        const inputs =
            this.template.querySelectorAll('lightning-input');

        let isValid = true;

        inputs.forEach(input => {

            if (!input.reportValidity()) {
                isValid = false;
            }

        });

        return isValid;
    }

    async handleSave() {

        if (!this.validateFields()) {

            this.showToast(
                'Error',
                'Please fill all fields correctly',
                'error'
            );

            return;
        }

        try {

            await saveClaim({

                customerName: this.customerName,
                policyNumber: this.policyNumber,
                claimAmount: Number(this.claimAmount)

            });

            this.showToast(
                'Success',
                'Claim Saved Successfully',
                'success'
            );

            this.resetForm();

            await refreshApex(this.wiredClaimsResult);

            this.displayedClaims = this.wiredClaimsResult.data;

        }
        catch (error) {

            console.error(error);

            const message =
                error?.body?.message || 'Unknown error occurred';

            this.showToast(
                'Error',
                message,
                'error'
            );

        }

    }

    async handleUpdate() {

        if (!this.validateFields()) {
            return;
        }

        try {

            await updateClaim({

                claimId: this.selectedClaimId,
                customerName: this.customerName,
                policyNumber: this.policyNumber,
                claimAmount: Number(this.claimAmount)

            });

            this.showToast(
                'Success',
                'Claim Updated Successfully',
                'success'
            );

            this.resetForm();

            await refreshApex(this.wiredClaimsResult);

            this.displayedClaims = this.wiredClaimsResult.data;

        }
        catch (error) {

            console.error(error);

            const message =
                error?.body?.message || 'Unknown error occurred';

            this.showToast(
                'Error',
                message,
                'error'
            );

        }

    }

    // Dynamic Search
    async handleSearch() {

        try {

            this.displayedClaims = await searchClaims({

                customerName: this.searchCustomerName,
                policyNumber: this.searchPolicyNumber

            });

            this.showToast(
                'Success',
                'Search completed successfully',
                'success'
            );

        }
        catch (error) {

            const message =
                error?.body?.message || 'Search failed';

            this.showToast(
                'Error',
                message,
                'error'
            );

        }

    }

    handleShowAll() {

        if (this.wiredClaimsResult?.data) {

            this.displayedClaims = this.wiredClaimsResult.data;

        }

        this.searchCustomerName = '';
        this.searchPolicyNumber = '';

    }

    resetForm() {

        this.customerName = '';
        this.policyNumber = '';
        this.claimAmount = '';

        this.selectedClaimId = null;
        this.isEditMode = false;

    }

    showToast(title, message, variant) {

        this.dispatchEvent(

            new ShowToastEvent({

                title,
                message,
                variant

            })

        );

    }

}