import { LightningElement, wire } from 'lwc';
import getTerritoryMapData from '@salesforce/apex/TerritoryMapController.getTerritoryMapData';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
import LEAFLET from '@salesforce/resourceUrl/leaflet';

export default class TerritoryMapView extends LightningElement {
    isMapInitialized = false;
    territories = [];

    @wire(getTerritoryMapData)
    wiredTerritories({ error, data }) {
        if (data) {
            this.territories = data;
            if (this.isMapInitialized) {
                this.renderMap();
            }
        }
    }

    renderedCallback() {
        if (this.isMapInitialized) return;

        Promise.all([
            loadScript(this, LEAFLET + '/leaflet.js'),
            loadStyle(this, LEAFLET + '/leaflet.css')
        ]).then(() => {
            this.isMapInitialized = true;
            this.renderMap();
        });
    }

    renderMap() {
        const mapContainer = this.template.querySelector('.map');
        const map = L.map(mapContainer).setView([37.7749, -122.4194], 4); // Default view

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(map);

        this.territories.forEach(t => {
            if (t.latitude && t.longitude) {
                const marker = L.circleMarker([t.latitude, t.longitude], {
                    color: t.color || 'blue',
                    radius: 10
                }).addTo(map);

                marker.bindPopup(`<strong>${t.name}</strong><br/>Users: ${t.users.map(u => u.name).join(', ')}`);
            }
        });
    }
}
