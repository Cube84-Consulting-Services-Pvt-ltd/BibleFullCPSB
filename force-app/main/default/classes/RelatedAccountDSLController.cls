public class RelatedAccountDSLController {
    
    @AuraEnabled
    public static List<Daily_laser__c> retrieveDSL(String recordId){
        system.debug('recordId'+recordId);
        System.debug('DSL'+[select id,name,Amount__c,Account_Name__c,Reason__c,RecordType.Name,RecordTypeId from Daily_laser__c where Account_Name__c =: recordId]);
      return [select id,name,Amount__c,Account_Name__c,Date__c,Reason__c,RecordType.Name,RecordTypeId,Account_Name__r.Name,Createddate from Daily_laser__c where Account_Name__c=: recordId  ORDER BY Createddate DESC];
        // return [SELECT Name, Id, Account.Name, Amount, StageName, CloseDate  FROM Opportunity WHERE  Competitor_1__r.Id = :recordId OR Competitor_2__r.Id = :recordId ];
    }  

}