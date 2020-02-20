# FPGA-USB-Oscilloscope

This repository has the system verilog code for the FPGA-USB oscope project I did with another student in my JR design class.

The project was a two channel USB oscilloscope built using an FPGA. The FPGA was used to acquirer data and send that 
to the computer over USB to be proccessed and displayed on a GUI. 

I was responsible for the data acquisition half of the project. One part of this half of the project was writting 
SyetemVerilog code to controll and read in samples from those adc's. Another part of my half of the project was writting 
HDL code that interfaced with a FIFO-to-USB chip, that was used to send data over USB to a computer. 
The code written to do these two things is split into two folders this repository. 

USB_oscope.sv is the top level module for this project. 

project_final_report.pdf is the final report that was written for this project. This report has block diagrams for each part of the project.


This is a link to a video overview of the project, which has more block diagrams and gives a more indepth overview of the project

https://drive.google.com/file/d/1r8u2nNMfyLop7pe8nbi3-C_ytLskglB_/view

