public class Recepit {

    public  Warehouse_Recip__c wr{get; set;}
    public Warehouse_Recip__c wrId{get; set;}
     public Recepit(ApexPages.StandardController controller){
         this.wrId = (Warehouse_Recip__c )controller.getRecord();
         wr=[SELECT  OwnerId, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
         LastViewedDate, LastReferencedDate, Avg_Weight__c, Column_Number__c, Date_Of_Sell__c, Date_of_Purchase__c, Item_Name__c, 
         Item_Quantity__c, Owner_Goods_Sign__c, Rate_Of_Goods__c, Rent_of_per_Goods__c, Stage_of_Item__c, Stages__c, Type_of_item__c, 
         Warehouse_Number__c, Warehouse_Receipt_Number__c, Amount__c, Total_Number_of_Days__c, Total_Rent_Amount__c, Total_Weight_of_Goods__c, 
         Owner_Name__c, Warehouse_Address__Street__s, Warehouse_Address__City__s, Warehouse_Address__PostalCode__s, Warehouse_Address__StateCode__s, 
         Warehouse_Address__CountryCode__s, Warehouse_Address__Latitude__s, Warehouse_Address__Longitude__s, Warehouse_Address__GeocodeAccuracy__s, 
         Warehouse_Address__c FROM Warehouse_Recip__c where Id=:wrId.Id limit 1
         ];
     }
}