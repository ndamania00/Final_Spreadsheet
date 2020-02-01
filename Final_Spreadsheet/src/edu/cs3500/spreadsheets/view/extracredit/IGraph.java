package edu.cs3500.spreadsheets.view.extracredit;

/**
 * Interface representing graphs which visualize the data.
 */
public interface IGraph {

  /**
   * Refreshes the data on the given graph on edit button press. As data is updated, the graph
   * updates to match.
   */
  void refresh();

}
