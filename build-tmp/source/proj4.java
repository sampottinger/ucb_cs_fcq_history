import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class proj4 extends PApplet {

final String DATA_FILE_LOC = "cs_fcq.csv";
final int PLOT_WIDTH = 100;
final int PLOT_HEIGHT = 60;

List<CourseRecord> courseRecords;

PointDataSet pointDataSet;
Sparkline testSparkline;

public void setup()
{
    size(PLOT_WIDTH, PLOT_HEIGHT);
    SummarizedDataSet summarizedDataSet = getDataSetFromFile(DATA_FILE_LOC);
    pointDataSet = dataSetToPoints(summarizedDataSet,
        PLOT_WIDTH, PLOT_HEIGHT);
    LabeledPointSeriesSet sampleSet = pointDataSet.getSeriesSet(0);
    PointSeries sampleSeries = sampleSet.getSeries(9);
    testSparkline = new Sparkline(sampleSeries);
}

public void draw()
{
    noStroke();
    fill(0xffFFFFFF);
    rectMode(CORNERS);
    rect(0, 0, PLOT_WIDTH, PLOT_HEIGHT);

    stroke(0xff000000);
    testSparkline.draw();
}
// Property numerical IDs
final int CLASS_SEMESTER_ID_PROP_ID = 0;
final int FIRST_PROP_ID = CLASS_SEMESTER_ID_PROP_ID;
final int FORMS_REQUESTED_PROP_ID = 1;
final int FORMS_RETURNED_PROP_ID = 2;
final int COURSE_OVERALL_PROP_ID = 3;
final int INSTRUCTOR_OVERALL_PROP_ID = 4;
final int MIN_HOURS_WEEK_PROP_ID = 5;
final int AVG_HOURS_WEEK_PROP_ID = 6;
final int MAX_HOURS_WEEK_PROP_ID = 7;
final int PRIOR_INTEREST_PROP_ID = 8;
final int INSTRUCTOR_EFFECTIVENESS_PROP_ID = 9;
final int AVAILABILITY_PROP_ID = 10;
final int CHALLENGE_PROP_ID = 11;
final int AMOUNT_LEARNED_PROP_ID = 12;
final int RESPECT_PROP_ID = 13;
final int COURSE_CATEGORY_PROP_ID = 14;
final int LAST_PROP_ID = COURSE_CATEGORY_PROP_ID;

class CourseRecord
{
    // Member attributes
    private int classSemesterID;
    private String instructor;
    private String name;
    private float formsRequested;
    private float formsReturned;
    private float courseOverall;
    private float instructorOverall;
    private float minHoursWeek;
    private float avgHoursWee;
    private float maxHoursWeek;
    private float priorInterest;
    private float availability;
    private float challenge;
    private float amountLearned;
    private float respect;
    private int courseCategory;
    private float instructorEffectiveness;

    // Constructor
    public CourseRecord(
        int newSemesterID,
        String newName,
        String newInstructor,
        float newFormsRequested,
        float newFormsReturned,
        float newCourseOverall,
        float newInstructorOverall,
        float newMinHoursWeek,
        float newAvgHoursWeek,
        float newMaxHoursWeek,
        float newPriorInterest,
        float newInstructorEffectiveness,
        float newAvailability,
        float newChallenge,
        float newAmountLearned,
        float newRespect,
        int newCourseCategory)
    {
        classSemesterID = newSemesterID;
        name = newName;
        instructor = newInstructor;
        formsRequested = newFormsRequested;
        formsReturned = newFormsReturned;
        courseOverall = newCourseOverall;
        instructorOverall = newInstructorOverall;
        minHoursWeek = newMinHoursWeek;
        avgHoursWee = newAvgHoursWeek;
        maxHoursWeek = newMaxHoursWeek;
        priorInterest = newPriorInterest;
        availability = newAvailability;
        challenge = newChallenge;
        amountLearned = newAmountLearned;
        respect = newRespect;
        courseCategory = newCourseCategory;
        instructorEffectiveness = newInstructorEffectiveness;
    }

    // Getters
    public int getSemesterID()
    {
        return classSemesterID;
    }

    public String getName()
    {
        return name;
    }

    public String getInstructor()
    {
        return instructor;
    }

    public float getFormsRequested()
    {
        return formsRequested;
    }

    public float getFormsReturned()
    {
        return formsReturned;
    }

    public float getCourseOverall()
    {
        return courseOverall;
    }

    public float getInstructorOverall()
    {
        return instructorOverall;
    }

    public float getMinHoursWeek()
    {
        return minHoursWeek;
    }

    public float getAvgHoursWeek()
    {
        return avgHoursWee;
    }

    public float getMaxHoursWeek()
    {
        return maxHoursWeek;
    }

    public float getPriorInterest()
    {
        return priorInterest;
    }

    public float getAvailability()
    {
        return availability;
    }

    public float getChallenge()
    {
        return challenge;
    }

    public float getAmountLearned()
    {
        return amountLearned;
    }

    public float getRespect()
    {
        return respect;
    }

    public int getCourseCategory()
    {
        return courseCategory;
    }
    
    public float getInstructorEffectiveness()
    {
        return instructorEffectiveness;
    }

    public float getNumericalAttr(int id)
    {
        switch(id)
        {
            case CLASS_SEMESTER_ID_PROP_ID:
                return getSemesterID();
            case FORMS_REQUESTED_PROP_ID:
                return getFormsRequested();
            case FORMS_RETURNED_PROP_ID:
                return getFormsReturned();
            case COURSE_OVERALL_PROP_ID:
                return getCourseOverall();
            case INSTRUCTOR_OVERALL_PROP_ID:
                return getInstructorOverall();
            case MIN_HOURS_WEEK_PROP_ID:
                return getMinHoursWeek();
            case AVG_HOURS_WEEK_PROP_ID:
                return getAvgHoursWeek();
            case MAX_HOURS_WEEK_PROP_ID:
                return getMaxHoursWeek();
            case PRIOR_INTEREST_PROP_ID:
                return getPriorInterest();
            case INSTRUCTOR_EFFECTIVENESS_PROP_ID:
                return getInstructorEffectiveness();
            case AVAILABILITY_PROP_ID:
                return getAvailability();
            case CHALLENGE_PROP_ID:
                return getChallenge();
            case AMOUNT_LEARNED_PROP_ID:
                return getAmountLearned();
            case RESPECT_PROP_ID:
                return getRespect();
            case COURSE_CATEGORY_PROP_ID:
                return getCourseCategory();
            default:
                return -1;
        }
    }
};

class CourseSummary
{
    private CourseRecord firstQuartile;
    private CourseRecord secondQuartile;
    private CourseRecord thirdQuartile;

    public CourseSummary(CourseRecord newFirstQuartile,
        CourseRecord newSecondQuartile, CourseRecord newThirdQuartile)
    {
        firstQuartile = newFirstQuartile;
        secondQuartile = newSecondQuartile;
        thirdQuartile = newThirdQuartile;
    }

    public CourseRecord getFirstQuartile()
    {
        return firstQuartile;
    }

    public CourseRecord getSecondQuartile()
    {
        return secondQuartile;
    }

    public CourseRecord getThirdQuartile()
    {
        return thirdQuartile;
    }

};

class Distribution
{
    private float firstQuartile;
    private float secondQuartile;
    private float thirdQuartile;

    public Distribution(float newFirstQuartile, float newSecondQuartile,
        float newThirdQuartile)
    {
        firstQuartile = newFirstQuartile;
        secondQuartile = newSecondQuartile;
        thirdQuartile = newThirdQuartile;
    }

    public float getFirstQuartile()
    {
        return firstQuartile;
    }

    public float getSecondQuartile()
    {
        return secondQuartile;
    }

    public float getThirdQuartile()
    {
        return thirdQuartile;
    }

};

class SummarizedDataSet
{
    // <category, <semesterID, summary>>
    private Map<Integer, Map<Integer, CourseSummary>> categoryMap;

    public SummarizedDataSet()
    {
        categoryMap = new HashMap<Integer, Map<Integer, CourseSummary>>();
    }

    public void addSummary(int semesterID, int category, CourseSummary summary)
    {
        if(!categoryMap.containsKey(category))
            categoryMap.put(category, new HashMap<Integer, CourseSummary>());
        Map<Integer, CourseSummary> semesterMap = categoryMap.get(category);
        semesterMap.put(semesterID, summary);
    }

    public Map<Integer, CourseSummary> getCategory(int category)
    {
        return categoryMap.get(category);
    }

    public Set<Integer> getCategories()
    {
        return categoryMap.keySet();
    }
};
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
    assert record.getInstructor().equals("\"EISENBERG, MICHAEL\"");
    assert record.getFormsRequested() == 33;
    assert record.getFormsReturned() == 26;
    assert record.getCourseOverall() == 4.8f;
    assert record.getInstructorOverall() == 5.4f;
    assert record.getMinHoursWeek() == 4;
    assert record.getAvgHoursWeek() == 5;
    assert record.getMaxHoursWeek() == 6;
    assert record.getPriorInterest() == 4.3f;
    assert record.getInstructorEffectiveness() == 5.0f;
    assert record.getAvailability() == 5.0f;
    assert record.getChallenge() == 4.1f;
    assert record.getAmountLearned() == 4.3f;
    assert record.getRespect() == 5.9f;
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

public void test_floatIsInteger()
{
    assert floatIsInteger(5) == true;
    assert floatIsInteger(5.5f) == false;
}

public void test_getValueInDistribution()
{
    ArrayList<Float> testList1 = new ArrayList<Float>();
    testList1.add(2.0f);
    testList1.add(5.0f);
    testList1.add(6.0f);
    assert getValueInDistribution(testList1, 1) == 5;

    ArrayList<Float> testList2 = new ArrayList<Float>();
    testList2.add(2.0f);
    testList2.add(5.0f);
    testList2.add(6.0f);
    testList2.add(7.0f);
    testList2.add(9.0f);
    testList2.add(10.0f);
    assert getValueInDistribution(testList2, 2.5f) == 6.5f;
}

public void test_getDistribution()
{
    ArrayList<Float> testList = new ArrayList<Float>();
    testList.add(2.0f);
    testList.add(5.0f);
    testList.add(6.0f);
    testList.add(7.0f);
    testList.add(9.0f);
    testList.add(10.0f);

    Distribution distribution = getDistribution(testList);
    assert distribution.getFirstQuartile() == 4.25f;
    assert distribution.getSecondQuartile() == 6.5f;
    assert distribution.getThirdQuartile() == 9.25f;

    testList.add(11.0f);
    distribution = getDistribution(testList);
    assert distribution.getFirstQuartile() == 5;
    assert distribution.getSecondQuartile() == 7;
    assert distribution.getThirdQuartile() == 10;
}

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

    assert overallScores.get(0) == 4.8f;
    assert overallScores.get(1) == 4.9f;
    assert overallScores.get(2) == 5.0f;
    assert overallScores.get(3) == 5.2f;
    assert overallScores.get(4) == 5.4f;
    assert overallScores.get(5) == 5.6f;
}

