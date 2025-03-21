/**
 * Week 5
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Codell L. Jackson
 */

public with sharing class SOQL {
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */
	public static List<Lead> getAllLeads () {

		List<Lead> myleads = [SELECT Id, Name, LastName, Company, Phone, Email FROM Lead];
		return myleads; 

	}

	/**
	 * Question 2
	 * Update/Uncomment the template code to create a method
	 * Returns all contacts with first name of John.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByFirstName method to cover this method
	 */
	public static List<Contact> getAllContacts() {

		List<Contact> contacts = [SELECT Name FROM Contact WHERE FirstName = 'John'];
		return contacts; 
	}

	/**
	 * Question 3
	 * Update/Uncomment the template code to create a method
	 * Returns the Contact Id for all contacts with last name of Smith or Jones
	 * @return A list of Contact Ids.
	 * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
	 */
	public static List<Id> getContactIdsByLastName() {

		List<Contact> contacts = [SELECT Id FROM Contact WHERE LastName IN ('Smith', 'Jones')];

		List<Id> contactIds = new List<Id>();

		for (Contact mycontact : contacts){
			contactIds.add(mycontact.Id);
}
		return contactIds;
}

	/**
	 * Question 4
	 * Update/Uncomment the template code to create a method
	 * Returns List of closed won opportunities for a specific Account.
	 * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Opportunities with important opportunities fields
	 * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
	 */
	public static List<Opportunity> getClosedWonOpportunityCountByAccount(Id accountId) {
	
		List<Opportunity> opportunities = [SELECT Name, Id, CloseDate, Amount, StageName, AccountId
											FROM Opportunity 
											WHERE StageName = 'Closed Won' 
											AND AccountId = :accountId];
		return opportunities; 
	}
	

	/**
	 * Question 5
	 * Update/Uncomment the template code to create a method
	 * Returns the total count of Account records.
	 * @return The Integer count of Account records.
	 * Update the corresponding test class and testGetAccountCount method to cover this method
	 */
	public static Integer getAccountCount() {
		
		Integer numAccount= [SELECT COUNT() FROM Account];	
		return numAccount; 
	}

	/**
	 * Question 6
	 * Update/Uncomment the template code to create a method
	 * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
	 * @return A map of Task Ids to Task records.
	 * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
	 */
	public static Map<Id, Task> getTasksDueNextWeek() {

		List<Task> tasks = [SELECT Id, ActivityDate FROM Task WHERE ActivityDate = NEXT_N_DAYS:7];
		Map<Id, Task> taskMap = new Map<Id, Task>(tasks); 
		return taskMap; 
	}

	/**
	 * Question 7
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Contacts that have a example.com domain in their Email.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
	 */
	public static List<Contact> getContactsByEmailDomain() {
	
		String emailDomain = '%example.com%';

		List<Contact> contacts = [SELECT Id, Name, Email FROM Contact WHERE EMAIL LIKE :emailDomain];
		return contacts; 
	}

	/**
	 * Question 8
	 * Retrieves all Opportunities that have a specific keyword in their Name.
	 * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
	 * @param keyword The keyword to search for in the Opportunity Name.
	 * @return A list of Opportunity records.
	 */
	public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {

		keyword = '%' + keyword + '%'; 

		List<Opportunity> opportunities = [SELECT Id, Name FROM Opportunity WHERE Name LIKE :keyword];
		return opportunities; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 9
	 * Retrieves all Cases that Case Origin is not Web or Email or Blank
	 * @return A list of Case records.
	 */
	public static List<Case> getFilterCaseOrigins() {

		List<Case> cases = [SELECT Id, AccountId, Origin  FROM Case WHERE Origin NOT IN ('Web', 'Email', '') ];
		return cases; // Replace null with the variable you used to store the result
	}
	

	/**
	 * Question 10
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
	 * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
	 * @param leadSource The Lead Source to search for.
	 * @param keyWord The keyword to search for in the Lead Title.
	 * @return A list of Lead records.
	 * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
	 */
	public static List<Lead> getLeadsBySourceOrTitle(String leadSource, String keyWord) {
		
		if (String.isBlank(leadSource) && String.isBlank(keyWord)) return new List<Lead>();
	
		String titleKeyword = '%' + keyWord + '%';
	
		return [
			SELECT Id, LeadSource, Title, LastName, Company, Phone, Email
			FROM Lead
			WHERE LeadSource = :leadSource OR Title LIKE :titleKeyword];
	}
	
	/**
	 * Question 11
	 * Returns the names of all Contacts associated with an Account.
	 * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Contact LastName.
	 */
	public static List<String> getContactNamesByAccount(Id accountId) {
		
		List<String> contactNames = new List<String>();  // Create a list to hold the Contact LastNames

		for (Contact c : [SELECT LastName FROM Contact WHERE AccountId = :accountId]) {// Query the Contacts // Loop through each Contact and add the LastName to the list
			contactNames.add(c.LastName);
		}
		return contactNames; // Return the list of Contact LastNames // Replace null with the variable you used to store the result
	}

	/**
	 * Question 12
	 * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
	 * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
	 * @param stage The Stage value to filter Opportunities.
	 * @return The total revenue.
	 */
	public static Decimal getTotalRevenueByStage(String stage) {
		
		AggregateResult sumAmount = [SELECT SUM(Amount) totalRevenue 
									FROM Opportunity 
									WHERE StageName = 'Closed Won' OR Amount > 10000];// Use AggregateQuery to get the total revenue
		Decimal totalRevenue = (Decimal) sumAmount.get('totalRevenue');

		return totalRevenue; // Return the total revenue// Replace null with the variable you used to store the result 
	}

	/**
	 * Question 13
	 * Retrieves the first 10 Accounts ordered by Name.
	 * @return A list of the first 10 Accounts ordered by Name.
	 */
	public static List<Account> getFirstTenAccounts() {

		List<Account> firstTenAcc = [SELECT Name FROM Account ORDER BY Name ASC LIMIT 10];
		return firstTenAcc; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 14
	 * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 */
	public static List<Opportunity> getHighValueOpportunities() {

		List<Opportunity> highValueOpp = [SELECT Id, Name, CloseDate, Amount 
										FROM Opportunity 
										WHERE Amount > 100000 
										ORDER BY CloseDate ASC LIMIT 5];
		return highValueOpp; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 15
	 * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
	 * @return A list of Contacts
	 */
	public static List<Contact> getBirthdateContacts() {

		List<Contact> birthdateCon = [SELECT Name, Birthdate FROM Contact ORDER BY Birthdate DESC LIMIT 3];
		return birthdateCon; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 16
	 * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
	 * @return A list of Cases
	 */
	public static List<Case> getCasesWithStatus() {

		List<Case> myCases = [SELECT Subject, Status , CreatedDate 
							FROM Case 
							WHERE Status = 'Open' ORDER BY CreatedDate ASC LIMIT 10 OFFSET 5];

		return myCases; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 17
	 * Returns Set of Case Ids for a specific Account.
	 * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A set of Case Ids.
	 */
	public static Set<Id> getCaseIdsByAccount(Id accountId) {

		Set<Id> caseIds = new Set<Id>(); // Create a set to hold the Case Ids
		
		List<Case> caseList = [SELECT Id FROM Case WHERE AccountId = :accountId];     // Query the Cases
		
		for (Case singlecase : caseList) {  // Loop through each Case and add the Id to the set
			caseIds.add(singlecase.Id);
	}
		return caseIds; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 18
	 * Return Map of Account Ids to Account Names Not in a specific Country.
	 * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
	 * @param country The country to filter Accounts.
	 * @return A map of Account Ids to Account Names.
	 */
	public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
		// Create a map to hold the Account Ids to Account Names
		Map<Id, String> accountIdsToNames = new Map<Id, String>();

		List<Account> accountIds = [SELECT Id, Name, BillingCountry FROM Account WHERE BillingCountry != :country];// Query the Accounts
		
		for (Account a : accountIds) {// Loop through each Account and add the Id and Name to the map
			accountIdsToNames.put(a.Id, a.Name);
	}
		return accountIdsToNames; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 19
	 * Retrieves the Account Name for a given Contact.
	 * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
	 * @param contactId The Id of the Contact.
	 * @return The Account Name of the Contact.
	 */
	public static String getAccountNameForContact(String contactId) {

		List<Contact> contacts = [SELECT Account.Name FROM Contact WHERE Id = :contactId LIMIT 1];

        if (!contacts.isEmpty() && contacts[0].Account != null) {
            return contacts[0].Account.Name;
        }
        return null;// Replace null with the variable you used to store the result
	}

	/**
	 * Question 20
	 * Returns single Account that has related opportunities in the same query
	 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
	 * @param accountId The ID of the Account.
	 * @return An Account record with related Opportunities.
	 */
	public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {

		List<Account> singleAcc = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Id = :accountId LIMIT 1];

		if (!singleAcc.isEmpty()){
			return singleAcc.get(0); 
		}
		return null; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 21
	 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
	 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
	 * @param Account Id
	 * @return List of contacts with the same Mailing State as the Account Billing State
	 */
	public static List<Contact> getAccountsWithContactsByState(Id accountId) {
		
		List<Account> accounts = [SELECT Id, Name, BillingState FROM Account WHERE Id = :accountId];   // Query the Account

		String billingState = ''; // Store the Account's BillingState

		if (!accounts.isEmpty()) {
			billingState = accounts[0].BillingState;  
	}
		List<Contact> contacts = [SELECT Id, Name, MailingState FROM Contact WHERE MailingState = :billingState]; // Query the Contacts
		return contacts; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 22
	 * Extracts email domains from them leads, then finds Accounts with matching website domains
	 * If Lead Email = test@test.com return account with website = www.test.com
	 * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
	 * @param A set of Lead Ids.
	 * @return A list of Accounts with matching email domains.
	 */
	public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
		
		List<Lead> myLeads = [SELECT Email FROM Lead WHERE Id IN :leadIds]; // Query the Leads

		Set<String> emailDomains =  new Set<String>(); // Create a set of email domains from the Leads

		for (Lead leadRecord : myLeads) {// Loop through each Lead // Get the email from the Lead
			
			if (leadRecord.Email != null && leadRecord.Email.contains('@')) {
				List <String> emailParts = leadRecord.Email.split('@'); 

            if (emailParts.size() > 1) {
				emailDomains.add('www.' + emailParts[1].toLowerCase().trim()); // Add the email domain to the set
	}
	}
	}
	if (emailDomains.isEmpty()) {
        return new List<Account>();
    }
	List<Account> myAccounts = [SELECT Id, Name, Website FROM Account WHERE Website IN :emailDomains];
    	return myAccounts; // Replace null with the variable you used to store the result
	}
	
	/**
	 * Question 23
	 * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
	 * Adds a randomized number between 1 to 3 to the quantity of each line item.
	 * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
	 * @param Original Opportunity Id
	 * @param List of cloned Opportunity Ids
	 */
	public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
		
		List<OpportunityLineItem> origOppLineItems = [SELECT PricebookEntryId, OpportunityId, Quantity, UnitPrice,  TotalPrice 
													FROM OpportunityLineItem 
													WHERE OpportunityId = :origOppId];  // Query the original Opportunity Line Items

		List<OpportunityLineItem> oppLineItems = new List<OpportunityLineItem>();  // Create a list to hold the new line items

		Integer randNumber = (Integer) Math.floor(Math.random() * 3) + 1; // Generate a random number between 1 and 3

		for (Id cloneOppId : cloneOppIds ){  // Loop through each cloned Opportunity Ids

			for (OpportunityLineItem origOppLineItem : origOppLineItems) { // Loop through each original line items
	
				OpportunityLineItem newLineItem = origOppLineItem.clone(false, true); // Clone the original line item and add the random number to the quantity
				newLineItem.OpportunityId = cloneOppId; 
				newLineItem.Quantity += randNumber; 
				newLineItem.TotalPrice = null; 	
				oppLineItems.add(newLineItem); 
	}
	}
		if (!oppLineItems.isEmpty()){
			insert oppLineItems; // Insert the new line items
	}
	}
	/**
	 * Question 24
	 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
	 * @return A list of filtered Opportunity
	 */
	public static List<Opportunity> getOpportunityDetailsForClosedWon() {

		List<Opportunity> myOpps = [SELECT AccountId, Name, OwnerId FROM Opportunity WHERE StageName = 'Closed Won'];
		return myOpps; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 25
	 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account with the alphabetically first first name.
	 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
	 */
	public static void setPrimaryContact() {

		List<Opportunity> closeWonOpps = getOpportunityDetailsForClosedWon(); //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
		
		Set<Id> accountIds = new Set<Id>();  // Create a set of Account Ids from the Opportunities
		
		for (Opportunity opp : closeWonOpps){
			if (opp.AccountId != null) {
				accountIds.add(opp.AccountId);
	}
	}
		if (accountIds.isEmpty()) {
			return; 
	}
		List<Contact> primContacts = [SELECT Id, FirstName, AccountId FROM Contact WHERE AccountId IN :accountIds ORDER BY AccountId, FirstName ASC];  // Query the Contacts
	
		Map<Id, Id> accountToPrimaryContact = new Map<Id, Id>();   //Add the Account Id and Contact to the map

		for (Contact primContact : primContacts) {   // Loop through each Contact
			if (!accountToPrimaryContact.containsKey(primContact.AccountId)){
				accountToPrimaryContact.put(primContact.AccountId, primContact.Id);
	}
	}
			for (Opportunity closeWonOpp : closeWonOpps) { // Loop through each Opportunity
				if (accountToPrimaryContact.containsKey(closeWonOpp.AccountId)) {
					closeWonOpp.Primary_Contact__c = accountToPrimaryContact.get(closeWonOpp.AccountId);  // Update the Opportunity primary contact from accountToContactMap
	}
	}
		   if (!closeWonOpps.isEmpty()) { // Update the Opportunities
			update closeWonOpps; 
	}
}
}