public with sharing class InsurancePdfService {

    public static void generateClaimPdf(List<Id> claimIds) {

        // Fetch claim records
        List<Insurance_Claim__c> claimList = [
            SELECT Id,
                   Name,
                   Customer_Name__c,
                   Policy_Number__c,
                   Claim_Amount__c,
                   Claim_Status__c
            FROM Insurance_Claim__c
            WHERE Id IN :claimIds
        ];

        for (Insurance_Claim__c claim : claimList) {

            // Reference the Visualforce page
            PageReference pdfPage = Page.InsuranceClaimPdf;
            pdfPage.getParameters().put('id', claim.Id);

            // Generate PDF
            Blob pdfBlob = pdfPage.getContentAsPDF();

            // Save PDF as Salesforce File
            ContentVersion contentVersion = new ContentVersion();
            contentVersion.Title = 'Claim_' + claim.Name;
            contentVersion.PathOnClient = 'Claim_' + claim.Name + '.pdf';
            contentVersion.VersionData = pdfBlob;

            insert contentVersion;

            // Get ContentDocumentId
            contentVersion = [
                SELECT Id, ContentDocumentId
                FROM ContentVersion
                WHERE Id = :contentVersion.Id
                LIMIT 1
            ];

            // Link file to Insurance Claim
            ContentDocumentLink documentLink = new ContentDocumentLink();
            documentLink.ContentDocumentId = contentVersion.ContentDocumentId;
            documentLink.LinkedEntityId = claim.Id;
            documentLink.ShareType = 'V';
            documentLink.Visibility = 'AllUsers';

            insert documentLink;
        }
    }
}