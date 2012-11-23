final String DATA_FILE_LOC = "cs_fcq.csv";
final int PLOT_WIDTH = 100;
final int PLOT_HEIGHT = 60;

List<CourseRecord> courseRecords;

PointDataSet pointDataSet;
Sparkline testSparkline;

void setup()
{
    size(PLOT_WIDTH, PLOT_HEIGHT);
    SummarizedDataSet summarizedDataSet = getDataSetFromFile(DATA_FILE_LOC);
    pointDataSet = dataSetToPoints(summarizedDataSet,
        PLOT_WIDTH, PLOT_HEIGHT);
    LabeledPointSeriesSet sampleSet = pointDataSet.getSeriesSet(0);
    PointSeries sampleSeries = sampleSet.getSeries(9);
    testSparkline = new Sparkline(sampleSeries);
}

void draw()
{
    noStroke();
    fill(#FFFFFF);
    rectMode(CORNERS);
    rect(0, 0, PLOT_WIDTH, PLOT_HEIGHT);

    stroke(#000000);
    testSparkline.draw();
}