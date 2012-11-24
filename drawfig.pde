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
                fill(252, 240, 221);
                rectMode(CORNERS);
                rect(secondQuartile.x - 1, 0, secondQuartile.x + 1,
                    PLOT_HEIGHT);
                noFill();
            }

            stroke(#707070);
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
        total = 0;
        for(Dichotomy dichotomy : newSeries.getDichotomies())
            total += dichotomy.getVal1() + dichotomy.getVal2();

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
            
            if(highlightedSemID == semID)
            {
                noStroke();
                fill(252, 240, 221);
                rectMode(CORNERS);
                rect(-2, 0, 2, dispHeight+2);
                noFill();
            }

            float firstValOut = classConversionFactor * dichotomy.getVal1();
            float secondValOut = classConversionFactor * dichotomy.getVal2();
            
            stroke(#000000);
            line(0, dispHeight, 0, dispHeight - firstValOut);
            
            stroke(#505050);
            line(0, dispHeight - firstValOut, 0,
                dispHeight - (firstValOut + secondValOut));
            
            popMatrix();
        }

        fill(#000000);
        text(new Integer(total).toString() + " entries", 0, 42);
    }
};
