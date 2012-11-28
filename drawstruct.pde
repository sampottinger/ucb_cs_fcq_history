/**
 * Name: drawstrcut.pde
 * Auth: Sam Pottinger
 * Lisc: GPL v2
 * Desc: Classes that assist in representing the FCQ data set such that they can
 *       be drawn.
**/

/**
 * Name: Dichotomy
 * Desc: Structure with two float values representing values for two categories.
**/
class Dichotomy
{
    private float val1;
    private float val2;

    /**
     * Name: Dichotomy(float newVal1, float newVal2)
     * Desc: Create a new dichotomy.
     * Para: newVal1, The value for the first category.
     *       newVal2, The value for the second category.
    **/
    public Dichotomy(float newVal1, float newVal2)
    {
        val1 = newVal1;
        val2 = newVal2;
    }

    /**
     * Name: getVal1()
     * Desc: Get the value representing the first category.
    **/
    public float getVal1()
    {
        return val1;
    }

    /**
     * Name: getVal2()
     * Desc: Get the value representing the second category.
    **/
    public float getVal2()
    {
        return val2;
    }
};

/**
 * Name: DichotomySeries
 * Desc: A series of one dichotomy per semester.
**/
class DichotomySeries
{
    private Map<Integer, Dichotomy> dichotomies;
    private List<Integer> sortedKeys;

    /**
     * Name: DichotomySeries()
     * Desc: Create a new empty dichotomy series.
    **/
    public DichotomySeries()
    {
        dichotomies = new HashMap<Integer, Dichotomy>();
    }

    /**
     * Name: addDichotomy(int semID, Dichotomy newDichotomy)
     * Desc: Adds a new dichotomy to this dichotomy series.
     * Para: semID, The id of the semester to add a dichotomy for.
     *       newDichotomy, The dichotomy to add to the series.
    **/
    public void addDichotomy(int semID, Dichotomy newDichotomy)
    {
        dichotomies.put(semID, newDichotomy);
        sortedKeys = new ArrayList<Integer>(dichotomies.keySet());
        Collections.sort(sortedKeys);
    }

    /**
     * Name: getDichotomies()
     * Desc: Get the dichotomies in this seires.
    **/
    public Collection<Dichotomy> getDichotomies()
    {
        return dichotomies.values();
    }

    /**
     * Name: getDichotomy(int semID)
     * Desc: Get the dichotomy for the given semester.
     * Retr: The dichotomy for the given semseter or null if not available.
    **/
    public Dichotomy getDichotomy(int semID)
    {
        return dichotomies.get(semID);
    }

    /**
     * Name: getSortedKeys()
     * Desc: Get the semesters in this series sorted by ID (ascending)
    **/
    public List<Integer> getSortedKeys()
    {
        return sortedKeys;
    }
};

/**
 * Name: LabeledDichotomySeriesSet
 * Desc: A set of DichotomySeries labeled by integer categories.
**/
class LabeledDichotomySeriesSet
{
    private Map<Integer, DichotomySeries> dichotomySets;
    private List<Integer> sortedKeys;

    /**
     * Name: LabeledDichotomySeriesSet()
     * Desc: Create a new empty DichotomySeriesSet.
    **/
    public LabeledDichotomySeriesSet()
    {
        dichotomySets = new HashMap<Integer, DichotomySeries>();
    }

    /**
     * Name: addDichotomySeries(int category, DichotomySeries series)
     * Desc: Add a new dichotomy series to this set labeled with the given
     *       category ID.
     * Para: category, The category to add this series under.
     *       series, The series to add to this set.
    **/
    public void addDichotomySeries(int category, DichotomySeries series)
    {
        dichotomySets.put(category, series);
        sortedKeys = new ArrayList<Integer>(dichotomySets.keySet());
        Collections.sort(sortedKeys);
    }

    /**
     * Name: getSeriesCollection()
     * Desc: Get all of the dichotomy series in this set.
    **/
    public Collection<DichotomySeries> getSeriesCollection()
    {
        return dichotomySets.values();
    }

    /**
     * Name: getSeries(int category)
     * Desc: Get the series under the given category.
    **/
    public DichotomySeries getSeries(int category)
    {
        return dichotomySets.get(category);
    }

    /**
     * Name: getSortedKeys()
     * Desc: Get the categories in this set sorted in ascending order.
    **/
    public List<Integer> getSortedKeys()
    {
        return sortedKeys;
    }
};

/**
 * Name: PointSummary
 * Desc: A set of coordiantes representing each quartile from a distribution.
**/
class PointSummary
{
    private PVector firstQuartile;
    private PVector secondQuartile;
    private PVector thirdQuartile;

