# Right_Note_Machine
- **Team Members:** Jon Cili, Xingjian Jiang, Raphael Mok
- **Demo Video Link:** https://drive.google.com/drive/folders/11A1SHO1mGmDlg9j-xsYX-SH7_U4Lv7an?usp=share_link
- **Bilibili Link:** https://www.bilibili.com/video/BV15i4y1x7rV/?buvid=Z446DE4F5D19E79547E1916B7B653B96CA57&from_spmid=playlist.playlist-detail.0.0&is_story_h5=false&mid=0tJnQDyRk9UJ1LwnzxPIaw%3D%3D&p=1&plat_id=116&share_from=ugc&share_medium=iphone&share_plat=ios&share_session_id=6B471C3E-DE0D-4902-9C5D-DF0D96469443&share_source=COPY&share_tag=s_i&spmid=main.ugc-video-detail.0.0&timestamp=1701545554&unique_k=vdNTFpN&up_id=12619366
- **Overview:** Our project seeks to create a digital musical keyboard using a computer's keyboard as well as an FPGA, while also allowing for the user to save a series of notes and their length for future use. Howover, it is still a work in progress with limited functionality.
- **How to Run:** To run, the user would have to generate the bitstream, upload it to an FPGA, and connect a speaker and keyboard to the FPGA's peripheral ports. (NOTE: The keyboard functionality is currently not working.)
- ## **Code Structure Overview:**
  - interface.v: The interface file is the top level file which replaces the old control file. It interfaces the clock as well as 19 inputs which are set to complete various tasks for the final code. 10 of the inputs are included in the rawnote variable, a 10-bit onehot encoced variable which represents which "keys" are currently being pressed. 2 of the inputs are used to shift the pitch of the current note in either direction. Another input is provided to reset the code. Another input begins the recording process and has it run for ten notes. Yet another input changes the program to begin playback mode. The last 4 inputs allow the the user to select between between 3 prerecorded songs and 1 recorded song in playback mode.
  - modeselect.v: This module allows the user to select the mode which they are using. If the 'mode' is low, it will simply select the current note and whatever the user's pitch shift is. Otherwise, it uses the romneote and rompit variables accessed through Rom.v for the note and pitchshift (aka, whatever the user has selected with the selectsong variables). Moreover, it also contains the code which allows for timing of playback, with a cnt accessing the amount of time a note was pressed in recording from mem.v and counting to that to ensure beatlengths match.
    - mem.v: a lower level file that saves all of the pre-recorded notes and notes from a recording to ensure they can be played back when the user accesses playback in modeselect.v. **Of importantance** to note is that mem.v file returns only one note at a time, and thus that the program needs to access mem.v several times to let an entire string of notes be played back. This functionality has not been tested.
  - btn_dbc.v: Simple debouncer that allows us to debounce the buttons on the FPGA (which is where we ported our inputs too via our constraints files when we could not connect a keyboard successfully).
  - debouncer.v: Simple debouncer that is intended to debounce keys on the keyboard.
  - ena.v: Module that sets the clock cycles for each of the different pulse frequencies which are accessed in modeselect.v, as well as generally accross the code when the recording functions are accessed.
  - midi.v: Top module for all of the various midi encoding and selection options throughout the code.
    - midi_encoder.v: Takes in the MIDI files and encodes them into the note values in the FPGA.
    - uart_tx.v: Accesses other files which can modify audio and encodes them into the FPGA. Currently not functional and without external files it is not accessed by the final code.
  - pitchshifter.v: Module that accesses the pitchshifter inputs and increases or decreases the pitch depending on which input is pressed.
  - usb_mouse.v: Top level module that accesses the ps2 data and transmits signals into the keyboard. This code is not currently used by our top level function but we kept it in our final code to demonstrate what we had as a reference for pursuing keyboard implementation code.
    - ps2_transmitter.v: Sends data directly through the connection to the keyboard, does not decode any of the data sent though. This file is implemented by the usb_mouse, and thus is not used in our top level module.
