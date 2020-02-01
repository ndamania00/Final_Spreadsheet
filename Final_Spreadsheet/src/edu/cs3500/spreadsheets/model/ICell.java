package edu.cs3500.spreadsheets.model;

import edu.cs3500.spreadsheets.sexp.Sexp;
import java.util.List;

/**
 * Represents an interface of a Cell.
 */
public interface ICell {

  /**
   * Gets the coordinate of a Cell.
   *
   * @return the Coordinate of a Cell
   */
  public Coord getCoord();

  /**
   * Gets the S-expression of a Cell representing the content.
   *
   * @return S-Expression of Cell
   */
  public Sexp getSexp();

  /**
   * Gets the unformatted string content of a Cell.
   *
   * @return the unformatted string content of a Cell
   */
  public String getContent();

  /**
   * Sets the unformatted string content of a Cell to the given one.
   */
  public void setContent(String content);


  /**
   * Sets a Cells S-expression to the given Sexp.
   *
   * @param exp a S-Expression
   */
  public void setSexp(Sexp exp);

  /**
   * Adds the coordinate of dependent cell.
   *
   * @param coord coordinate of dependent cell
   */
  public void addDependency(Coord coord);

  /**
   * Gets the coordinate of dependent cell.
   */
  public List<Coord> getDependencies();


  /**
   * Determines whether this Cell is part or contains a cyclic reference.
   *
   * @return whether there exists a cycle
   */
  public boolean containsCycle();

  /**
   * Removes all the added dependencies from this cell.
   */
  public void clearDependencies();

}
