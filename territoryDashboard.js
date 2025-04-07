import { LightningElement, wire } from 'lwc';
import getDashboardData from '@salesforce/apex/TerritoryDashboardController.getDashboardData';

export default class TerritoryDashboard extends LightningElement {
    data;
    error;
    
    @wire(getDashboardData)
    wiredData({ error, data }) {
        if (data) {
            this.data = data;
        } else {
            this.error = error;
        }
    }
}