public void test_getNumericalAttr()
{
    CourseRecord record = courseRecordFromLine("Spr,11,CSCI 1240,1,\"INST, LAST\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,SOMETHING 1,4,6,5");

    assert record.getNumericalAttr(CLASS_SEMESTER_ID_PROP_ID) == 33;
    assert record.getNumericalAttr(FORMS_REQUESTED_PROP_ID) == 33;
    assert record.getNumericalAttr(FORMS_RETURNED_PROP_ID) == 26;
    assert record.getNumericalAttr(COURSE_OVERALL_PROP_ID) == 4.8f;
    assert record.getNumericalAttr(INSTRUCTOR_OVERALL_PROP_ID) == 5.4f;
    assert record.getNumericalAttr(MIN_HOURS_WEEK_PROP_ID) == 4;
    assert record.getNumericalAttr(AVG_HOURS_WEEK_PROP_ID) == 5;
    assert record.getNumericalAttr(MAX_HOURS_WEEK_PROP_ID) == 6;
    assert record.getNumericalAttr(PRIOR_INTEREST_PROP_ID) == 4.3f;
    assert record.getNumericalAttr(INSTRUCTOR_EFFECTIVENESS_PROP_ID) == 5.0f;
    assert record.getNumericalAttr(AVAILABILITY_PROP_ID) == 5.0f;
    assert record.getNumericalAttr(CHALLENGE_PROP_ID) == 4.1f;
    assert record.getNumericalAttr(AMOUNT_LEARNED_PROP_ID) == 4.3f;
    assert record.getNumericalAttr(RESPECT_PROP_ID) == 5.9f;
    assert record.getNumericalAttr(COURSE_CATEGORY_PROP_ID) == 0;
}
// Semester mapping
final int SPRING_INT = 0;
final int SUMMER_INT = 1;
final int FALL_INT = 2;
final int NUM_SEMESTERS = 3;
final int UNKNOWN_SEMESTER_INT = -1;
final String SPRING_STR = "Spr";
final String SUMMER_STR = "Sum";
final String FALL_STR = "Fall";
final String UNKNOWN_SEMESTER_STR = "Unknown";

