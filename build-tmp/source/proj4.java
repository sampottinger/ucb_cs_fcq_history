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

final String DATA_FILE_LOC = "fcq.csv";

List<CourseRecord> courseRecords;

public void setup()
{
    testData();
}

public void draw()
{

}
// Property numerical IDs
final int CLASS_SEMESTER_ID_PROP_ID = 0;
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
        avgHoursWee = newAvgHoursWee;
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

    public float getAvgHoursWee()
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

    public CourseSetSummary(CourseRecord newFirstQuartile,
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
            categoryMap.put(new HashMap<Integer, CourseSummary>());
        Map<Integer, CourseSummary> semesterMap = categoryMap.get(category);
        semesterMap.put(semesterID, summary);
    }

    public Map<Integer, CourseSummary> getCategory(int category)
    {
        return categoryMap.get(category);
    }
};
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
    String testInput = "Spr,11,CSCI 1240,1,\"EISENBERG, MICHAEL\",TTT,33,26,4.8,5.4,4.3,5,5,4.1,4.3,5.9,COMPUTATIONAL WORLD,4,6,5"
    CourseRecord record = courseRecordFromLine(testInput);

    assert record.getSemesterID() == 33;
    assert record.getInstructor() == "\"EISENBERG, MICHAEL\"";
    assert record.getFormsRequested() == 33;
    assert record.getFormsReturned() == 26;
    assert record.getCourseOverall() == 4.8f;
    assert record.getInstructorOverall() == 5.4f;
    assert record.getMinHoursWeek() == 4;
    assert record.getAvgHoursWeed() == 5;
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

    List<CourseRecord> testList = semesterRecord.get(33);
    assert checkPair(testList, "CSCI 1240", "CSCI 1241");

    List<CourseRecord> testList = semesterRecord.get(34);
    assert checkPair(testList, "CSCI 1242", "CSCI 1243");

    List<CourseRecord> testList = semesterRecord.get(35);
    assert checkPair(testList, "CSCI 1244", "CSCI 1245");

    List<CourseRecord> testList = semesterRecord.get(36);
    assert checkPair(testList, "CSCI 1246", "CSCI 1247");
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
final int INSTRUCTOR_NAME_INDEX = 4;
final int INSTRUCTOR_GROUP_INDEX = 5;
final int FORMS_REQUESTED_INDEX = 6;
final int FORMS_RETURNED_INDEX = 7;
final int COURSE_OVERALL_INDEX = 8;
final int INSTRUCTOR_OVERALL_INDEX = 9;
final int PRIOR_INTEREST_INDEX = 10;
final int INSTRUCTOR_EFFECTIVENESS_INDEX = 11;
final int AVAILABILITY_INDEX = 12;
final int CHALLENGE_INDEX = 13;
final int AMOUNT_LEARNED_INDEX = 14;
final int INSTRUCTOR_RESPECT_INDEX = 15;
final String CLASS_NAME_INDEX = 16;
final int MIN_HOURS_WEEK_INDEX = 17;
final int AVG_HOURS_WEEK_INDEX = 18;
final int MAX_HOURS_WEEK_INDEX = 19;

// Data support
public int semesterStrToInt(String name)
{
    if(name.equals(SPRING_STR))
        return SPRING_INT;
    else if(name.equals(SPRING_STR))
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
    return new Integer(classID.charAt(classID.length() - 1));
}

public CourseRecord courseRecordFromLine(String targetLine)
{
    String[] components = split(targetLine, ",");

    String semester = components[CLASS_SEM_INDEX];
    String className = components[CLASS_NAME_INDEX];
    int targetYear = new Integer(components[CLASS_YEAR_INDEX]);
    String instructor = components[INSTRUCTOR_NAME_INDEX];
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
        new HashMap<Integer, CourseRecord>();
    int targetListSize = targetList.size();

    for(CourseRecord target : targetList)
    {
        int semID = target.getSemesterID();

        if(!retMap.containsKey(semID))
            retMap.put(semID, new ArrayList<CourseRecord>());

        retMap.get(semID).add(target);
    }
}

