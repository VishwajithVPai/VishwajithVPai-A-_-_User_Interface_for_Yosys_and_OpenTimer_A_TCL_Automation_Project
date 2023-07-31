# VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project
VishwajithVPai/A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project

PiSYNTH is a unique User Interface (UI) that will take RTL netlist and SDC constraints as a input, and will generate synthesized netlist & pre-layout timing report as an output. It uses Yosys open-source tool for synthesis and OpenTimer to generate pre-layout timing reports.
This project is done as per the course VSD - TCL Programming from Novice to Expert This project is done by Vishwajith V Pai under the guidance of Kunal Gosh.

# Introduction
TCL (Tool Command Language) is widely used in the VLSI sector for scripting and automation in electronic design automation (EDA) operations.
It's utilised to automate operations including design setup, simulation, synthesis, timing analysis, and verification. 
TCL is also used to set design restrictions, integrate several EDA tools, create test benches, test chips, and customise and enhance tool functionality.
TCL, in general, plays an important role in streamlining the design processes and increasing productivity in the VLSI sector.

# Overview of the Project 
* Input file is .csv file that contains the following details namely Design name, paths for the library, netlist used, and output generated.
* Converted constraints file into sdc format file differentiating bit and a bus by "*".
* Created .ys file and passed it to the Yosys tool and generated the synthesis.v file
* Processed the synthesis.v file and generated synthesis.final.v file
* Converted sdc format file into the corresponding .timing file
* Created .config file and passed it to the OpenTimer tool and generated .results file
* Extracted the desired contents from the .results file

# Shell Code
This code is given in the folder Code and can be referred.
![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/39d25ec2-8759-46a5-9802-f0885631d877)
