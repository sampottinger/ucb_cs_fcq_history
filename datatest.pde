public void testData()
{
    test_classIDToCategory();
    test_courseRecordFromLine();
    test_sortRecordsBySemester();
}

public void test_classIDToCategory()
{
    assert classIDToCategory("CSCI 1000") == 0;
    assert classIDToCategory("CSCI 3112") == 2;
    assert classIDToCategory("CSCI 3155") == 5;
    assert classIDToCategory("CSCI 3287") == 7;
    assert classIDToCategory("CSCI 3308") == 8;
}

public void test_courseRecordFromLine()
{
    String testInput = "Spr,11,CSCI 1240,1,\"EISENBERG, MICHAEL\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,COMPUTATIONAL WORLD,4,6,5";
    CourseRecord record = courseRecordFromLine(testInput);

    assert record.getSemesterID() == 33;
    assert record.getInstructor() == "\"EISENBERG, MICHAEL\"";
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

private boolean checkPair(List<CourseRecord> pair, String name1, String name2)
{
    CourseRecord first = pair.get(0);
    CourseRecord second = pair.get(1);

    return (first.getName().equals(name1) && second.getName().equals(name2)) ||
        (first.getName().equals(name2) && second.getName().equals(name1));
}

public void test_sortRecordsBySemester()
{
    List<CourseRecord> records = new ArrayList<CourseRecord>();
    records.add(
        courseRecordFromLine("Spr,11,CSCI 1240,1,\"INST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING,4,6,5")
    );
    records.add(
        courseRecordFromLine("Spr,11,CSCI 1241,1,\"INST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING,4,6,5")
    );
    records.add(
        courseRecordFromLine("Sum,11,CSCI 1242,1,\"INST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING,4,6,5")
    );
    records.add(
        courseRecordFromLine("Sum,11,CSCI 1243,1,\"INST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING,4,6,5")
    );
    records.add(
        courseRecordFromLine("Fall,11,CSCI 1244,1,\"INST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING,4,6,5")
    );
    records.add(
        courseRecordFromLine("Fall,11,CSCI 1245,1,\"INST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING,4,6,5")
    );
    records.add(
        courseRecordFromLine("Spr,12,CSCI 1246,1,\"INST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING,4,6,5")
    );
    records.add(
        courseRecordFromLine("Spr,12,CSCI 1247,1,\"INST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING,4,6,5")
    );

    Map<Integer, List<CourseRecord>> semesterRecords = sortRecordsBySemester(records);

    List<CourseRecord> testList = semesterRecords.get(33);
    assert checkPair(testList, "CSCI 1240", "CSCI 1241");

    testList = semesterRecords.get(34);
    assert checkPair(testList, "CSCI 1242", "CSCI 1243");

    testList = semesterRecords.get(35);
    assert checkPair(testList, "CSCI 1244", "CSCI 1245");

    testList = semesterRecords.get(36);
    assert checkPair(testList, "CSCI 1246", "CSCI 1247");
}
