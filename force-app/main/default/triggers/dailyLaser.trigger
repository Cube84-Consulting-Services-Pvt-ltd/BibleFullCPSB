trigger dailyLaser on Daily_laser__c (after insert, after update) {
    
    if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
            System.debug('Insert into after insert');
            /*List<Daily_laser__c> ds=[select id,name,Amount__c,Account_Name__c,Reason__c,RecordType.Name,RecordTypeId from Daily_laser__c where id in: Trigger.new];
            for(Daily_laser__c d:ds)
            {
                if(d.RecordType.Name=='Inward')
                    dailyLaserController.updateInwardAmount(Trigger.new);
                else if(d.RecordType.Name=='Outward')
                    dailyLaserController.updateOutwardAmount(Trigger.new);
            }*/
            dailyLaserController.updateInwardAmount(Trigger.new);
            dailyLaserController.updateOutwardAmount(Trigger.new);
        }
        else if(Trigger.isUpdate)
        {
            System.debug('Insert into after Update');
            //dailyLaserController.updateOutwardAmount(Trigger.new);
        }
    }
    
}