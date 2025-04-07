public with sharing class TerritoryMapController {
    @AuraEnabled(cacheable=true)
    public static List<TerritoryMapDTO> getTerritoryMapData() {
        List<TerritoryMapDTO> dtoList = new List<TerritoryMapDTO>();

        List<Territory__c> territories = [SELECT Id, Name, Region__c, Latitude__c, Longitude__c, Color__c FROM Territory__c];
        Map<Id, List<User>> usersByTerritory = new Map<Id, List<User>>();

        for (UserTerritory__c ut : [SELECT Id, User__r.Name, User__r.Email, Territory__c FROM UserTerritory__c]) {
            if (!usersByTerritory.containsKey(ut.Territory__c)) {
                usersByTerritory.put(ut.Territory__c, new List<User>());
            }
            usersByTerritory.get(ut.Territory__c).add(ut.User__r);
        }

        for (Territory__c t : territories) {
            TerritoryMapDTO dto = new TerritoryMapDTO();
            dto.name = t.Name;
            dto.region = t.Region__c;
            dto.latitude = t.Latitude__c;
            dto.longitude = t.Longitude__c;
            dto.color = t.Color__c;
            dto.users = new List<TerritoryMapDTO.UserData>();

            for (User u : usersByTerritory.getOrDefault(t.Id, new List<User>())) {
                dto.users.add(new TerritoryMapDTO.UserData(u.Name, u.Email));
            }

            dtoList.add(dto);
        }

        return dtoList;
    }

    public class TerritoryMapDTO {
        @AuraEnabled public String name;
        @AuraEnabled public String region;
        @AuraEnabled public Double latitude;
        @AuraEnabled public Double longitude;
        @AuraEnabled public String color;
        @AuraEnabled public List<UserData> users;

        public class UserData {
            @AuraEnabled public String name;
            @AuraEnabled public String email;

            public UserData(String name, String email) {
                this.name = name;
                this.email = email;
            }
        }
    }
}
