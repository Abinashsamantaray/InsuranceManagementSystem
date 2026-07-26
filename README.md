# Insurance Management System

A Salesforce DX project that demonstrates an enterprise-level Insurance Claim Management System built using Salesforce technologies and integrated with an external Spring Boot REST API.

---

## Overview

This project showcases a complete end-to-end Insurance Claim Management application using:

- Lightning Web Components (LWC)
- Apex
- Apex Trigger Framework
- Service Layer Architecture
- Selector Pattern
- Batch Apex
- Queueable Apex
- Scheduled Apex
- Visualforce PDF Generation
- Dynamic SOQL
- Named Credentials
- HTTP Callouts
- JSON Parsing
- Spring Boot REST API Integration

---

# Features

### Insurance Claim Management

- Create Insurance Claims
- Update Insurance Claims
- Search Claims by Customer Name
- Search Claims by Policy Number
- View All Claims
- Lightning Datatable
- Edit Existing Claims

### Business Logic

- Duplicate Policy Number Validation
- Default Claim Status using Trigger
- Prevent Updating Approved Claims
- Dynamic SOQL Search

### Asynchronous Processing

- Queueable Apex
- Batch Apex
- Scheduled Apex

### PDF Generation

- Generate Insurance Claim PDF
- Store PDF using ContentVersion
- Link PDF to Claim Record

### External API Integration

- Named Credential
- HTTP GET Callout
- JSON Deserialization
- Wrapper Class
- Iterable
- Batch Apex Import
- Import Claims from Spring Boot API

---

# Architecture

```
                 Lightning Web Component
                           │
                           ▼
                  InsuranceController
                           │
                           ▼
                   InsuranceService
                    /             \
                   /               \
                  ▼                 ▼
     Salesforce Database     Spring Boot REST API
             │                      │
             ▼                      ▼
           Trigger          Named Credential
             │                      │
             ▼                      ▼
     Trigger Handler        HTTP Callout
             │                      │
             ▼                      ▼
      Queueable Apex      InsuranceApiService
             │                      │
             ▼                      ▼
      Generate PDF      InsuranceClaimWrapper
             │                      │
             ▼                      ▼
      ContentVersion   InsuranceClaimIterable
                                     │
                                     ▼
                           InsuranceApiBatch
                                     │
                                     ▼
                          Insurance_Claim__c
```

---

# Project Structure

```
InsuranceManagementSystem
│
├── force-app
│   └── main
│       └── default
│
│           ├── classes
│           │
│           │   InsuranceController.cls
│           │   InsuranceService.cls
│           │   InsuranceSelector.cls
│           │   InsuranceClaimBatch.cls
│           │   InsuranceScheduler.cls
│           │   InsuranceQueueable.cls
│           │   InsurancePdfService.cls
│           │   InsuranceClaimTriggerHandler.cls
│           │
│           ├── api
│           │
│           │   InsuranceClaimWrapper.cls
│           │   InsuranceApiService.cls
│           │   InsuranceClaimIterable.cls
│           │   InsuranceApiBatch.cls
│           │   InsuranceApiBatchTest.cls
│           │   InsuranceApiCalloutMock.cls
│           │
│           ├── lwc
│           │
│           │   insuranceClaim
│           │
│           ├── triggers
│           │
│           │   InsuranceClaimTrigger.trigger
│           │
│           ├── pages
│           │
│           │   InsuranceClaimPdf.page
│           │
│           └── objects
│
└── sfdx-project.json
```

---

# Technologies Used

- Salesforce DX
- Lightning Web Components
- Apex
- SOQL
- Dynamic SOQL
- Batch Apex
- Queueable Apex
- Scheduled Apex
- Trigger Framework
- Visualforce
- Named Credentials
- REST API
- HTTP Callouts
- JSON
- Spring Boot
- Git
- GitHub
- VS Code

---

# Deployment

Deploy the project to your Salesforce Org.

```bash
sf project deploy start
```

---

# Run Apex Tests

Run all local Apex tests.

```bash
sf apex run test --test-level RunLocalTests
```

Run a specific test class.

```bash
sf apex run test --tests InsuranceApiBatchTest
```

---

# API Integration Flow

```
LWC
        │
        ▼
InsuranceController
        │
        ▼
runInsuranceApiBatch()
        │
        ▼
InsuranceApiBatch
        │
        ▼
InsuranceClaimIterable
        │
        ▼
InsuranceApiService
        │
        ▼
Named Credential
        │
        ▼
HTTP GET Callout
        │
        ▼
Spring Boot REST API
        │
        ▼
JSON Response
        │
        ▼
InsuranceClaimWrapper
        │
        ▼
Insurance_Claim__c
```

---

# Future Enhancements

- JWT Authentication
- Platform Events
- Change Data Capture
- Email Notifications
- Dashboard Analytics
- Einstein AI Predictions
- Flow Automation
- Scheduled API Synchronization
- Bulk Update Support
- Duplicate Detection Rules

---

# Author

**Abinash Samantaray**

Software Engineer | Salesforce Developer

GitHub:
https://github.com/Abinashsamantaray

---

# License

This project is intended for learning, demonstration, and portfolio purposes.