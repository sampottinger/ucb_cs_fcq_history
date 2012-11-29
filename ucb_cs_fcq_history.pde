/**
 * Name: ucbcsviz.pde
 * Auth: Sam Pottinger
 * Lisc: GPL v2
 * Desc: Driver for visualization of history of the Department of Computer
 *       Science from the University of Colorado at Boulder through the lens
 *       of FCQ survey results.
**/

// Presentation and data location constants
final String DATA_FILE_LOC = "cs_fcq.csv";
final int PLOT_WIDTH = 60;
final int SPARKLINE_HORIZ_PADDING = 10;
final int PLOT_HEIGHT = 44;
final int CATEGORY_VERT_PADDING = 17;
final int WIDTH = 1230;
final int HEIGHT = 730;

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

/**
 * Name: prepareSparklinesForCategory(LabeledPointSeriesSet seriesSet)
 * Desc: Create sparklines for category of courses.
 * Para: seriesSet, The set of points to create sparklines for.
 * Retr: List of sparklines cooresponding to each field represented in the
 *       underlying data set.
**/
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

/**
 * Name: prepareSparklines(PointDataSet dataSet)
 * Desc: Create sparklines for a set of categories.
 * Para: dataSet, The data set to create sparklines for.
 * Retr: Mapping from semester ID to list of sparklines for that category's
 *       values.
**/
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

    curSet = dataSet.getSeriesSet(GRAPHICS_CATEGORY);
    newSparklines = prepareSparklinesForCategory(curSet);
    sparklines.put(GRAPHICS_CATEGORY, newSparklines);

    return sparklines;
}

/**
 * Name: prepareDichotomyGraphs(
 *          LabeledDichotomySeriesSet populationDichotomySet,
 *          int maxClassesInSeries)
 * Desc: Create dichotomy graphs to show number of graduate v undergraduate
 *       courses for a category of courses.
 * Para: populationDichotomySet, The dichotomy set for a category of courses.
 *       maxClassesInSeries, The maximum number of classes in the provided
 *          series.
**/
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

/**
 * Name: prepareMetricDisplays(SummarizedDataSet dataSet,
 *          int newWidth)
 * Desc: Create metric displays for a data set.
 * Para: dataSet, the data set to create metric displays for.
 *       newWidth, The width of target display in pixels (to calculate
 *          coordinates).
**/
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

/**
 * Name: setup()
 * Desc: Load data set, create visual structures, and adjust visual properties.
**/
void setup()
{
    size(WIDTH, HEIGHT);

    // Load data
    selectedSemID = MIN_SEMESTER_ID;
    SummarizedDataSet summarizedDataSet = getDataSetFromFile(DATA_FILE_LOC);
    pointDataSet = dataSetToPoints(summarizedDataSet,
        PLOT_WIDTH, PLOT_HEIGHT);
    populationDichotomySet = dataSetToDichotomySeriesSet(summarizedDataSet);
    maxClassesInSeries = getMaxClassesInSeriesSet(populationDichotomySet);

    // Create summarizing visual structures
    sparklines = prepareSparklines(pointDataSet);
    dichotomyGraphs = prepareDichotomyGraphs(populationDichotomySet,
        maxClassesInSeries);

    // Create individual metric displays
    metricDisplays = prepareMetricDisplays(summarizedDataSet, 100);

    // Turn down framerate
    frameRate(30);
}

/**
 * Name: draw()
 * Desc: Draw all the visual structures and respond to user feedback.
**/
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
    translate(300, 22);

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
    translate(14, PLOT_HEIGHT + 33);

    pushMatrix();
    rotate(-PI/2.0);
    text("General", 0, 0);
    popMatrix();
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    pushMatrix();
    rotate(-PI/2.0);
    text("AI / HCC", 0, 0);
    popMatrix();
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    pushMatrix();
    rotate(-PI/2.0);
    text("OS / Hard.", 0, 0);
    popMatrix();
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    pushMatrix();
    rotate(-PI/2.0);
    text("Theory", 0, 0);
    popMatrix();
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    pushMatrix();
    rotate(-PI/2.0);
    text("Lang.", 0, 0);
    popMatrix();
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    pushMatrix();
    rotate(-PI/2.0);
    text("Numerical", 0, 0);
    popMatrix();
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    pushMatrix();
    rotate(-PI/2.0);
    text("Databases", 0, 0);
    popMatrix();
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    pushMatrix();
    rotate(-PI/2.0);
    text("Soft. Eng.", 0, 0);
    popMatrix();
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);

    pushMatrix();
    rotate(-PI/2.0);
    text("Graphics", 0, 0);
    popMatrix();
    translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);
    popMatrix();

    // High level category info
    pushMatrix();
    translate(20, 0);
    int numCategories = dichotomyGraphs.size();
    for(int i=0; i<numCategories; i++)
    {
        DichotomyGraph graph = dichotomyGraphs.get(i);
        MetricDisplay metricDisplay = metricDisplays.get(i);

        textFont(labelFont, 9);
        metricDisplay.draw(selectedSemID);
        translate(240, 20);
        textFont(labelFont, 10);
        graph.draw(selectedSemID);
        translate(-240, -20);
        translate(0, CATEGORY_VERT_PADDING * 2 + PLOT_HEIGHT);
    }
    popMatrix();

    // Sparklines
    pushMatrix();
    translate(320, 0);
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

    // Calculate semester
    int selectedSem = ((int)selectedSemID) % 3;
    int selectedYear = ((int)(selectedSemID - selectedSem)) / 3;
    String semStr;
    switch(selectedSem)
    {
        case SPRING_INT:
            semStr = "Spring";
            break;
        case SUMMER_INT:
            semStr = "Summer";
            break;
        case FALL_INT:
            semStr = "Fall";
            break;
        default:
            semStr = "Other";
            break;
    }

    noStroke();
    fill(242, 230, 211);
    rectMode(CORNERS);
    rect(0, 0, 80, 18);
    textFont(labelFont, 14);
    fill(#000000);
    text(String.format("%s %d", semStr, selectedYear), 1, 14);

    text("History of UCB CS FCQ Results", 90, 14);

    redrawRequired = false;
}

/**
 * Name: keyPressed()
 * Desc: Listen for user's key presses indicating movement between semesters.
**/
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
