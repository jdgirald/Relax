public class SwapSLAs extends BatchableProcessStep {

	// Swap the SLA's of our Gold and Bronze accounts

	public override Database.Querylocator start(Database.BatchableContext btx) {
		return Database.getQueryLocator([select SLA__c from Account where SLA__c in ('Gold','Bronze')]);
	}
	
	public override void execute(Database.BatchableContext btx, List<SObject> scope) {
		List<Account> accs = (List<Account>) scope;
		for (Account a : accs) {
			if (a.SLA__c == 'Gold') a.SLA__c = 'Bronze';
			else if (a.SLA__c == 'Bronze') a.SLA__c = 'Gold';
		}
		update accs;
	}
	
	public override void finish(Database.BatchableContext btx) {
		// Complete this ProcessStep
		complete();
	}

}