/**
 * Name: datastruct.pde
 * Auth: Sam Pottinger
 * Lisc: GPL v2
 * Desc: Different data representations for FCQ results.
**/

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

/**
 * Name: CourseRecord
 * Desc: Raw record of a course's FCQ results.
**/
class CourseRecord
{
    // Member attributes
    private int classSemesterID;
    private String classID;
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

    /**
     * Name: CourseRecord(int newSemesterID, String newClassID, String newName,
     *          String newInstructor, float newFormsRequested,
     *          float newFormsReturned, float newCourseOverall,
     *          float newInstructorOverall, float newMinHoursWeek,
     *          float newAvgHoursWeek, float newMaxHoursWeek,
     *          float newPriorInterest, float newInstructorEffectiveness,
     *          float newAvailability, float newChallenge,
     *          float newAmountLearned, float newRespect, int newCourseCategory)
     * Desc: Terrifically awful constructor for a CourseRecord with raw values.
     * Para: newSemesterID, The unique numerical id of the semester that this
     *          course ran in.
     *       newClassID, The string class identifier (CSCI 1300 for example)
     *       newName, The human readable name of this course (Intro to
     *          Programming for example).
     *       newInstructor, The name of the instructor (Main, Michael for
     *          example).
     *       newFormsRequested, The number of forms requested for the FCQ.
     *       newFormsReturned, The number of forms returned for the FCQ.
     *       newCourseOverall, The course overall raiting from the FCQ.
     *       newInstructorOverall, Overall raiting for the instructor for the
     *          FCQ.
     *       newMinHoursWeek, The minimum weekly work load reported.
     *       newAvgHoursWeek, The average weekly work load reported.
     *       newMaxHoursWeek, The maximum weekly work load reported.
     *       newPriorInterest, Prior interest of students reported on FCQ.
     *       newInstructorEffectiveness, The effectiveness raiting from the FCQ.
     *       newAvailability, Professor availability raiting from the FCQ.
     *       newChallenge, The challenge of the course as rated on the FCQ.
     *       newAmountLearned, The amount learned from this course as reported
     *          on the FCQ.
     *       newRespect, Instructor respect raiting reported on the FCQ.
     *       newCourseCategory, The identifier for the category this course
     *          falls under.
    **/
    public CourseRecord(
        int newSemesterID,
        String newClassID,
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
        classID = newClassID;
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

    /**
     * Name: getSemesterID()
     * Desc: Get the unique identifier for the semester this course ran in.
    **/
    public int getSemesterID()
    {
        return classSemesterID;
    }

    /**
     * Name: getClassID()
     * Desc: Get the string short identifier for this class (ex. CSCI 1300)
    **/
    public String getClassID()
    {
        return classID;
    }

    /**
     * Name: getName()
     * Desc: Get the human readable name for this class (ex. Intro to
     *       Programming)
    **/
    public String getName()
    {
        return name;
    }

    /**
     * Name: getInstructor()
     * Desc: Get the name of instructor for this class (ex. Main, Micheal)
    **/
    public String getInstructor()
    {
        return instructor;
    }

    /**
     * Name: getFormsRequested()
     * Desc: Get the number of FCQ forms requested for this course.
    **/
    public float getFormsRequested()
    {
        return formsRequested;
    }

    /**
     * Name: getFormsReturned()
     * Desc: Get the number of FCQ forms returned for this course.
    **/
    public float getFormsReturned()
    {
        return formsReturned;
    }

    /**
     * Name: getCourseOverall()
     * Desc: Get the overall course raiting reported on FCQs for this course.
    **/
    public float getCourseOverall()
    {
        return courseOverall;
    }

    /**
     * Name: getInstructorOverall()
     * Desc: Get the overall instructor raiting from FCQs for this course.
    **/
    public float getInstructorOverall()
    {
        return instructorOverall;
    }

    /**
     * Name: getMinHoursWeek()
     * Desc: Get the minimum weekly work load reported on FCQs for this course.
    **/
    public float getMinHoursWeek()
    {
        return minHoursWeek;
    }

    /**
     * Name: getAvgHoursWeek()
     * Desc: Get the average weekly work load reported on FCQs for this course.
    **/
    public float getAvgHoursWeek()
    {
        return avgHoursWee;
    }

    /**
     * Name: getMaxHoursWeek()
     * Desc: Get the maximum weekly work load reported on FCQs for this course.
    **/
    public float getMaxHoursWeek()
    {
        return maxHoursWeek;
    }

    /**
     * Name: getPriorInterest()
     * Desc: Get student prior interest reported on FCQs for this course.
    **/
    public float getPriorInterest()
    {
        return priorInterest;
    }

    /**
     * Name: getAvailability()
     * Desc: Get instructor availability score reported on FCQs.
    **/
    public float getAvailability()
    {
        return availability;
    }

    /**
     * Name: getChallenge()
     * Desc: Get the challenege score reported on FCQs.
    **/
    public float getChallenge()
    {
        return challenge;
    }

    /**
     * Name: getAmountLearned()
     * Desc: Get student reported amount learned in course from FCQs.
    **/
    public float getAmountLearned()
    {
        return amountLearned;
    }

    /**
     * Name: getRespect()
     * Desc: Get instructor respect raiting from FCQ results.
    **/
    public float getRespect()
    {
        return respect;
    }

    /**
     * Name: getCourseCategory()
     * Desc: Get the category this course is in within the CS dept.
     * Retr: Integer constant of category this course is in.
    **/
    public int getCourseCategory()
    {
        return courseCategory;
    }
    
    /**
     * Name: getInstructorEffectiveness()
     * Desc: Get the instructor effectiveness score from FCQ results.
    **/
    public float getInstructorEffectiveness()
    {
        return instructorEffectiveness;
    }

    /**
     * Name: getNumericalAttr(int id)
     * Desc: Get a field from this course's FCQ results from a field id.
     * Para: id, The integer ID of the attribute to read.
     * Retr: Value of attribute with given numerical id.
    **/
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

/**
 * Name: CourseSummary
 * Desc: Summary of a category of courses in a semester
**/
class CourseSummary
{
    private CourseRecord firstQuartile;
    private CourseRecord secondQuartile;
    private CourseRecord thirdQuartile;
    private int numUndergrad;
    private int numGrad;

    /**
     * Name: CourseSummary(CourseRecord newFirstQuartile,
     *          CourseRecord newSecondQuartile, CourseRecord newThirdQuartile,
     *          int newNumUndergrad, int newNumGrad)
     * Desc: Creates a new course summary.
     * Para: newFirstQuartile, CourseRecord representing the first quartile of
     *          the underlying data set (record with first quartile of each FCQ
     *          metric).
     *       newSecondQuartile, CourseRecord representing the second quartile of
     *          the underlying data set (record with second quartile of each FCQ
     *          metric).
     *       newThirdQuartile, CourseRecord representing the third quartile of
     *          the underlying data set (record with third quartile of each FCQ
     *          metric).
     *       newNumUndergrad, The number of undergraduate courses in the
     *          underlying data set.
     *       newNumGrad, The number of gradaute courses in the underlying data
     *          set.
    **/
    public CourseSummary(CourseRecord newFirstQuartile,
        CourseRecord newSecondQuartile, CourseRecord newThirdQuartile,
        int newNumUndergrad, int newNumGrad)
    {
        firstQuartile = newFirstQuartile;
        secondQuartile = newSecondQuartile;
        thirdQuartile = newThirdQuartile;
        numUndergrad = newNumUndergrad;
        numGrad = newNumGrad;
    }

    /**
     * Name: getFirstQuartile()
     * Desc: Get a course record with the first quartile values of underlying
     *       data set.
    **/
    public CourseRecord getFirstQuartile()
    {
        return firstQuartile;
    }

    /**
     * Name: getSecondQuartile()
     * Desc: Get a course record with the second quartile values of underlying
     *       data set.
    **/
    public CourseRecord getSecondQuartile()
    {
        return secondQuartile;
    }

    /**
     * Name: getThirdQuartile()
     * Desc: Get a course record with the third quartile values of underlying
     *       data set.
    **/
    public CourseRecord getThirdQuartile()
    {
        return thirdQuartile;
    }

    /**
     * Name: getNumUndergrad()
     * Desc: Get the number of undergraduate coureses in the underlying data
     *       set.
    **/
    public int getNumUndergrad()
    {
        return numUndergrad;
    }

    /**
     * Name: getNumGrad()
     * Desc: Get the number of undergraduate courses in the underlying data set.
    **/
    public int getNumGrad()
    {
        return numGrad;
    }

};

/**
 * Name: Distribution
 * Desc: Represents a structure for first, second, and third quartiles from a
 *       data set of floating point values.
**/
class Distribution
{
    private float firstQuartile;
    private float secondQuartile;
    private float thirdQuartile;

    /**
     * Name: Distribution(float newFirstQuartile, float newSecondQuartile,
     *          float newThirdQuartile)
     * Desc: Create a new record of first, second, and third quartiles from a
     *       data set of floating point values.
    **/
    public Distribution(float newFirstQuartile, float newSecondQuartile,
        float newThirdQuartile)
    {
        firstQuartile = newFirstQuartile;
        secondQuartile = newSecondQuartile;
        thirdQuartile = newThirdQuartile;
    }

    /**
     * Name: getFirstQuartile()
     * Desc: Get the value fo the first quartile for the underlying data set.
    **/
    public float getFirstQuartile()
    {
        return firstQuartile;
    }

    /**
     * Name: getSecondQuartile()
     * Desc: Get the value fo the second quartile for the underlying data set.
    **/
    public float getSecondQuartile()
    {
        return secondQuartile;
    }

    /**
     * Name: getThirdQuartile()
     * Desc: Get the value fo the third quartile for the underlying data set.
    **/
    public float getThirdQuartile()
    {
        return thirdQuartile;
    }

};

/**
 * Name: SummarizedDataSet
 * Desc: Structure holding categories and their semester information (category
 *       with semesters with course summaries)
**/
class SummarizedDataSet
{
    // <category, <semesterID, summary>>
    private Map<Integer, Map<Integer, CourseSummary>> categoryMap;

    /**
     * Name: SummarizedDataSet()
     * Desc: Creates a new empty structure for a data set of categories and 
     *       their semesters.
    **/
    public SummarizedDataSet()
    {
        categoryMap = new HashMap<Integer, Map<Integer, CourseSummary>>();
    }

    /**
     * Name: addSummary(int semesterID, int category, CourseSummary summary)
     * Desc: Adds a new course summary to this data set.
     * Para: semesterID, the unqiue integer of the ID of the semester this
     *           summary is for.
     *       category, The ID of the category that this summary falls under.
     *       summary, The summary of the course beinga dded to this data set.
    **/
    public void addSummary(int semesterID, int category, CourseSummary summary)
    {
        if(!categoryMap.containsKey(category))
            categoryMap.put(category, new HashMap<Integer, CourseSummary>());
        Map<Integer, CourseSummary> semesterMap = categoryMap.get(category);
        semesterMap.put(semesterID, summary);
    }

    /**
     * Name: getCategory(int category)
     * Desc: Get a category from this data set.
     * Retr: Collection of semesters and course summaries for those semesters.
    **/
    public Map<Integer, CourseSummary> getCategory(int category)
    {
        return categoryMap.get(category);
    }

    /**
     * Name: getCategories()
     * Desc: Get the IDs of the categories in this data set.
    **/
    public Set<Integer> getCategories()
    {
        return categoryMap.keySet();
    }
};
