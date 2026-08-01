import { LightningElement, api } from 'lwc';

export default class ClaimDetails extends LightningElement {

    @api claim;

    connectedCallback() {
        console.log('Claim Details Component Loaded');
    }

    renderedCallback() {
        if (this.claim) {
            console.log('Selected Claim:', this.claim);
        }
    }

    approveClaim() {

        const event = new CustomEvent('claimaction', {
            detail: {
                action: 'Approved',
                claimId: this.claim.Id
            }
        });

        this.dispatchEvent(event);

    }

    rejectClaim() {

        const event = new CustomEvent('claimaction', {
            detail: {
                action: 'Rejected',
                claimId: this.claim.Id
            }
        });

        this.dispatchEvent(event);

    }

}