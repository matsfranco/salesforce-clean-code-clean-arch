// This class is a kind of Adapter
public with sharing class InfraDatabaseSFDC implements InfraDatabase {

    public InfraDatabaseSFDC() {
        
    }

    public List<SObject> many(String queryString, String parameters) {
        return Database.query(queryString);
    }
    
    public SObject one(String queryString, String parameters) {
        return Database.query(queryString+' LIMIT 1');
    }

}
