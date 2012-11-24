final String DATA_FILE_LOC = "cs_fcq.csv";
final int PLOT_WIDTH = 60;
final int SPARKLINE_HORIZ_PADDING = 10;
final int PLOT_HEIGHT = 60;
final int CATEGORY_VERT_PADDING = 17;
final int WIDTH = 1200;
final int HEIGHT = 680;

List<CourseRecord> courseRecords;

PointDataSet pointDataSet;
Sparkline testSparkline;
Map<Integer, List<Sparkline>> sparklines;
LabeledDichotomySeriesSet populationDichotomySet;
int maxClassesInSeries;
List<DichotomyGraph> dichotomyGraphs;
boolean redrawRequired = true;
int selectedSemID;
List<MetricDisplay> metricDisplays;

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

List<DichotomyGraph> prepareDichotomyGraphs(
    LabeledDichotomySeriesSet populationDichotomySet, int maxClassesInSeries)
{
    List<DichotomyGraph> retList = new ArrayList<DichotomyGraph>();

    for(Integer category : populationDichotomySet.getSortedKeys())
    {
        DichotomyGraph newStar = new DichotomyGraph(
            populationDichotomySet.getSeries(category),
            maxClassesInSeries,
            30,
            MIN_SEMESTER_ID,
            MAX_SEMESTER_ID,
            50
        );
        retList.add(newStar);
    }

    return retList;
}

List<MetricDisplay> prepareMetricDisplays(SummarizedDataSet dataSet,
    int newWidth)
{
    List<MetricDisplay> retList = new ArrayList<MetricDisplay>();
    for(Integer categoryID : dataSet.getCategories())
    {
        Map<Integer, CourseSummary> category = dataSet.getCategory(categoryID);
        retList.add(new MetricDisplay(category, newWidth));
    }
    return retList;
}

void setup()
{
    size(WIDTH, HEIGHT);
    selectedSemID = MIN_SEMESTER_ID;
    SummarizedDataSet summarizedDataSet = getDataSetFromFile(DATA_FILE_LOC);
    pointDataSet = dataSetToPoints(summarizedDataSet,
        PLOT_WIDTH, PLOT_HEIGHT);
    populationDichotomySet = dataSetToDichotomySeriesSet(summarizedDataSet);
    maxClassesInSeries = getMaxClassesInSeriesSet(populationDichotomySet);

    sparklines = prepareSparklines(pointDataSet);
    dichotomyGraphs = prepareDichotomyGraphs(populationDichotomySet,
        maxClassesInSeries);

    metricDisplays = prepareMetricDisplays(summarizedDataSet, 100);

    frameRate(30);
}

