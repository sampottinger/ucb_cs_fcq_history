/**
 * Name: datautil.pde
 * Auth: Sam Pottinger
 * Lisc: GPL v2
 * Desc: Functions with logic for performing transformations between data
 *       structures.
**/

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

/**
 * Name: semesterStrToInt(String name)
 * Desc: Get the integer ID of a semester without its year/
**/
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

/**
 * Name: semesterAndYearToSemesterID(int targetYear, int targetSemester)
 * Desc: Get a unqiue numerical ID of a semester.
**/
int semesterAndYearToSemesterID(int targetYear, int targetSemester)
{
    return targetYear * NUM_SEMESTERS + targetSemester;
}

/**
 * Name: classIDToCategory(String classID)
 * Desc: Get the integer ID of the category of a class given its short name
 * Para: classID, the ID of the course to get a class ID for (classID = CSCI
 *       1300 for example).
**/
int classIDToCategory(String classID)
{
    return new Integer(classID.substring(classID.length() - 1,
        classID.length()));
}

/**
 * Name: courseRecordFromLine(String targetLine)
 * Desc: Read a course record from a line in a CSV file.
**/
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

/**
 * Name: sortRecordsBySemester(List<CourseRecord> targetList)
 * Desc: Sort a collection of course records into a mapping between semester and
 *       courses.
 * Para: targetList, The reocrds to sort.
**/
Map<Integer, List<CourseRecord>> sortRecordsBySemester(
    List<CourseRecord> targetList)
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

/**
 * Name: sortRecordsByCategory(List<CourseRecord> targetList)
 * Desc: Sort course records into a mapping between category and courses.
 * Para: targetList, The collection of course records to sort.
**/
Map<Integer, List<CourseRecord>> sortRecordsByCategory(
    List<CourseRecord> targetList)
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

/**
 * Name: floatIsInteger(float target)
 * Desc: Determine if a floating point number is a whole number or not.
 * Retr: True if it is a whole number and false otherwise.
**/ 
boolean floatIsInteger(float target)
{
    return target == Math.floor(target);
}

/**
 * Name: safeGet(List<Float> target, int index)
 * Desc: Get a value from the given list, forcing the index within range. If the
 *       provided index is larger than the size of the list, return the last
 *       element and, if the index is less than zero, the first element is
 *       returned.
 * Para: target, The list to get a value from.
 *       index, The index of the element to get.
**/
float safeGet(List<Float> target, int index)
{
    if(index < 0)
        index = 0;
    if(index >= target.size())
        index = target.size() - 1;
    return target.get(index);
}

/**
 * Name: getValueInDistribution(List<Float> target, float index)
 * Desc: Get the element at the index closest to the provided index.
 * Para: index, The index of the element to get, getting the element with the
 *          nearest available index to the provided one.
 * Retr: The element with the closest available index to the one provided.
**/
float getValueInDistribution(List<Float> target, float index)
{
    if(floatIsInteger(index))
        return target.get((int)index);
    else
    {
        int closestIndex = (int)Math.floor(index);
        float m = safeGet(target, closestIndex + 1) -
            safeGet(target, closestIndex);
        return m * (index - closestIndex) + safeGet(target, closestIndex);
    }
}

/**
 * Name: getDistribution(List<Float> target)
 * Desc: Get the first, second, and third quartiles from the given collection of
 *       floats.
 * Retr: Distribution containing element quartiles.
**/
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

/**
 * Name: getRecordValues(List<CourseRecord> targetList, int attrID)
 * Desc: Get the values of an attribute across a collection of course records.
 * Para: targetList, The collection of course records to pull the attribute
 *          from.
 *       attrID, the unique numerical ID of the field to read across all of the
 *          provided course records.
**/
List<Float> getRecordValues(List<CourseRecord> targetList, int attrID)
{
    List<Float> retList = new ArrayList<Float>(targetList.size());
    for(CourseRecord target : targetList)
        retList.add(target.getNumericalAttr(attrID));
    return retList;
}

// TODO: Assigning distribution information to CourseRecords seems really
//       kludgy.
/**
 * Name: getCourseSummary(List<CourseRecord> target, int semesterID,
 *          String instructor, int courseCategory)
 * Desc: Summarize a collection of course records values, getting distributions
 *          for all of the fields of the course records in the given collection.
 * Para: target, The collection of course records to get distributions from.
 *       semesterID, The semester IDs to assign to the course records that will
 *          contain distribution information (quartiles).
 *       instructor, The instructor to assign to the course records that will
 *          contain distribution information (quartiles).
 *       courseCategory, The category to assign to the course records that will
 *          contain distribution informaiton (quartiles).
**/
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

/**
 * Name: summarizeSemesters(Map<Integer, List<CourseRecord>> coursesBySemester)
 * Desc: Sort courses from a set of semesters into categories with semester
 *       to course mappings.
 * Para: coursesBySemester, The mapping of semester IDs to collections of
 *          course records to sort.
**/
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

/**
 * Name: getRecordsFromLines(String[] lines)
 * Desc: Get CourseRecords from CSV lines.
**/
List<CourseRecord> getRecordsFromLines(String[] lines)
{
    ArrayList<CourseRecord> retList = new ArrayList<CourseRecord>();
    int numLines = lines.length;
    for(int i=0; i<numLines; i++)
        retList.add(courseRecordFromLine(lines[i]));
    return retList;
}

/**
 * Name: getRecordsFromFile(String loc)
 * Desc: Load course records from a CSV file.
**/
List<CourseRecord> getRecordsFromFile(String loc)
{
    return getRecordsFromLines(loadStrings(loc));
}

/**
 * Name: getDataSetFromFile(String loc)
 * Desc: Load a summarized data set from a file.
**/
SummarizedDataSet getDataSetFromFile(String loc)
{
    List<CourseRecord> records = getRecordsFromFile(loc);
    Map<Integer, List<CourseRecord>> recordsBySemester =
        sortRecordsBySemester(records);
    return summarizeSemesters(recordsBySemester);
}