public Map<Integer, CourseRecord> sortRecordsByCategory(List<CourseRecord> targetList)
{
    Map<Integer, List<CourseRecord>> retMap =
        new HashMap<Integer, CourseRecord>();
    int targetListSize = targetList.size();

    for(CourseRecord target : targetList)
    {
        int category = target.getCourseCategory();

        if(!retMap.containsKey(category))
            retMap.put(category, new ArrayList<CourseRecord>());

        retMap.get(category).add(target);
    }
}

public boolean floatIsInteger(float target)
{
    return index == Math.floor(index);
}

public float getValueInDistribution(List<Float> target, float index)
{
    if(floatIsInteger(index))
        return target.get(index);
    else
    {
        int closestIndex = Math.floor(index);
        float sum = target.get(closestIndex) + target.get(closestIndex + 1);
        return sum / 2;
    }
}

public Distribution getDistribtion(List<Float> target)
{
    Collections.sort(target);
    float q1Index = target.size() / 4.0f;
    float q2Index = q1Index * 2;
    float q3Index = q1Index * 3;

    return new Distribution(
        getValueInDistribution(target, q1Index),
        getValueInDistribution(target, q2Index),
        getValueInDistribution(target, q3Index)
    );
}

public List<Float> getRecordValues(List<CourseRecord> targetList, int attrID)
{
    List<Float> retList = new ArrayList<Float>(target.size());
    for(CourseRecord target : targetList)
        retList.add(target.getNumericalAttr(attrID));
    return retList;
}

public CourseSummary getCourseSummary(List<CourseRecord> target, int semesterID,
    String instructor, int courseCategory)
{
    Distribution formsRequestedDist = getDistribtion(
        getRecordValues(target, FORMS_REQUESTED_INDEX)
    );

    Distribution formsReturnedDist = getDistribtion(
        getRecordValues(target, FORMS_RETURNED_INDEX)
    );

    Distribution courseOverallDist = getDistribtion(
        getRecordValues(target, COURSE_OVERALL_INDEX)
    );

    Distribution instructorOverallDist = getDistribtion(
        getRecordValues(target, INSTRUCTOR_OVERALL_INDEX)
    );

    Distribution minHoursWeekDist = getDistribtion(
        getRecordValues(target, MIN_HOURS_WEEK_INDEX)
    );

    Distribution avgHoursWeekDist = getDistribtion(
        getRecordValues(target, AVG_HOURS_WEEK_INDEX)
    );

    Distribution maxHoursWeekDist = getDistribtion(
        getRecordValues(target, MAX_HOURS_WEEK_INDEX)
    );

    Distribution priorInterestDist = getDistribtion(
        getRecordValues(target, PRIOR_INTEREST_INDEX)
    );

    Distribution instructorEffectivenessDist = getDistribtion(
        getRecordValues(target, INSTRUCTOR_EFFECTIVENESS_INDEX)
    );

    Distribution availabilityDist = getDistribtion(
        getRecordValues(target, AVAILABILITY_INDEX)
    );

    Distribution challengeDist = getDistribtion(
        getRecordValues(target, CHALLENGE_INDEX)
    );

    Distribution amountLearnedDist = getDistribtion(
        getRecordValues(target, AMOUNT_LEARNED_INDEX)
    );

    Distribution respectDist = getDistribtion(
        getRecordValues(target, INSTRUCTOR_RESPECT_INDEX)
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
    Map<Integer, CourseRecord> coursesBySemester)
{
    FCQDataSet dataSet = new FCQDataSet();

    for(Integer semID : coursesBySemester.keySet())
    {
        List<CourseRecord> semCourses = coursesBySemester.get(semID);
        Map<Integer, List<CourseRecord>> coursesByCategory =
            sortRecordsByCategory(semCourses);

        for(Integer category : coursesByCategory)
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "proj4" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
