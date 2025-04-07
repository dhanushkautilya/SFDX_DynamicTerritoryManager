trigger UserTrigger on User (after insert, after update) {
    for (User u : Trigger.new) {
        if (u.IsActive) {
            TerritoryAssignmentService.evaluateUser(u);
        }
    }
}
