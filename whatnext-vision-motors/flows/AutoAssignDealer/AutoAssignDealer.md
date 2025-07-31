# Auto Assign Dealer – Record-Triggered Flow

## Description
This flow automatically assigns the nearest dealer to a vehicle order when it is created with status "Pending", based on the customer's location.

## Trigger Details
- **Object**: `Vehicle_Order__c`
- **Trigger**: When record **is created**
- **Condition**: `Status__c == 'Pending'`

## Flow Elements

1. **Get Records: Get Customer Information**
   - **Object**: `Vehicle_Customer__c`
   - **Condition**: `Id == $Record.Vehicle_Customer__c`

2. **Get Records: Get Nearest Dealer**
   - **Object**: `Vehicle_Dealer__c`
   - **Condition**: `Dealer_Location__c == {!Get_Customer_Information.Address__c}`

3. **Update Records: Assign Dealer to Order**
   - **Target**: Current `Vehicle_Order__c` record
   - **Action**: Set `Dealer__c = {!Get_Nearest_Dealer.Id}`

## Notes
- Used for intelligent dealer assignment at order creation
- Works without code (Flow-based logic)
