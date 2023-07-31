#--------------------------------------------------------------------------------------------------------------------------------------------------#
# tcl code that will take RTL netlist and SDC constraints as a input, and will generate synthesized netlist & pre-layout timing report as an outpu #
#--------------------------------------------------------------------------------------------------------------------------------------------------#

#--------------------------------------------------------------------------------------------------------------------------------#
#--------------------------------By Vishwajith V Pai , under the guidance of Mr.Kunal Gosh---------------------------------------#
#--------------------------------------------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------#
#---------Checks whether PiSYNTH usage is correct or not--------------#
#---------------------------------------------------------------------#

set enable_prelayout_timing 1
set working_dir [exec pwd]

#--------------------------------------------------------------------------------------------------------------------------------#
#-------------------------------Converts CVS file to a matrix which is used to auto-generate the variables-----------------------#
#--------------------------------------------------------------------------------------------------------------------------------#

set filename [lindex $argv 0]
package require csv
package require struct::matrix
struct::matrix m
set f [open $filename]

#Auto Creation of Variables#

csv::read2matrix $f m , auto ; #reading the csv file into a matrix
close $f
set columns [m columns]
# m add columns $columns #
m link my_arr ; #converting the matrix to an array 
set num_of_rows [m rows]
set i 0
#Now we take the name from the csv and covert it to a variable name #
while {$i < $num_of_rows} {
	puts "\nINFO: Setting $my_arr(0,$i) as '$my_arr(1,$i)'"
	if {$i == 0} {
		set [string map {" " ""} $my_arr(0,$i)] $my_arr(1,$i)
	} else {
		set [string map {" " ""} $my_arr(0,$i)] [file normalize $my_arr(1,$i)] ; #Normalizes ~ , '~' gets removed and becomes a normal address 
	}
	set i [expr {$i+1}]
	}


puts "\nINFO: Below are the list of the initial variables and their values. User can use these variables for further debug.\nUse 'puts <variable name>' command to query value of below variables"

puts "DesignName = $DesignName"
puts "OutputDirectory = $OutputDirectory"
puts "NetlistDirectory = $NetlistDirectory"
puts "EarlyLibraryPath = $EarlyLibraryPath"
puts "LateLibraryPath = $LateLibraryPath"
puts "ConstraintsFile = $ConstraintsFile"

#-------------------------------------------------------------------------------------------------#
#---------------------------------To Check if the  directries are present------------------------#
#------------------------------------------------------------------------------------------------#

if { [file isdirectory $OutputDirectory] } {
	puts "\nINFO: Output directory found in path $OutputDirectory"
	} else { 
	puts "\nERROR : Output directory $OutputDirectory cannot be found....\nCreating $OutputDirectory..."
	file mkdir $OutputDirectory 
	}

if { [file isdirectory $NetlistDirectory] } {
	puts "\nINFO: Netlist directory found in path $NetlistDirectory"
	} else { 
	puts "\nERROR : Netlist directory $NetlistDirectory cannot be found....\nExiting..."
	exit 
	}

if { [file exists $EarlyLibraryPath] } {
	puts "\nINFO: Early Cell Library found in path $EarlyLibraryPath"
	} else { 
	puts "\nERROR : Early cell Library $EarlyLibraryPath cannot be found....\nExiting..."
	exit
	}

if { [file exists $LateLibraryPath] } {
	puts "\nINFO: Late Cell Library found in path $LateLibraryPath"
	} else { 
	puts "\nERROR : Late cell Library $LateLibraryPath cannot be found....\nExiting..."
	exit
	}
	
if { [file exists $ConstraintsFile] } {
	puts "\nINFO: Constraints File found in path $ConstraintsFile"
	} else { 
	puts "\nERROR : Constraints File $ConstraintsFile cannot be found....\nExiting..."
	exit
	}
	
#-----------------------------------------------------------------------------------------------------#
#--------------------------Read the "Cinstraint File" and Convert it to SDC format-------------------#
#----------------------------------------------------------------------------------------------------#

#Convert csv file to matrix and get count of rows and columns#

puts "\nINFO: Dumping SDC constraints for $DesignName"
::struct::matrix constraints
set chan [open $ConstraintsFile]
csv::read2matrix $chan constraints , auto
close $chan
set number_of_rows [constraints rows]
set number_of_columns [constraints columns]

#Assigning the start value for clock, input and output port form  the cvs#

set clock_start [lindex [lindex [constraints search all CLOCKS] 0 ] 1]  
#Here the index comes to 0,0 which is 0 column and 0 row , we take the row value and assign to clock_start, similarly it is done for the other variables #
set input_ports_start [lindex [lindex [constraints search all INPUTS] 0 ] 1] ; #Here the value of the index is 0,4 and of the row is 4 #
set output_ports_start [lindex [lindex [constraints search all OUTPUTS] 0] 1]; #Here the value of the index is 0,27 and of the row is 27 #
# To automate the procedure to find the first column containing the list under the above headding we use the below command #
#This basically sets the cariable clock_start_column to 0 #
set clock_start_column [lindex [lindex [constraints search all CLOCKS] 0 ] 0]

#-------------------------------------------------------------------------------------------#
#-------------------------Clock Constraints - Clock Latency  --> SDC-----------------------#
#-------------------------------------------------------------------------------------------#

