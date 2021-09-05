public interface InfraDatabase {
  
    List<SObject> many(String queryString, String parameters);
    SObject one(String queryString, String parameters);
}
