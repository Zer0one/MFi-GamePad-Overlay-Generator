#!/bin/bash

cd -- "$(dirname "$0")"

OLDIFS=$IFS
IFS=$'\n'
shopt -s nullglob

### Variables definition
## Common - Targets prorieties Definition
olayFS="true"
olayNorm="true"
olayRangeMod="1.5"
olayAlphaMod="2.0"

## Common - Button Definition Table
# Function							# Geometry					# SizeX	(Landscape)			# SizeY (Landscape)			# Image									# SizeX (Portrait)			# SizeY (Portrait)
btnShow[0]="overlay_next"			;btnShow[1]="radial"		;btnShow[2]="0.026"			;btnShow[3]="0.046"			;btnShow[4]="show.png"					
btnHide[0]="overlay_next"			;btnHide[1]="radial"		;btnHide[2]="0.026"			;btnHide[3]="0.046"			;btnHide[4]="hide.png"					
btnStaShow[0]="overlay_next"		;btnStaShow[1]="radial"		;btnStaShow[2]="0.026"		;btnStaShow[3]="0.046"		;btnStaShow[4]="show.png"				
btnStaHide[0]="overlay_next"		;btnStaHide[1]="radial"		;btnStaHide[2]="0.026"		;btnStaHide[3]="0.046"		;btnStaHide[4]="hide.png"				
btnStaRew[0]="rewind"				;btnStaRew[1]="radial"		;btnStaRew[2]="0.026"		;btnStaRew[3]="0.046"		;btnStaRew[4]="c_rew.png"				
btnStaFfw[0]="toggle_fast_forward"	;btnStaFfw[1]="radial"		;btnStaFfw[2]="0.026"		;btnStaFfw[3]="0.046"		;btnStaFfw[4]="c_ffw.png"			
btnStaDec[0]="state_slot_decrease"	;btnStaDec[1]="radial"		;btnStaDec[2]="0.026"		;btnStaDec[3]="0.046"		;btnStaDec[4]="less.png"				
btnStaInc[0]="state_slot_increase"	;btnStaInc[1]="radial"		;btnStaInc[2]="0.026"		;btnStaInc[3]="0.046"		;btnStaInc[4]="plus.png"				
btnStaSave[0]="save_state"			;btnStaSave[1]="radial"		;btnStaSave[2]="0.026"		;btnStaSave[3]="0.046"		;btnStaSave[4]="c_save.png"				
btnStaLoad[0]="load_state"			;btnStaLoad[1]="radial"		;btnStaLoad[2]="0.026"		;btnStaLoad[3]="0.046"		;btnStaLoad[4]="c_load.png"				
btnSelectCon[0]="select"			;btnSelectCon[1]="rect"		;btnSelectCon[2]="0.038"	;btnSelectCon[3]="0.04"		;btnSelectCon[4]="select_psx.png"		;btnSelectCon[5]="0.068"	;btnSelectCon[6]="0.0225"
btnStartCon[0]="start"				;btnStartCon[1]="rect"		;btnStartCon[2]="0.036"		;btnStartCon[3]="0.04"		;btnStartCon[4]="start_psx.png"			;btnStartCon[5]="0.0632"	;btnStartCon[6]="0.0225"	
btnSelectArc[0]="select"			;btnSelectArc[1]="radial"	;btnSelectArc[2]="0.042"	;btnSelectArc[3]="0.074"	;btnSelectArc[4]="coin.png"				
btnStartArc[0]="start"				;btnStartArc[1]="radial"	;btnStartArc[2]="0.042"		;btnStartArc[3]="0.074"		;btnStartArc[4]="start_rounded.png"		
btnL3[0]="l3"						;btnL3[1]="radial"			;btnL3[2]="0.07"			;btnL3[3]="0.125"			;btnL3[4]="L_face.png"					
btnR3[0]="r3"						;btnR3[1]="radial"			;btnR3[2]="0.07"			;btnR3[3]="0.125"			;btnR3[4]="R_face.png"					
btnL3Low[0]="l3"					;btnL3Low[1]="rect"			;btnL3Low[2]="0.052"		;btnL3Low[3]="0.0926"		;btnL3Low[4]="L_down.png"				;btnL3Low[5]="0.0926"		;btnL3Low[6]="0.052"
btnR3Low[0]="r3"					;btnR3Low[1]="rect"			;btnR3Low[2]="0.052"		;btnR3Low[3]="0.0926"		;btnR3Low[4]="R_down.png"				;btnR3Low[5]="0.0926"		;btnR3Low[6]="0.052"
btnShaPre[0]="shader_prev"			;btnShaPre[1]="radial"		;btnShaPre[2]="0.026"		;btnShaPre[3]="0.046"		;btnShaPre[4]="c_left.png"				
btnShaNex[0]="shader_next"			;btnShaNex[1]="radial"		;btnShaNex[2]="0.026"		;btnShaNex[3]="0.046"		;btnShaNex[4]="c_right.png"				
btnOrie[0]="overlay_next"			;btnOrie[1]="radial"		;btnOrie[2]="0.026"			;btnOrie[3]="0.046"			;btnOrie[4]="rotate.png"				
btnBtnM[0]="overlay_next"			;btnBtnM[1]="rect"			;btnBtnM[2]="0.038"			;btnBtnM[3]="0.04"			;btnBtnM[4]="mode_square_text.png"		;btnBtnM[5]="0.068"			;btnBtnM[6]="0.0225"
btnMenu[0]="menu_toggle"			;btnMenu[1]="radial"		;btnMenu[2]="0.026"			;btnMenu[3]="0.046"			;btnMenu[4]="rgui.png"					
btnReset[0]="reset"					;btnReset[1]="rect"			;btnReset[2]="0.038"		;btnReset[3]="0.04"			;btnReset[4]="reset_square_text.png"	;btnReset[5]="0.068"		;btnReset[6]="0.0225"
btnKeyBd[0]="osk_toggle"			;btnKeyBd[1]="rect"			;btnKeyBd[2]="0.038"		;btnKeyBd[3]="0.0675"		;btnKeyBd[4]="keyboard.png"				;btnKeyBd[5]="0.0675"		;btnKeyBd[6]="0.038"

## Common - B(utton) G(roup) P(osition) Table
# Top Group (Landscape)
bgpTopX_L[0]="0.05"	 ;bgpTopY_L[0]="0.09"	# Hide Button
bgpTopX_L[1]="0.2"	 ;bgpTopY_L[1]="0.09"	# Shader Previous
bgpTopX_L[2]="0.37"	 ;bgpTopY_L[2]="0.09"	# Button Mode Switch Button
bgpTopX_L[3]="0.5"	 ;bgpTopY_L[3]="0.20"	# Menu Toggle Button
bgpTopX_L[4]="0.63"	 ;bgpTopY_L[4]="0.09"	# Reset Button
bgpTopX_L[5]="0.80"	 ;bgpTopY_L[5]="0.09"	# Shader Next
bgpTopX_L[6]="0.95"	 ;bgpTopY_L[6]="0.09"	# Show Button

