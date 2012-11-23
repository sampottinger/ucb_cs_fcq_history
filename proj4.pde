final String DATA_FILE_LOC = "cs_fcq.csv";
final int PLOT_WIDTH = 70;
final int SPARKLINE_HORIZ_PADDING = 10;
final int PLOT_HEIGHT = 60;
final int CATEGORY_VERT_PADDING = 10;
final int WIDTH = 1000;
final int HEIGHT = 560;

List<CourseRecord> courseRecords;

PointDataSet pointDataSet;
Sparkline testSparkline;
Map<Integer, List<Sparkline>> sparklines;

List<Sparkline> prepareSparklinesForCategory(LabeledPointSeriesSet seriesSet)
{
    List<Sparkline> sparklines = new ArrayList<Sparkline>();
    Sparkline newSparkline;
    PointSeries curSeries;

    curSeries = seriesSet.getSeries(COURSE_OVERALL_PROP_ID);
    newSparkline = new Sparkline(curSeries);
    sparklines.add(newSparkline);

    curSeries = seriesSet.getSeries(INSTRUCTOR_OVERALL_PROP_ID);
    newSparkline = new Sparkline(curSeries);
    sparklines.add(newSparkline);

    curSeries = seriesSet.getSeries(PRIOR_INTEREST_PROP_ID);
    newSparkline = new Sparkline(curSeries);
    sparklines.add(newSparkline);

    curSeries = seriesSet.getSeries(INSTRUCTOR_EFFECTIVENESS_PROP_ID);
    newSparkline = new Sparkline(curSeries);
    sparklines.add(newSparkline);

    curSeries = seriesSet.getSeries(AVAILABILITY_PROP_ID);
    newSparkline = new Sparkline(curSeries);
    sparklines.add(newSparkline);

    curSeries = seriesSet.getSeries(CHALLENGE_PROP_ID);
    newSparkline = new Sparkline(curSeries);
    sparklines.add(newSparkline);

    curSeries = seriesSet.getSeries(AMOUNT_LEARNED_PROP_ID);
    newSparkline = new Sparkline(curSeries);
    sparklines.add(newSparkline);

    curSeries = seriesSet.getSeries(RESPECT_PROP_ID);
    newSparkline = new Sparkline(curSeries);
    sparklines.add(newSparkline);

    curSeries = seriesSet.getSeries(MIN_HOURS_WEEK_PROP_ID);
    newSparkline = new Sparkline(curSeries);
    sparklines.add(newSparkline);

    curSeries = seriesSet.getSeries(AVG_HOURS_WEEK_PROP_ID);
    newSparkline = new Sparkline(curSeries);
    sparklines.add(newSparkline);

    curSeries = seriesSet.getSeries(MAX_HOURS_WEEK_PROP_ID);
    newSparkline = new Sparkline(curSeries);
    sparklines.add(newSparkline);

    return sparklines;
}

HashMap<Integer, List<Sparkline>> prepareSparklines(PointDataSet dataSet)
{
    HashMap<Integer, List<Sparkline>> sparklines =
        new HashMap<Integer, List<Sparkline>>();
    LabeledPointSeriesSet curSet;
    List<Sparkline> newSparklines;

    curSet = dataSet.getSeriesSet(GENERAL_COMP_SCI_CATEGORY);
    newSparklines = prepareSparklinesForCategory(curSet);
    sparklines.put(GENERAL_COMP_SCI_CATEGORY, newSparklines);

    curSet = dataSet.getSeriesSet(AI_CATEGORY);
    newSparklines = prepareSparklinesForCategory(curSet);
    sparklines.put(AI_CATEGORY, newSparklines);

    curSet = dataSet.getSeriesSet(OS_AND_HARDWARE_CATEGORY);
    newSparklines = prepareSparklinesForCategory(curSet);
    sparklines.put(OS_AND_HARDWARE_CATEGORY, newSparklines);

    curSet = dataSet.getSeriesSet(THEORY_OF_COMPUTATION_CATEGORY);
    newSparklines = prepareSparklinesForCategory(curSet);
    sparklines.put(THEORY_OF_COMPUTATION_CATEGORY, newSparklines);

    curSet = dataSet.getSeriesSet(PROGRAMMING_LANGUAGES_CATEGORY);
    newSparklines = prepareSparklinesForCategory(curSet);
    sparklines.put(PROGRAMMING_LANGUAGES_CATEGORY, newSparklines);

    curSet = dataSet.getSeriesSet(NUMERICAL_COMP_CATEGORY);
    newSparklines = prepareSparklinesForCategory(curSet);
    sparklines.put(NUMERICAL_COMP_CATEGORY, newSparklines);

    curSet = dataSet.getSeriesSet(DATABASE_CATEGORY);
    newSparklines = prepareSparklinesForCategory(curSet);
    sparklines.put(DATABASE_CATEGORY, newSparklines);

    curSet = dataSet.getSeriesSet(SOFTWARE_ENG_CATEGORY);
    newSparklines = prepareSparklinesForCategory(curSet);
    sparklines.put(SOFTWARE_ENG_CATEGORY, newSparklines);

    return sparklines;
}

void setup()
{
    size(WIDTH, HEIGHT);
    SummarizedDataSet summarizedDataSet = getDataSetFromFile(DATA_FILE_LOC);
    pointDataSet = dataSetToPoints(summarizedDataSet,
        PLOT_WIDTH, PLOT_HEIGHT);
    sparklines = prepareSparklines(pointDataSet);
    frameRate(30);
}

void draw()
{
    // Clear
    noStroke();
    fill(#FFFFFF);
    rectMode(CORNERS);
    rect(0, 0, WIDTH, HEIGHT);

    // Sparklines
    pushMatrix();
    for(Integer category : sparklines.keySet())
    {
        List<Sparkline> categorySparklines = sparklines.get(category);
        translate(0, CATEGORY_VERT_PADDING);
        pushMatrix();
        for(Sparkline sparkline : categorySparklines)
        {
            translate(SPARKLINE_HORIZ_PADDING, 0);
            sparkline.draw();
            translate(SPARKLINE_HORIZ_PADDING, 0);
            translate(PLOT_WIDTH, 0);
        }
        popMatrix();
        translate(0, PLOT_HEIGHT);
        translate(0, CATEGORY_VERT_PADDING);
    }
    popMatrix();
}