// Line parsing constants
final int CLASS_SEM_INDEX = 0;
final int CLASS_YEAR_INDEX = 1;
final int CLASS_ID_INDEX = 2;
final int CLASS_SECTION_INDEX = 3;
final int INSTRUCTOR_FIRST_NAME_INDEX = 4;
final int INSTRUCTOR_LAST_NAME_INDEX = 5;
final int INSTRUCTOR_GROUP_INDEX = 6;
final int FORMS_REQUESTED_INDEX = 7;
final int FORMS_RETURNED_INDEX = 8;
final int COURSE_OVERALL_INDEX = 9;
final int INSTRUCTOR_OVERALL_INDEX = 10;
final int PRIOR_INTEREST_INDEX = 11;
final int INSTRUCTOR_EFFECTIVENESS_INDEX = 12;
final int AVAILABILITY_INDEX = 13;
final int CHALLENGE_INDEX = 14;
final int AMOUNT_LEARNED_INDEX = 15;
final int INSTRUCTOR_RESPECT_INDEX = 16;
final int CLASS_NAME_INDEX = 17;
final int MIN_HOURS_WEEK_INDEX = 18;
final int AVG_HOURS_WEEK_INDEX = 20;
final int MAX_HOURS_WEEK_INDEX = 19;

// Data support
public int semesterStrToInt(String name)
{
    if(name.equals(SPRING_STR))
        return SPRING_INT;
    else if(name.equals(SUMMER_STR))
        return SUMMER_INT;
    else if(name.equals(FALL_STR))
        return FALL_INT;
    else
        return UNKNOWN_SEMESTER_INT;
}

