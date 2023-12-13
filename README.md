## Right_Note_Machine
- **Team Members:** Jon Cili, Xingjian Jiang, Raphael Mok
- **Demo Video Link:**
- **Overview:** Our project seeks to create a digital musical keyboard using a computer's keyboard as well as an FPGA, while also allowing for the user to save a series of notes and their length for future use.
- **How to Run:**
- **Code Structure Overview:**
  - interface.v: The interface file is the top level file which replaces the old control file. It interfaces the clock as well as 19 keyboard buttons which are set to complete various tasks for the final code. 10 of the keys are included in the rawnote variable, a 10 bit onehot encoced variable which allows the user to select the pitch they want. We also use the up and down arrows to pitchshift the current note, as well as using the P key to reset the code. The R key when pressed once begins the recording process, and when pressed again it ends the recording and saves it. The last 4 are the 1-4 number keys, where three of the keys allow for the user to access prerecorded songs, and the final one allows the user to access the last thing they recorded.
  - 
