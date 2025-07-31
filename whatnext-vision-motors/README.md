# WhatNext Vision Motors – Salesforce CRM Capstone Project

This Salesforce CRM application was built for **WhatNext Vision Motors**, a futuristic automotive company focused on enhancing the customer ordering and service experience through automation, efficiency, and transparency.

This capstone project was completed as part of a Salesforce virtual internship and demonstrates advanced concepts in Salesforce Data Modeling, Flow Automation, Apex Trigger Logic, and Batch Apex Processing.

---

## Use Case Overview

WhatNext Vision Motors wanted a solution to:

- Automatically assign the **nearest dealer** to a customer's vehicle order
- Prevent customers from placing orders for vehicles that are out of stock
- Send **reminder emails** to customers before their scheduled test drive
- Automatically **confirm pending orders** when stock is replenished using a scheduled **Batch Apex Job**

---

## Data Model – Objects and Relationships

### Custom Objects Created:

`Vehicle__c` | Stores details about each car (Model, Stock, Price, Status)
`Vehicle_Dealer__c` | Represents dealer location, contact info, and dealer codes
`Vehicle_Customer__c` | Captures customer info and preferences
`Vehicle_Order__c` | Tracks customer orders for vehicles
`Vehicle_Test_Drive__c` | Manages test drive scheduling
`Vehicle_Service_Request__c` | Tracks vehicle maintenance requests from customers

### Relationships Between Objects:

Vehicle_Order → Vehicle | Lookup Relationship
Vehicle_Order → Customer | Lookup Relationship
Vehicle_Order → Dealer | Lookup Relationship
Test Drive → Vehicle | Lookup Relationship
Test Drive → Customer | Lookup Relationship
Service Request → Vehicle | Lookup Relationship
Service Request → Customer | Lookup Relationship

These relationships enable full visibility of who bought which vehicle, from which dealer, and when service or test drives occurred.

---

## Tabs Created

For user-friendly navigation, **custom tabs** were created for:

- `Vehicle`
- `Vehicle Dealer`
- `Vehicle Customer`
- `Vehicle Order`
- `Vehicle Test Drive`
- `Vehicle Service Request`
- Reports (optional)
- Dashboards (optional)

All tabs were added to a custom Lightning App called **"WhatNext Vision Motors"**.

---

## Flows Implemented

### **Auto Assign Dealer Flow**
- **Type**: Record-Triggered Flow
- **Trigger**: When `Vehicle_Order__c` is created and `Status__c = 'Pending'`
- **Logic**: Fetches the customer's address → Finds a matching dealer location → Auto-assigns that dealer to the order

### **Test Drive Reminder Flow**
- **Type**: Record-Triggered Flow with Scheduled Path
- **Trigger**: When `Vehicle_Test_Drive__c` is created or updated
- **Condition**: `Status__c = 'Scheduled'`
- **Scheduled Path**: 1 day before `Test_Drive_Date__c`
- **Action**: Sends an automated email reminder to the customer

All flows were built **declaratively (no code)** in Flow Builder.

---

## Apex and Automation Logic

### `VehicleOrderTriggerHandler.cls`
- Prevents placing orders for vehicles that are out of stock (in `before insert/update`)
- Updates vehicle stock by reducing `Stock_Quantity__c` when an order is confirmed (in `after insert/update`)

### `VehicleOrderTrigger.trigger`
- Calls the handler class on `before/after insert/update` of `Vehicle_Order__c`

### `VehicleOrderBatch.cls`
- Batch Apex job that runs daily to:
  - Check for all `Pending` orders
  - If stock is available, updates the order to `Confirmed` and reduces stock

### `VehicleOrderBatchScheduler.cls`
- Schedules the batch job to run **daily at 12:00 AM**

## apex
String cronExp = '0 0 0 * * ?';
System.schedule('Daily Vehicle Order Processing', cronExp, new VehicleOrderBatchScheduler());

---

## Project Video
### Link: