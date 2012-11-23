class PointSummary
{
    private PVector firstQuartile;
    private PVector secondQuartile;
    private PVector thirdQuartile;

    public PointSummary(PVector newFirstQuartile, PVector newSecondQuartile,
        PVector newThirdQuartile)
    {
        firstQuartile = newFirstQuartile;
        secondQuartile = newSecondQuartile;
        thirdQuartile = newThirdQuartile;
    }

    public PVector getFirstQuartile()
    {
        return firstQuartile;
    }

    public PVector getSecondQuartile()
    {
        return secondQuartile;
    }

    public PVector getThirdQuartile()
    {
        return thirdQuartile;
    }
};

class PointSeries
{
    private Map<Integer, PointSummary> pointSummaries;

    public PointSeries()
    {
        pointSummaries = new HashMap<Integer, PointSummary>();
    }

    public void addSummary(int semID, PointSummary summary)
    {
        pointSummaries.put(semID, summary);
    }
};

class LabeledPointSeriesSet
{
    private Map<Integer, PointSeries> pointSeries;

    public LabeledPointSeriesSet()
    {
        pointSeries = new HashMap<Integer, PointSeries>();
    }

    public void addSeries(int seriesID, PointSeries series)
    {
        pointSeries.put(seriesID, series);
    }
};

class PointDataSet
{
    private Map<Integer, LabeledPointSeriesSet> seriesSets;

    public PointDataSet()
    {
        seriesSets = new HashMap<Integer, LabeledPointSeriesSet>();
    }

    public void addSet(int category, LabeledPointSeriesSet newSet)
    {
        seriesSets.put(category, newSet);
    }
};