public int semesterAndYearToSemesterID(int targetYear, int targetSemester)
{
    return targetYear * NUM_SEMESTERS + targetSemester;
}

public int classIDToCategory(String classID)
{
    return new Integer(classID.substring(classID.length() - 1, classID.length()));
}

public CourseRecord courseRecordFromLine(String targetLine)
{
    String[] components = split(targetLine, ",");

    String semester = components[CLASS_SEM_INDEX];
    String className = components[CLASS_NAME_INDEX];
    int targetYear = new Integer(components[CLASS_YEAR_INDEX]);
    String instructor = components[INSTRUCTOR_FIRST_NAME_INDEX] + "," +
        components[INSTRUCTOR_LAST_NAME_INDEX];
    int formsRequested = new Integer(components[FORMS_REQUESTED_INDEX]);
    int formsReturned = new Integer(components[FORMS_RETURNED_INDEX]);
    float courseOverall = new Float(components[COURSE_OVERALL_INDEX]);
    float instructorOverall = new Float(components[INSTRUCTOR_OVERALL_INDEX]);
    int minHoursWeek = new Integer(components[MIN_HOURS_WEEK_INDEX]);
    float avgHoursWeek = new Float(components[AVG_HOURS_WEEK_INDEX]);
    int maxHoursWeek = new Integer(components[MAX_HOURS_WEEK_INDEX]);
    float priorInterest = new Float(components[PRIOR_INTEREST_INDEX]);
    float instructorEffectiveness =
        new Float(components[INSTRUCTOR_EFFECTIVENESS_INDEX]);
    float availability = new Float(components[AVAILABILITY_INDEX]);
    float challenge = new Float(components[CHALLENGE_INDEX]);
    float amountLearned = new Float(components[AMOUNT_LEARNED_INDEX]);
    float respect = new Float(components[INSTRUCTOR_RESPECT_INDEX]);
    String classID = components[CLASS_ID_INDEX];

    int semesterNum = semesterStrToInt(semester);
    int semesterID = semesterAndYearToSemesterID(targetYear, semesterNum);
    int courseCategory = classIDToCategory(classID);

    return new CourseRecord(
        semesterID,
        className,
        instructor,
        formsRequested,
        formsReturned,
        courseOverall,
        instructorOverall,
        minHoursWeek,
        avgHoursWeek,
        maxHoursWeek,
        priorInterest,
        instructorEffectiveness,
        availability,
        challenge,
        amountLearned,
        respect,
        courseCategory
    );
}