# Saves Manage Group(Landscape)
bgpSavX_L[0]="0.05"	 ;bgpSavY_L[0]="0.3"	# State Slot Dec Button
bgpSavX_L[1]="0.95"	 ;bgpSavY_L[1]="0.3"	# State Slot Inc Button
bgpSavX_L[2]="0.05"	 ;bgpSavY_L[2]="0.5"	# Load State Button
bgpSavX_L[3]="0.95"	 ;bgpSavY_L[3]="0.5"	# Save State Button
bgpSavX_L[4]="0.05"	 ;bgpSavY_L[4]="0.7"	# Rewind Button
bgpSavX_L[5]="0.95"	 ;bgpSavY_L[5]="0.7"	# Fast Forward Button

# Thumb Buttons Group (Landscape)
bgpTmbX_L[0]="0.275" ;bgpTmbY_L[0]="0.75"	# Thumb L3 Button
bgpTmbX_L[1]="0.725" ;bgpTmbY_L[1]="0.75"	# Thumb R3 Button

# Thumb Buttons Group - Low Variant (Landscape)
bgpTmLX_L[0]="0.275" ;bgpTmLY_L[0]="0.948"	# Thumb L3 Button (Low Variant)
bgpTmLX_L[1]="0.725" ;bgpTmLY_L[1]="0.948"	# Thumb R3 Button (Low Variant)

# Bottom Group (Landscape)
bgpBtmX_L[0]="0.05"	 ;bgpBtmY_L[0]="0.90"	# Save Show/Hide Button (Left)
bgpBtmX_L[1]="0.14"	 ;bgpBtmY_L[1]="0.90"	# Select Button
bgpBtmX_L[2]="0.5"	 ;bgpBtmY_L[2]="0.90"	# Orientation Switch Button
bgpBtmX_L[3]="0.86"	 ;bgpBtmY_L[3]="0.90"	# Start Button
bgpBtmX_L[4]="0.95"	 ;bgpBtmY_L[4]="0.90"	# Save Show/Hide Button (Right)
bgpBtmX_L[5]="0.5"	 ;bgpBtmY_L[5]="0.75"	# Show on-screen Keyboard

# Top Group (Portrait)
bgpTopX_P[0]="0.09"	 ;bgpTopY_P[0]="0.05"	# Hide Button
bgpTopX_P[1]="0.223" ;bgpTopY_P[1]="0.05"	# Shader Previous
bgpTopX_P[2]="0.355" ;bgpTopY_P[2]="0.09"	# Button Mode Switch Button
bgpTopX_P[3]="0.5"	 ;bgpTopY_P[3]="0.155"	# Menu Toggle Button
bgpTopX_P[4]="0.645" ;bgpTopY_P[4]="0.09"	# Reset Button
bgpTopX_P[5]="0.777" ;bgpTopY_P[5]="0.05"	# Shader Next
bgpTopX_P[6]="0.91"	 ;bgpTopY_P[6]="0.05"	# Show Button

# Saves Manage Group(Portrait)
bgpSavX_P[0]="0.09"	 ;bgpSavY_P[0]="0.57"	# State Slot Dec Button
bgpSavX_P[1]="0.91"	 ;bgpSavY_P[1]="0.57"	# State Slot Inc Button
bgpSavX_P[2]="0.09"	 ;bgpSavY_P[2]="0.67"	# Load State Button
bgpSavX_P[3]="0.91"	 ;bgpSavY_P[3]="0.67"	# Save State Button
bgpSavX_P[4]="0.09"	 ;bgpSavY_P[4]="0.77"	# Rewind Button
bgpSavX_P[5]="0.91"	 ;bgpSavY_P[5]="0.77"	# Fast Forward Button

# Thumb Buttons Group (Portrait)
bgpTmbX_P[0]="0.275" ;bgpTmbY_P[0]="0.86"	# Thumb L3 Button
bgpTmbX_P[1]="0.725" ;bgpTmbY_P[1]="0.86"	# Thumb R3 Button

# Thumb Buttons Group - Low Variant (Portrait)
bgpTmLX_P[0]="0.371" ;bgpTmLY_P[0]="0.97"	# Thumb L3 Button (Low Variant)
bgpTmLX_P[1]="0.629" ;bgpTmLY_P[1]="0.97"	# Thumb R3 Button (Low Variant)

# Bottom Group (Portrait)
bgpBtmX_P[0]="0.09"	 ;bgpBtmY_P[0]="0.87"	# Save Show/Hide Button (Left)
bgpBtmX_P[1]="0.14"	 ;bgpBtmY_P[1]="0.944"	# Select Button
bgpBtmX_P[2]="0.5"	 ;bgpBtmY_P[2]="0.944"	# Orientation Switch Button
bgpBtmX_P[3]="0.86"	 ;bgpBtmY_P[3]="0.944"	# Start Button
bgpBtmX_P[4]="0.91"	 ;bgpBtmY_P[4]="0.87"	# Save Show/Hide Button (Right)
bgpBtmX_P[5]="0.5"	 ;bgpBtmY_P[5]="0.87"	# Show on-screen Keyboard

# Bottom Group Exceptions (Portrait - Low Button Mode)
bgpBtmX_PLw[2]="${bgpBtmX_P[2]}" ;bgpBtmY_PLw[2]="0.87"		# Orientation Switch Button
bgpBtmX_PLw[5]="${bgpBtmX_P[5]}" ;bgpBtmY_PLw[5]="0.796"	# Show on-screen Keyboard

## Common - File name definition
fileName="mfi-pad"
fileExt="cfg"

fileName_btnM[0]=""				# Normal Variant Prefix
fileName_btnM[1]="-lowbtn"		# Low Variant Prefix

fileName_mach[0]=" (Console)"	# Console Mode Suffix
fileName_mach[1]=" (Arcade)"	# Arcade Mode Suffix

## Target ID atoms definitions

# Orientation mode
orie[0]="landscape"
orie[1]="portrait"

# Thumb button mode (Normal, Inverted)
btnM[0]="norbtn"
btnM[1]="invbtn"

# Save controls visualization
savM[0]="savNo"
savM[1]="savYs"

# Visualization levels
show[0]=""
show[1]="partial"
show[2]="full"
show[3]="minimal"
show[4]="abovMin"

## Per Targets ID atoms - List definition
tarId_orie[0]=""	# Orientation mode					- Defined Next - Change every  16
tarId_btnM[0]=""	# Thumb buttons mode				- Defined Next - Change every  4
tarId_savM[0]=""	# Save controls visualization mode	- Defined Next - Change every  8
tarId_show[0]=""	# Visualization levels				- Defined Next - Change every  1

