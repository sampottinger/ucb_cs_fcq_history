class Sparkline
{
    private PointSeries series;
    private int plotColor;

    public Sparkline(PointSeries newSeries, int newPlotColor)
    {
        series = newSeries;
        newPlotColor = plotColor;
    }

    public void draw()
    {
        // Set color and other display options
        strokeWeight(1);
        noSmooth();
        stroke(plotColor);
        noFill();

        // Render plot
        rectMode(RADIUS);
        for(Integer semID : series.getSortedKeys())
        {
            PointSummary pointSummary = series.getSummary(semID);

            // Draw plot itself
            PVector firstQuartile = pointSummary.getFirstQuartile();
            PVector secondQuartile = pointSummary.getSecondQuartile();
            PVector thirdQuartile = pointSummary.getThirdQuartile();

            line(firstQuartile.x, firstQuartile.y, secondQuartile.x,
                secondQuartile.y);
            rect(secondQuartile.x, secondQuartile.y, 1, 1);
            line(secondQuartile.x, secondQuartile.y, thirdQuartile.x,
                thirdQuartile.y);
        }
    }
};