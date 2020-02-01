package edu.cs3500.spreadsheets.view;

import edu.cs3500.spreadsheets.controller.IController;
import edu.cs3500.spreadsheets.model.Coord;
import edu.cs3500.spreadsheets.model.IWorksheetGetters;
import edu.cs3500.spreadsheets.view.extracredit.BarGraph;
import edu.cs3500.spreadsheets.view.extracredit.LineGraph;
import edu.cs3500.spreadsheets.view.extracredit.PieChart;
import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.File;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JScrollBar;
import javax.swing.JScrollPane;
import javax.swing.JTextField;
import javax.swing.JToolBar;
import javax.swing.JViewport;
import javax.swing.ScrollPaneConstants;
import javax.swing.event.ChangeListener;
import javax.swing.filechooser.FileFilter;

/**
 * Represents an editable view with the ability to modify cells contents, deleting cells, loading in
 * different spreadsheets and saving the current spreadsheet.
 */
public class WorksheetEditableView extends JFrame implements IEditableView, ActionListener {

  private final String BUTTON_1 = "B1";
  private final String BUTTON_2 = "B2";
  private final String BUTTON_3 = "Open";
  private final String BUTTON_4 = "Save";
  private int cellWidth = 100;
  private int cellHeight = 40;
  private int windowWidth = 800;
  private int windowHeight = 500;
  private JButton b1;
  private JButton b2;
  private JButton b3;
  private JButton b4;
  private JTextField textField;
  private WorksheetEditPanel worksheetPanel;
  private IWorksheetGetters model;
  private IController controller;
  private JScrollPane scrollPane;
  private JMenuBar bar;
  private PieChart pc;
  private JTextField popupTf;
  private BarGraph bc;
  private LineGraph lc;

  /**
   * Construct a visual view of our worksheet.
   *
   * @param model the model that gets visually represented as a sheet
   */
  public WorksheetEditableView(IWorksheetGetters model, IController controller) {
    if (model == null) {
      throw new IllegalArgumentException("Model cannot be null");
    }
    this.model = model;
    this.controller = controller;

    int sheetXSize = cellWidth * (1 + model.getMaxColumn());
    int sheetYSize = cellHeight * (1 + model.getMaxRow());

    this.initButtonAndTextField();
    this.initChartChooser();
    this.initToolBar();

    this.setTitle("Worksheet");
    this.setSize(sheetXSize, sheetYSize);
    this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

    worksheetPanel = new WorksheetEditPanel(this, model, cellWidth, cellHeight);
    worksheetPanel.setPreferredSize(new Dimension(sheetXSize, sheetYSize));
    this.addMouseListener(worksheetPanel);
    this.addKeyListener(new MyKeyListener());
    this.setFocusable(true);
    this.initScrollBar();
  }

  @Override
  public void render() {
    this.pack();
    this.setVisible(true);
  }

  @Override
  public void setText(Coord c) {
    String content;
    try {
      content = model.getCellAt(c).getContent();
      this.textField.setText(content);
    } catch (IllegalArgumentException e) {
      this.textField.setText("...");
    }
  }

  @Override
  public void actionPerformed(ActionEvent e) {
    String command = e.getActionCommand();
    Coord c = this.worksheetPanel.getCoord();
    switch (command) {
      case BUTTON_1:
        try {
          controller.changeContent(c, textField.getText());
          if (pc != null) {
            pc.refresh();
          }
          if (bc != null) {
            bc.refresh();
          }
          if (lc != null) {
            lc.refresh();
          }
        } catch (IllegalArgumentException exc) {
          textField.setText(exc.getMessage());
        }
        this.repaint();
        this.requestFocus();
        break;
      case BUTTON_2:
        this.setText(c);
        if (model.containsCell(c)) {
          this.textField.setText(model.getCellAt(c).getContent());
          this.repaint();
        }
        this.requestFocus();
        break;
      case BUTTON_3:
        JFileChooser fileChooser = new JFileChooser();
        fileChooser.addChoosableFileFilter(new TextFileFilter());
        fileChooser.setCurrentDirectory(new java.io.File("."));
        int returnValue = fileChooser.showOpenDialog(null);
        if (returnValue == JFileChooser.APPROVE_OPTION) {
          File selectedFile = fileChooser.getSelectedFile();
          controller.changeFile(selectedFile.getName());
          worksheetPanel.initHighlight();
          this.repaint();
        }
        break;
      case BUTTON_4:
        JFileChooser fileChooserSave = new JFileChooser();
        fileChooserSave.setCurrentDirectory(new java.io.File("."));
        fileChooserSave.addChoosableFileFilter(new TextFileFilter());
        int returnVal = fileChooserSave.showSaveDialog(null);
        if (returnVal == JFileChooser.APPROVE_OPTION) {
          File selectedFile = fileChooserSave.getSelectedFile();
          controller.saveFile(selectedFile.getName());
        }
        break;
      case "PieChart":
      case "BarChart":
      case "LineGraph":
        this.popUpWindow(command);
        break;
      case "Draw PieChart":
        pc = new PieChart("Something", popupTf.getText(), model, true);
        break;
      case "Draw BarChart":
        bc = new BarGraph("Something",popupTf.getText(),model,true);
        break;
      case "Draw LineGraph":
        lc = new LineGraph("Something", popupTf.getText(), model,true);
        break;
      default:
        throw new IllegalArgumentException("Illegal ActionCommand");
    }

  }