set clock_early_rise_delay_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$number_of_columns-1}] [expr {$input_ports_start-1}] early_rise_delay] 0 ] 0]
set clock_early_fall_delay_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$number_of_columns-1}] [expr {$input_ports_start-1}] early_fall_delay] 0 ] 0]
set clock_late_rise_delay_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$number_of_columns-1}] [expr {$input_ports_start-1}] late_rise_delay] 0 ] 0]
set clock_late_fall_delay_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$number_of_columns-1}] [expr {$input_ports_start-1}] late_fall_delay] 0 ] 0]
set clock_early_rise_slew_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$number_of_columns-1}] [expr {$input_ports_start-1}] early_rise_slew] 0 ] 0]
set clock_early_fall_slew_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$number_of_columns-1}] [expr {$input_ports_start-1}] early_fall_slew] 0 ] 0]
set clock_late_rise_slew_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$number_of_columns-1}] [expr {$input_ports_start-1}]  late_rise_slew] 0 ] 0]
set clock_late_fall_slew_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$number_of_columns-1}] [expr {$input_ports_start-1}]  late_fall_slew] 0 ] 0]



set sdc_file [open $OutputDirectory/$DesignName.sdc "w"]
set i [expr {$clock_start+1}]
set end_of_ports [expr {$input_ports_start-1}]

#Clock Constraints#
puts "\nInfo-SDC : Working on clock constraints..... "
while { $i < $end_of_ports } {
	puts "\nWorking on clock [constraints get cell 0 $i]...."
	puts -nonewline $sdc_file "\ncreate_clock -name [constraints get cell 0 $i] -period [constraints get cell 1 $i] -waveform \{0 [expr {[constraints get cell  1 $i]*[constraints get cell 2 $i]/100}]\} \[get_ports [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_latency -source -early -rise [constraints get cell $clock_early_rise_delay_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_latency -source -early -fall [constraints get cell $clock_early_fall_delay_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_latency -source -late -rise [constraints get cell $clock_late_rise_delay_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_latency -source -late -fall [constraints get cell $clock_late_fall_delay_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_transition -rise -min [constraints get cell $clock_early_rise_slew_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_transition -fall -min [constraints get cell $clock_early_fall_slew_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_transition -rise -max [constraints get cell $clock_late_rise_slew_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_transition -fall -max [constraints get cell $clock_late_fall_slew_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	set i [expr {$i+1}]
}

#--------------------------------------------------------------------------------------#
#------------------------Input Constraints - Input Latency -> SDC---------------------#
#-------------------------------------------------------------------------------------#

set input_early_rise_slew_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$number_of_columns-1}] [expr {$output_ports_start-1}] early_rise_slew] 0] 0]
set input_early_fall_slew_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$number_of_columns-1}] [expr {$output_ports_start-1}] early_fall_slew] 0] 0]
set input_late_rise_slew_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$number_of_columns-1}] [expr {$output_ports_start-1}] late_rise_slew] 0] 0]
set input_late_fall_slew_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$number_of_columns-1}] [expr {$output_ports_start-1}] late_fall_slew] 0] 0]
set input_early_rise_delay_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$number_of_columns-1}] [expr {$output_ports_start-1}] early_rise_delay] 0] 0]
set input_early_fall_delay_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$number_of_columns-1}] [expr {$output_ports_start-1}] early_fall_delay] 0] 0]
set input_late_rise_delay_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$number_of_columns-1}] [expr {$output_ports_start-1}] late_rise_delay] 0] 0]
set input_late_fall_delay_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$number_of_columns-1}] [expr {$output_ports_start-1}] late_fall_delay] 0] 0]
set related_clock [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$number_of_columns-1}] [expr {$output_ports_start-1}] clocks] 0] 0]

#Input - IO Constraints#
set i [expr {$input_ports_start+1}]
set end_of_ports [expr {$output_ports_start-1}]
puts "\nInfo-SDC : Working on IO constraints....."
puts "\nInfo-SDC : Categorizing input ports as bits and busses"

while { $i < $end_of_ports } {
	set netlist [glob -dir $NetlistDirectory *.v] ; #Here we are globing the directory - we are trying to identify all the .v files from the directory
	set tmp_file [open /tmp/1 "w"] ; #A temperory file is created in the tmp file area , this file can be deleted later on and is used for processing 
	foreach f $netlist {
	#space seperated .v files are assigned to f
		set fd [open $f] ; #open the . v file in the read mode 
		while {[gets $fd line] != -1} {
			set pattern1 " [constraints get cell 0 $i];" ;#set a patter1 of  ex: "___  cpu_en;"  to be searched
			#The below expression searches for $pattern1 in the entire line of each and every line of all the .v files 
			if {[regexp -all -- $pattern1 $line]} {      
				set pattern2 [lindex [split $line ";"] 0]  ; #The line is split as per the delimiter ";" and we take the 0th element  
				#In the bellow if statement we are splitting the $pattern2 based the delimitter being multiple spaces, and we take the 0th element into consideration, if this element is the word  "input" then enter the block
				if {[regexp -all {input} [lindex [split $pattern2 "\S+"] 0]]} {
					set s1 "[lindex [split $pattern2 "\S+"] 0] [lindex [split $pattern2 "\S+"] 1] [lindex [split $pattern2 "\S+"] 2]"
					#The pattern has 3 elements to account for 0->input 1->in_name 2->blank space, we are creating a new string here 
					puts -nonewline $tmp_file "\n[regsub -all {\s+} $s1 " "]" ; #we put this in the temp file ; we substitute \s+ - multiple spaces by a single space
					#puts "\n[regsub -all {\s+} $s1 " "]" 
					}
				}
			}
		close $fd
		}
		close $tmp_file
		set tmp_file [open /tmp/1 r]
		set tmp2_file [open /tmp/2 w]
		puts -nonewline $tmp2_file [join [lsort -unique [split [read $tmp_file] \n]] \n]
		close $tmp_file
		close $tmp2_file 
		set tmp2_file [open /tmp/2 r]
		set count [llength [read $tmp2_file]]
		if { $count > 2 } {
			set inp_ports [concat [constraints get cell 0 $i]*] ; #Multi-Bit Ports - Busses
			#puts "bussed"
			} else {
			set inp_ports [constraints get cell 0 $i] ; #1 Bit Port
			#puts "not buzzed"
			}
			
			puts -nonewline $sdc_file "\nset_input_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -max -rise [constraints get cell $input_early_rise_delay_start $i] \[get_ports $inp_ports\]"
			puts -nonewline $sdc_file "\nset_input_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -max -fall [constraints get cell $input_early_fall_delay_start $i] \[get_ports $inp_ports\]"
			puts -nonewline $sdc_file "\nset_input_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -min -rise [constraints get cell $input_late_rise_delay_start $i] \[get_ports $inp_ports\]"
			puts -nonewline $sdc_file "\nset_input_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -min -fall [constraints get cell $input_late_fall_delay_start $i] \[get_ports $inp_ports\]"
			puts -nonewline $sdc_file "\nset_input_transition -clock \[get_clocks [constraints get cell $related_clock $i]\] -max -rise  [constraints get cell $input_early_rise_slew_start $i] \[get_ports $inp_ports\]"
			puts -nonewline $sdc_file "\nset_input_transition -clock \[get_clocks [constraints get cell $related_clock $i]\] -max -fall  [constraints get cell $input_early_fall_slew_start $i] \[get_ports $inp_ports\]"
			puts -nonewline $sdc_file "\nset_input_transition -clock \[get_clocks [constraints get cell $related_clock $i]\] -min -rise   [constraints get cell $input_late_rise_slew_start $i] \[get_ports $inp_ports\]"
			puts -nonewline $sdc_file "\nset_input_transition -clock \[get_clocks [constraints get cell $related_clock $i]\] -min -fall   [constraints get cell $input_late_fall_slew_start $i] \[get_ports $inp_ports\]"
			set i [expr {$i+1}]
	}
