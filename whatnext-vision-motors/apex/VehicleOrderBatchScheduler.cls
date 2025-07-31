global class VehicleOrderBatchScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        VehicleOrderBatch batchJob = new VehicleOrderBatch();
        Database.executeBatch(batchJob, 50);
    }
}

//Job Schedule Execution code

String cronExp = '0 0 0 * * ?'; // Runs daily at 12:00 AM midnight
System.schedule('Daily Vehicle Order Processing', cronExp, new VehicleOrderBatchScheduler());