public Map<Integer, List<CourseRecord>> sortRecordsBySemester(List<CourseRecord> targetList)
{
    Map<Integer, List<CourseRecord>> retMap =
        new HashMap<Integer, List<CourseRecord>>();
    int targetListSize = targetList.size();

    for(CourseRecord target : targetList)
    {
        int semID = target.getSemesterID();

        if(!retMap.containsKey(semID))
            retMap.put(semID, new ArrayList<CourseRecord>());

        retMap.get(semID).add(target);
    }
    
    return retMap;
}

public Map<Integer, List<CourseRecord>> sortRecordsByCategory(List<CourseRecord> targetList)
{
    Map<Integer, List<CourseRecord>> retMap =
        new HashMap<Integer, List<CourseRecord>>();
    int targetListSize = targetList.size();

    for(CourseRecord target : targetList)
    {
        int category = target.getCourseCategory();

        if(!retMap.containsKey(category))
            retMap.put(category, new ArrayList<CourseRecord>());

        retMap.get(category).add(target);
    }
    
    return retMap;
}

public boolean floatIsInteger(float target)
{
    return target == Math.floor(target);
}

public float safeGet(List<Float> target, int index)
{
    if(index < 0)
        index = 0;
    if(index >= target.size())
        index = target.size() - 1;
    return target.get(index);
}

public float getValueInDistribution(List<Float> target, float index)
{
    if(floatIsInteger(index))
        return target.get((int)index);
    else
    {
        int closestIndex = (int)Math.floor(index);
        float m = safeGet(target, closestIndex + 1) - safeGet(target, closestIndex);
        return m * (index - closestIndex) + safeGet(target, closestIndex);
    }
}

public Distribution getDistribution(List<Float> target)
{
    Collections.sort(target);

    float q1Index;
    float q2Index;
    float q3Index;
    
    q1Index = (target.size() + 1) / 4.0f;
    q2Index = (target.size() + 1) / 2.0f;
    q3Index = (target.size() + 1) / 4.0f * 3;

    return new Distribution(
        getValueInDistribution(target, q1Index - 1),
        getValueInDistribution(target, q2Index - 1),
        getValueInDistribution(target, q3Index - 1)
    );
}

public List<Float> getRecordValues(List<CourseRecord> targetList, int attrID)
{
    List<Float> retList = new ArrayList<Float>(targetList.size());
    for(CourseRecord target : targetList)
        retList.add(target.getNumericalAttr(attrID));
    return retList;
}