close $tmp2_file

#--------------------------------------------------------------------------------#
#--------------------Output Constraints - OUTput Latency -> SDC-----------------#
#-------------------------------------------------------------------------------#

set output_early_rise_slew_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$number_of_columns-1}] [expr {$number_of_rows-1}] early_rise_slew] 0] 0]
set output_early_fall_slew_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$number_of_columns-1}] [expr {$number_of_rows-1}] early_fall_slew] 0] 0]
set output_late_rise_slew_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$number_of_columns-1}] [expr {$number_of_rows-1}] late_rise_slew] 0] 0]
set output_late_fall_slew_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$number_of_columns-1}] [expr {$number_of_rows-1}] late_fall_slew] 0] 0]
set output_early_rise_delay_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$number_of_columns-1}] [expr {$number_of_rows-1}] early_rise_delay] 0] 0]
set output_early_fall_delay_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$number_of_columns-1}] [expr {$number_of_rows-1}] early_fall_delay] 0] 0]
set output_late_rise_delay_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$number_of_columns-1}] [expr {$number_of_rows-1}] late_rise_delay] 0] 0]
set output_late_fall_delay_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$number_of_columns-1}] [expr {$number_of_rows-1}] late_fall_delay] 0] 0]
set related_clock [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$number_of_columns-1}] [expr {$number_of_rows-1}] clocks] 0] 0]
set output_load_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$number_of_columns-1}] [expr {$number_of_rows-1}] load] 0] 0]

#Output - IO Constraints#

set i [expr {$output_ports_start+1}]
set end_of_ports [expr {$number_of_rows}]
puts "\nInfo-SDC : Working on IO constraints....."
puts "\nInfo-SDC : Categorizing input ports as bits and busses"

while { $i < $end_of_ports } {
	set netlist [glob -dir $NetlistDirectory *.v] ; #Here we are globing the directory - we are trying to identify all the .v files from the directory
	set tmp_file [open /tmp/1 "w"] ; #A temperory file is created in the tmp file area , this file can be deleted later on and is used for processing 
	foreach f $netlist {
	#space seperated .v files are assigned to f
		set fd [open $f] ; #open the . v file in the read mode 
		while {[gets $fd line] != -1} {
			set pattern1 " [constraints get cell 0 $i];" ;#set a patter1 of  ex: "___  cpu_en;"  to be searched
			#The below expression searches for $pattern1 in the entire line of each and every line of all the .v files 
			if {[regexp -all -- $pattern1 $line]} {      
				set pattern2 [lindex [split $line ";"] 0]  ; #The line is split as per the delimiter ";" and we take the 0th element  
				#In the bellow if statement we are splitting the $pattern2 based the delimitter being multiple spaces, and we take the 0th element into consideration, if this element is the word  "output" then enter the block
				if {[regexp -all {output} [lindex [split $pattern2 "\S+"] 0]]} {
					set s1 "[lindex [split $pattern2 "\S+"] 0] [lindex [split $pattern2 "\S+"] 1] [lindex [split $pattern2 "\S+"] 2]"
					#The pattern has 3 elements to account for 0->output 1->in_name 2->blank space, we are creating a new string here 
					puts -nonewline $tmp_file "\n[regsub -all {\s+} $s1 " "]" ; #we put this in the temp file ; we substitute \s+ - multiple spaces by a single space
					#puts "\n[regsub -all {\s+} $s1 " "]" 
					}
				}
			}
		close $fd
		}
		close $tmp_file
		set tmp_file [open /tmp/1 r]
		set tmp2_file [open /tmp/2 w]
		puts -nonewline $tmp2_file [join [lsort -unique [split [read $tmp_file] \n]] \n]
		close $tmp_file
		close $tmp2_file 
		set tmp2_file [open /tmp/2 r]
		set count [llength [read $tmp2_file]]
		if { $count > 2 } {
			set op_ports [concat [constraints get cell 0 $i]*] ; #Multi-Bit Ports - Busses
			#puts "bussed"
			} else {
			set op_ports [constraints get cell 0 $i] ; #1 Bit Port
			#puts "not buzzed"
			}
			puts -nonewline $sdc_file "\nset_output_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -max -rise  [constraints get cell $output_early_rise_delay_start $i] \[get_ports $op_ports\]"
			puts -nonewline $sdc_file "\nset_output_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -max -fall  [constraints get cell $output_early_fall_delay_start $i] \[get_ports $op_ports\]"
			puts -nonewline $sdc_file "\nset_output_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -min -rise  [constraints get cell $output_late_rise_delay_start $i] \[get_ports $op_ports\]"
			puts -nonewline $sdc_file "\nset_output_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -min -fall [constraints get cell $output_late_fall_delay_start $i] \[get_ports $op_ports\]"
			puts -nonewline $sdc_file "\nset_load [constraints get cell $output_load_start $i] \[get_ports $op_ports\]"
			set i [expr {$i+1}]
	}
