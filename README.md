# Right_Note_Machine
- **Team Members:** Jon Cili, Xingjian Jiang, Raphael Mok
- **Demo Video Link:**
- **Overview:** Our project seeks to create a digital musical keyboard using a computer's keyboard as well as an FPGA, while also allowing for the user to save a series of notes and their length for future use.
- **How to Run:** To run the user simply has to generate the bitstream and upload it to the FPGA and computer. From there, the keyboard should immediately work to generate notes from the user's input.
- ## **Code Structure Overview:**
  - [interface.v](interface.v): The interface file is the top level file which replaces the old control file. It interfaces the clock as well as 19 keyboard buttons which are set to complete various tasks for the final code. 10 of the keys are included in the rawnote variable, a 10 bit onehot encoced variable which allows the user to select the pitch they want. We also use the up and down arrows to pitchshift the current note, as well as using the P key to reset the code. The R key when pressed once begins the recording process, and when pressed again it ends the recording and saves it. The last 4 are the 1-4 number keys, where three of the keys allow for the user to access prerecorded songs, and the final one allows the user to access the last thing they recorded.
  - [modeselect.v](modeselect.v): This module allows the user to select the mode which they are using. If the 'mode' is low, and cycle is not active, it will simply select the current note and whatever the user's pitch shift is. Otherwise, it uses the romneote and rompit variables accessed through Rom.v for the note and pitchshift. It also has a pulse variable which allows the user to select the speed at which notes are palyed back. Finally, it also contains the code which allows for timing of playback, with a cnt accessing the amount of time a note was pressed in recording from mem.v and counting to that to ensure beatlengths match.
    - [mem.v](mem.v): a lower level file that saves all of the variable from a recording to ensure they can be played back when the user accesses playback in modeselect.v
  - [btn_dbc.v](btn_dbc.v): Simple debouncer that allows us to debounce the buttons on the FPGA
  - [counter.v](counter.v): Intended to access a 7-segment display for VGA display, though it was never fully implemented
  - [debouncer.v](debouncer.v): Simple debouncer that is intended to debounce keys on the keyboard
  - [ena.v](ena.v): Module that sets the clock cycles for each of the different pulse frequencies which are accessed in modeselect.v, as well as generally accross the code when the recording functions are accessed.
  - [midi.v](midi.v): Top module for all of the various midi encoding and selection options throughout the code
    - [midi_encoder.v](midi_encoder.v): Takes in the MIDI files and encodes them into the note values in the FPGA
    - [uart_tx.v](uart_tx.v): Accesses other files which can modify audio and encodes them into the FPGA. Currently not functional and without external files it is not accessed by the final code.
  - [pitchshifter.v](pitchshifter.v): Module that accesses the arrow key inputs and increases or decreases the pitch depending on which key is pressed.
  - [usb_keyboard.v](usb_keyboard.v): Top level module that accesses the ps2 data and transmits signals into the keyboard, as well as taking input signals from the keyboard.
    - [ps2_transmitter.v](ps2_transmitter.v): Sends data directly through the connection to the keyboard, does not decode any of the data sent though. 
