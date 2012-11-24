class Dichotomy
{
    private float val1;
    private float val2;

    public Dichotomy(float newVal1, float newVal2)
    {
        val1 = newVal1;
        val2 = newVal2;
    }

    public float getVal1()
    {
        return val1;
    }

    public float getVal2()
    {
        return val2;
    }
};

class DichotomySeries
{
    private Map<Integer, Dichotomy> dichotomies;
    private List<Integer> sortedKeys;

    public DichotomySeries()
    {
        dichotomies = new HashMap<Integer, Dichotomy>();
    }

    public void addDichotomy(int semID, Dichotomy newDichotomy)
    {
        dichotomies.put(semID, newDichotomy);
        sortedKeys = new ArrayList<Integer>(dichotomies.keySet());
        Collections.sort(sortedKeys);
    }

    public Collection<Dichotomy> getDichotomies()
    {
        return dichotomies.values();
    }

    public Dichotomy getDichotomy(int semID)
    {
        return dichotomies.get(semID);
    }

    public List<Integer> getSortedKeys()
    {
        return sortedKeys;
    }
};

class LabeledDichotomySeriesSet
{
    private Map<Integer, DichotomySeries> dichotomySets;
    private List<Integer> sortedKeys;

    public LabeledDichotomySeriesSet()
    {
        dichotomySets = new HashMap<Integer, DichotomySeries>();
    }

    public void addDichotomySeries(int category, DichotomySeries series)
    {
        dichotomySets.put(category, series);
        sortedKeys = new ArrayList<Integer>(dichotomySets.keySet());
        Collections.sort(sortedKeys);
    }

    public Collection<DichotomySeries> getSeriesCollection()
    {
        return dichotomySets.values();
    }

    public DichotomySeries getSeries(int category)
    {
        return dichotomySets.get(category);
    }

    public List<Integer> getSortedKeys()
    {
        return sortedKeys;
    }
};

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
    private List<Integer> sortedKeys;

    public PointSeries()
    {
        pointSummaries = new HashMap<Integer, PointSummary>();
    }

    public void addSummary(int semID, PointSummary summary)
    {
        pointSummaries.put(semID, summary);
        sortedKeys = new ArrayList<Integer>(pointSummaries.keySet());
        Collections.sort(sortedKeys);
    }

    public PointSummary getSummary(int semID)
    {
        return pointSummaries.get(semID);
    }

    public List<Integer> getSortedKeys()
    {
        return sortedKeys;
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

    public PointSeries getSeries(int seriesID)
    {
        return pointSeries.get(seriesID);
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

    public LabeledPointSeriesSet getSeriesSet(int categoryID)
    {
        return seriesSets.get(categoryID);
    }
};
