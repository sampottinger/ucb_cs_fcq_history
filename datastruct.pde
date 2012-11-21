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
};
