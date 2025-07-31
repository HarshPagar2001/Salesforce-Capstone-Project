public class VehicleOrderTriggerHandler {
    public static void handleTrigger(List<Vehicle_Order__c> newOrders, Map<Id, Vehicle_Order__c> oldOrders, Boolean isBefore, Boolean isAfter, Boolean isInsert, Boolean isUpdate) {
        if (isBefore && (isInsert || isUpdate)) {
            preventOrderIfOutOfStock(newOrders);
        }
        if (isAfter && (isInsert || isUpdate)) {
            updateStockOnOrderPlacement(newOrders);
        }
    }

    private static void preventOrderIfOutOfStock(List<Vehicle_Order__c> orders) {
        // (as provided)
    }

    private static void updateStockOnOrderPlacement(List<Vehicle_Order__c> orders) {
        // (as provided)
    }
}
