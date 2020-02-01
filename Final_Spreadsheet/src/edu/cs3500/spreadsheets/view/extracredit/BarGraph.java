package edu.cs3500.spreadsheets.view.extracredit;

import edu.cs3500.spreadsheets.model.Coord;
import edu.cs3500.spreadsheets.model.ICell;
import edu.cs3500.spreadsheets.model.IWorksheetGetters;

import java.util.ArrayList;
import java.util.List;
import javax.swing.JFrame;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;

/**
 * Represents the visualization of selected data as a Bar Graph.
 */
public class BarGraph extends JFrame implements IGraph {

  private static final long serialVersionUID = 1L;
  private int x;
  private String chartTitle;
  private IWorksheetGetters model;
  private String inputRegion;
  private List<ICell> cells;
  private ChartPanel chartPanel;
  private CategoryDataset dataset;
  private JFreeChart chart;

  /**
   * Constructs a Bar Graph showing the count of the given data.
   * @param chartTitle title of the graph
   * @param range input region
   * @param model worksheet model
   * @param existence whether the bar graph exists or not
   */
  public BarGraph(String chartTitle, String range, IWorksheetGetters model, boolean existence) {
    super("Bar Chart");
    this.chartTitle = chartTitle;
    this.model = model;
    this.inputRegion = range;
    this.cells = getCells();
    // This will create the dataset
    dataset = createDataset();
    // based on the dataset we create the chart
    chart = createChart(dataset, chartTitle);
    // we put the chart into a panel
    chartPanel = new ChartPanel(chart);
    // default size
    chartPanel.setPreferredSize(new java.awt.Dimension(500, 270));
    // add it to our application
    setContentPane(chartPanel);
    this.pack();
    this.setVisible(true);
  }

  private List<ICell> getCells() {
    Coord c1;
    Coord c2;
    if (inputRegion.contains(":")) {
      String[] los = inputRegion.split(":");
      if (los.length != 2) {
        throw new IllegalArgumentException("#InvalRef");
      }
      String[] firstCell = los[0].split("(?=\\d)(?<!\\d)");
      String[] secondCell = los[1].split("(?=\\d)(?<!\\d)");
      c1 = new Coord(Coord.colNameToIndex(firstCell[0]),
              Integer.parseInt(firstCell[1]));
      c2 = new Coord(Coord.colNameToIndex(secondCell[0]),
              Integer.parseInt(secondCell[1]));
      return rectRegion(c1,c2);
    }
    return new ArrayList<>();
  }

  private List<ICell> rectRegion(Coord c1, Coord c2) {
    List<ICell> loc = new ArrayList<>();
    int minCol = Math.min(c1.col, c2.col);
    int maxCol = Math.max(c1.col, c2.col);
    int minRow = Math.min(c1.row, c2.row);
    int maxRow = Math.max(c1.row, c2.row);
    for (int row = maxRow; row >= minRow; row--) {
      for (int col = maxCol; col >= minCol; col--) {
        Coord coord = new Coord(col, row);
        if (model.containsCell(coord)) {
          loc.add(model.getCellAt(coord));
        }
      }
    }
    return loc;
  }

  private CategoryDataset createDataset() {
    DefaultCategoryDataset result = new DefaultCategoryDataset();
    for (ICell cell : cells) {
      String content = model.evaluate(cell.getCoord());
      int count = 0;
      for (ICell c : cells) {
        String cellCont = model.evaluate(c.getCoord());
        if (content.equals(cellCont)) {
          count++;
        }
      }
      result.setValue(count,content,"item");
    }
    return result;
  }

  private JFreeChart createChart(CategoryDataset dataset, String title) {

    JFreeChart chart = ChartFactory.createBarChart("Something", "Item",
            "Count", dataset);

    CategoryPlot plot = (CategoryPlot) chart.getPlot();
    plot.setForegroundAlpha(0.5f);
    return chart;
  }

  /**
   * Refreshes the data on the given graph on edit button press. As data is updated, the graph
   * updates to match.
   */
  public void refresh() {
    dataset = createDataset();
    chart = createChart(dataset, chartTitle);
    chartPanel = new ChartPanel(chart);
    setContentPane(chartPanel);
    this.pack();
    this.setVisible(true);
    this.chartPanel.repaint();
  }
}