## Per Targets ID Name - List definition
tarId_Name[0]=""	# Defined Next

## Redirection "Tables" definition
tarTableChgOrie[0]=""	# Orientation mode change					- Defined Next
tarTableChgBtnM[0]=""	# Thumb buttons mode change			    	- Defined Next
tarTableChgSavM[0]=""	# Save controls visualization mode change	- Defined Next
tarTableShow[0]=""   	# Visualization levels control (Show)		- Defined Next
tarTableHide[0]=""   	# Visualization levels control (Hide)		- Defined Next

## Targets conunter definition
tarTot=0	# Denined Next

### Variabile fill-zone
## Fill tarId_Name[] and define tarId "Atoms" value
tarCount="-1"
for orieCount in `seq 0 1`; do
	for btnMCount in `seq 0 1`; do
		for savMCount in `seq 0 1`; do
			for showCount in `seq 0 4`; do
				((tarCount+=1))
				# Definition of "Atoms" values for each "Target"
				tarId_orie[$tarCount]=${orie[$orieCount]}
				tarId_btnM[$tarCount]=${btnM[$btnMCount]}
				tarId_savM[$tarCount]=${savM[$savMCount]}
				tarId_show[$tarCount]=${show[$showCount]}
				# Definition of Names for each "Target"
				if [ "${tarId_show[$tarCount]}" == "" ]; then
					tarId_Name[$tarCount]=${tarId_orie[$tarCount]}"-"${tarId_btnM[$tarCount]}"-"${tarId_savM[$tarCount]}
				else
					tarId_Name[$tarCount]=${tarId_orie[$tarCount]}"-"${tarId_btnM[$tarCount]}"-"${tarId_savM[$tarCount]}"-"${tarId_show[$tarCount]}
				fi
				# echo ${tarId_Name[$tarCount]}			
			done
		done
	done
done

## Define file tarTot
tarTot=$tarCount

## Fill tarTableShow[] Show redirection value
for tarCount in `seq 0 $tarTot`; do
	case $((tarCount % 5)) in
		0|1|2|3)
			tarTableShow[$tarCount]=${tarId_Name[$((tarCount+1))]}
			;;
		4)
			tarTableShow[$tarCount]=${tarId_Name[$((tarCount-4))]}
			;;
	esac
done

## Fill tarTableHide[] Hide redirection value
for tarCount in `seq 0 $tarTot`; do
	case $((tarCount % 5)) in
		0)
			tarTableHide[$tarCount]=${tarId_Name[$((tarCount+4))]}
			;;
		1|2|3|4)
			tarTableHide[$tarCount]=${tarId_Name[$((tarCount-1))]}
			;;
	esac
done

## Fill tarTableChgOrie[] Orientation redirection value
for tarCount in `seq 0 $tarTot`; do
	case "${tarId_orie[$tarCount]}" in
		"${orie[0]}")
			if [ "${tarId_show[$tarCount]}" == "" ]; then
				tarTableChgOrie[$tarCount]=${orie[1]}"-"${tarId_btnM[$tarCount]}"-"${tarId_savM[$tarCount]}
			else
				tarTableChgOrie[$tarCount]=${orie[1]}"-"${tarId_btnM[$tarCount]}"-"${tarId_savM[$tarCount]}"-"${tarId_show[$tarCount]}
			fi
			;;
		"${orie[1]}")
			if [ "${tarId_show[$tarCount]}" == "" ]; then
				tarTableChgOrie[$tarCount]=${orie[0]}"-"${tarId_btnM[$tarCount]}"-"${tarId_savM[$tarCount]}
			else
				tarTableChgOrie[$tarCount]=${orie[0]}"-"${tarId_btnM[$tarCount]}"-"${tarId_savM[$tarCount]}"-"${tarId_show[$tarCount]}
			fi
			;;
	esac	
done

## Fill tarTableChgBtnM[] Button Mode redirection value
for tarCount in `seq 0 $tarTot`; do
	case "${tarId_btnM[$tarCount]}" in
		"${btnM[0]}")
			if [ "${tarId_show[$tarCount]}" == "" ]; then
				tarTableChgBtnM[$tarCount]=${tarId_orie[$tarCount]}"-"${btnM[1]}"-"${tarId_savM[$tarCount]}
			else
				tarTableChgBtnM[$tarCount]=${tarId_orie[$tarCount]}"-"${btnM[1]}"-"${tarId_savM[$tarCount]}"-"${tarId_show[$tarCount]}
			fi
			;;
		"${btnM[1]}")
			if [ "${tarId_show[$tarCount]}" == "" ]; then
				tarTableChgBtnM[$tarCount]=${tarId_orie[$tarCount]}"-"${btnM[0]}"-"${tarId_savM[$tarCount]}
			else
				tarTableChgBtnM[$tarCount]=${tarId_orie[$tarCount]}"-"${btnM[0]}"-"${tarId_savM[$tarCount]}"-"${tarId_show[$tarCount]}
			fi
			;;
	esac	
done

## Fill tarTableChgSavM[] Button Mode redirection value
for tarCount in `seq 0 $tarTot`; do
	case "${tarId_savM[$tarCount]}" in
		"${savM[0]}")
			if [ "${tarId_show[$tarCount]}" == "" ]; then
				tarTableChgSavM[$tarCount]=${tarId_orie[$tarCount]}"-"${tarId_btnM[$tarCount]}"-"${savM[1]}
			else
				tarTableChgSavM[$tarCount]=${tarId_orie[$tarCount]}"-"${tarId_btnM[$tarCount]}"-"${savM[1]}"-"${tarId_show[$tarCount]}
			fi
			;;
		"${savM[1]}")
			if [ "${tarId_show[$tarCount]}" == "" ]; then
				tarTableChgSavM[$tarCount]=${tarId_orie[$tarCount]}"-"${tarId_btnM[$tarCount]}"-"${savM[0]}
			else
				tarTableChgSavM[$tarCount]=${tarId_orie[$tarCount]}"-"${tarId_btnM[$tarCount]}"-"${savM[0]}"-"${tarId_show[$tarCount]}
			fi
			;;
	esac	
done

# for tarCount in `seq 0 $tarTot`; do
# 	printf "%-32s %s %s\n" ${tarId_Name[$tarCount]} " -> " ${tarTableChgBtnM[$tarCount]}
# done

