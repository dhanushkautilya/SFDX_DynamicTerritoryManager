public with sharing class TerritoryAssignmentService {

    public static void evaluateUser(User u) {
        List<Territory_Rule__mdt> rules = Territory_Rule__mdt.getAll().values();
        List<UserTerritory__c> assignments = new List<UserTerritory__c>();

        for (Territory_Rule__mdt rule : rules) {
            if (matchesRule(u, rule)) {
                assignments.add(new UserTerritory__c(
                    User__c = u.Id,
                    Territory__c = rule.Territory_API_Name__c
                ));
            }
        }

        if (!assignments.isEmpty()) {
            insert assignments;
            TerritoryPlatformEventPublisher.publish(u.Id, assignments);
        }
    }

    private static Boolean matchesRule(User u, Territory_Rule__mdt rule) {
        Boolean match = true;
        if (String.isNotBlank(rule.Profile__c)) {
            match = match && (u.Profile.Name == rule.Profile__c);
        }
        if (String.isNotBlank(rule.Role__c)) {
            match = match && (u.UserRole.Name == rule.Role__c);
        }
        if (String.isNotBlank(rule.Region__c)) {
            match = match && (u.Region__c == rule.Region__c);
        }
        return match;
    }
}
