Changes to Assignment 6:
1. We were not required to make any changes to our model since we already had all necessary methods
   and design choices made beforehand.
2. Since we decided to follow a similar design as in design 6 with the view, by having a class extending JFrame as
   our main view and a class extending JPanel to represents the grid, we decided to make an interface for Worksheet Panels

Assignment 7:

Design choices:
As already mentioned we followed a similar design to the previous assignment for our view.
1. Our EditPanel class extends the WorksheetPanel class to make use of the methods drawing the grid,
   but with the added feature to draw make a cell highlighted on a mouse click.
2. The EditPanel class contains the MouseListener to be make it easier to directly use the mouse
   click and position to highlight the clicked cell. We thought about moving the MouseListener to the
   View class, but either design choice would have required us to write an extra interface or a method
   that has some redundancy in another class.
3. Therefore our EditView class has a separate interface for editable spreadsheet views with the
   ability to change the text in the JToolBar which is cannot exist in a JPanel.
4. Since JSwing acts like a controller in some form our controller doesn't even have to hold the view, but the view has the controller as a field.
   When a certain key or mouse action happens the view calls one of the controller methods, which then makes changes to the model.

Extra Credit:
We successfully attempted all four extra credit functionalities:

1. Choosing cell on arrow key press:
   Our EditView class has a private KeyListener class and when an arrow key is being pressed our EditPanel
   handles which cell is supposed to be highlighted.
2. Removing cell on "delete":
   The KeyListener calls a removeCell method from the Controller when the delete key is being pressed.
3. Saving the current Spreadsheet:
   We added a "Save" button to the toolbar which if its being pressed opens JFileChooser.
   Within the FileChooser you enter the name of the file to be saved and choose the directory where
   it is supposed to be saved with resources being the default.
   When that is executed the filename is being passed to a controller method which fulfills saving files.
4. Opening files:
   Similar to saving files we have a button in the toolbar which if its being pressed opens a JFileChooser.
   You choose your File and when you press open, the controller handles modifying the model to the one
   from the chosen file.


