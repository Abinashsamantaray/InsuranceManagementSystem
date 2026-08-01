import { LightningElement, api } from 'lwc';

export default class InsuranceMessage extends LightningElement {

    @api message;

    connectedCallback() {
        console.log('🟢 Child Connected');
    }

    renderedCallback() {
        console.log('🟡 Child Rendered');
    }

    disconnectedCallback() {
        console.log('🔴 Child Disconnected');
    }

    sendMessage() {

        const event = new CustomEvent('notifyparent', {
            detail: {
                message: 'Button clicked in Child Component'
            }
        });

        this.dispatchEvent(event);

    }

}