/**
 * Name: drawutil.pde
 * Auth: Sam Pottinger
 * Lisc: GPL v2
 * Desc: Functions that assist in converting underlying data sets to structures
 *       suitable for drawing.
**/

/**
 * Name: courseSummaryToPointSummary(
 *          Map<Integer, CourseSummary> summaries, int fieldID, int minValue,
 *          int maxValue, int minKey, int maxKey, int availWidth,
 *          int availHeight)
 * Desc: Conversts a course summary to coordinates representing its values
 *          centered on 0, 0.
 * Para: summaries, The summaries to create a PointSummary for.
 *       fieldID, The numerical ID of the field to create a summary for.
 *       minValue, The minimum value in the set of field values with the given 
 *          field ID.
 *       maxValue, The maximum value in the set of field values with the given 
 *          field ID.
 *       minKey, The minimum key value in the set (semester ID)
 *       maxKey, The maximum key value in the set (semester ID)
 *       availWidth, The width of the target display in pixels (to convert
 *          values to points).
 *       availHeight, The height of the target display in pixels (to convert
 *          values to points).
 * Retr: New PointSeries for the given semester to course mapping.
**/
PointSeries courseSummaryToPointSummary(
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

        float firstY = availHeight - valueConvFactor * (firstVal - minValue);
        float secondY = availHeight - valueConvFactor * (secondVal - minValue);
        float thirdY = availHeight - valueConvFactor * (thirdVal - minValue);

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

/**
 * Name: courseSummaryToPointSeries(
 *          Map<Integer, CourseSummary> summaries, int availWidth,
 *          int availHeight)
 * Desc: Convert a course summary to a point series with 2D coordinates.
 * Para: summaries, Mapping from mapping from categories to course summaries.
 *       availWidth, The width of the target display (in pixels).
 *       availHeight, The height of the target display (in pixels).
**/
LabeledPointSeriesSet courseSummaryToPointSeries(
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
        MIN_SEMESTER_ID,
        MAX_SEMESTER_ID,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(COURSE_OVERALL_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(
        summaries,
        INSTRUCTOR_OVERALL_PROP_ID,
        1,
        6,
        MIN_SEMESTER_ID,
        MAX_SEMESTER_ID,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(INSTRUCTOR_OVERALL_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(
        summaries,
        PRIOR_INTEREST_PROP_ID,
        1,
        6,
        MIN_SEMESTER_ID,
        MAX_SEMESTER_ID,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(PRIOR_INTEREST_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(
        summaries,
        INSTRUCTOR_EFFECTIVENESS_PROP_ID,
        1,
        6,
        MIN_SEMESTER_ID,
        MAX_SEMESTER_ID,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(INSTRUCTOR_EFFECTIVENESS_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(
        summaries,
        AVAILABILITY_PROP_ID,
        1,
        6,
        MIN_SEMESTER_ID,
        MAX_SEMESTER_ID,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(AVAILABILITY_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(
        summaries,
        CHALLENGE_PROP_ID,
        1,
        6,
        MIN_SEMESTER_ID,
        MAX_SEMESTER_ID,
        availWidth,
        availHeight);
    seriesSet.addSeries(CHALLENGE_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(summaries,
        AMOUNT_LEARNED_PROP_ID,
        1,
        6,
        MIN_SEMESTER_ID,
        MAX_SEMESTER_ID,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(AMOUNT_LEARNED_PROP_ID, newSeries);
    
    newSeries = courseSummaryToPointSummary(summaries,
        RESPECT_PROP_ID,
        1,
        6,
        MIN_SEMESTER_ID,
        MAX_SEMESTER_ID,
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
        MIN_SEMESTER_ID,
        MAX_SEMESTER_ID,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(MIN_HOURS_WEEK_PROP_ID, newSeries);

    newSeries = courseSummaryToPointSummary(
        summaries,
        AVG_HOURS_WEEK_PROP_ID,
        0,
        16,
        MIN_SEMESTER_ID,
        MAX_SEMESTER_ID,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(AVG_HOURS_WEEK_PROP_ID, newSeries);

    newSeries = courseSummaryToPointSummary(
        summaries,
        MAX_HOURS_WEEK_PROP_ID,
        0,
        16,
        MIN_SEMESTER_ID,
        MAX_SEMESTER_ID,
        availWidth,
        availHeight
    );
    seriesSet.addSeries(MAX_HOURS_WEEK_PROP_ID, newSeries);

    return seriesSet;
}

/**
 * Name: dataSetToPoints(SummarizedDataSet origDataSet, int availWidth,
 *          int availHeight)
 * Desc: Convert a data set to 2D coordinates.
 * Para: origDataSet, The data set to convert to coordinates.
 *       availWidth, The width in pixels of the target display (to convert
 *          points).
 *       availHeight, The height in pixels of the target display (to convert
 *          points).
 * Retr: Cooresponding coordinate representation of the provided data set.
**/
PointDataSet dataSetToPoints(SummarizedDataSet origDataSet, int availWidth,
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

/**
 * Name: courseSummaryToDichotomy(CourseSummary summary)
 * Desc: Get the dichotomy of the unergraduate and graduate courses in a course
 *       summary.
 * Para: summary, The summary to get the portions of undergrad and grad courses.
 * Retr: Dichotomy representing number of graduate and undergraduate courses in
 *       the given summary.
**/
Dichotomy courseSummaryToDichotomy(CourseSummary summary)
{
    return new Dichotomy(summary.getNumUndergrad(), summary.getNumGrad());
}

/**
 * Name: courseSummaryMapToDichotomySeries(Map<Integer, CourseSummary> target)
 * Desc: Convert mapping of semester IDs to course summaries to a series of
 *       dichotomies.
 * Para: target, The mapping of semester IDs to course summaries to convert.
**/
DichotomySeries courseSummaryMapToDichotomySeries(
    Map<Integer, CourseSummary> target)
{
    DichotomySeries newSeries = new DichotomySeries();
    for(Integer semID : target.keySet())
    {
        CourseSummary courseSummary = target.get(semID);
        Dichotomy newDichotomy = courseSummaryToDichotomy(courseSummary);
        newSeries.addDichotomy(semID, newDichotomy);
    }
    return newSeries;
}

/**
 * Name: dataSetToDichotomySeriesSet(SummarizedDataSet origDataSet)
 * Desc: Convert a data set to a dichotomy series of graduate and undergraduate
 *       courses.
 * Para: origDataSet, The data set to convert to dichotomies.
**/
LabeledDichotomySeriesSet dataSetToDichotomySeriesSet(
    SummarizedDataSet origDataSet)
{
    LabeledDichotomySeriesSet retSet = new LabeledDichotomySeriesSet();
    for(Integer category : origDataSet.getCategories())
    {
        DichotomySeries newSet = courseSummaryMapToDichotomySeries(
            origDataSet.getCategory(category));
        retSet.addDichotomySeries(category, newSet);
    }
    return retSet;
}

/**
 * Name: getMaxClassesInSeriesSet(LabeledDichotomySeriesSet target)
 * Desc: Get the maximum number of total classes represented in a single
 *       semester within a single category from a dichotomy series set.
 * Para: target, The dichotomy series set to scan through. 
 * Retr: The maximum number of courses in a single category for a single
 *       semseter.
**/
int getMaxClassesInSeriesSet(LabeledDichotomySeriesSet target)
{
    int maxFound = 0;
    for(DichotomySeries series : target.getSeriesCollection())
    {
        for(Dichotomy dichotomy : series.getDichotomies())
        {
            int curCount = (int)(dichotomy.getVal1() + dichotomy.getVal2());
            if(curCount > maxFound)
                maxFound = curCount;
        }
    }

    return maxFound;
}