  private void initScrollBar() {
    scrollPane = new JScrollPane(worksheetPanel,
        ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS,
        ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
    scrollPane.setPreferredSize(new Dimension(windowWidth, windowHeight));
    scrollPane.getViewport().setScrollMode(JViewport.SIMPLE_SCROLL_MODE);
    ChangeListener verticalListener = e -> {
      JScrollBar scrollBar = scrollPane.getVerticalScrollBar();
      if (scrollBar.getValue() + scrollBar.getVisibleAmount() == scrollBar.getMaximum()) {
        worksheetPanel.updateHeight();
      }
    };
    ChangeListener horizontallistener = e -> {
      JScrollBar scrollBar = scrollPane.getHorizontalScrollBar();
      if (scrollBar.getValue() + scrollBar.getVisibleAmount() == scrollBar.getMaximum()) {
        worksheetPanel.updateWidth();
      }
    };
    scrollPane.getViewport().addChangeListener(horizontallistener);
    scrollPane.getViewport().addChangeListener(verticalListener);
    this.add(scrollPane);
  }

  private void popUpWindow(String command) {
    JFrame popupMenu = new JFrame(command);
    JToolBar tb = new JToolBar();
    popupMenu.setPreferredSize(new Dimension(200, 150));
    popupTf = new JTextField("Enter your cell range");
    tb.add(popupTf);
    tb.setPreferredSize(new Dimension(200, 60));
    JButton b5 = new JButton("Draw");
    b5.setActionCommand("Draw " + command);
    b5.addActionListener(this);
    popupMenu.add(b5);
    popupMenu.add(tb, BorderLayout.NORTH);
    popupMenu.setVisible(true);
    popupMenu.pack();

  }

  private void initButtonAndTextField() {
    b1 = new JButton("Edit");
    b2 = new JButton("Restore");
    b3 = new JButton("Open File");
    b4 = new JButton("Save File");
    b1.setActionCommand(BUTTON_1);
    b1.addActionListener(this);
    b2.setActionCommand(BUTTON_2);
    b2.addActionListener(this);
    b3.setActionCommand(BUTTON_3);
    b3.addActionListener(this);
    b4.setActionCommand(BUTTON_4);
    b4.addActionListener(this);
    textField = new JTextField("...");
  }

  private void initToolBar() {
    JPanel toolBarPanel = new JPanel();
    toolBarPanel.add(b3);
    toolBarPanel.add(b4);
    toolBarPanel.add(b1);
    toolBarPanel.add(b2);
    JToolBar tb = new JToolBar("Toolbar");
    tb.add(toolBarPanel);
    tb.add(textField);
    tb.add(bar);
    add(tb, BorderLayout.NORTH);
  }

  private void initChartChooser() {
    bar = new JMenuBar();
    JMenu menu = new JMenu("Chart");
    JMenuItem item = new JMenuItem("Pie Chart");
    item.setActionCommand("PieChart");
    item.addActionListener(this);
    JMenuItem item2 = new JMenuItem("Line Graph");
    item2.setActionCommand("LineGraph");
    item2.addActionListener(this);
    JMenuItem item3 = new JMenuItem("Bar Chart");
    item3.setActionCommand("BarChart");
    item3.addActionListener(this);
    menu.add(item);
    menu.add(item3);
    menu.add(item2);
    bar.add(menu);
  }

  private class MyKeyListener implements KeyListener {

    @Override
    public void keyTyped(KeyEvent e) {
      // all operations on keyPressed.
    }

    @Override
    public void keyPressed(KeyEvent e) {
      if (e.getKeyCode() == KeyEvent.VK_DELETE) {
        Coord c = worksheetPanel.getCoord();
        controller.deleteCell(c);
        textField.setText("...");
        repaint();
      } else if (e.getKeyCode() == KeyEvent.VK_LEFT) {
        worksheetPanel.moveLeft();
        Coord c = worksheetPanel.getCoord();
        setText(c);
        repaint();
      } else if (e.getKeyCode() == KeyEvent.VK_RIGHT) {
        worksheetPanel.moveRight();
        Coord c = worksheetPanel.getCoord();
        setText(c);
        repaint();
      } else if (e.getKeyCode() == KeyEvent.VK_UP) {
        worksheetPanel.moveUp();
        Coord c = worksheetPanel.getCoord();
        setText(c);
        repaint();
      } else if (e.getKeyCode() == KeyEvent.VK_DOWN) {
        worksheetPanel.moveDown();
        Coord c = worksheetPanel.getCoord();
        setText(c);
        repaint();
      }
    }

    @Override
    public void keyReleased(KeyEvent e) {
      // all operations on keyPressed.
    }
  }

  // Makes it so that only textFiles are allowed to be accessed through the File chooser when that
  // option is selected.
  private class TextFileFilter extends FileFilter {

    @Override
    public boolean accept(File f) {
      return f.getName().contains(".txt");
    }

    @Override
    public String getDescription() {
      return "TextFileFilter";
    }
  }


}