public CourseSummary getCourseSummary(List<CourseRecord> target, int semesterID,
    String instructor, int courseCategory)
{
    Distribution formsRequestedDist = getDistribution(
        getRecordValues(target, FORMS_REQUESTED_PROP_ID)
    );

    Distribution formsReturnedDist = getDistribution(
        getRecordValues(target, FORMS_RETURNED_PROP_ID)
    );

    Distribution courseOverallDist = getDistribution(
        getRecordValues(target, COURSE_OVERALL_PROP_ID)
    );

    Distribution instructorOverallDist = getDistribution(
        getRecordValues(target, INSTRUCTOR_OVERALL_PROP_ID)
    );

    Distribution minHoursWeekDist = getDistribution(
        getRecordValues(target, MIN_HOURS_WEEK_PROP_ID)
    );

    Distribution avgHoursWeekDist = getDistribution(
        getRecordValues(target, AVG_HOURS_WEEK_PROP_ID)
    );

    Distribution maxHoursWeekDist = getDistribution(
        getRecordValues(target, MAX_HOURS_WEEK_PROP_ID)
    );

    Distribution priorInterestDist = getDistribution(
        getRecordValues(target, PRIOR_INTEREST_PROP_ID)
    );

    Distribution instructorEffectivenessDist = getDistribution(
        getRecordValues(target, INSTRUCTOR_EFFECTIVENESS_PROP_ID)
    );

    Distribution availabilityDist = getDistribution(
        getRecordValues(target, AVAILABILITY_PROP_ID)
    );

    Distribution challengeDist = getDistribution(
        getRecordValues(target, CHALLENGE_PROP_ID)
    );

    Distribution amountLearnedDist = getDistribution(
        getRecordValues(target, AMOUNT_LEARNED_PROP_ID)
    );

    Distribution respectDist = getDistribution(
        getRecordValues(target, RESPECT_PROP_ID)
    );

    CourseRecord firstQuartile = new CourseRecord(
        semesterID,
        "firstQuartile",
        instructor,
        formsRequestedDist.getFirstQuartile(),
        formsReturnedDist.getFirstQuartile(),
        courseOverallDist.getFirstQuartile(),
        instructorOverallDist.getFirstQuartile(),
        minHoursWeekDist.getFirstQuartile(),
        avgHoursWeekDist.getFirstQuartile(),
        maxHoursWeekDist.getFirstQuartile(),
        priorInterestDist.getFirstQuartile(),
        instructorEffectivenessDist.getSecondQuartile(),
        availabilityDist.getFirstQuartile(),
        challengeDist.getFirstQuartile(),
        amountLearnedDist.getFirstQuartile(),
        respectDist.getFirstQuartile(),
        courseCategory
    );

    CourseRecord secondQuartile = new CourseRecord(
        semesterID,
        "secondQuartile",
        instructor,
        formsRequestedDist.getSecondQuartile(),
        formsReturnedDist.getSecondQuartile(),
        courseOverallDist.getSecondQuartile(),
        instructorOverallDist.getSecondQuartile(),
        minHoursWeekDist.getSecondQuartile(),
        avgHoursWeekDist.getSecondQuartile(),
        maxHoursWeekDist.getSecondQuartile(),
        priorInterestDist.getSecondQuartile(),
        instructorEffectivenessDist.getSecondQuartile(),
        availabilityDist.getSecondQuartile(),
        challengeDist.getSecondQuartile(),
        amountLearnedDist.getSecondQuartile(),
        respectDist.getSecondQuartile(),
        courseCategory
    );

    CourseRecord thirdQuartile = new CourseRecord(
        semesterID,
        "thirdQuartile",
        instructor,
        formsRequestedDist.getThirdQuartile(),
        formsReturnedDist.getThirdQuartile(),
        courseOverallDist.getThirdQuartile(),
        instructorOverallDist.getThirdQuartile(),
        minHoursWeekDist.getThirdQuartile(),
        avgHoursWeekDist.getThirdQuartile(),
        maxHoursWeekDist.getThirdQuartile(),
        priorInterestDist.getThirdQuartile(),
        instructorEffectivenessDist.getSecondQuartile(),
        availabilityDist.getThirdQuartile(),
        challengeDist.getThirdQuartile(),
        amountLearnedDist.getThirdQuartile(),
        respectDist.getThirdQuartile(),
        courseCategory
    );

    return new CourseSummary(firstQuartile, secondQuartile, thirdQuartile);
}

public SummarizedDataSet summarizeSemesters(
    Map<Integer, List<CourseRecord>> coursesBySemester)
{
    SummarizedDataSet dataSet = new SummarizedDataSet();

    for(Integer semID : coursesBySemester.keySet())
    {
        List<CourseRecord> semCourses = coursesBySemester.get(semID);
        Map<Integer, List<CourseRecord>> coursesByCategory =
            sortRecordsByCategory(semCourses);

        for(Integer category : coursesByCategory.keySet())
        {
            CourseSummary summary = getCourseSummary(
                coursesByCategory.get(category),
                semID,
                "",
                category
            );
            dataSet.addSummary(semID, category, summary);
        }
    }

    return dataSet;
}

