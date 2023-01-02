public class listofDSLRecord {
    
   	public Account acc {set;get;}
    public listofDSLRecord(ApexPages.StandardController controller) {
        this.acc = (Account)controller.getRecord();
        system.debug('acc-->'+acc);
    }
    
   	public List<Daily_laser__c> getDLInward() {
        //Account a=[select id,name from Program__c where id=:pro.id];
	List<Daily_laser__c> dLIresults = [select id,name,Amount__c,Account_Name__c,Reason__c,RecordType.Name,Date__c,Createddate,
                                RecordTypeId from Daily_laser__c where Account_Name__c=:acc.Id and RecordType.Name='Inward' ORDER BY Createddate DESC ];
	return dLIresults;
	}
	public List<Daily_laser__c> getDLOutward() {
	List<Daily_laser__c> dLOresults = [select id,name,Amount__c,Account_Name__c,Reason__c,RecordType.Name,Date__c,Createddate,
                                RecordTypeId from Daily_laser__c where Account_Name__c=:acc.Id and RecordType.Name='Outward' ORDER BY Createddate DESC];
	return dLOresults;
	} 

}