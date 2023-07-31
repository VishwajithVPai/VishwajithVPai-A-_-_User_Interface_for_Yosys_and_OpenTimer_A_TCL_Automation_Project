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

# TCL Code 
This code is given in the folder Code and can be referred.
![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/d23f76a7-6e6b-4745-a4b4-d4dfe955193b)
![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/8bef1668-3842-4851-bae6-c7e1903b3d59)

# Shell Outputs
![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/de526a6b-0333-47ea-9e76-3b115cbe015e)
                                               
->When No input .csv file is given

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/84a9c513-fd69-458a-8aff-04bc132f2f9a)

->Help Option

* When the design details are given as a .csv file , the tool creates the SDC file , performs Synthesis and performs Static Timing Analysis

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/abf1c584-a85d-4394-90a7-8e9d5e1ab46c)

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/5848d1d5-b105-4126-90e2-9e4d74be1ddb)

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/2f83f871-9f72-4b39-8228-df23008d6add)

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/9dcb1042-1773-42cd-8d2f-373c93995774)

* The outputs are :

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/2052abc4-7c8b-404e-bfe5-818f007b6297)

->SDC File created

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/4a7f734c-7d37-47a7-b1dd-475abe2219c7)

->Synthesis Command File

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/ac299b3c-2dd5-448f-a8d0-a1603808a2f0)

->Hierarchy Check Log 

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/8f8bfe28-2d42-4e89-bf44-200858bcc52c)

->Synthesis Log

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/52d0306d-8060-4025-9a80-ebc6e6bd6c90)

->Synthesized Netlist File

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/98e38722-b5c2-44e2-ba55-fffce34a37b8)

->Config File

* STA Result

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/6dc89b1c-af9c-4814-a689-40858f7af59f)

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/aff120ec-34c5-4014-95d8-8528d1a6d93e)

Here I have run the STA based on the SDC only, which is supported by OpenTimer, for which I had to convert the bussed ports like pre_addr* which would be normally accepted in tools like prime time to it bit format of pre_addr_0_, pre_addr_1_ ….., which is accepted by OpenTimer.
Yet some constraints like clock latency and clock transition were not supported.
The WNS was found out to be 222.093ns , but the critical path could not be found since the constraints file had yet to decide the clocks for the circuit, as shown below.

![image](https://github.com/VishwajithVPai/VishwajithVPai-A-_-Graphical_User_Interface_for_Yosys_and_OpenTimer_A_TCL_Automation_Project/assets/130815256/1540c28d-0e4c-45e5-a4ae-d0c1d33621e7)

## Tools used in the project






















