class Sparkline
{
    private PointSeries series;

    public Sparkline(PointSeries newSeries)
    {
        series = newSeries;
    }

    public void draw(int highlightedSemID)
    {
        // Set display options
        strokeWeight(1);
        noSmooth();
        noFill();

        // Render plot
        for(Integer semID : series.getSortedKeys())
        {
            PointSummary pointSummary = series.getSummary(semID);

            // Draw plot itself
            PVector firstQuartile = pointSummary.getFirstQuartile();
            PVector secondQuartile = pointSummary.getSecondQuartile();
            PVector thirdQuartile = pointSummary.getThirdQuartile();

            if(highlightedSemID == semID)
            {
                noStroke();
                fill(#C0C0C0);
                rectMode(CORNERS);
                rect(secondQuartile.x - 1, 0, secondQuartile.x + 1,
                    PLOT_HEIGHT);
                noFill();
            }

            stroke(#505050);
            line(firstQuartile.x, firstQuartile.y, secondQuartile.x,
                secondQuartile.y);
            line(secondQuartile.x, secondQuartile.y, thirdQuartile.x,
                thirdQuartile.y);
            stroke(#000000);
            rectMode(RADIUS);
            rect(secondQuartile.x, secondQuartile.y, 1, 1);
        }
    }
};

class DichotomyGraph
{
    private DichotomySeries dichotomySeries;
    private int maxClasses;
    private float classConversionFactor;
    private int minSemesterID;
    private int dispHeight;
    private float semConversionFactor;
    private int total;

    public DichotomyGraph(DichotomySeries newSeries, int newMaxClasses,
        int newHeight, int newMinSemesterID, int newMaxSemesterID,
        int dispWidth)
    {
        dichotomySeries = newSeries;
        maxClasses = newMaxClasses;
        minSemesterID = newMinSemesterID;
        classConversionFactor = newHeight / ((float)newMaxClasses);
        semConversionFactor =  dispWidth /
            (newMaxSemesterID - newMinSemesterID);
        dispHeight = newHeight;
    }

    public void draw(int highlightedSemID)
    {
        float highlightedVals = 0;
        float highlightedVal1 = 0;
        float highlightedVal2 = 0;

        // Set color and other display options
        strokeWeight(1);
        smooth();
        noFill();

        for(Integer semID : dichotomySeries.getSortedKeys())
        {
            pushMatrix();
            Dichotomy dichotomy = dichotomySeries.getDichotomy(semID);
            float effectiveSemID = semID - minSemesterID;
            
            translate(effectiveSemID * semConversionFactor, 0);

            float valOne = dichotomy.getVal1();
            float valTwo = dichotomy.getVal2();

            if(highlightedSemID == semID)
            {
                noStroke();
                fill(#E0E0E0);
                rectMode(CORNERS);
                rect(-2, 0, 2, dispHeight+2);
                noFill();

                highlightedVal1 = valOne;
                highlightedVal2 = valTwo;
                highlightedVals = valOne + valTwo;
            }

            float firstValOut = classConversionFactor * valOne;
            float secondValOut = classConversionFactor * valTwo;
            
            stroke(#000000);
            line(0, dispHeight, 0, dispHeight - firstValOut);
            
            stroke(#757575);
            line(0, dispHeight - firstValOut, 0,
                dispHeight - (firstValOut + secondValOut));
            
            popMatrix();
        }

        fill(#000000);
        String caption = String.format("%.0f entries\n%.0f ugrad\n%.0f grad",
            highlightedVals, highlightedVal1, highlightedVal2);
        text(caption, 0, 42);
    }
};

class MetricDisplay
{
    private Map<Integer, CourseSummary> category;
    private int displayWidth;
    private float generalConversionFactor;
    private float workConversionFactor;

    public MetricDisplay(Map<Integer, CourseSummary> newCategory,
        int newDisplayWidth)
    {
        category = newCategory;
        displayWidth = newDisplayWidth;
        generalConversionFactor = newDisplayWidth / 6.0;
        workConversionFactor = newDisplayWidth / 18.0;
    }

    public void draw(int highlightedSemID)
    {
        float firstQuartileDist;
        float secondQuartileDist;
        float thirdQuartileDist;

        CourseSummary selectedSummary = category.get(highlightedSemID);

        if(selectedSummary == null)
            return;

        CourseRecord firstQuartileRecord = selectedSummary.getFirstQuartile();
        CourseRecord secondQuartileRecord = selectedSummary.getSecondQuartile();
        CourseRecord thirdQuartileRecord = selectedSummary.getThirdQuartile();

        fill(#000000);
        smooth();

        pushMatrix();
        
        translate(0, 22);
        firstQuartileDist = firstQuartileRecord.getCourseOverall() *
            generalConversionFactor;
        secondQuartileDist = secondQuartileRecord.getCourseOverall() *
            generalConversionFactor;
        thirdQuartileDist = thirdQuartileRecord.getCourseOverall() *
            generalConversionFactor;
        stroke(#808080);
        strokeWeight(2);
        line(0, 2, secondQuartileDist, 2);
        stroke(#404040);
        strokeWeight(1);
        line(firstQuartileDist, 2, secondQuartileDist, 2);
        line(secondQuartileDist, 2, thirdQuartileDist, 2);
        text(String.format("Course Overall (%.1f)",
            secondQuartileRecord.getCourseOverall()), 0, 0);
        
        translate(0, 12);
        firstQuartileDist = firstQuartileRecord.getInstructorOverall() *
            generalConversionFactor;
        secondQuartileDist = secondQuartileRecord.getInstructorOverall() *
            generalConversionFactor;
        thirdQuartileDist = thirdQuartileRecord.getInstructorOverall() *
            generalConversionFactor;
        stroke(#808080);
        strokeWeight(2);
        line(0, 2, secondQuartileDist, 2);
        stroke(#404040);
        strokeWeight(1);
        line(firstQuartileDist, 2, secondQuartileDist, 2);
        line(secondQuartileDist, 2, thirdQuartileDist, 2);
        text(String.format("Inst. Overall (%.1f)",
            secondQuartileRecord.getInstructorOverall()), 0, 0);
        
        translate(0, 12);
        firstQuartileDist = firstQuartileRecord.getPriorInterest() *
            generalConversionFactor;
        secondQuartileDist = secondQuartileRecord.getPriorInterest() *
            generalConversionFactor;
        thirdQuartileDist = thirdQuartileRecord.getPriorInterest() *
            generalConversionFactor;
        stroke(#808080);
        strokeWeight(2);
        line(0, 2, secondQuartileDist, 2);
        stroke(#404040);
        strokeWeight(1);
        line(firstQuartileDist, 2, secondQuartileDist, 2);
        line(secondQuartileDist, 2, thirdQuartileDist, 2);
        text(String.format("Prior Interest (%.1f)",
            secondQuartileRecord.getPriorInterest()), 0, 0);
        
        translate(0, 12);
        firstQuartileDist = firstQuartileRecord.getInstructorEffectiveness() *
            generalConversionFactor;
        secondQuartileDist = secondQuartileRecord.getInstructorEffectiveness() *
            generalConversionFactor;
        thirdQuartileDist = thirdQuartileRecord.getInstructorEffectiveness() *
            generalConversionFactor;
        stroke(#808080);
        strokeWeight(2);
        line(0, 2, secondQuartileDist, 2);
        stroke(#404040);
        strokeWeight(1);
        line(firstQuartileDist, 2, secondQuartileDist, 2);
        line(secondQuartileDist, 2, thirdQuartileDist, 2);
        text(String.format("Inst. Effect. (%.1f)",
            secondQuartileRecord.getInstructorEffectiveness()), 0, 0);
        
        translate(0, 12);
        firstQuartileDist = firstQuartileRecord.getAvailability() *
            generalConversionFactor;
        secondQuartileDist = secondQuartileRecord.getAvailability() *
            generalConversionFactor;
        thirdQuartileDist = thirdQuartileRecord.getAvailability() *
            generalConversionFactor;
        stroke(#808080);
        strokeWeight(2);
        line(0, 2, secondQuartileDist, 2);
        stroke(#404040);
        strokeWeight(1);
        line(firstQuartileDist, 2, secondQuartileDist, 2);
        line(secondQuartileDist, 2, thirdQuartileDist, 2);
        text(String.format("Inst. Avail. (%.1f)",
            secondQuartileRecord.getAvailability()), 0, 0);
        
        translate(0, 12);
        firstQuartileDist = firstQuartileRecord.getChallenge() *
            generalConversionFactor;
        secondQuartileDist = secondQuartileRecord.getChallenge() *
            generalConversionFactor;
        thirdQuartileDist = thirdQuartileRecord.getChallenge() *
            generalConversionFactor;
        stroke(#808080);
        strokeWeight(2);
        line(0, 2, secondQuartileDist, 2);
        stroke(#404040);
        strokeWeight(1);
        line(firstQuartileDist, 2, secondQuartileDist, 2);
        line(secondQuartileDist, 2, thirdQuartileDist, 2);
        text(String.format("Challenge (%.1f)",
            secondQuartileRecord.getChallenge()), 0, 0);
        popMatrix();

        pushMatrix();
        
        translate(120, 22);
        firstQuartileDist = firstQuartileRecord.getAmountLearned() *
            generalConversionFactor;
        secondQuartileDist = secondQuartileRecord.getAmountLearned() *
            generalConversionFactor;
        thirdQuartileDist = thirdQuartileRecord.getAmountLearned() *
            generalConversionFactor;
        stroke(#808080);
        strokeWeight(2);
        line(0, 2, secondQuartileDist, 2);
        stroke(#404040);
        strokeWeight(1);
        line(firstQuartileDist, 2, secondQuartileDist, 2);
        line(secondQuartileDist, 2, thirdQuartileDist, 2);
        text(String.format("Amt. Learned (%.1f)",
            secondQuartileRecord.getAmountLearned()), 0, 0);
        
        translate(0, 12);
        firstQuartileDist = firstQuartileRecord.getInstructorEffectiveness() *
            generalConversionFactor;
        secondQuartileDist = secondQuartileRecord.getInstructorEffectiveness() *
            generalConversionFactor;
        thirdQuartileDist = thirdQuartileRecord.getInstructorEffectiveness() *
            generalConversionFactor;
        stroke(#808080);
        strokeWeight(2);
        line(0, 2, secondQuartileDist, 2);
        stroke(#404040);
        strokeWeight(1);
        line(firstQuartileDist, 2, secondQuartileDist, 2);
        line(secondQuartileDist, 2, thirdQuartileDist, 2);
        text(String.format("Inst. Respect (%.1f)",
            secondQuartileRecord.getInstructorEffectiveness()), 0, 0);
        
        translate(0, 12);
        firstQuartileDist = firstQuartileRecord.getMinHoursWeek() *
            workConversionFactor;
        secondQuartileDist = secondQuartileRecord.getMinHoursWeek() *
            workConversionFactor;
        thirdQuartileDist = thirdQuartileRecord.getMinHoursWeek() *
            workConversionFactor;
        stroke(#808080);
        strokeWeight(2);
        line(0, 2, secondQuartileDist, 2);
        stroke(#404040);
        strokeWeight(1);
        line(firstQuartileDist, 2, secondQuartileDist, 2);
        line(secondQuartileDist, 2, thirdQuartileDist, 2);
        text(String.format("Min Hrs / Week (%.1f)",
            secondQuartileRecord.getMinHoursWeek()), 0, 0);
        
        translate(0, 12);
        firstQuartileDist = firstQuartileRecord.getAvgHoursWeek() *
            workConversionFactor;
        secondQuartileDist = secondQuartileRecord.getAvgHoursWeek() *
            workConversionFactor;
        thirdQuartileDist = thirdQuartileRecord.getAvgHoursWeek() *
            workConversionFactor;
        stroke(#808080);
        strokeWeight(2);
        line(0, 2, secondQuartileDist, 2);
        stroke(#404040);
        strokeWeight(1);
        line(firstQuartileDist, 2, secondQuartileDist, 2);
        line(secondQuartileDist, 2, thirdQuartileDist, 2);
        text(String.format("Avg Hrs / Week (%.1f)",
            secondQuartileRecord.getAvgHoursWeek()), 0, 0);
        
        translate(0, 12);
        firstQuartileDist = firstQuartileRecord.getMaxHoursWeek() *
            workConversionFactor;
        secondQuartileDist = secondQuartileRecord.getMaxHoursWeek() *
            workConversionFactor;
        thirdQuartileDist = thirdQuartileRecord.getMaxHoursWeek() *
            workConversionFactor;
        stroke(#808080);
        strokeWeight(2);
        line(0, 2, secondQuartileDist, 2);
        stroke(#404040);
        strokeWeight(1);
        line(firstQuartileDist, 2, secondQuartileDist, 2);
        line(secondQuartileDist, 2, thirdQuartileDist, 2);
        text(String.format("Max Hrs / Week (%.1f)",
            secondQuartileRecord.getMaxHoursWeek()), 0, 0);
        popMatrix();
    }
};
