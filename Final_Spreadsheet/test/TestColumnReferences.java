import org.junit.Test;

import edu.cs3500.spreadsheets.model.Coord;
import edu.cs3500.spreadsheets.model.IWorksheetModel;
import edu.cs3500.spreadsheets.model.WorksheetModel;

import static org.junit.Assert.assertEquals;

/**
 * Class to test column references for full columns.
 */
public class TestColumnReferences {

  private WorksheetModel.Builder builder = new WorksheetModel.Builder();
  private IWorksheetModel worksheet = new WorksheetModel(builder);

  @Test
  public void normalColumnReference() {
    builder.createCell(1, 1, "=2.0");
    builder.createCell(2, 1, "=4.0");
    builder.createCell(1, 2, "=2.5");
    builder.createCell(3,3,"=(SUM A:B)");
    assertEquals("8.5", worksheet.evaluate(new Coord(3, 3)));
  }

  @Test (expected = IllegalArgumentException.class)
  public void containsCycle() {
    builder.createCell(1, 1, "=2.0");
    builder.createCell(2, 1, "=4.0");
    builder.createCell(1, 2, "=A3");
    builder.createCell(1, 3, "=A2");
    builder.createCell(3,3,"=(SUM A:B)");
    assertEquals(new IllegalArgumentException("#Cycle!"), worksheet.evaluate(new Coord(3, 3)));
  }
}
