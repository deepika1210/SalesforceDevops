global class MySOAPService {
    webservice static Id createAccount(String firstname,String lastname)
    {
        Contact c=new Contact();
        c.FirstName=firstname;
        c.LastName=lastname;
        insert c;
        return c.id;
    }

}