public List<CourseRecord> getRecordsFromLines(String[] lines)
{
    ArrayList<CourseRecord> retList = new ArrayList<CourseRecord>();
    int numLines = lines.length;
    for(int i=0; i<numLines; i++)
        retList.add(courseRecordFromLine(lines[i]));
    return retList;
}

public List<CourseRecord> getRecordsFromFile(String loc)
{
    return getRecordsFromLines(loadStrings(loc));
}

public SummarizedDataSet getDataSetFromFile(String loc)
{
    List<CourseRecord> records = getRecordsFromFile(loc);
    Map<Integer, List<CourseRecord>> recordsBySemester =
        sortRecordsBySemester(records);
    return summarizeSemesters(recordsBySemester);
}
class Sparkline
{
    private PointSeries series;

    public Sparkline(PointSeries newSeries)
    {
        series = newSeries;
    }

    public void draw()
    {
        // Set color and other display options
        strokeWeight(1);
        noFill();
        noSmooth();

        // Render centers
        rectMode(RADIUS);
        for(Integer semID : series.getSortedKeys())
        {
            PointSummary pointSummary = series.getSummary(semID);
            PVector secondQuartile = pointSummary.getSecondQuartile();
            rect(secondQuartile.x, secondQuartile.y, 2, 2);
        }
    }
};
class PointSummary
{
    private PVector firstQuartile;
    private PVector secondQuartile;
    private PVector thirdQuartile;

    public PointSummary(PVector newFirstQuartile, PVector newSecondQuartile,
        PVector newThirdQuartile)
    {
        firstQuartile = newFirstQuartile;
        secondQuartile = newSecondQuartile;
        thirdQuartile = newThirdQuartile;
    }

    public PVector getFirstQuartile()
    {
        return firstQuartile;
    }

    public PVector getSecondQuartile()
    {
        return secondQuartile;
    }

    public PVector getThirdQuartile()
    {
        return thirdQuartile;
    }
};

class PointSeries
{
    private Map<Integer, PointSummary> pointSummaries;
    private List<Integer> sortedKeys;

    public PointSeries()
    {
        pointSummaries = new HashMap<Integer, PointSummary>();
        sortedKeys = new ArrayList<Integer>(pointSummaries.keySet());
        Collections.sort(sortedKeys);
    }

    public void addSummary(int semID, PointSummary summary)
    {
        pointSummaries.put(semID, summary);
    }

    public PointSummary getSummary(int semID)
    {
        return pointSummaries.get(semID);
    }

    public Set<Integer> getSortedKeys()
    {
        return pointSummaries.keySet();
    }
};

class LabeledPointSeriesSet
{
    private Map<Integer, PointSeries> pointSeries;

    public LabeledPointSeriesSet()
    {
        pointSeries = new HashMap<Integer, PointSeries>();
    }

    public void addSeries(int seriesID, PointSeries series)
    {
        pointSeries.put(seriesID, series);
    }

    public PointSeries getSeries(int seriesID)
    {
        return pointSeries.get(seriesID);
    }
};

class PointDataSet
{
    private Map<Integer, LabeledPointSeriesSet> seriesSets;

    public PointDataSet()
    {
        seriesSets = new HashMap<Integer, LabeledPointSeriesSet>();
    }

    public void addSet(int category, LabeledPointSeriesSet newSet)
    {
        seriesSets.put(category, newSet);
    }

