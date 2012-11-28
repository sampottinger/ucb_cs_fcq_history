/**
 * Name: datatest.pde
 * Auth: Sam Pottinger
 * Lisc: GPL v2
 * Desc: Unit tests for the data structures in the UCB CS history visualization
 *       and transformation operations on those structures.
**/

/**
 * Name: testData()
 * Desc: Runs the unit test suite for data structures.
**/
public void testData()
{
    test_classIDToCategory();
    test_courseRecordFromLine();
    test_sortRecordsBySemester();
    test_floatIsInteger();
    test_getValueInDistribution();
    test_getDistribution();
    test_getRecordValues();
    test_getNumericalAttr();
}

/**
 * Name: test_classIDToCategory()
 * Desc: Test conversion of course names (CSCI 1300 for ex.) to categories IDs.
**/
public void test_classIDToCategory()
{
    assert classIDToCategory("CSCI 1000") == 0;
    assert classIDToCategory("CSCI 3112") == 2;
    assert classIDToCategory("CSCI 3155") == 5;
    assert classIDToCategory("CSCI 3287") == 7;
    assert classIDToCategory("CSCI 3308") == 8;
}

/**
 * Name: test_courseRecordFromLine()
 * Desc: Read a course record from a line from a CSV file.
**/
public void test_courseRecordFromLine()
{
    String testInput = "Spr,11,CSCI 1240,1,\"EISENBERG, MICHAEL\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,COMPUTATIONAL WORLD,4,6,5";
    CourseRecord record = courseRecordFromLine(testInput);

    assert record.getSemesterID() == 33;
    assert record.getInstructor().equals("\"EISENBERG, MICHAEL\"");
    assert record.getFormsRequested() == 33;
    assert record.getFormsReturned() == 26;
    assert record.getCourseOverall() == 4.8;
    assert record.getInstructorOverall() == 5.4;
    assert record.getMinHoursWeek() == 4;
    assert record.getAvgHoursWeek() == 5;
    assert record.getMaxHoursWeek() == 6;
    assert record.getPriorInterest() == 4.3;
    assert record.getInstructorEffectiveness() == 5.0;
    assert record.getAvailability() == 5.0;
    assert record.getChallenge() == 4.1;
    assert record.getAmountLearned() == 4.3;
    assert record.getRespect() == 5.9;
    assert record.getCourseCategory() == 0;
}

/**
 * Name: checkPair(List<CourseRecord> pair, String name1, String name2)
 * Desc: Checks that two records include the courses of the given names.
 * Para: pair, The collection of two course records.
 *       name1, The first name to look for in the given pair.
 *       name2, The second name to look for in the given pair.
 * Retr: True if the two names are present and false otherwise.
**/
private boolean checkPair(List<CourseRecord> pair, String name1, String name2)
{
    CourseRecord first = pair.get(0);
    CourseRecord second = pair.get(1);

    return (first.getName().equals(name1) && second.getName().equals(name2)) ||
        (first.getName().equals(name2) && second.getName().equals(name1));
}

/**
 * Name: test_sortRecordsBySemester()
 * Desc: Test sorting course records by their individual semester IDs.
**/
public void test_sortRecordsBySemester()
{
    List<CourseRecord> records = new ArrayList<CourseRecord>();
    records.add(
        courseRecordFromLine("Spr,11,CSCI 1240,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 1,4,6,5")
    );
    records.add(
        courseRecordFromLine("Spr,11,CSCI 1241,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 2,4,6,5")
    );
    records.add(
        courseRecordFromLine("Sum,11,CSCI 1242,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 3,4,6,5")
    );
    records.add(
        courseRecordFromLine("Sum,11,CSCI 1240,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 4,4,6,5")
    );
    records.add(
        courseRecordFromLine("Fall,11,CSCI 1241,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 5,4,6,5")
    );
    records.add(
        courseRecordFromLine("Fall,11,CSCI 1242,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 6,4,6,5")
    );
    records.add(
        courseRecordFromLine("Spr,12,CSCI 1240,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 7,4,6,5")
    );
    records.add(
        courseRecordFromLine("Spr,12,CSCI 1241,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 8,4,6,5")
    );

    Map<Integer, List<CourseRecord>> semesterRecords = sortRecordsBySemester(records);

    List<CourseRecord> testList = semesterRecords.get(33);
    assert checkPair(testList, "SOMETHING 1", "SOMETHING 2");

    testList = semesterRecords.get(34);
    assert checkPair(testList, "SOMETHING 3", "SOMETHING 4");

    testList = semesterRecords.get(35);
    assert checkPair(testList, "SOMETHING 5", "SOMETHING 6");

    testList = semesterRecords.get(36);
    assert checkPair(testList, "SOMETHING 7", "SOMETHING 8");
}

/**
 * Name: test_sortRecordsByCategory()
 * Desc: Test sorting course records by category integer IDs.
**/
public void test_sortRecordsByCategory()
{
    List<CourseRecord> records = new ArrayList<CourseRecord>();
    records.add(
        courseRecordFromLine("Spr,11,CSCI 1240,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 1,4,6,5")
    );
    records.add(
        courseRecordFromLine("Spr,11,CSCI 1241,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 2,4,6,5")
    );
    records.add(
        courseRecordFromLine("Sum,11,CSCI 1242,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 3,4,6,5")
    );
    records.add(
        courseRecordFromLine("Sum,11,CSCI 1240,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 4,4,6,5")
    );
    records.add(
        courseRecordFromLine("Fall,11,CSCI 1241,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 5,4,6,5")
    );
    records.add(
        courseRecordFromLine("Fall,11,CSCI 1242,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 6,4,6,5")
    );

    Map<Integer, List<CourseRecord>> categoryRecords = sortRecordsByCategory(records);

    List<CourseRecord> testList = categoryRecords.get(0);
    assert checkPair(testList, "SOMETHING 1", "SOMETHING 4");

    testList = categoryRecords.get(1);
    assert checkPair(testList, "SOMETHING 2", "SOMETHING 5");

    testList = categoryRecords.get(2);
    assert checkPair(testList, "SOMETHING 3", "SOMETHING 6");
}

