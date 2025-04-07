public with sharing class TerritoryDashboardController {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getDashboardData() {
        Map<String, Object> result = new Map<String, Object>();

        result.put('totalTerritories', [SELECT COUNT() FROM Territory__c]);
        result.put('totalAssignments', [SELECT COUNT() FROM UserTerritory__c]);

        AggregateResult topRegion = [
            SELECT Region__c, COUNT(Id) cnt
            FROM Territory__c
            GROUP BY Region__c
            ORDER BY COUNT(Id) DESC
            LIMIT 1
        ];

        result.put('topRegion', topRegion != null ? String.valueOf(topRegion.get('Region__c')) : 'N/A');
        return result;
    }
}