close $tmp2_file
close $sdc_file

puts "\nINFO: SDC created. Please use constraints in path $OutputDirectory/$DesignName.sdc"

#--------------------------------------------------#
#             Hierarchy Check                     #
#-------------------------------------------------#

puts "\nINFO: Creating Hierarchy Check script to be used by Yosys"
set data "\nread_liberty -lib -ignore_miss_dir -setattr blackbox ${LateLibraryPath}"
puts "data is \"$data\""
set filename "$DesignName.hier.ys"
puts "filename is \"$filename\""
set fileID [open $OutputDirectory/$filename "w"]
puts -nonewline $fileID $data
set netlist [glob -dir $NetlistDirectory *.v]
puts "The Netlist are :\n\"$netlist\""
foreach f $netlist {
	set data $f 
	puts "data is \"$f\""
	puts "read_verilog $f"
	puts -nonewline $fileID "\nread_verilog $f"
}
puts -nonewline $fileID "\nhierarchy -check"
close $fileID
puts "\nclose \"$OutputDirectory/$filename\"\n"
 
#------------ERROR Handling--------------#

puts "\nChecking Hierarchy.........."

if { [catch { exec yosys -s $OutputDirectory/$DesignName.hier.ys >& $OutputDirectory/$DesignName.hierarchy_check.log} msg] } { 
	set filename "$OutputDirectory/$DesignName.hierarchy_check.log"
	set pattern {referenced in module}
	set count 0
	set fid [open $filename r]
	while {[gets $fid line] != -1} {
		incr count [regexp -all -- $pattern $line]
		if {[regexp -all -- $pattern $line]} {
			puts "\nERROR : Module [lindex $line 2] is not a part of the design $DesignName. Please correct RTL in the path '$NetlistDirectory'"
			puts "\nINFO: Hierarchy check FAILED....."
		}
	}
	close $fid
} else {
	puts "\nINFO : Hierarchy check PASSED"
}
puts "\nINFO : Please find Hierarchy Check details in [file normalize $OutputDirectory/$DesignName.hierarchy_check.log] for more info."


#--------------------------------------------#
#----------Main Synthesis Script------------#
#-------------------------------------------#

puts "\nINFO : Creating main synthesis script to be used by Yosys."
set data "read_liberty -lib -ignore_miss_dir -setattr blackbox ${LateLibraryPath}"
set filename "$DesignName.ys"
set fileID [open $OutputDirectory/$filename "w"]
puts -nonewline $fileID $data 

set netlist [glob -dir $NetlistDirectory *.v]
foreach f $netlist {
	set data $f
	puts -nonewline $fileID "\nread_verilog $f"
}
puts -nonewline $fileID "\nhierarchy -top $DesignName"
puts -nonewline $fileID "\nsynth -top $DesignName"
puts -nonewline $fileID "\nsplitnets -ports -format ___\ndfflibmap -liberty ${LateLibraryPath}\nopt"
puts -nonewline $fileID "\nabc -liberty ${LateLibraryPath}"
puts -nonewline $fileID "\nflatten"
puts -nonewline $fileID "\nclean -purge\niopadmap -outpad BUFX2 A:Y -bits\nopt\nclean"
puts -nonewline $fileID "\nwrite_verilog $OutputDirectory/$DesignName.synth.v"
close $fileID
puts "\nINFO : Synthesis script created and can be accessed from path $OutputDirectory/$DesignName.ys"
puts "\nINFO : Running Synthesis.........."

#-------------------------------------------------------------------------#
#--------------------Run Synthesis Script using Yosys--------------------#
#-------------------------------------------------------------------------#

if {[catch { exec yosys -s $OutputDirectory/$DesignName.ys >& $OutputDirectory/$DesignName.synthesis.log} msg]} {
	puts "\nERROR : Synthesis failed due to errors. Please refer to log $OutputDirectory/$DesignName.synthesis.log ."
	puts "Exiting Tool...."
	exit

} else {
	puts "\nINFO : Synthesis finished successfully"
}
puts "\nINFO : Please refer to log $OutputDirectory/$DesignName.synthesis.log"

#-----------------------------------------------------------------------------------------------#
#-------------------------Edit the Synth.v to be useable by OpenTimer--------------------------#
#----------------------------------------------------------------------------------------------#

