// Most common salesforce apex operations

/* String name = 'Abinash';
System.debug('Hello ' + name); */

// exercise -2 
/* String str1 ='Hello';
String str2 ='HELLO';
System.debug(str1.equalsIgnoreCase(str2)); 
System.debug(str1.equals(str2)); */

//3

/* Map<String,Decimal> mapOfCon = new Map<String,Decimal>();
for(Contact con : [SELECT Id , Email  from Contact limit 100]){
    if(!mapOfCon.containsKey(con.Email)){
        mapOfCon.put(con.Email, 0.00);
    }
    Decimal amount = mapOfCon.get(con.Email);
   mapOfCon.put(con.Email, amount + 1);
}
 */

 // 4 Convert comman separated string to list of string
/* 
 String a = 'x,y,z';
 List<String> listOfString = a.split(',');
 System.debug(listOfString);
 */
 // 5 SOQL query and get a map returned.
/* Map<Id,Account> objectQuery = new Map<Id,Account>([select Id , Name , Type from Account]);
System.debug(objectQuery); */

//GET set of Id from sobject 
/* List<Account> accountIds = [Select id, Name, Type from Account];
Set<Id> newAccountIds = (new Map<Id,Account>(accountIds)).keySet();
System.debug(newAccountIds); */


//serialize and object as JSON
/* List<SObject> accountList = [select Id , Name , Type from Account];
String jsonString = JSON.serialize(accountList);
System.debug(jsonString); */

//Get Map Keys and Values in Apex.
/* Map<String, Integer> mapnew = new Map<String, Integer>();

mapnew.put('February', 2);
mapnew.put('March', 3);

System.debug('Map values: ' + mapnew.values());
System.debug('Map keys: ' + mapnew.keySet()); */


// Generaate an random sring in apex.
/* public static String generateRandomString(Integer length){
    String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    String randomString = '';
    while (randomString.length() < length) {
        Integer randomIndex = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
        randomString += chars.substring(randomIndex, randomIndex + 1);
    }
    return randomString;
} */

// Get the Day , Month and Year from a date in apex.
/* Date today = System.today();
date.getDay();
date.getMonth();
date.getYear(); */

//Convert String into Date in Apex.
/* Date db = date.Parse('2025-06-02'); */