### File generator
for machCount in `seq 0 1`; do
	for btnTCount in `seq 0 1`; do
		
		## File ouputs definition - Common
		outName="$fileName${fileName_btnM[$btnTCount]}${fileName_mach[$machCount]}.$fileExt"

		## Print operations progress
		echo "Generation of \""$outName"\" in progress…"

		## Conmmons definition generator
		echo "overlays = "$((tarTot+1))											> "$outName"

		## Targets definition generator
		for tarCount in `seq 0 $tarTot`; do
			echo ""															 	>> "$outName"
			echo "overlay"$tarCount"_full_screen = "$olayFS					 	>> "$outName"
			echo "overlay"$tarCount"_normalized = "$olayNorm				 	>> "$outName"
			echo "overlay"$tarCount"_name = \""${tarId_Name[$tarCount]}"\""		>> "$outName"
			echo "overlay"$tarCount"_range_mod = "$olayRangeMod				 	>> "$outName"
			echo "overlay"$tarCount"_alpha_mod = "$olayAlphaMod				 	>> "$outName"
		done

		## Define "descTot" value based on "tarId_savM[]" and "tarId_show[]" atoms value
		for tarCount in `seq 0 $tarTot`; do			
			case "${tarId_savM[$tarCount]}" in
				"${savM[0]}")
					case "${tarId_show[$tarCount]}" in
						"${show[0]}")
							descTot="7"
							;;
						"${show[1]}")
							descTot="9"
							;;
						"${show[2]}")
							descTot="15"
							;;
						"${show[3]}")
							descTot="2"
							;;
						"${show[4]}")
							descTot="4"
							;;
					esac
					;;
				"${savM[1]}")
					case "${tarId_show[$tarCount]}" in
						"${show[0]}")
							descTot="13"
							;;
						"${show[1]}")
							descTot="15"
							;;
						"${show[2]}")
							descTot="21"
							;;
						"${show[3]}")
							descTot="2"
							;;
						"${show[4]}")
							descTot="10"
							;;
					esac
					;;
			esac
			
			## Define "descAddsavM": number of buttons add by "savM" group to Total count.
			descAddsavM="6"

			## Orientation Specific Operations
			case "${tarId_orie[$tarCount]}" in
				"${orie[0]}")
					# Position Switch (Landscape)
					# Group 1 (Top)												# Group 2 (Sav)												# Group 3A (Tmb)											# Group 4 (Btm)
					bgpTopX_[0]=${bgpTopX_L[0]} ;bgpTopY_[0]=${bgpTopY_L[0]}	;bgpSavX_[0]=${bgpSavX_L[0]} ;bgpSavY_[0]=${bgpSavY_L[0]}	;bgpTmbX_[0]=${bgpTmbX_L[0]} ;bgpTmbY_[0]=${bgpTmbY_L[0]}	;bgpBtmX_[0]=${bgpBtmX_L[0]} ;bgpBtmY_[0]=${bgpBtmY_L[0]}
					bgpTopX_[1]=${bgpTopX_L[1]} ;bgpTopY_[1]=${bgpTopY_L[1]}	;bgpSavX_[1]=${bgpSavX_L[1]} ;bgpSavY_[1]=${bgpSavY_L[1]}	;bgpTmbX_[1]=${bgpTmbX_L[1]} ;bgpTmbY_[1]=${bgpTmbY_L[1]}	;bgpBtmX_[1]=${bgpBtmX_L[1]} ;bgpBtmY_[1]=${bgpBtmY_L[1]}
					bgpTopX_[2]=${bgpTopX_L[2]} ;bgpTopY_[2]=${bgpTopY_L[2]}	;bgpSavX_[2]=${bgpSavX_L[2]} ;bgpSavY_[2]=${bgpSavY_L[2]}																;bgpBtmX_[2]=${bgpBtmX_L[2]} ;bgpBtmY_[2]=${bgpBtmY_L[2]}
					bgpTopX_[3]=${bgpTopX_L[3]} ;bgpTopY_[3]=${bgpTopY_L[3]}	;bgpSavX_[3]=${bgpSavX_L[3]} ;bgpSavY_[3]=${bgpSavY_L[3]}	# Group 3B (TmL)											
					bgpTopX_[4]=${bgpTopX_L[4]} ;bgpTopY_[4]=${bgpTopY_L[4]}	;bgpSavX_[4]=${bgpSavX_L[4]} ;bgpSavY_[4]=${bgpSavY_L[4]}	;bgpTmLX_[0]=${bgpTmLX_L[0]} ;bgpTmLY_[0]=${bgpTmLY_L[0]}	;bgpBtmX_[3]=${bgpBtmX_L[3]} ;bgpBtmY_[3]=${bgpBtmY_L[3]}
					bgpTopX_[5]=${bgpTopX_L[5]} ;bgpTopY_[5]=${bgpTopY_L[5]}	;bgpSavX_[5]=${bgpSavX_L[5]} ;bgpSavY_[5]=${bgpSavY_L[5]}	;bgpTmLX_[1]=${bgpTmLX_L[1]} ;bgpTmLY_[1]=${bgpTmLY_L[1]}	;bgpBtmX_[4]=${bgpBtmX_L[4]} ;bgpBtmY_[4]=${bgpBtmY_L[4]}
					bgpTopX_[6]=${bgpTopX_L[6]} ;bgpTopY_[6]=${bgpTopY_L[6]}																															;bgpBtmX_[5]=${bgpBtmX_L[5]} ;bgpBtmY_[5]=${bgpBtmY_L[5]}
					
					# Size Switch (Landscape)
					# Radial Shape																# Rectangular Shape
					      btnShow_[2]=${btnShow[2]}		      ;btnShow_[3]=${btnShow[3]}		     ;btnBtnM_[2]=${btnBtnM[2]}		      ;btnBtnM_[3]=${btnBtnM[3]}
					      btnHide_[2]=${btnHide[2]}		      ;btnHide_[3]=${btnHide[3]}		    ;btnReset_[2]=${btnReset[2]}	     ;btnReset_[3]=${btnReset[3]}
					   btnStaShow_[2]=${btnStaShow[2]}	   ;btnStaShow_[3]=${btnStaShow[3]}		    ;btnKeyBd_[2]=${btnKeyBd[2]}	     ;btnKeyBd_[3]=${btnKeyBd[3]}
					   btnStaHide_[2]=${btnStaHide[2]}	   ;btnStaHide_[3]=${btnStaHide[3]}		
					    btnStaRew_[2]=${btnStaRew[2]}	    ;btnStaRew_[3]=${btnStaRew[3]}		
					    btnStaFfw_[2]=${btnStaFfw[2]}	    ;btnStaFfw_[3]=${btnStaFfw[3]}		
					    btnStaDec_[2]=${btnStaDec[2]}	    ;btnStaDec_[3]=${btnStaDec[3]}		
					    btnStaInc_[2]=${btnStaInc[2]}	    ;btnStaInc_[3]=${btnStaInc[3]}		
					   btnStaSave_[2]=${btnStaSave[2]}	   ;btnStaSave_[3]=${btnStaSave[3]}		
					   btnStaLoad_[2]=${btnStaLoad[2]}	   ;btnStaLoad_[3]=${btnStaLoad[3]}		
					 btnSelectArc_[2]=${btnSelectArc[2]} ;btnSelectArc_[3]=${btnSelectArc[3]}	;btnSelectCon_[2]=${btnSelectCon[2]} ;btnSelectCon_[3]=${btnSelectCon[3]}
					  btnStartArc_[2]=${btnStartArc[2]}	  ;btnStartArc_[3]=${btnStartArc[3]}	 ;btnStartCon_[2]=${btnStartCon[2]}	  ;btnStartCon_[3]=${btnStartCon[3]}
					        btnL3_[2]=${btnL3[2]}		        ;btnL3_[3]=${btnL3[3]}			    ;btnL3Low_[2]=${btnL3Low[2]}	     ;btnL3Low_[3]=${btnL3Low[3]}
					        btnR3_[2]=${btnR3[2]}		        ;btnR3_[3]=${btnR3[3]}			    ;btnR3Low_[2]=${btnR3Low[2]}	     ;btnR3Low_[3]=${btnR3Low[3]}
					    btnShaPre_[2]=${btnShaPre[2]}	    ;btnShaPre_[3]=${btnShaPre[3]}		
					    btnShaNex_[2]=${btnShaNex[2]}	    ;btnShaNex_[3]=${btnShaNex[3]}		
					      btnOrie_[2]=${btnOrie[2]}		      ;btnOrie_[3]=${btnOrie[3]}		
					      btnMenu_[2]=${btnMenu[2]}		      ;btnMenu_[3]=${btnMenu[3]}		
					;;
				"${orie[1]}")
					# Position Switch (Portrait)
					# Group 1 (Top)												# Group 2 (Sav)												# Group 3A (Tmb)											# Group 4 (Btm)
					bgpTopX_[0]=${bgpTopX_P[0]} ;bgpTopY_[0]=${bgpTopY_P[0]}	;bgpSavX_[0]=${bgpSavX_P[0]} ;bgpSavY_[0]=${bgpSavY_P[0]}	;bgpTmbX_[0]=${bgpTmbX_P[0]} ;bgpTmbY_[0]=${bgpTmbY_P[0]}	  ;bgpBtmX_[0]=${bgpBtmX_P[0]} ;bgpBtmY_[0]=${bgpBtmY_P[0]}
					bgpTopX_[1]=${bgpTopX_P[1]} ;bgpTopY_[1]=${bgpTopY_P[1]}	;bgpSavX_[1]=${bgpSavX_P[1]} ;bgpSavY_[1]=${bgpSavY_P[1]}	;bgpTmbX_[1]=${bgpTmbX_P[1]} ;bgpTmbY_[1]=${bgpTmbY_P[1]}	  ;bgpBtmX_[1]=${bgpBtmX_P[1]} ;bgpBtmY_[1]=${bgpBtmY_P[1]}
					bgpTopX_[2]=${bgpTopX_P[2]} ;bgpTopY_[2]=${bgpTopY_P[2]}	;bgpSavX_[2]=${bgpSavX_P[2]} ;bgpSavY_[2]=${bgpSavY_P[2]}																  ;bgpBtmX_[2]=${bgpBtmX_P[2]} ;bgpBtmY_[2]=${bgpBtmY_P[2]}
					bgpTopX_[3]=${bgpTopX_P[3]} ;bgpTopY_[3]=${bgpTopY_P[3]}	;bgpSavX_[3]=${bgpSavX_P[3]} ;bgpSavY_[3]=${bgpSavY_P[3]}	# Group 3B (TmL)											  
					bgpTopX_[4]=${bgpTopX_P[4]} ;bgpTopY_[4]=${bgpTopY_P[4]}	;bgpSavX_[4]=${bgpSavX_P[4]} ;bgpSavY_[4]=${bgpSavY_P[4]}	;bgpTmLX_[0]=${bgpTmLX_P[0]} ;bgpTmLY_[0]=${bgpTmLY_P[0]}	  ;bgpBtmX_[3]=${bgpBtmX_P[3]} ;bgpBtmY_[3]=${bgpBtmY_P[3]}
					bgpTopX_[5]=${bgpTopX_P[5]} ;bgpTopY_[5]=${bgpTopY_P[5]}	;bgpSavX_[5]=${bgpSavX_P[5]} ;bgpSavY_[5]=${bgpSavY_P[5]}	;bgpTmLX_[1]=${bgpTmLX_P[1]} ;bgpTmLY_[1]=${bgpTmLY_P[1]}	  ;bgpBtmX_[4]=${bgpBtmX_P[4]} ;bgpBtmY_[4]=${bgpBtmY_P[4]}
					bgpTopX_[6]=${bgpTopX_P[6]} ;bgpTopY_[6]=${bgpTopY_P[6]}																															  ;bgpBtmX_[5]=${bgpBtmX_P[5]} ;bgpBtmY_[5]=${bgpBtmY_P[5]}

																																																		# Button Type (Low) Variants Exception
																																																case "$btnTCount" in
																																																	# Low Button
																																																	"1")
																																																		 bgpBtmX_[2]=${bgpBtmX_PLw[2]} ;bgpBtmY_[2]=${bgpBtmY_PLw[2]}
																																																		 bgpBtmX_[5]=${bgpBtmX_PLw[5]} ;bgpBtmY_[5]=${bgpBtmY_PLw[5]}
																																																		 ;;
																																																esac

					## Size Switch (Portrait)
					# Radial Shape																# Rectangular Shape
					      btnShow_[2]=${btnShow[3]}		      ;btnShow_[3]=${btnShow[2]}		     ;btnBtnM_[2]=${btnBtnM[5]}		      ;btnBtnM_[3]=${btnBtnM[6]}
					      btnHide_[2]=${btnHide[3]}		      ;btnHide_[3]=${btnHide[2]}		    ;btnReset_[2]=${btnReset[5]} 	     ;btnReset_[3]=${btnReset[6]}
					   btnStaShow_[2]=${btnStaShow[3]}	   ;btnStaShow_[3]=${btnStaShow[2]}		    ;btnKeyBd_[2]=${btnKeyBd[5]} 	     ;btnKeyBd_[3]=${btnKeyBd[6]}
					   btnStaHide_[2]=${btnStaHide[3]}	   ;btnStaHide_[3]=${btnStaHide[2]}		
					    btnStaRew_[2]=${btnStaRew[3]}	    ;btnStaRew_[3]=${btnStaRew[2]}		
					    btnStaFfw_[2]=${btnStaFfw[3]}	    ;btnStaFfw_[3]=${btnStaFfw[2]}		
					    btnStaDec_[2]=${btnStaDec[3]}	    ;btnStaDec_[3]=${btnStaDec[2]}		
					    btnStaInc_[2]=${btnStaInc[3]}	    ;btnStaInc_[3]=${btnStaInc[2]}		
					   btnStaSave_[2]=${btnStaSave[3]}	   ;btnStaSave_[3]=${btnStaSave[2]}		
					   btnStaLoad_[2]=${btnStaLoad[3]}	   ;btnStaLoad_[3]=${btnStaLoad[2]}		
					 btnSelectArc_[2]=${btnSelectArc[3]} ;btnSelectArc_[3]=${btnSelectArc[2]}	;btnSelectCon_[2]=${btnSelectCon[5]} ;btnSelectCon_[3]=${btnSelectCon[6]}
					  btnStartArc_[2]=${btnStartArc[3]}	  ;btnStartArc_[3]=${btnStartArc[2]}	 ;btnStartCon_[2]=${btnStartCon[5]}	  ;btnStartCon_[3]=${btnStartCon[6]}
					        btnL3_[2]=${btnL3[3]} 		        ;btnL3_[3]=${btnL3[2]}			    ;btnL3Low_[2]=${btnL3Low[5]}	     ;btnL3Low_[3]=${btnL3Low[6]}
					        btnR3_[2]=${btnR3[3]} 		        ;btnR3_[3]=${btnR3[2]}			    ;btnR3Low_[2]=${btnR3Low[5]}	     ;btnR3Low_[3]=${btnR3Low[6]}
					    btnShaPre_[2]=${btnShaPre[3]}	    ;btnShaPre_[3]=${btnShaPre[2]}		
					    btnShaNex_[2]=${btnShaNex[3]}	    ;btnShaNex_[3]=${btnShaNex[2]}		
					      btnOrie_[2]=${btnOrie[3]} 	      ;btnOrie_[3]=${btnOrie[2]}		
					      btnMenu_[2]=${btnMenu[3]} 	      ;btnMenu_[3]=${btnMenu[2]}		
					;;
			esac

			## Buttom Mode Specific Operations
			case "${tarId_btnM[$tarCount]}" in
				"${btnM[0]}")
					btnL3__[0]=${btnL3[0]}			;btnL3__[1]=${btnL3[1]}			;btnL3__[2]=${btnL3_[2]}		;btnL3__[3]=${btnL3_[3]}		;btnL3__[4]=${btnL3[4]}
					btnR3__[0]=${btnR3[0]}			;btnR3__[1]=${btnR3[1]}			;btnR3__[2]=${btnR3_[2]}		;btnR3__[3]=${btnR3_[3]}		;btnR3__[4]=${btnR3[4]}

					btnL3Low__[0]=${btnL3Low[0]}	;btnL3Low__[1]=${btnL3Low[1]}	;btnL3Low__[2]=${btnL3Low_[2]}	;btnL3Low__[3]=${btnL3Low_[3]}	;btnL3Low__[4]=${btnL3Low[4]}
					btnR3Low__[0]=${btnR3Low[0]}	;btnR3Low__[1]=${btnR3Low[1]}	;btnR3Low__[2]=${btnR3Low_[2]}	;btnR3Low__[3]=${btnR3Low_[3]}	;btnR3Low__[4]=${btnR3Low[4]}
					;;
				"${btnM[1]}")
					btnL3__[0]=${btnR3[0]}			;btnL3__[1]=${btnR3[1]}			;btnL3__[2]=${btnR3_[2]}		;btnL3__[3]=${btnR3_[3]}		;btnL3__[4]=${btnR3[4]}
					btnR3__[0]=${btnL3[0]}			;btnR3__[1]=${btnL3[1]}			;btnR3__[2]=${btnL3_[2]}		;btnR3__[3]=${btnL3_[3]}		;btnR3__[4]=${btnL3[4]}

					btnL3Low__[0]=${btnR3Low[0]}	;btnL3Low__[1]=${btnR3Low[1]}	;btnL3Low__[2]=${btnR3Low_[2]}	;btnL3Low__[3]=${btnR3Low_[3]}	;btnL3Low__[4]=${btnR3Low[4]}
					btnR3Low__[0]=${btnL3Low[0]}	;btnR3Low__[1]=${btnL3Low[1]}	;btnR3Low__[2]=${btnL3Low_[2]}	;btnR3Low__[3]=${btnL3Low_[3]}	;btnR3Low__[4]=${btnL3Low[4]}
					;;
			esac

			## Save controls visualization Specific Operations
			case "${tarId_savM[$tarCount]}" in
				"${savM[0]}")
					btnStaCtrl_[0]=${btnStaShow[0]}	;btnStaCtrl_[1]=${btnStaShow[1]}	;btnStaCtrl_[2]=${btnStaShow_[2]}	;btnStaCtrl_[3]=${btnStaShow_[3]}	;btnStaCtrl_[4]=${btnStaShow[4]}
					offsetSavM="0"
					;;
				"${savM[1]}")
					btnStaCtrl_[0]=${btnStaHide[0]}	;btnStaCtrl_[1]=${btnStaHide[1]}	;btnStaCtrl_[2]=${btnStaHide_[2]}	;btnStaCtrl_[3]=${btnStaHide_[3]}	;btnStaCtrl_[4]=${btnStaHide[4]}
					offsetSavM=$descAddsavM
					;;
			esac
			
			## Visualization Level Specific Operations
			case "${tarId_show[$tarCount]}" in
				"${show[0]}")
					;;
				"${show[1]}")
					;;
				"${show[2]}")
					;;
				"${show[3]}")
					;;
				"${show[4]}")
					;;
			esac

			## Machine Type Variants Operations
			case "$machCount" in
				# Console
				"0")
					btnSelect_[0]=${btnSelectCon[0]}	;btnSelect_[1]=${btnSelectCon[1]}	;btnSelect_[2]=${btnSelectCon_[2]}	;btnSelect_[3]=${btnSelectCon_[3]}	;btnSelect_[4]=${btnSelectCon[4]}
					btnStart_[0]=${btnStartCon[0]}		;btnStart_[1]=${btnStartCon[1]}		;btnStart_[2]=${btnStartCon_[2]}	;btnStart_[3]=${btnStartCon_[3]}	;btnStart_[4]=${btnStartCon[4]}
					;;
				# Arcade
				"1")
					btnSelect_[0]=${btnSelectArc[0]}	;btnSelect_[1]=${btnSelectArc[1]}	;btnSelect_[2]=${btnSelectArc_[2]}	;btnSelect_[3]=${btnSelectArc_[3]}	;btnSelect_[4]=${btnSelectArc[4]}
					btnStart_[0]=${btnStartArc[0]}		;btnStart_[1]=${btnStartArc[1]}		;btnStart_[2]=${btnStartArc_[2]}	;btnStart_[3]=${btnStartArc_[3]}	;btnStart_[4]=${btnStartArc[4]}
					;;
			esac

			## Button Type (Size/Shape) Variants Operations
			case "$btnTCount" in
				# Normal Buttons
				"0")
					btnL3___[0]=${btnL3__[0]}			;btnL3___[1]=${btnL3__[1]}			;btnL3___[2]=${btnL3__[2]}		;btnL3___[3]=${btnL3__[3]}		;btnL3___[4]=${btnL3__[4]}
					btnR3___[0]=${btnR3__[0]}			;btnR3___[1]=${btnR3__[1]}			;btnR3___[2]=${btnR3__[2]}		;btnR3___[3]=${btnR3__[3]}		;btnR3___[4]=${btnR3__[4]}
					bgpTmbX__[0]=${bgpTmbX_[0]} 		;bgpTmbY__[0]=${bgpTmbY_[0]}
					bgpTmbX__[1]=${bgpTmbX_[1]} 		;bgpTmbY__[1]=${bgpTmbY_[1]}
					;;
				# Low Buttons
				"1")
					btnL3___[0]=${btnL3Low__[0]}		;btnL3___[1]=${btnL3Low__[1]}		;btnL3___[2]=${btnL3Low__[2]}		;btnL3___[3]=${btnL3Low__[3]}		;btnL3___[4]=${btnL3Low__[4]}
					btnR3___[0]=${btnR3Low__[0]}		;btnR3___[1]=${btnR3Low__[1]}		;btnR3___[2]=${btnR3Low__[2]}		;btnR3___[3]=${btnR3Low__[3]}		;btnR3___[4]=${btnR3Low__[4]}
					bgpTmbX__[0]=${bgpTmLX_[0]} 		;bgpTmbY__[0]=${bgpTmLY_[0]}
					bgpTmbX__[1]=${bgpTmLX_[1]} 		;bgpTmbY__[1]=${bgpTmLY_[1]}
					;;
			esac

			## Target Head (Commons)
			echo ""																																														>> "$outName"
			echo "# Overlay "$tarCount" - "${tarId_Name[$tarCount]}																																		>> "$outName"
			echo ""																																														>> "$outName"
			echo "overlay"$tarCount"_descs = "$descTot																																					>> "$outName"
			# echo ${tarId_show_orie[$tarCount]}","${orie[0]}","${orie[1]}

			## Visualization Level - Fixed Buttons
			echo ""																																														>> "$outName"
			echo "overlay"$tarCount"_desc0 = \""${btnHide[0]}","${bgpTopX_[0]}","${bgpTopY_[0]}","${btnHide[1]}","${btnHide_[2]}","${btnHide_[3]}"\""													>> "$outName"
			echo "overlay"$tarCount"_desc0_overlay = "${btnHide[4]}																																		>> "$outName"
			echo "overlay"$tarCount"_desc0_next_target = \""${tarTableHide[$tarCount]}"\""																												>> "$outName"
			echo "overlay"$tarCount"_desc1 = \""${btnShow[0]}","${bgpTopX_[6]}","${bgpTopY_[6]}","${btnShow[1]}","${btnShow_[2]}","${btnShow_[3]}"\""													>> "$outName"
			echo "overlay"$tarCount"_desc1_overlay = "${btnShow[4]}																																		>> "$outName"
			echo "overlay"$tarCount"_desc1_next_target = \""${tarTableShow[$tarCount]}"\""																												>> "$outName"

			## Visualization Level - Variable Buttons
			case "${tarId_show[$tarCount]}" in
				# Visualization Level - NOT minimal (normal, partial, full, abovMin) (Add to previous)
				"${show[4]}"|"${show[0]}"|"${show[1]}"|"${show[2]}")			
					# Visualization Level - Save State Control Enable (Add to previous)
					case "${tarId_savM[$tarCount]}" in
						"${savM[1]}")
							# State selection
							echo ""																																										>> "$outName"
							echo "overlay"$tarCount"_desc2 = \""${btnStaDec[0]}","${bgpSavX_[0]}","${bgpSavY_[0]}","${btnStaDec[1]}","${btnStaDec_[2]}","${btnStaDec_[3]}"\""							>> "$outName"
							echo "overlay"$tarCount"_desc2_overlay = "${btnStaDec[4]}																													>> "$outName"
							echo "overlay"$tarCount"_desc3 = \""${btnStaInc[0]}","${bgpSavX_[1]}","${bgpSavY_[1]}","${btnStaInc[1]}","${btnStaInc_[2]}","${btnStaInc_[3]}"\""							>> "$outName"
							echo "overlay"$tarCount"_desc3_overlay = "${btnStaInc[4]}																													>> "$outName"
							# State operations
							echo ""																																										>> "$outName"
							echo "overlay"$tarCount"_desc4 = \""${btnStaLoad[0]}","${bgpSavX_[2]}","${bgpSavY_[2]}","${btnStaLoad[1]}","${btnStaLoad_[2]}","${btnStaLoad_[3]}"\""						>> "$outName"
							echo "overlay"$tarCount"_desc4_overlay = "${btnStaLoad[4]}																													>> "$outName"
							echo "overlay"$tarCount"_desc5 = \""${btnStaSave[0]}","${bgpSavX_[3]}","${bgpSavY_[3]}","${btnStaSave[1]}","${btnStaSave_[2]}","${btnStaSave_[3]}"\""						>> "$outName"
							echo "overlay"$tarCount"_desc5_overlay = "${btnStaSave[4]}																													>> "$outName"
							# Specials controls (Rewind, Fast Forward)
							echo ""																																										>> "$outName"
							echo "overlay"$tarCount"_desc6 = \""${btnStaRew[0]}","${bgpSavX_[4]}","${bgpSavY_[4]}","${btnStaRew[1]}","${btnStaRew_[2]}","${btnStaRew_[3]}"\""							>> "$outName"
							echo "overlay"$tarCount"_desc6_overlay = "${btnStaRew[4]}																													>> "$outName"
							echo "overlay"$tarCount"_desc7 = \""${btnStaFfw[0]}","${bgpSavX_[5]}","${bgpSavY_[5]}","${btnStaFfw[1]}","${btnStaFfw_[2]}","${btnStaFfw_[3]}"\""							>> "$outName"
							echo "overlay"$tarCount"_desc7_overlay = "${btnStaFfw[4]}																													>> "$outName"
							;;
					esac
					
					# Visualization Level - Above Minimal (Add to previous)
					echo ""																																												>> "$outName"
					echo "overlay"$tarCount"_desc"$((2+$offsetSavM))" = \""${btnStaCtrl_[0]}","${bgpBtmX_[0]}","${bgpBtmY_[0]}","${btnStaCtrl_[1]}","${btnStaCtrl_[2]}","${btnStaCtrl_[3]}"\""			>> "$outName"
					echo "overlay"$tarCount"_desc"$((2+$offsetSavM))"_overlay = "${btnStaCtrl_[4]}																										>> "$outName"
					echo "overlay"$tarCount"_desc"$((2+$offsetSavM))"_next_target = \""${tarTableChgSavM[$tarCount]}"\""																				>> "$outName"
					echo "overlay"$tarCount"_desc"$((3+$offsetSavM))" = \""${btnStaCtrl_[0]}","${bgpBtmX_[4]}","${bgpBtmY_[4]}","${btnStaCtrl_[1]}","${btnStaCtrl_[2]}","${btnStaCtrl_[3]}"\""			>> "$outName"
					echo "overlay"$tarCount"_desc"$((3+$offsetSavM))"_overlay = "${btnStaCtrl_[4]}																										>> "$outName"
					echo "overlay"$tarCount"_desc"$((3+$offsetSavM))"_next_target = \""${tarTableChgSavM[$tarCount]}"\""																				>> "$outName"

					# Visualization Level - Normal (Adds to previous)
					case "${tarId_show[$tarCount]}" in
						"${show[0]}"|"${show[1]}"|"${show[2]}")
							echo ""																																										>> "$outName"
							echo "overlay"$tarCount"_desc"$((4+$offsetSavM))" = \""${btnSelect_[0]}","${bgpBtmX_[1]}","${bgpBtmY_[1]}","${btnSelect_[1]}","${btnSelect_[2]}","${btnSelect_[3]}"\""		>> "$outName"
							echo "overlay"$tarCount"_desc"$((4+$offsetSavM))"_overlay = "${btnSelect_[4]}																								>> "$outName"
							echo "overlay"$tarCount"_desc"$((5+$offsetSavM))" = \""${btnOrie[0]}","${bgpBtmX_[2]}","${bgpBtmY_[2]}","${btnOrie[1]}","${btnOrie_[2]}","${btnOrie_[3]}"\""				>> "$outName"
							echo "overlay"$tarCount"_desc"$((5+$offsetSavM))"_overlay = "${btnOrie[4]}																									>> "$outName"
							echo "overlay"$tarCount"_desc"$((5+$offsetSavM))"_next_target = \""${tarTableChgOrie[$tarCount]}"\""																		>> "$outName"
							echo "overlay"$tarCount"_desc"$((6+$offsetSavM))" = \""${btnStart_[0]}","${bgpBtmX_[3]}","${bgpBtmY_[3]}","${btnStart_[1]}","${btnStart_[2]}","${btnStart_[3]}"\""			>> "$outName"
							echo "overlay"$tarCount"_desc"$((6+$offsetSavM))"_overlay = "${btnStart_[4]}																								>> "$outName"
							;;
					esac
										
					# Visualization Level - Partial Buttons (Adds to previous)
					case "${tarId_show[$tarCount]}" in
						"${show[1]}"|"${show[2]}")
							echo ""																																										>> "$outName"
							echo "overlay"$tarCount"_desc"$((7+$offsetSavM))" = \""${btnL3___[0]}","${bgpTmbX__[0]}","${bgpTmbY__[0]}","${btnL3___[1]}","${btnL3___[2]}","${btnL3___[3]}"\""			>> "$outName"
							echo "overlay"$tarCount"_desc"$((7+$offsetSavM))"_overlay = "${btnL3___[4]}																									>> "$outName"
							echo "overlay"$tarCount"_desc"$((8+$offsetSavM))" = \""${btnR3___[0]}","${bgpTmbX__[1]}","${bgpTmbY__[1]}","${btnR3___[1]}","${btnR3___[2]}","${btnR3___[3]}"\""			>> "$outName"
							echo "overlay"$tarCount"_desc"$((8+$offsetSavM))"_overlay = "${btnR3___[4]}																									>> "$outName"
							;;
					esac
					
					# Visualization Level - Full Buttons (Adds to previous)
					case "${tarId_show[$tarCount]}" in
						"${show[2]}")
							# Top Bar
							echo ""																																										>> "$outName"
							echo "overlay"$tarCount"_desc"$((9+$offsetSavM))" = \""${btnShaPre[0]}","${bgpTopX_[1]}","${bgpTopY_[1]}","${btnShaPre[1]}","${btnShaPre_[2]}","${btnShaPre_[3]}"\""		>> "$outName"
							echo "overlay"$tarCount"_desc"$((9+$offsetSavM))"_overlay = "${btnShaPre[4]}																								>> "$outName"
							echo "overlay"$tarCount"_desc"$((10+$offsetSavM))" = \""${btnBtnM[0]}","${bgpTopX_[2]}","${bgpTopY_[2]}","${btnBtnM[1]}","${btnBtnM_[2]}","${btnBtnM_[3]}"\""				>> "$outName"
							echo "overlay"$tarCount"_desc"$((10+$offsetSavM))"_overlay = "${btnBtnM[4]}																									>> "$outName"
							echo "overlay"$tarCount"_desc"$((10+$offsetSavM))"_next_target = \""${tarTableChgBtnM[$tarCount]}"\""																		>> "$outName"
							echo "overlay"$tarCount"_desc"$((11+$offsetSavM))" = \""${btnMenu[0]}","${bgpTopX_[3]}","${bgpTopY_[3]}","${btnMenu[1]}","${btnMenu_[2]}","${btnMenu_[3]}"\""				>> "$outName"
							echo "overlay"$tarCount"_desc"$((11+$offsetSavM))"_overlay = "${btnMenu[4]}																									>> "$outName"
							echo "overlay"$tarCount"_desc"$((12+$offsetSavM))" = \""${btnReset[0]}","${bgpTopX_[4]}","${bgpTopY_[4]}","${btnReset[1]}","${btnReset_[2]}","${btnReset_[3]}"\""			>> "$outName"
							echo "overlay"$tarCount"_desc"$((12+$offsetSavM))"_overlay = "${btnReset[4]}																								>> "$outName"
							echo "overlay"$tarCount"_desc"$((13+$offsetSavM))" = \""${btnShaNex[0]}","${bgpTopX_[5]}","${bgpTopY_[5]}","${btnShaNex[1]}","${btnShaNex_[2]}","${btnShaNex_[3]}"\""		>> "$outName"
							echo "overlay"$tarCount"_desc"$((13+$offsetSavM))"_overlay = "${btnShaNex[4]}																								>> "$outName"
							echo "overlay"$tarCount"_desc"$((14+$offsetSavM))" = \""${btnKeyBd[0]}","${bgpBtmX_[5]}","${bgpBtmY_[5]}","${btnKeyBd[1]}","${btnKeyBd_[2]}","${btnKeyBd_[3]}"\""			>> "$outName"
							echo "overlay"$tarCount"_desc"$((14+$offsetSavM))"_overlay = "${btnKeyBd[4]}																								>> "$outName"
							;;
					esac
					;;
			esac

			# ((descTot-=1))
			# for descCount in `seq 0 $descTot`; do
			# 	echo "overlay"$tarCount"_desc"$descCount" = "
			# 	echo "overlay"$tarCount"_desc"$descCount"_overlay = "
			# done
		done
	done
done

IFS=$OLDIFS