set fileID [open /tmp/1 "w"]
puts -nonewline $fileID [exec grep -v -w "*" $OutputDirectory/$DesignName.synth.v]
close $fileID
set output [open $OutputDirectory/$DesignName.final.synth.v "w"]
set filename "/tmp/1"
set fid [open $filename r]
while {[gets $fid line] != -1} {
	puts -nonewline $output [string map {"\\" ""} $line]
	puts -nonewline $output "\n"
}
close $fid
close $output

puts "\nINFO : Please find the synthesized netlist for $DesignName at $OutputDirectory/$DesignName.final.synth.v\n    You can use this netlist for STA or PNR"
puts "\n"
#-----------------------------------------------------------#
#-------------------Recreating SDC File--------------------#
#-----------------------------------------------------------#
puts "\nINFO : Rewriting the SDC File as per final netlist $OutputDirectory/$DesignName.final.synth.v ........... "
set sdc [open $OutputDirectory/$DesignName.sdc r]
set tmp_file [open /tmp/4 w]
set new_sdcfilename [open $OutputDirectory/$DesignName.final.sdc w]
puts -nonewline $tmp_file [string map {"\[" "" "\]" " "} [read $sdc]]
close $tmp_file 
#--------------Converting the create clock to standard format-----------------#
set tmp_file [open /tmp/4 r]
set timing_file [open /tmp/5 w]
set lines [split [read $tmp_file] "\n"]
#puts "$lines"
set find_clocks [lsearch -all -inline $lines "create_clock*"]
#puts "clocks found\n$find_clocks"
foreach elem $find_clocks {
	set clock_port_name [lindex $elem [expr {[lsearch $elem "get_ports"]+1}]]
	set clock_period [lindex $elem [expr {[lsearch $elem "-period"]+1}]]
	set duty_cycle [lindex $elem [expr {[lsearch $elem "-waveform"]+1}]]
	puts -nonewline $timing_file "\ncreate_clock -name $clock_port_name -period $clock_period -waveform \{$duty_cycle\} \[get_ports $clock_port_name\]"
		}
