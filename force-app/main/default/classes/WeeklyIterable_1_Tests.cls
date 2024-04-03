
@isTest
public class WeeklyIterable_1_Tests {

    @isTest
    static void testFirstRunOnOccurrenceDay() {
        Date runningDate = Date.newInstance(2023, 4, 3); // Assuming this is a Monday
        List<Integer> dayNums = new List<Integer>{1, 3, 5}; // Monday, Wednesday, Friday
        
        RecurrenceRule rRule = new RecurrenceRule();
        rRule.DayNums = dayNums; // Assuming direct assignment is possible
        rRule.Interval = 1;      // Assuming direct assignment is possible

        WeeklyIterable iterable = new WeeklyIterable(runningDate, rRule);

        Test.startTest();
        iterable.calculateRunningDate();
        Test.stopTest();

        // Assert that the running date hasn't changed as it's the first run and the date is on an occurrence day
        System.assertEquals(runningDate, iterable.runningDate, 'The running date should not change on the first run if it is an occurrence day');
    }

    @isTest
    static void testRunningDateBeforeNextOccurrence() {
        Date runningDate = Date.newInstance(2023, 4, 4); // Assuming this is a Tuesday
        List<Integer> dayNums = new List<Integer>{1, 3, 5}; // Monday, Wednesday, Friday
        
        RecurrenceRule rRule = new RecurrenceRule();
        rRule.DayNums = dayNums; // Assuming direct assignment is possible
        rRule.Interval = 1;      // Assuming direct assignment is possible

        WeeklyIterable iterable = new WeeklyIterable(runningDate, rRule);

        Test.startTest();
        iterable.calculateRunningDate();
        Test.stopTest();

        // Assert that the running date has moved to the next occurrence day
        System.assertEquals(Date.newInstance(2023, 4, 5), iterable.runningDate, 'The running date should move to the next occurrence day');
    }

    @isTest
    static void testRunningDateAfterLastOccurrence() {
        Date runningDate = Date.newInstance(2023, 4, 7); // Assuming this is a Friday
        List<Integer> dayNums = new List<Integer>{1, 3};  // Monday, Wednesday
        
        RecurrenceRule rRule = new RecurrenceRule();
        rRule.DayNums = dayNums; // Assuming direct assignment is possible
        rRule.Interval = 1;      // Assuming direct assignment is possible

        WeeklyIterable iterable = new WeeklyIterable(runningDate, rRule);
        
        // This should set the running day to the next interval, hence we are calling the method twice
        iterable.calculateRunningDate();
        Test.startTest();
        iterable.calculateRunningDate();
        Test.stopTest();

        // Assert that the running date has moved to the next week's first occurrence day
        Date expectedDate = Date.newInstance(2023, 4, 10); // Next Monday
        System.assertEquals(expectedDate, iterable.runningDate, 'The running date should move to the next week\'s first occurrence day');
    }
}
