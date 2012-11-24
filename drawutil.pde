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

Dichotomy courseSummaryToDichotomy(CourseSummary summary)
{
    return new Dichotomy(summary.getNumUndergrad(), summary.getNumGrad());
}

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
