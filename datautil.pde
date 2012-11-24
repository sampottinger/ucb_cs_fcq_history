// Semester mapping
final int SPRING_INT = 0;
final int SUMMER_INT = 1;
final int FALL_INT = 2;
final int NUM_SEMESTERS = 3;
final int MIN_SEMESTER_ID = 20;
final int MAX_SEMESTER_ID = 36;
final int UNKNOWN_SEMESTER_INT = -1;
final String SPRING_STR = "Spr";
final String SUMMER_STR = "Sum";
final String FALL_STR = "Fall";
final String UNKNOWN_SEMESTER_STR = "Unknown";

// Course categories
final int GENERAL_COMP_SCI_CATEGORY = 0;
final int AI_CATEGORY = 2;
final int OS_AND_HARDWARE_CATEGORY = 3;
final int THEORY_OF_COMPUTATION_CATEGORY = 4;
final int PROGRAMMING_LANGUAGES_CATEGORY = 5;
final int NUMERICAL_COMP_CATEGORY = 6;
final int DATABASE_CATEGORY = 7;
final int SOFTWARE_ENG_CATEGORY = 8;
final int GRAPHICS_CATEGORY = 9;

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
int semesterStrToInt(String name)
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

int semesterAndYearToSemesterID(int targetYear, int targetSemester)
{
    return targetYear * NUM_SEMESTERS + targetSemester;
}

int classIDToCategory(String classID)
{
    return new Integer(classID.substring(classID.length() - 1, classID.length()));
}

CourseRecord courseRecordFromLine(String targetLine)
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
        classID,
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

Map<Integer, List<CourseRecord>> sortRecordsBySemester(List<CourseRecord> targetList)
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

Map<Integer, List<CourseRecord>> sortRecordsByCategory(List<CourseRecord> targetList)
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

boolean floatIsInteger(float target)
{
    return target == Math.floor(target);
}

float safeGet(List<Float> target, int index)
{
    if(index < 0)
        index = 0;
    if(index >= target.size())
        index = target.size() - 1;
    return target.get(index);
}

float getValueInDistribution(List<Float> target, float index)
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

Distribution getDistribution(List<Float> target)
{
    Collections.sort(target);

    float q1Index;
    float q2Index;
    float q3Index;
    
    q1Index = (target.size() + 1) / 4.0;
    q2Index = (target.size() + 1) / 2.0;
    q3Index = (target.size() + 1) / 4.0 * 3;

    return new Distribution(
        getValueInDistribution(target, q1Index - 1),
        getValueInDistribution(target, q2Index - 1),
        getValueInDistribution(target, q3Index - 1)
    );
}

List<Float> getRecordValues(List<CourseRecord> targetList, int attrID)
{
    List<Float> retList = new ArrayList<Float>(targetList.size());
    for(CourseRecord target : targetList)
        retList.add(target.getNumericalAttr(attrID));
    return retList;
}

CourseSummary getCourseSummary(List<CourseRecord> target, int semesterID,
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
        "",
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
        "",
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
        "",
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

    int numUgrad = 0;
    int numGrad = 0;
    for(CourseRecord record : target)
    {
        String classID = record.getClassID();
        int courseNumber = new Integer(classID.substring(5));
        if(courseNumber < 5000)
            numUgrad++;
        else
            numGrad++;
    }

    return new CourseSummary(firstQuartile, secondQuartile, thirdQuartile,
        numUgrad, numGrad);
}

SummarizedDataSet summarizeSemesters(
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

List<CourseRecord> getRecordsFromLines(String[] lines)
{
    ArrayList<CourseRecord> retList = new ArrayList<CourseRecord>();
    int numLines = lines.length;
    for(int i=0; i<numLines; i++)
        retList.add(courseRecordFromLine(lines[i]));
    return retList;
}

List<CourseRecord> getRecordsFromFile(String loc)
{
    return getRecordsFromLines(loadStrings(loc));
}

SummarizedDataSet getDataSetFromFile(String loc)
{
    List<CourseRecord> records = getRecordsFromFile(loc);
    Map<Integer, List<CourseRecord>> recordsBySemester =
        sortRecordsBySemester(records);
    return summarizeSemesters(recordsBySemester);
}
