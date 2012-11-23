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
        noSmooth();
        noFill();

        // Render border
        stroke(#A0A0A0);
        line(-3, PLOT_HEIGHT, PLOT_WIDTH, PLOT_HEIGHT);
        line(-3, 0, -3, PLOT_HEIGHT);

        // Render plot
        rectMode(RADIUS);
        for(Integer semID : series.getSortedKeys())
        {
            PointSummary pointSummary = series.getSummary(semID);

            // Draw plot itself
            PVector firstQuartile = pointSummary.getFirstQuartile();
            PVector secondQuartile = pointSummary.getSecondQuartile();
            PVector thirdQuartile = pointSummary.getThirdQuartile();

            stroke(#707070);
            line(firstQuartile.x, firstQuartile.y, secondQuartile.x,
                secondQuartile.y);
            line(secondQuartile.x, secondQuartile.y, thirdQuartile.x,
                thirdQuartile.y);
            stroke(#000000);
            rect(secondQuartile.x, secondQuartile.y, 1, 1);
        }
    }
};