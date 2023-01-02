public class dailyLaserController {
    
    public static void updateInwardAmount(List<Daily_laser__c> uIAList)
    {
        Set<Id> setAccIds =new Set<Id>();
        Set<Id> setAccIds1 =new Set<Id>();
        Map<Id,Account> accountMapToUpdate = new Map<Id,Account>();  
        System.debug('Insert into updateInwardAmount');
        List<Daily_laser__c> dslList =[select id,name,Amount__c,Account_Name__c,Reason__c,RecordType.Name,RecordTypeId,
                                       Total_Weight_of_Goods__c from Daily_laser__c where id in: uIAList];
        for(Daily_laser__c dsl : dslList)
        {
            if(dsl.Account_Name__c != null && dsl.RecordType.Name=='Inward' && dsl.Amount__c != null && dsl.Total_Weight_of_Goods__c==null)
            {
                System.debug('Insert into If loop'+dsl);
                setAccIds.add(dsl.Account_Name__c);
            }
            else if(dsl.Account_Name__c != null && dsl.RecordType.Name=='Inward' && dsl.Amount__c != null && dsl.Total_Weight_of_Goods__c != null)
            {
                System.debug('Insert into else If loop'+dsl);
                setAccIds1.add(dsl.Account_Name__c);
            }
        }
        System.debug('setAccIds-->'+setAccIds);
        system.debug('setAccIds.Size-->'+setAccIds.Size());
        system.debug('setAccIds.Size-->'+setAccIds1.Size());
        if(setAccIds.Size()>0)
        {
            List<AggregateResult> aggrList=[SELECT Count(Id)ids,Account_Name__c,SUM(Amount__c)amt   
                                      FROM Daily_laser__c WHERE Account_Name__c IN:setAccIds and RecordType.Name=:'Inward' GROUP BY Account_Name__c];
            //Using Aggregate functions in SOQL, to Count(), SUM() and MAX(), for roll up and summarize data in a query.   
            if(aggrList.Size()>0)
            {
            for(AggregateResult aggr:aggrList){  
                                          Account accounts = new Account();
                                          accounts.Id = (Id)aggr.get('Account_Name__c'); 
                                          accounts.Inward_Amount__c = (Decimal)aggr.get('amt');
                                          accountMapToUpdate.put(accounts.Id, accounts);
                                          system.debug('AggregateResult'+aggr);
                                      }
            }}
        	if(setAccIds1.Size()>0)
           	{
                for(AggregateResult aggr:[SELECT Count(Id)ids,Account_Name__c,SUM(Amount__c)amt,Sum(Total_Weight_of_Goods__c)twg   
                                      FROM Daily_laser__c WHERE Account_Name__c IN:setAccIds1 
                                          and RecordType.Name=:'Inward' GROUP BY Account_Name__c]){  
                                          Account accounts = new Account();
                                          accounts.Id = (Id)aggr.get('Account_Name__c'); 
                                          accounts.Inward_Amount__c = (Decimal)aggr.get('amt');
                                          //accounts.Total_Weight_of_Goods__c=(Decimal)aggr.get('twg');
                                          accounts.Inward_Stock__c=(Decimal)aggr.get('twg');
                                          accountMapToUpdate.put(accounts.Id, accounts);
                                          system.debug('AggregateResult'+aggr);
                                      }
            }
            system.debug('accountMapToUpdate'+accountMapToUpdate);
            try{  
                update accountMapToUpdate.values();  
            }
            catch(Exception e){  
                System.debug('Exception Message'+e.getMessage()+'Line No. >>'+e.getLineNumber());  
            }  
        
    }
    
    public static void updateOutwardAmount(List<Daily_laser__c> uOAList)
    {
        System.debug('Insert into updateOutwardAmount');
        Set<Id> setAccIds =new Set<Id>();
        Set<Id> setAccIds1 =new Set<Id>();
        Map<Id,Account> accountMapToUpdate1 = new Map<Id,Account>();  
        List<Daily_laser__c> dslList =[select id,name,Amount__c,Account_Name__c,Reason__c,RecordType.Name,RecordTypeId,
                                       Total_Weight_of_Goods__c from Daily_laser__c where id in: uOAList];
        for(Daily_laser__c dsl : dslList)
        {
            if(dsl.Account_Name__c != null && dsl.RecordType.Name=='Outward' && dsl.Amount__c != null && dsl.Total_Weight_of_Goods__c==null)
            {
                System.debug('Insert into If loop'+dsl);
                setAccIds.add(dsl.Account_Name__c);
            }
            else if(dsl.Account_Name__c != null && dsl.RecordType.Name=='Outward' && dsl.Amount__c != null && dsl.Total_Weight_of_Goods__c!=null)
            {
                System.debug('Insert into If loop'+dsl);
                setAccIds1.add(dsl.Account_Name__c);
            } 
            
        }
        System.debug('setAccIds-->'+setAccIds);
        system.debug('setAccIds.Size-->'+setAccIds.Size());
        system.debug('setAccIds.Size-->'+setAccIds1.Size());
        if(setAccIds.Size()>0)
        {
            //Using Aggregate functions in SOQL, to Count(), SUM() and MAX(), for roll up and summarize data in a query. 
            List<AggregateResult> aggrList=[SELECT Count(Id)ids,Account_Name__c,SUM(Amount__c)amt   
                                      FROM Daily_laser__c WHERE Account_Name__c IN:setAccIds and RecordType.Name=:'Outward' GROUP BY Account_Name__c];  
            if(aggrList.size()>0){
            for(AggregateResult aggr:aggrList){  
                                          Account accounts = new Account();
                                          accounts.Id = (Id)aggr.get('Account_Name__c'); 
                                          accounts.Outward_Income__c = (Decimal)aggr.get('amt');
                                          accountMapToUpdate1.put(accounts.Id, accounts);
                                          system.debug('AggregateResult'+aggr);
                                      } 
        }}
        	if(setAccIds1.Size()>0)
            {
                for(AggregateResult aggr:[SELECT Count(Id)ids,Account_Name__c,SUM(Amount__c)amt,Sum(Total_Weight_of_Goods__c)twg   
                                      FROM Daily_laser__c WHERE Account_Name__c IN:setAccIds1 
                                          and RecordType.Name=:'Outward' GROUP BY Account_Name__c]){  
                                          Account accounts = new Account();
                                          accounts.Id = (Id)aggr.get('Account_Name__c'); 
                                          accounts.Outward_Income__c = (Decimal)aggr.get('amt');
                                          //accounts.Total_Weight_of_Goods__c=(Decimal)aggr.get('twg');
                                          accounts.Outward_Stocks__c=(Decimal)aggr.get('twg');
                                          accountMapToUpdate1.put(accounts.Id, accounts);
                                          system.debug('AggregateResult'+aggr);
                                      }
            }
            system.debug('accountMapToUpdate1'+accountMapToUpdate1);
            try{  
                update accountMapToUpdate1.values();  
            }
            catch(Exception e){  
                System.debug('Exception Message'+e.getMessage()+'Line No. >>'+e.getLineNumber());  
            }  
        
    } 
}