/**
 * Name: test_floatIsInteger()
 * Desc: Test checking if a number is an integer or not.
**/
public void test_floatIsInteger()
{
    assert floatIsInteger(5) == true;
    assert floatIsInteger(5.5) == false;
}

/**
 * Name: test_getValueInDistribution()
 * Desc: Test calculation of percentiles.
**/
public void test_getValueInDistribution()
{
    ArrayList<Float> testList1 = new ArrayList<Float>();
    testList1.add(2.0);
    testList1.add(5.0);
    testList1.add(6.0);
    assert getValueInDistribution(testList1, 1) == 5;

    ArrayList<Float> testList2 = new ArrayList<Float>();
    testList2.add(2.0);
    testList2.add(5.0);
    testList2.add(6.0);
    testList2.add(7.0);
    testList2.add(9.0);
    testList2.add(10.0);
    assert getValueInDistribution(testList2, 2.5) == 6.5;
}

/**
 * Name: test_getDistribution()
 * Desc: Test calculation of first, second, and third quartiles.
**/
public void test_getDistribution()
{
    ArrayList<Float> testList = new ArrayList<Float>();
    testList.add(2.0);
    testList.add(5.0);
    testList.add(6.0);
    testList.add(7.0);
    testList.add(9.0);
    testList.add(10.0);

    Distribution distribution = getDistribution(testList);
    assert distribution.getFirstQuartile() == 4.25;
    assert distribution.getSecondQuartile() == 6.5;
    assert distribution.getThirdQuartile() == 9.25;

    testList.add(11.0);
    distribution = getDistribution(testList);
    assert distribution.getFirstQuartile() == 5;
    assert distribution.getSecondQuartile() == 7;
    assert distribution.getThirdQuartile() == 10;
}

/**
 * Name: test_getRecordValues()
 * Desc: Test reading a set of numerical values denoted by integer field IDs.
**/
public void test_getRecordValues()
{
    List<CourseRecord> records = new ArrayList<CourseRecord>();
    records.add(
        courseRecordFromLine("Spr,11,CSCI 1240,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 1,4,6,5")
    );
    records.add(
        courseRecordFromLine("Spr,11,CSCI 1241,1,\"INST, LAST\",TTT,33,26,4.9,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 2,4,6,5")
    );
    records.add(
        courseRecordFromLine("Sum,11,CSCI 1242,1,\"INST, LAST\",TTT,33,26,5.0,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 3,4,6,5")
    );
    records.add(
        courseRecordFromLine("Sum,11,CSCI 1240,1,\"INST, LAST\",TTT,33,26,5.2,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 4,4,6,5")
    );
    records.add(
        courseRecordFromLine("Fall,11,CSCI 1241,1,\"INST, LAST\",TTT,33,26,5.4,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 5,4,6,5")
    );
    records.add(
        courseRecordFromLine("Fall,11,CSCI 1242,1,\"INST, LAST\",TTT,33,26,5.6,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 6,4,6,5")
    );

    List<Float> overallScores = getRecordValues(records,
        COURSE_OVERALL_PROP_ID);

    assert overallScores.get(0) == 4.8;
    assert overallScores.get(1) == 4.9;
    assert overallScores.get(2) == 5.0;
    assert overallScores.get(3) == 5.2;
    assert overallScores.get(4) == 5.4;
    assert overallScores.get(5) == 5.6;
}

/**
 * Name: test_getNumericalAttr()
 * Desc: Test getting attributes of course records by numerical field IDs.
**/
public void test_getNumericalAttr()
{
    CourseRecord record = courseRecordFromLine("Spr,11,CSCI 1240,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 1,4,6,5");

    assert record.getNumericalAttr(CLASS_SEMESTER_ID_PROP_ID) == 33;
    assert record.getNumericalAttr(FORMS_REQUESTED_PROP_ID) == 33;
    assert record.getNumericalAttr(FORMS_RETURNED_PROP_ID) == 26;
    assert record.getNumericalAttr(COURSE_OVERALL_PROP_ID) == 4.8;
    assert record.getNumericalAttr(INSTRUCTOR_OVERALL_PROP_ID) == 5.4;
    assert record.getNumericalAttr(MIN_HOURS_WEEK_PROP_ID) == 4;
    assert record.getNumericalAttr(AVG_HOURS_WEEK_PROP_ID) == 5;
    assert record.getNumericalAttr(MAX_HOURS_WEEK_PROP_ID) == 6;
    assert record.getNumericalAttr(PRIOR_INTEREST_PROP_ID) == 4.3;
    assert record.getNumericalAttr(INSTRUCTOR_EFFECTIVENESS_PROP_ID) == 5.0;
    assert record.getNumericalAttr(AVAILABILITY_PROP_ID) == 5.0;
    assert record.getNumericalAttr(CHALLENGE_PROP_ID) == 4.1;
    assert record.getNumericalAttr(AMOUNT_LEARNED_PROP_ID) == 4.3;
    assert record.getNumericalAttr(RESPECT_PROP_ID) == 5.9;
    assert record.getNumericalAttr(COURSE_CATEGORY_PROP_ID) == 0;
}