    /**
     * Name: PointSummary(PVector newFirstQuartile, PVector newSecondQuartile,
     *          PVector newThirdQuartile)
     * Desc: Create a new point summary.
     * Para: newFirstQuartile, Coordinates representing the first quartile.
     *       newSecondQuartile, Coordinates representing the second quartile.
     *       newThirdQuartile, Coordinates representing the third quartile.
    **/
    public PointSummary(PVector newFirstQuartile, PVector newSecondQuartile,
        PVector newThirdQuartile)
    {
        firstQuartile = newFirstQuartile;
        secondQuartile = newSecondQuartile;
        thirdQuartile = newThirdQuartile;
    }

    /**
     * Name: getFirstQuartile()
     * Desc: Get the coordiantes for the first quartile in this distribution.
    **/
    public PVector getFirstQuartile()
    {
        return firstQuartile;
    }

    /**
     * Name: getSecondQuartile()
     * Desc: Get the coordinate for the second quartile in this distribution.
    **/
    public PVector getSecondQuartile()
    {
        return secondQuartile;
    }

    /**
     * Name: getThirdQuartile()
     * Desc: Get the coordinate for the third quartile in this distribution.
    **/
    public PVector getThirdQuartile()
    {
        return thirdQuartile;
    }
};

/**
 * Name: PointSeries
 * Desc: Series of PointSummaries labeled by integer semester IDs.
**/
class PointSeries
{
    private Map<Integer, PointSummary> pointSummaries;
    private List<Integer> sortedKeys;

    /**
     * Name: PointSeries()
     * Desc: Create a new empty point series.
    **/
    public PointSeries()
    {
        pointSummaries = new HashMap<Integer, PointSummary>();
    }

    /**
     * Name: addSummary(int semID, PointSummary summary)
     * Desc: Add a new summary to this point series.
     * Para: semID, The id of the semester for which a point series is being
     *          added.
     *       summary, The PointSummary to add to this series.
    **/
    public void addSummary(int semID, PointSummary summary)
    {
        pointSummaries.put(semID, summary);
        sortedKeys = new ArrayList<Integer>(pointSummaries.keySet());
        Collections.sort(sortedKeys);
    }

    /**
     * Name: getSummary(int semID)
     * Desc: Get the summary for the given semester ID
     * Para: semID, The ID of the semester to get the point summary for.
    **/
    public PointSummary getSummary(int semID)
    {
        return pointSummaries.get(semID);
    }

    /**
     * Name: getSortedKeys()
     * Desc: Get the semester IDs of the semesters in this series sorted in
     *       ascending order.
    **/
    public List<Integer> getSortedKeys()
    {
        return sortedKeys;
    }
};

/**
 * Name: LabeledPointSeriesSet
 * Desc: PointSeriesSet with PointsSeries labeled by fields (like instructor
 *          overall).
**/
class LabeledPointSeriesSet
{
    private Map<Integer, PointSeries> pointSeries;

    /**
     * Name: LabeledPointSeriesSet()
     * Desc: Create an empty series set.
    **/
    public LabeledPointSeriesSet()
    {
        pointSeries = new HashMap<Integer, PointSeries>();
    }

    /**
     * Name: addSeries(int seriesID, PointSeries series)
     * Desc: Adds a new series to this set.
     * Para: seriesID, The ID of the category to put the series under.
     *       series, The series to add to this set.
    **/
    public void addSeries(int seriesID, PointSeries series)
    {
        pointSeries.put(seriesID, series);
    }

    /**
     * Name: getSeries(int seriesID)
     * Desc: Get the PointSeries for the given category of the given id.
     * Para: seriesID, The ID of the field for which a PointSeries is being
     *          requested.
    **/
    public PointSeries getSeries(int seriesID)
    {
        return pointSeries.get(seriesID);
    }
};

/**
 * Name: PointDataSet
 * Desc: A data set containing LabeledPointSeriesSets labeled by course
 *       course categoies (like software engineering).
**/
class PointDataSet
{
    private Map<Integer, LabeledPointSeriesSet> seriesSets;

    /**
     * Name: PointDataSet()
     * Desc: Create a new empty data set.
    **/
    public PointDataSet()
    {
        seriesSets = new HashMap<Integer, LabeledPointSeriesSet>();
    }

    /**
     * Name: addSet(int category, LabeledPointSeriesSet newSet)
     * Desc: Add a new LabeledPointSeriesSet to this data set.
     * Para: category, The category (like HCC / AI) to put this set under.
     *       newSet, The point set to add to this data set.
    **/
    public void addSet(int category, LabeledPointSeriesSet newSet)
    {
        seriesSets.put(category, newSet);
    }

    /**
     * Name: getSeriesSet(int categoryID)
     * Desc: Get the series set for the given category.
     * Para: categoryID, The integer ID of the category for which a
     *          LabeledPointSeriesSet is being requested.
    **/
    public LabeledPointSeriesSet getSeriesSet(int categoryID)
    {
        return seriesSets.get(categoryID);
    }
};
