# Test Drive Reminder – Scheduled Flow

## Description
This flow sends an automated email reminder to a customer **1 day before** their scheduled vehicle test drive.

## Trigger Details
- **Object**: `Vehicle_Test_Drive__c`
- **Trigger**: When record **is created or updated**
- **Condition**: `Status__c == 'Scheduled'`

## Scheduled Path
- **Label**: Reminder Before Test Drive
- **Time Source**: `Test_Drive_Date__c`
- **Offset**: 1 day **before**

## Flow Elements

1. **Get Records: Get Customer Information**
   - **Object**: `Vehicle_Customer__c`
   - **Condition**: `Id == $Record.Customer__c`

2. **Send Email: Send Test Drive Reminder**
   - **To**: `{!Get_Customer_Information.Email__c}`
   - **Subject**: `"Reminder: Your Test Drive is Tomorrow!"`
   - **Body**: Basic reminder message (Rich Text Enabled)

## Notes
- Email is sent automatically 24 hours before the test drive
- Works reliably using Scheduled Path in Flow Builder