void draw()
{
    if(!redrawRequired)
        return;

    // Clear
    noStroke();
    fill(#FFFFFF);
    rectMode(CORNERS);
    rect(0, 0, WIDTH, HEIGHT);

    // Labels
    PFont labelFont = loadFont("Helvetica-12.vlw");
    fill(#000000);
    textFont(labelFont, 10);
    textAlign(LEFT);

    // Metric labels
    pushMatrix();
    translate(280, 12);

    translate(SPARKLINE_HORIZ_PADDING, 0);
    text("Course Overall", 18, 0);
    translate(SPARKLINE_HORIZ_PADDING, 0);
    translate(PLOT_WIDTH, 0);

    translate(SPARKLINE_HORIZ_PADDING, 0);
    text("Inst. Overall", 18, 0);
    translate(SPARKLINE_HORIZ_PADDING, 0);
    translate(PLOT_WIDTH, 0);

    translate(SPARKLINE_HORIZ_PADDING, 0);
    text("Prior Interest", 18, 0);
    translate(SPARKLINE_HORIZ_PADDING, 0);
    translate(PLOT_WIDTH, 0);

    translate(SPARKLINE_HORIZ_PADDING, 0);
    text("Inst. Effectiv.", 18, 0);
    translate(SPARKLINE_HORIZ_PADDING, 0);
    translate(PLOT_WIDTH, 0);

    translate(SPARKLINE_HORIZ_PADDING, 0);
    text("Inst. Avail.", 18, 0);
    translate(SPARKLINE_HORIZ_PADDING, 0);
    translate(PLOT_WIDTH, 0);

    translate(SPARKLINE_HORIZ_PADDING, 0);
    text("Challenge", 18, 0);
    translate(SPARKLINE_HORIZ_PADDING, 0);
    translate(PLOT_WIDTH, 0);

    translate(SPARKLINE_HORIZ_PADDING, 0);
    text("Amt Learned", 18, 0);
    translate(SPARKLINE_HORIZ_PADDING, 0);
    translate(PLOT_WIDTH, 0);

    translate(SPARKLINE_HORIZ_PADDING, 0);
    text("Inst. Respect", 18, 0);
    translate(SPARKLINE_HORIZ_PADDING, 0);
    translate(PLOT_WIDTH, 0);

    translate(SPARKLINE_HORIZ_PADDING, 0);
    text("Min Hrs / Week", 18, 0);
    translate(SPARKLINE_HORIZ_PADDING, 0);
    translate(PLOT_WIDTH, 0);

    translate(SPARKLINE_HORIZ_PADDING, 0);
    text("Avg Hrs / Week", 18, 0);
    translate(SPARKLINE_HORIZ_PADDING, 0);
    translate(PLOT_WIDTH, 0);

    translate(SPARKLINE_HORIZ_PADDING, 0);
    text("Max Hrs / Week", 18, 0);
    translate(SPARKLINE_HORIZ_PADDING, 0);
    translate(PLOT_WIDTH, 0);

    popMatrix();

    // Leave room for labels
    pushMatrix();
    translate(0, 14);

    // Category labels
    textFont(labelFont, 13);
    pushMatrix();
    translate(0, 14);

    text("General", 0, 0);
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    text("AI/HCC", 0, 0);
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    text("OS/Hard.", 0, 0);
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    text("Theory", 0, 0);
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    text("Languages", 0, 0);
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    text("Numerical", 0, 0);
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    text("Databases", 0, 0);
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);
    popMatrix();

    // High level category info
    pushMatrix();
    int numCategories = dichotomyGraphs.size();
    for(int i=0; i<numCategories; i++)
    {
        DichotomyGraph graph = dichotomyGraphs.get(i);
        MetricDisplay metricDisplay = metricDisplays.get(i);

        textFont(labelFont, 9);
        metricDisplay.draw(selectedSemID);
        translate(240, 25);
        textFont(labelFont, 10);
        graph.draw(selectedSemID);
        translate(-240, -25);
        translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);
    }
    popMatrix();

    // Sparklines
    pushMatrix();
    translate(300, 0);
    for(Integer category : sparklines.keySet())
    {
        List<Sparkline> categorySparklines = sparklines.get(category);
        translate(0, CATEGORY_VERT_PADDING);
        pushMatrix();
        for(Sparkline sparkline : categorySparklines)
        {
            translate(SPARKLINE_HORIZ_PADDING, 0);
            sparkline.draw(selectedSemID);
            translate(SPARKLINE_HORIZ_PADDING, 0);
            translate(PLOT_WIDTH, 0);
        }
        popMatrix();
        translate(0, PLOT_HEIGHT);
        translate(0, CATEGORY_VERT_PADDING);
    }
    popMatrix();

    popMatrix();

    redrawRequired = false;
}

void keyPressed()
{
    if(key != CODED)
        return;

    if (keyCode == LEFT)
    {
        if(selectedSemID > MIN_SEMESTER_ID)
            selectedSemID--;
    }
    else if(keyCode == RIGHT)
    {  
        if(selectedSemID < MAX_SEMESTER_ID)
            selectedSemID++;
    }
    redrawRequired = true;
}
