@isTest
public class InfraDatabaseSFDCTest {
    
    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();
        Account newAccount1 = new Account(Name = 'Test 1');
        accounts.add(newAccount1);
        Account newAccount2 = new Account(Name = 'Test 2');
        accounts.add(newAccount2);
        Account newAccount3 = new Account(Name = 'Test 3');
        accounts.add(newAccount3);
        Database.insert(accounts);
    }

    @isTest 
    static void validateManyMethod() {
        InfraDatabaseSFDC sfdcDb = new InfraDatabaseSFDC();
        List<Account> accounts = sfdcDb.many('SELECT Name from Account','');
        System.assertEquals(3,accounts.size(),'Failed to get all Account records');    
    }

    @isTest
    static void validateOneMethod() {
        InfraDatabaseSFDC sfdcDb = new InfraDatabaseSFDC();
        Account accountRecord = (Account)sfdcDb.one('SELECT Name from Account','');
        System.assertEquals('Test 1',accountRecord.Name,'Failed to one Account record');    
    }

}