close $tmp_file 
#----------------converting set_clock_latency constraints---------------------#
set find_keyword [lsearch -all -inline $lines "set_clock_latency*"]
set tmp2_file [open /tmp/2 w]
foreach elem $find_keyword {
	set port_name [lindex $elem [expr {[lsearch $elem "get_clocks"]+1}]]
	set para_1 [lindex $elem [expr {[lsearch $elem "-source"]}]]
	set para_2 [lindex $elem [expr {[lsearch $elem "-source"]+1}]]
	set para_3 [lindex $elem [expr {[lsearch $elem "-source"]+2}]]
	set val_x  [lindex $elem [expr {[lsearch $elem "-source"]+3}]]
	puts -nonewline $tmp2_file "\nset_clock_latency $para_1 $para_2 $para_3 $val_x \[get_clocks $port_name\]"
}
close $tmp2_file
set tmp2_file [open /tmp/2 r]
puts -nonewline $timing_file [read $tmp2_file]
close $tmp2_file
#-----------------------converting set_clock_transition constraints-----------------------#
set find_keyword [lsearch -all -inline $lines "set_clock_transition*"]
set tmp2_file [open /tmp/2 w]
foreach elem $find_keyword {
	set port_name [lindex $elem [expr {[lsearch $elem "get_clocks"]+1}]]
	if {[lindex $elem [expr {[lsearch $elem "-rise"]}]] == "-rise" } {
		set para_1 [lindex $elem [expr {[lsearch $elem "-rise"]}]]
		if {[lindex $elem [expr {[lsearch $elem "-rise"]+1}]] == "-max"} {
			set para_2 [lindex $elem [expr {[lsearch $elem "-rise"]+1}]]
		} else {
			set para_2 [lindex $elem [expr {[lsearch $elem "-rise"]+1}]]	 
		}
		set val_x  [lindex $elem [expr {[lsearch $elem "-rise"]+2}]]
	} else {
		set para_1 [lindex $elem [expr {[lsearch $elem "-fall"]}]]
		if {[lindex $elem [expr {[lsearch $elem "-fall"]+1}]] == "-max"} {
			set para_2 [lindex $elem [expr {[lsearch $elem "-fall"]+1}]]
		} else {
			set para_2 [lindex $elem [expr {[lsearch $elem "-fall"]+1}]]	 
		}
		set val_x  [lindex $elem [expr {[lsearch $elem "-fall"]+2}]]
	}
	puts -nonewline $tmp2_file "\nset_clock_transition $para_1 $para_2 $val_x \[get_clocks $port_name\]"
}
close $tmp2_file
set tmp2_file [open /tmp/2 r]
puts -nonewline $timing_file [read $tmp2_file]
close $tmp2_file
#----------------------converting set_input_delay constraints---------------------------#
set find_keyword [lsearch -all -inline $lines "set_input_delay*"]
set tmp2_file [open /tmp/2 w]
foreach elem $find_keyword {
	set port_name [lindex $elem [expr {[lsearch $elem "get_ports"]+1}]]
	set clock_name [lindex $elem [expr {[lsearch $elem "get_clocks"]+1}]]
	if {[lindex $elem [expr {[lsearch $elem "-max"]}]] == "-max"} {
		set para_1 [lindex $elem [expr {[lsearch $elem "-max"]}]]
		if {[lindex $elem [expr {[lsearch $elem "-max"]+1}]] == "-rise"} {
			set para_2 [lindex $elem [expr {[lsearch $elem "-max"]+1}]]
			set val_x [lindex $elem [expr {[lsearch $elem "-max"]+2}]]  
			#----to check if bussed of not----#
			if {[regexp -all -- {\*} $port_name]} {
				set final_synth_netlist [open $OutputDirectory/$DesignName.final.synth.v]
				while {[gets $final_synth_netlist line2] != -1} {
					if {[regexp -all -- $port_name $line2] && [regexp -all -- {input} $line2] && ![string match "" $port_name]} {
						set real_port_name [lindex [lindex [split $line2 ";"] 0] 1]
						puts -nonewline $tmp2_file "\nset_input_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $real_port_name\]"
					}
				}
			} else {
				puts -nonewline $tmp2_file "\nset_input_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $port_name\]" 
			}
		} else {
			set para_2 [lindex $elem [expr {[lsearch $elem "-max"]+1}]]
			set val_x [lindex $elem [expr {[lsearch $elem "-max"]+2}]]  
			#----to check if bussed of not----#
			if {[regexp -all -- {\*} $port_name]} {
				set final_synth_netlist [open $OutputDirectory/$DesignName.final.synth.v]
				while {[gets $final_synth_netlist line2] != -1} {
					if {[regexp -all -- $port_name $line2] && [regexp -all -- {input} $line2] && ![string match "" $port_name]} {
						set real_port_name [lindex [lindex [split $line2 ";"] 0] 1]
						puts -nonewline $tmp2_file "\nset_input_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $real_port_name\]"
					}
				}
			} else {
				puts -nonewline $tmp2_file "\nset_input_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $port_name\]" 
			}
		}
		 
	} else {
		set para_1 [lindex $elem [expr {[lsearch $elem "-min"]}]]
		if {[lindex $elem [expr {[lsearch $elem "-min"]+1}]] == "-rise"} {
			set para_2 [lindex $elem [expr {[lsearch $elem "-min"]+1}]]
			set val_x [lindex $elem [expr {[lsearch $elem "-min"]+2}]]  
			#----to check if bussed of not----#
			if {[regexp -all -- {\*} $port_name]} {
				set final_synth_netlist [open $OutputDirectory/$DesignName.final.synth.v]
				while {[gets $final_synth_netlist line2] != -1} {
					if {[regexp -all -- $port_name $line2] && [regexp -all -- {input} $line2] && ![string match "" $port_name]} {
						set real_port_name [lindex [lindex [split $line2 ";"] 0] 1]
						puts -nonewline $tmp2_file "\nset_input_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $real_port_name\]"
					}
				}
			} else {
				puts -nonewline $tmp2_file "\nset_input_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $port_name\]" 
			}
		} else {
			set para_2 [lindex $elem [expr {[lsearch $elem "-min"]+1}]]
			set val_x [lindex $elem [expr {[lsearch $elem "-min"]+2}]]  
			#----to check if bussed of not----#
			if {[regexp -all -- {\*} $port_name]} {
				set final_synth_netlist [open $OutputDirectory/$DesignName.final.synth.v]
				while {[gets $final_synth_netlist line2] != -1} {
					if {[regexp -all -- $port_name $line2] && [regexp -all -- {input} $line2] && ![string match "" $port_name]} {
						set real_port_name [lindex [lindex [split $line2 ";"] 0] 1]
						puts -nonewline $tmp2_file "\nset_input_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $real_port_name\]"
					}
				}
			} else {
				puts -nonewline $tmp2_file "\nset_input_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $port_name\]" 
			}
		}
		 
	}
}
close $tmp2_file
set tmp2_file [open /tmp/2 r]
puts -nonewline $timing_file [read $tmp2_file]
close $tmp2_file
#----------------------converting set_input_transition constraints---------------------------#
set find_keyword [lsearch -all -inline $lines "set_input_transition*"]
set tmp2_file [open /tmp/2 w]
foreach elem $find_keyword {
	set port_name [lindex $elem [expr {[lsearch $elem "get_ports"]+1}]]
	set clock_name [lindex $elem [expr {[lsearch $elem "get_clocks"]+1}]]
	if {[lindex $elem [expr {[lsearch $elem "-max"]}]] == "-max"} {
		set para_1 [lindex $elem [expr {[lsearch $elem "-max"]}]]
		if {[lindex $elem [expr {[lsearch $elem "-max"]+1}]] == "-rise"} {
			set para_2 [lindex $elem [expr {[lsearch $elem "-max"]+1}]]
			set val_x [lindex $elem [expr {[lsearch $elem "-max"]+2}]]  
			#----to check if bussed of not----#
			if {[regexp -all -- {\*} $port_name]} {
				set final_synth_netlist [open $OutputDirectory/$DesignName.final.synth.v]
				while {[gets $final_synth_netlist line2] != -1} {
					if {[regexp -all -- $port_name $line2] && [regexp -all -- {input} $line2] && ![string match "" $port_name]} {
						set real_port_name [lindex [lindex [split $line2 ";"] 0] 1]
						puts -nonewline $tmp2_file "\nset_input_transition -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $real_port_name\]"
					}
				}
			} else {
				puts -nonewline $tmp2_file "\nset_input_transition -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $port_name\]" 
			}
		} else {
			set para_2 [lindex $elem [expr {[lsearch $elem "-max"]+1}]]
			set val_x [lindex $elem [expr {[lsearch $elem "-max"]+2}]]  
			#----to check if bussed of not----#
			if {[regexp -all -- {\*} $port_name]} {
				set final_synth_netlist [open $OutputDirectory/$DesignName.final.synth.v]
				while {[gets $final_synth_netlist line2] != -1} {
					if {[regexp -all -- $port_name $line2] && [regexp -all -- {input} $line2] && ![string match "" $port_name]} {
						set real_port_name [lindex [lindex [split $line2 ";"] 0] 1]
						puts -nonewline $tmp2_file "\nset_input_transition -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $real_port_name\]"
					}
				}
			} else {
				puts -nonewline $tmp2_file "\nset_input_transition -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $port_name\]" 
			}
		}
		 
	} else {
		set para_1 [lindex $elem [expr {[lsearch $elem "-min"]}]]
		if {[lindex $elem [expr {[lsearch $elem "-min"]+1}]] == "-rise"} {
			set para_2 [lindex $elem [expr {[lsearch $elem "-min"]+1}]]
			set val_x [lindex $elem [expr {[lsearch $elem "-min"]+2}]]  
			#----to check if bussed of not----#
			if {[regexp -all -- {\*} $port_name]} {
				set final_synth_netlist [open $OutputDirectory/$DesignName.final.synth.v]
				while {[gets $final_synth_netlist line2] != -1} {
					if {[regexp -all -- $port_name $line2] && [regexp -all -- {input} $line2] && ![string match "" $port_name]} {
						set real_port_name [lindex [lindex [split $line2 ";"] 0] 1]
						puts -nonewline $tmp2_file "\nset_input_transition -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $real_port_name\]"
					}
				}
			} else {
				puts -nonewline $tmp2_file "\nset_input_transition -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $port_name\]" 
			}
		} else {
			set para_2 [lindex $elem [expr {[lsearch $elem "-min"]+1}]]
			set val_x [lindex $elem [expr {[lsearch $elem "-min"]+2}]]  
			#----to check if bussed of not----#
			if {[regexp -all -- {\*} $port_name]} {
				set final_synth_netlist [open $OutputDirectory/$DesignName.final.synth.v]
				while {[gets $final_synth_netlist line2] != -1} {
					if {[regexp -all -- $port_name $line2] && [regexp -all -- {input} $line2] && ![string match "" $port_name]} {
						set real_port_name [lindex [lindex [split $line2 ";"] 0] 1]
						puts -nonewline $tmp2_file "\nset_input_transition -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $real_port_name\]"
					}
				}
			} else {
				puts -nonewline $tmp2_file "\nset_input_transition -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $port_name\]" 
			}
		}
		 
	}
}
close $tmp2_file
set tmp2_file [open /tmp/2 r]
puts -nonewline $timing_file [read $tmp2_file]
close $tmp2_file
#------------------------converting set_output_delay constraints-----------------------------#
set find_keyword [lsearch -all -inline $lines "set_output_delay*"]
set tmp2_file [open /tmp/2 w]
foreach elem $find_keyword {
	set port_name [lindex $elem [expr {[lsearch $elem "get_ports"]+1}]]
	set clock_name [lindex $elem [expr {[lsearch $elem "get_clocks"]+1}]]
	if {[lindex $elem [expr {[lsearch $elem "-max"]}]] == "-max"} {
		set para_1 [lindex $elem [expr {[lsearch $elem "-max"]}]]
		if {[lindex $elem [expr {[lsearch $elem "-max"]+1}]] == "-rise"} {
			set para_2 [lindex $elem [expr {[lsearch $elem "-max"]+1}]]
			set val_x [lindex $elem [expr {[lsearch $elem "-max"]+2}]]  
			#----to check if bussed of not----#
			if {[regexp -all -- {\*} $port_name]} {
				set final_synth_netlist [open $OutputDirectory/$DesignName.final.synth.v]
				while {[gets $final_synth_netlist line2] != -1} {
					if {[regexp -all -- $port_name $line2] && [regexp -all -- {output} $line2] && ![string match "" $port_name]} {
						set real_port_name [lindex [lindex [split $line2 ";"] 0] 1]
						puts -nonewline $tmp2_file "\nset_output_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $real_port_name\]"
					}
				}
			} else {
				puts -nonewline $tmp2_file "\nset_output_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $port_name\]" 
			}
		} else {
			set para_2 [lindex $elem [expr {[lsearch $elem "-max"]+1}]]
			set val_x [lindex $elem [expr {[lsearch $elem "-max"]+2}]]  
			#----to check if bussed of not----#
			if {[regexp -all -- {\*} $port_name]} {
				set final_synth_netlist [open $OutputDirectory/$DesignName.final.synth.v]
				while {[gets $final_synth_netlist line2] != -1} {
					if {[regexp -all -- $port_name $line2] && [regexp -all -- {output} $line2] && ![string match "" $port_name]} {
						set real_port_name [lindex [lindex [split $line2 ";"] 0] 1]
						puts -nonewline $tmp2_file "\nset_output_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $real_port_name\]"
					}
				}
			} else {
				puts -nonewline $tmp2_file "\nset_output_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $port_name\]" 
			}
		}
		 
	} else {
		set para_1 [lindex $elem [expr {[lsearch $elem "-min"]}]]
		if {[lindex $elem [expr {[lsearch $elem "-min"]+1}]] == "-rise"} {
			set para_2 [lindex $elem [expr {[lsearch $elem "-min"]+1}]]
			set val_x [lindex $elem [expr {[lsearch $elem "-min"]+2}]]  
			#----to check if bussed of not----#
			if {[regexp -all -- {\*} $port_name]} {
				set final_synth_netlist [open $OutputDirectory/$DesignName.final.synth.v]
				while {[gets $final_synth_netlist line2] != -1} {
					if {[regexp -all -- $port_name $line2] && [regexp -all -- {output} $line2] && ![string match "" $port_name]} {
						set real_port_name [lindex [lindex [split $line2 ";"] 0] 1]
						puts -nonewline $tmp2_file "\nset_output_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $real_port_name\]"
					}
				}
			} else {
				puts -nonewline $tmp2_file "\nset_output_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $port_name\]" 
			}
		} else {
			set para_2 [lindex $elem [expr {[lsearch $elem "-min"]+1}]]
			set val_x [lindex $elem [expr {[lsearch $elem "-min"]+2}]]  
			#----to check if bussed of not----#
			if {[regexp -all -- {\*} $port_name]} {
				set final_synth_netlist [open $OutputDirectory/$DesignName.final.synth.v]
				while {[gets $final_synth_netlist line2] != -1} {
					if {[regexp -all -- $port_name $line2] && [regexp -all -- {output} $line2] && ![string match "" $port_name]} {
						set real_port_name [lindex [lindex [split $line2 ";"] 0] 1]
						puts -nonewline $tmp2_file "\nset_output_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $real_port_name\]"
					}
				}
			} else {
				puts -nonewline $tmp2_file "\nset_output_delay -clock \[get_clocks $clock_name\] $para_1 $para_2 $val_x \[get_ports $port_name\]" 
			}
		}
		 
	}
}
close $tmp2_file
set tmp2_file [open /tmp/2 r]
puts -nonewline $timing_file [read $tmp2_file]
close $tmp2_file
#-------------------------converting set_load constraints------------------------------------#
set find_keyword [lsearch -all -inline $lines "set_load*"]
set tmp2_file [open /tmp/2 w]
foreach elem $find_keyword {
	set port_name [lindex $elem [expr {[lsearch $elem "get_ports"]+1}]]
	#puts "$port_name"
	set val_x [lindex $elem [expr {[lsearch $elem "get_ports"]-1}]]  
	if {[regexp -all -- {\*} $port_name]} {
		set final_synth_netlist [open $OutputDirectory/$DesignName.final.synth.v]
		while {[gets $final_synth_netlist line2] != -1} {
			if {[regexp -all -- $port_name $line2] && [regexp -all -- {output} $line2] && ![string match "" $port_name]} {
				set real_port_name [lindex [lindex [split $line2 ";"] 0] 1]
				#puts "$real_port_name"
				puts -nonewline $tmp2_file "\nset_load $val_x \[get_ports $real_port_name\]"
			}
		}
	} else {
		puts -nonewline $tmp2_file "\nset_load $val_x \[get_ports $port_name\]"
	}
}
close $tmp2_file
set tmp2_file [open /tmp/2 r]
puts -nonewline $timing_file [read $tmp2_file]
close $tmp2_file			
#--------------------------------------------------------------------------------------------#
close $timing_file
set timing_file [open /tmp/5 r]
puts -nonewline $new_sdcfilename [read $timing_file]
close $timing_file
close $new_sdcfilename 

