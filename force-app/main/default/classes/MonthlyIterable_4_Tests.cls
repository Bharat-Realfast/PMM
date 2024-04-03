
@isTest
public class MonthlyIterable_4_Tests {
    
    // Util class to create a RecurrenceRule mock object
    private class RecurrenceRuleMock {
        private String byMonthDays;
        private Integer interval;
        private String byDay;

        public RecurrenceRuleMock(String byDay) {
            this.byDay = byDay;
            this.interval = 1; // assuming monthly interval for simplicity
        }

        public List<Integer> getByMonthDays() {
            // Return some sample month days
            return new List<Integer>{1, 15, 31};
        }

        public Integer getInterval() {
            return this.interval;
        }

        public String getByDay() {
            return this.byDay;
        }

        public Integer getDayNum(String weekDayAbbr) {
            // Mock implementation for simplicity, returning corresponding weekday number
            // assuming week starts with Sunday as 0
            Map<String, Integer> dayNums = new Map<String, Integer>{
                'SU' => 0, 'MO' => 1, 'TU' => 2, 'WE' => 3, 'TH' => 4, 'FR' => 5, 'SA' => 6
            };
            return dayNums.get(weekDayAbbr);
        }
    }

    private static MonthlyIterable createMonthlyIterable(Date runningDate, String byDay) {
        RecurrenceRuleMock rRule = new RecurrenceRuleMock(byDay);
        return new MonthlyIterable(runningDate, rRule);
    }

    @isTest
    static void testFirstOccurrenceOfMonthOnSpecifiedDay() {
        // Given a running date and a mock recurrence rule with a specified day
        Date runningDate = Date.newInstance(2023, 5, 1); // May 1, 2023 is Monday
        MonthlyIterable monthlyIterable = createMonthlyIterable(runningDate, 'TU'); // Recurrence on Tuesday
        
        // When calling getFirstOccurrenceOfMonth
        Date firstOccurrence = monthlyIterable.getFirstOccurrenceOfMonth();
        
        // Then the date returned should be the first Tuesday of May 2023
        Date expectedDate = Date.newInstance(2023, 5, 2); // May 2, 2023 is Tuesday
        System.assertEquals(expectedDate, firstOccurrence, 'The first occurrence of the month should be on Tuesday, May 2, 2023.');
    }
}