    public LabeledPointSeriesSet getSeriesSet(int categoryID)
    {
        return seriesSets.get(categoryID);
    }
};
public PointSeries courseSummaryToPointSummary(
    Map<Integer, CourseSummary> summaries, int fieldID, int minValue,
    int maxValue, int minKey, int maxKey, int availWidth, int availHeight)
{
    CourseSummary curSummary;
    CourseRecord firstQuartileCourse;
    PointSummary firstQuartilePoint;
    CourseRecord secondQuartileCourse;
    PointSummary secondQuartilePoint;
    CourseRecord thirdQuartileCourse;
    PointSummary thirdQuartilePoint;

    float keyConvFactor = availWidth / ((float)(maxKey - minKey));
    float valueConvFactor = availHeight / ((float)(maxValue - minValue));

    PointSeries pointSeries = new PointSeries();
    for(Integer semID : summaries.keySet())
    {
        float x = (semID - minKey) * keyConvFactor;

        curSummary = summaries.get(semID);

        firstQuartileCourse = curSummary.getFirstQuartile();
        secondQuartileCourse = curSummary.getSecondQuartile();
        thirdQuartileCourse = curSummary.getThirdQuartile();

        float firstVal = firstQuartileCourse.getNumericalAttr(fieldID);
        float secondVal = secondQuartileCourse.getNumericalAttr(fieldID);
        float thirdVal = thirdQuartileCourse.getNumericalAttr(fieldID);

        float firstY = valueConvFactor * (firstVal - minValue);
        float secondY = valueConvFactor * (secondVal - minValue);
        float thirdY = valueConvFactor * (thirdVal - minValue);

        println(String.format("%f : %f", secondVal, secondY));

        PVector firstVector = new PVector(x, firstY);
        PVector secondVector = new PVector(x, secondY);
        PVector thirdVector = new PVector(x, thirdY);

        PointSummary newPointSummary = new PointSummary(
            firstVector,
            secondVector,
            thirdVector
        );

        pointSeries.addSummary(semID, newPointSummary);
    }

    return pointSeries;
}

public LabeledPointSeriesSet courseSummaryToPointSeries(
    Map<Integer, CourseSummary> summaries, int availWidth, int availHeight)
{
    LabeledPointSeriesSet seriesSet = new LabeledPointSeriesSet();

    PointSeries newSeries;

    // Fields ranging from 1 to 6
    newSeries = courseSummaryToPointSummary(
        summaries,
        COURSE_OVERALL_PROP_ID,
        1,
        6,
        20,
        36,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(COURSE_OVERALL_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(
        summaries,
        INSTRUCTOR_OVERALL_PROP_ID,
        1,
        6,
        20,
        36,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(INSTRUCTOR_OVERALL_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(
        summaries,
        PRIOR_INTEREST_PROP_ID,
        1,
        6,
        20,
        36,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(PRIOR_INTEREST_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(
        summaries,
        INSTRUCTOR_EFFECTIVENESS_PROP_ID,
        1,
        6,
        20,
        36,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(INSTRUCTOR_EFFECTIVENESS_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(
        summaries,
        AVAILABILITY_PROP_ID,
        1,
        6,
        20,
        36,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(AVAILABILITY_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(
        summaries,
        CHALLENGE_PROP_ID,
        1,
        6,
        20,
        36,
        availWidth,
        availHeight);
    seriesSet.addSeries(CHALLENGE_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(summaries,
        AMOUNT_LEARNED_PROP_ID,
        1,
        6,
        20,
        36,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(AMOUNT_LEARNED_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(summaries,
        RESPECT_PROP_ID,
        1,
        6,
        20,
        36,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(RESPECT_PROP_ID, newSeries);


    // Fields ranging from 0 to 16
    newSeries = courseSummaryToPointSummary(
        summaries,
        MIN_HOURS_WEEK_PROP_ID,
        0,
        16,
        20,
        36,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(MIN_HOURS_WEEK_PROP_ID, newSeries);

    newSeries = courseSummaryToPointSummary(
        summaries,
        AVG_HOURS_WEEK_PROP_ID,
        0,
        16,
        20,
        36,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(AVG_HOURS_WEEK_PROP_ID, newSeries);

    newSeries = courseSummaryToPointSummary(
        summaries,
        MAX_HOURS_WEEK_PROP_ID,
        0,
        16,
        20,
        36,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(MAX_HOURS_WEEK_PROP_ID, newSeries);

    return seriesSet;
}

public PointDataSet dataSetToPoints(SummarizedDataSet origDataSet, int availWidth,
    int availHeight)
{
    PointDataSet retPointDataSet = new PointDataSet();

    for(Integer category : origDataSet.getCategories())
    {
        LabeledPointSeriesSet newSet = courseSummaryToPointSeries(
            origDataSet.getCategory(category), availWidth, availHeight);
        retPointDataSet.addSet(category, newSet);
    }

    return retPointDataSet;
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "proj4" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
