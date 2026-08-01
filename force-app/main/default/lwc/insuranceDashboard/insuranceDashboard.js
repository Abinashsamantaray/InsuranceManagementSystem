import { LightningElement } from 'lwc';

export default class InsuranceDashboard extends LightningElement {

    showChild = true;

    // Message received from the child
    childMessage = 'Waiting for child message...';

    constructor() {
        super();
        console.log('✅ 1. Constructor Executed');
    }

    connectedCallback() {
        console.log('✅ 2. Connected Callback Executed');
    }

    renderedCallback() {
        console.log('✅ 3. Rendered Callback Executed');
    }

    disconnectedCallback() {
        console.log('❌ Parent Disconnected');
    }

    hideChild() {
        this.showChild = false;
    }

    handleNotification(event) {

        console.log('📩 Event received from Child');

        this.childMessage = event.detail.message;

        console.log(this.childMessage);

    }

}