puts "\nINFO : Refer $OutputDirectory/$DesignName.final.sdc for final SDC"
#--------------------------------------------------------------------------------------#
#-------------------------Static Timing Analysis using OpenTimer----------------------#
#-------------------------------------------------------------------------------------#

puts "\nINFO : Timing Analysis Started......"
puts "\nINFO : Initializing number of threads, libraries, sdc, verilog netlist path....."
source /home/vpai/tcl_project/procs/reopenStdout.proc
source /home/vpai/tcl_project/procs/set_num_threads.proc 
reopenStdout $OutputDirectory/$DesignName.conf
set_multi_cpu_usage -localCpu 3

source /home/vpai/tcl_project/procs/read_lib.proc 
read_lib -early  $EarlyLibraryPath
read_lib -late $LateLibraryPath

source /home/vpai/tcl_project/procs/read_verilog.proc 
read_verilog $OutputDirectory/$DesignName.final.synth.v


puts "read_sdc $OutputDirectory/$DesignName.final.sdc"
reopenStdout /dev/tty

if {$enable_prelayout_timing == 1} {
	puts "\nINFO : enable_prelayout_timing is $enable_prelayout_timing. Enabling zero-wire load parasitics"
	set spef_file [open $OutputDirectory/$DesignName.spef w]
	puts $spef_file "*SPEF \"IEEE 1481-1998\" "
	puts $spef_file "*DESIGN \"$DesignName\" "
	puts $spef_file "*DATE \"Tue Nov 25 16:55:03 2014\" "
	puts $spef_file "*VENDOR \"TAU 2015 Contest\" "
	puts $spef_file "*PROGRAM \"Benchmark Parasitic Generator\" "
	puts $spef_file "*VERSION \"0.0\" "
        puts $spef_file "*DESIGN_FLOW \"NETLIST_TYPE_VERILOG\" "
        puts $spef_file "*DIVIDER / "
	puts $spef_file "*DELIMITER : "
	puts $spef_file "*BUS_DELIMITER \[ \] "
	puts $spef_file "*T_UNIT 1 PS"
	puts $spef_file "*C_UNIT 1 FF "
	puts $spef_file "*R_UNIT 1 KOHM "
	puts $spef_file "*L_UNIT 1 UH "
}
close $spef_file

set conf_file [open $OutputDirectory/$DesignName.conf a] ; #Append Mode 
puts $conf_file "read_spef $OutputDirectory/$DesignName.spef"
puts $conf_file "init_timer "
puts $conf_file "dump_timer "
puts $conf_file "report_wns "
puts $conf_file "report_tns "
puts $conf_file "report_timing -num_paths 10000 "
close $conf_file

set time_elapsed_in_us [time {exec /home/vpai/tcl_project/bin/ot-shell < $OutputDirectory/$DesignName.conf >& $OutputDirectory/$DesignName.results}]
set time_elapsed_in_sec "[expr {[lindex $time_elapsed_in_us 0]/100000}]sec"
puts "\nINFO : STA finished in $time_elapsed_in_sec seconds."
puts "\nINFO : Refer to $OutputDirectory/$DesignName.results for warnings and errors"
return











	

	



















































































