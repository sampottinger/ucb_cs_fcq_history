class Sparkline
{
    private PointSeries series;

    public Sparkline(PointSeries newSeries)
    {
        series = newSeries;
    }

    public void draw()
    {
        // Set color and other display options
        strokeWeight(1);
        noFill();
        noSmooth();

        // Render centers
        rectMode(RADIUS);
        for(Integer semID : series.getSortedKeys())
        {
            PointSummary pointSummary = series.getSummary(semID);
            PVector secondQuartile = pointSummary.getSecondQuartile();
            rect(secondQuartile.x, secondQuartile.y, 2, 2);
        }
    }
};