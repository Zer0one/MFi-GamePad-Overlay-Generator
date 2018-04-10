#!/bin/bash

cd -- "$(dirname "$0")"

OLDIFS=$IFS
IFS=$'\n'
shopt -s nullglob

### Variables definition
## Common
olayFS="true"
olayNorm="true"
olayRangeMod="1.5"
olayAlphaMod="2.0"
fileName="mfi-pad"
fileExt="cfg"

## Common - Target ID Atom
# Machine Type
mach[0]="console"
mach[1]="arcade"

# Orientation
orie[0]="landscape"
orie[1]="portrait"

# Button Mode (Normal, Inverted)
btnM[0]="norbtn"
btnM[1]="invbtn"

# Show Mode
show[0]=""
show[1]="partial"
show[2]="full"

## Common - Button Definition Table
# Function							# Geometry					# SizeX	(Landscape)			# SizeY (Landscape)			# Image								# SizeX (Portrait)			# SizeY (Portrait)
btnShow[0]="overlay_next"			;btnShow[1]="radial"		;btnShow[2]="0.026"			;btnShow[3]="0.046"			;btnShow[4]="show.png"				
btnHide[0]="overlay_next"			;btnHide[1]="radial"		;btnHide[2]="0.026"			;btnHide[3]="0.046"			;btnHide[4]="hide.png"				
btnStaRew[0]="rewind"				;btnStaRew[1]="radial"		;btnStaRew[2]="0.026"		;btnStaRew[3]="0.046"		;btnStaRew[4]="rotate.png"			
btnStaFfw[0]="toggle_fast_forward"	;btnStaFfw[1]="radial"		;btnStaFfw[2]="0.026"		;btnStaFfw[3]="0.046"		;btnStaFfw[4]="rotateInv.png"		
btnStaDec[0]="state_slot_decrease"	;btnStaDec[1]="radial"		;btnStaDec[2]="0.026"		;btnStaDec[3]="0.046"		;btnStaDec[4]="c_left.png"			
btnStaInc[0]="state_slot_increase"	;btnStaInc[1]="radial"		;btnStaInc[2]="0.026"		;btnStaInc[3]="0.046"		;btnStaInc[4]="c_right.png"			
btnStaSave[0]="save_state"			;btnStaSave[1]="radial"		;btnStaSave[2]="0.026"		;btnStaSave[3]="0.046"		;btnStaSave[4]="c_down.png"			
btnStaLoad[0]="load_state"			;btnStaLoad[1]="radial"		;btnStaLoad[2]="0.026"		;btnStaLoad[3]="0.046"		;btnStaLoad[4]="c_up.png"			
btnSelectCon[0]="select"			;btnSelectCon[1]="rect"		;btnSelectCon[2]="0.038"	;btnSelectCon[3]="0.04"		;btnSelectCon[4]="select_psx.png"	;btnSelectCon[5]="0.068"	;btnSelectCon[6]="0.0225"
btnStartCon[0]="start"				;btnStartCon[1]="rect"		;btnStartCon[2]="0.036"		;btnStartCon[3]="0.04"		;btnStartCon[4]="start_psx.png"		;btnStartCon[5]="0.0632"	;btnStartCon[6]="0.0225"	
btnSelectArc[0]="select"			;btnSelectArc[1]="radial"	;btnSelectArc[2]="0.042"	;btnSelectArc[3]="0.074"	;btnSelectArc[4]="coin.png"			
btnStartArc[0]="start"				;btnStartArc[1]="radial"	;btnStartArc[2]="0.042"		;btnStartArc[3]="0.074"		;btnStartArc[4]="start_rounded.png"	
btnL3[0]="l3"						;btnL3[1]="radial"			;btnL3[2]="0.07"			;btnL3[3]="0.125"			;btnL3[4]="L_face.png"				
btnR3[0]="r3"						;btnR3[1]="radial"			;btnR3[2]="0.07"			;btnR3[3]="0.125"			;btnR3[4]="R_face.png"				
btnL3Low[0]="l3"					;btnL3Low[1]="rect"			;btnL3Low[2]="0.052"		;btnL3Low[3]="0.0926"		;btnL3Low[4]="L_down.png"			;btnL3Low[5]="0.0926"		;btnL3Low[6]="0.052"
btnR3Low[0]="r3"					;btnR3Low[1]="rect"			;btnR3Low[2]="0.052"		;btnR3Low[3]="0.0926"		;btnR3Low[4]="R_down.png"			;btnR3Low[5]="0.0926"		;btnR3Low[6]="0.052"
btnMach2Arc[0]="overlay_next"		;btnMach2Arc[1]="radial"	;btnMach2Arc[2]="0.026"		;btnMach2Arc[3]="0.046"		;btnMach2Arc[4]="A.png"				
btnMach2Con[0]="overlay_next"		;btnMach2Con[1]="radial"	;btnMach2Con[2]="0.026"		;btnMach2Con[3]="0.046"		;btnMach2Con[4]="C.png"				
btnOrie[0]="overlay_next"			;btnOrie[1]="radial"		;btnOrie[2]="0.026"			;btnOrie[3]="0.046"			;btnOrie[4]="rotate.png"			
btnBtnM[0]="overlay_next"			;btnBtnM[1]="rect"			;btnBtnM[2]="0.036"			;btnBtnM[3]="0.046"			;btnBtnM[4]="genesis_mode.png"		;btnBtnM[5]="0.064"			;btnBtnM[6]="0.026"
btnMenu[0]="menu_toggle"			;btnMenu[1]="radial"		;btnMenu[2]="0.026"			;btnMenu[3]="0.046"			;btnMenu[4]="rgui.png"				

## Common - B(utton) G(roup) P(osition) Table
# Top Group (Landscape)
bgpTopX_L[0]="0.05"	 ;bgpTopY_L[0]="0.09"	# Show Button
bgpTopX_L[1]="0.3"	 ;bgpTopY_L[1]="0.09"	# Button Mode Switch Button
bgpTopX_L[2]="0.4"	 ;bgpTopY_L[2]="0.09"	# Machine Type Switch Button
bgpTopX_L[3]="0.5"	 ;bgpTopY_L[3]="0.17"	# Menu Toggle Button
bgpTopX_L[4]="0.6"	 ;bgpTopY_L[4]="0.09"	# Orientation Switch Button
bgpTopX_L[5]="0.95"	 ;bgpTopY_L[5]="0.09"	# Hide Button


# Saves Manage Group(Landscape)
bgpSavX_L[0]="0.05"	 ;bgpSavY_L[0]="0.3"	# Save State Button
bgpSavX_L[1]="0.95"	 ;bgpSavY_L[1]="0.3"	# Load State Button
bgpSavX_L[2]="0.05"	 ;bgpSavY_L[2]="0.5"	# State Slot Dec Button
bgpSavX_L[3]="0.95"	 ;bgpSavY_L[3]="0.5"	# State Slot Inc Button
bgpSavX_L[4]="0.05"	 ;bgpSavY_L[4]="0.7"	# Rewind Button
bgpSavX_L[5]="0.95"	 ;bgpSavY_L[5]="0.7"	# Fast Forward Button

# Thumb Buttons Group (Landscape)
bgpTmbX_L[0]="0.275" ;bgpTmbY_L[0]="0.75"	# Thumb L3 Button
bgpTmbX_L[1]="0.725" ;bgpTmbY_L[1]="0.75"	# Thumb R3 Button


# Thumb Buttons Group - Low Variant (Landscape)
bgpTmLX_L[0]="0.275" ;bgpTmLY_L[0]="0.948"	# Thumb L3 Button (Low Variant)
bgpTmLX_L[1]="0.725" ;bgpTmLY_L[1]="0.948"	# Thumb R3 Button (Low Variant)

# Bottom Group (Landscape)
bgpBtmX_L[0]="0.14"	 ;bgpBtmY_L[0]="0.90"	# Select Button
bgpBtmX_L[1]="0.86"	 ;bgpBtmY_L[1]="0.90"	# Start Button

# Top Group (Portrait)
bgpTopX_P[0]="0.09"	 ;bgpTopY_P[0]="0.05"	# Show Button
bgpTopX_P[1]="0.23"	 ;bgpTopY_P[1]="0.05"	# Button Mode Switch Button
bgpTopX_P[2]="0.36"	 ;bgpTopY_P[2]="0.085"	# Machine Type Switch Button
bgpTopX_P[3]="0.5"	 ;bgpTopY_P[3]="0.145"	# Menu Toggle Button
bgpTopX_P[4]="0.64"	 ;bgpTopY_P[4]="0.085"	# Orientation Switch Button
bgpTopX_P[5]="0.91"	 ;bgpTopY_P[5]="0.05"	# Hide Button

# Saves Manage Group(Portrait)
bgpSavX_P[0]="0.09"	 ;bgpSavY_P[0]="0.40"	# Save State Button
bgpSavX_P[1]="0.91"	 ;bgpSavY_P[1]="0.40"	# Load State Button
bgpSavX_P[2]="0.09"	 ;bgpSavY_P[2]="0.50"	# State Slot Dec Button
bgpSavX_P[3]="0.91"	 ;bgpSavY_P[3]="0.50"	# State Slot Inc Button
bgpSavX_P[4]="0.09"	 ;bgpSavY_P[4]="0.60"	# Rewind Button
bgpSavX_P[5]="0.91"	 ;bgpSavY_P[5]="0.60"	# Fast Forward Button

# Thumb Buttons Group (Portrait)
bgpTmbX_P[0]="0.275" ;bgpTmbY_P[0]="0.86"	# Thumb L3 Button
bgpTmbX_P[1]="0.725" ;bgpTmbY_P[1]="0.86"	# Thumb R3 Button

# Thumb Buttons Group - Low Variant (Portrait)
bgpTmLX_P[0]="0.371" ;bgpTmLY_P[0]="0.97"	# Thumb L3 Button (Low Variant)
bgpTmLX_P[1]="0.629" ;bgpTmLY_P[1]="0.97"	# Thumb R3 Button (Low Variant)

# Bottom Group (Portrait)
bgpBtmX_P[0]="0.14"	 ;bgpBtmY_P[0]="0.944"	# Select Button
bgpBtmX_P[1]="0.86"	 ;bgpBtmY_P[1]="0.944"	# Start Button

## File name definition

fileName_Low="-lowbtn"		# Low Variant Prefix

fileName_con=" (Console)"	# Console Mode Suffix
fileName_arc=" (Arcade)"	# Arcade Mode Suffix

# Targets ID atoms definition
tarId_orie[0]=""	# Defined Next - Change every  6
tarId_btnM[0]=""	# Defined Next - Change every  3
tarId_show[0]=""	# Defined Next - Change every  1

# Targets ID Name definition
tarId_Name[0]=""	# Defined Next

# Redirection Table definition
tarTableShow[0]=""   	# Defined Next
tarTableHide[0]=""   	# Defined Next
tarTableChgOrie[0]=""	# Defined Next
tarTableChgBtnM[0]=""	# Defined Next

# Targets conunter definition
tarTot=0			# Denined Next


## Variabile fill-zone
# Fill tarId_Name[] and define tarId "Atoms" value
tarCount="-1"
for orieCount in `seq 0 1`; do
	for btnMCount in `seq 0 1`; do
		for showCount in `seq 0 2`; do
			((tarCount+=1))
			# Definition of "Atoms" values for each "Target"
			tarId_orie[$tarCount]=${orie[$orieCount]}
			tarId_btnM[$tarCount]=${btnM[$btnMCount]}
			tarId_show[$tarCount]=${show[$showCount]}
			# Definition of Names for each "Target"
			if [ "${tarId_show[$tarCount]}" == "" ]; then
				tarId_Name[$tarCount]=${tarId_orie[$tarCount]}"-"${tarId_btnM[$tarCount]}
			else
				tarId_Name[$tarCount]=${tarId_orie[$tarCount]}"-"${tarId_btnM[$tarCount]}"-"${tarId_show[$tarCount]}
			fi
			# echo ${tarId_Name[$tarCount]}			
		done
	done
done

# Define file tarTot
tarTot=$tarCount

# Fill tarTableShow[] Show redirection value
for tarCount in `seq 0 $tarTot`; do
	case $((tarCount % 3)) in
		0|1)
			tarTableShow[$tarCount]=${tarId_Name[$((tarCount+1))]}
			;;
		2)
			tarTableShow[$tarCount]=${tarId_Name[$((tarCount-2))]}
			;;
	esac
done

# Fill tarTableHide[] Hide redirection value
for tarCount in `seq 0 $tarTot`; do
	case $((tarCount % 3)) in
		0)
			tarTableHide[$tarCount]=${tarId_Name[$((tarCount+2))]}
			;;
		1|2)
			tarTableHide[$tarCount]=${tarId_Name[$((tarCount-1))]}
			;;
	esac
done

# Fill tarTableChgOrie[] Orientation redirection value
for tarCount in `seq 0 $tarTot`; do
	case "${tarId_orie[$tarCount]}" in
		"${orie[0]}")
			if [ "${tarId_show[$tarCount]}" == "" ]; then
				tarTableChgOrie[$tarCount]=${orie[1]}"-"${tarId_btnM[$tarCount]}
			else
				tarTableChgOrie[$tarCount]=${orie[1]}"-"${tarId_btnM[$tarCount]}"-"${tarId_show[$tarCount]}
			fi
			;;
		"${orie[1]}")
			if [ "${tarId_show[$tarCount]}" == "" ]; then
				tarTableChgOrie[$tarCount]=${orie[0]}"-"${tarId_btnM[$tarCount]}
			else
				tarTableChgOrie[$tarCount]=${orie[0]}"-"${tarId_btnM[$tarCount]}"-"${tarId_show[$tarCount]}
			fi
			;;
	esac	
done

# Fill tarTableChgBtnM[] Button Mode redirection value
for tarCount in `seq 0 $tarTot`; do
	case "${tarId_btnM[$tarCount]}" in
		"${btnM[0]}")
			if [ "${tarId_show[$tarCount]}" == "" ]; then
				tarTableChgBtnM[$tarCount]=${tarId_orie[$tarCount]}"-"${btnM[1]}
			else
				tarTableChgBtnM[$tarCount]=${tarId_orie[$tarCount]}"-"${btnM[1]}"-"${tarId_show[$tarCount]}
			fi
			;;
		"${btnM[1]}")
			if [ "${tarId_show[$tarCount]}" == "" ]; then
				tarTableChgBtnM[$tarCount]=${tarId_orie[$tarCount]}"-"${btnM[0]}
			else
				tarTableChgBtnM[$tarCount]=${tarId_orie[$tarCount]}"-"${btnM[0]}"-"${tarId_show[$tarCount]}
			fi
			;;
	esac	
done

## Check Redirection Tables Result (Debug)
# for tarCount in `seq 0 $tarTot`; do
# 	printf "%-32s %s %s\n" ${tarId_Name[$tarCount]} " -> " ${tarTableChgBtnM[$tarCount]}
# done

### File generator
## Targets definition
echo "Generation of \"$fileName$fileName_con.$fileExt\" in progress…"
echo "Generation of \"$fileName$fileName_Low$fileName_con.$fileExt\" in progress…"
echo "Generation of \"$fileName$fileName_arc.$fileExt\" in progress…"
echo "Generation of \"$fileName$fileName_Low$fileName_arc.$fileExt\" in progress…"

echo "overlays = "$((tarTot+1))											| tee    "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null

for tarCount in `seq 0 $tarTot`; do
	echo ""															 	| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_full_screen = "$olayFS					 	| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_normalized = "$olayNorm				 	| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_name = \""${tarId_Name[$tarCount]}"\""		| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_range_mod = "$olayRangeMod				 	| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_alpha_mod = "$olayAlphaMod				 	| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
done

## Targets generator
for tarCount in `seq 0 $tarTot`; do
	# Define "descTot" value based on "tarId_show[]" atom value
	case "${tarId_show[$tarCount]}" in
		"${show[0]}")
			descTot=10
			;;
		"${show[1]}")
			descTot=12
			;;
		"${show[2]}")
			descTot=15
			;;
	esac

	# Orientation Specific Operations
	case "${tarId_orie[$tarCount]}" in
		"${orie[0]}")
			## Position Switch (Landscape)
			# Group 1 (Top)												# Group 2 (Sav)												# Group 3A (Tmb)											# Group 4 (Btm)
			bgpTopX_[0]=${bgpTopX_L[0]} ;bgpTopY_[0]=${bgpTopY_L[0]}	;bgpSavX_[0]=${bgpSavX_L[0]} ;bgpSavY_[0]=${bgpSavY_L[0]}	;bgpTmbX_[0]=${bgpTmbX_L[0]} ;bgpTmbY_[0]=${bgpTmbY_L[0]}	;bgpBtmX_[0]=${bgpBtmX_L[0]} ;bgpBtmY_[0]=${bgpBtmY_L[0]}
			bgpTopX_[1]=${bgpTopX_L[1]} ;bgpTopY_[1]=${bgpTopY_L[1]}	;bgpSavX_[1]=${bgpSavX_L[1]} ;bgpSavY_[1]=${bgpSavY_L[1]}	;bgpTmbX_[1]=${bgpTmbX_L[1]} ;bgpTmbY_[1]=${bgpTmbY_L[1]}	;bgpBtmX_[1]=${bgpBtmX_L[1]} ;bgpBtmY_[1]=${bgpBtmY_L[1]}
			bgpTopX_[2]=${bgpTopX_L[2]} ;bgpTopY_[2]=${bgpTopY_L[2]}	;bgpSavX_[2]=${bgpSavX_L[2]} ;bgpSavY_[2]=${bgpSavY_L[2]}	
			bgpTopX_[3]=${bgpTopX_L[3]} ;bgpTopY_[3]=${bgpTopY_L[3]}	;bgpSavX_[3]=${bgpSavX_L[3]} ;bgpSavY_[3]=${bgpSavY_L[3]}	# Group 3B (TmL)
			bgpTopX_[4]=${bgpTopX_L[4]} ;bgpTopY_[4]=${bgpTopY_L[4]}	;bgpSavX_[4]=${bgpSavX_L[4]} ;bgpSavY_[4]=${bgpSavY_L[4]}	;bgpTmLX_[0]=${bgpTmLX_L[0]} ;bgpTmLY_[0]=${bgpTmLY_L[0]}
			bgpTopX_[5]=${bgpTopX_L[5]} ;bgpTopY_[5]=${bgpTopY_L[5]}	;bgpSavX_[5]=${bgpSavX_L[5]} ;bgpSavY_[5]=${bgpSavY_L[5]}	;bgpTmLX_[1]=${bgpTmLX_L[1]} ;bgpTmLY_[1]=${bgpTmLY_L[1]}
			
			## Size Switch (Landscape)
			# Radial Shape																# Rectangular Shape
			     btnShow_[2]=${btnShow[2]}		      ;btnShow_[3]=${btnShow[3]}		     ;btnBtnM_[2]=${btnBtnM[2]}		      ;btnBtnM_[3]=${btnBtnM[3]}
			     btnHide_[2]=${btnHide[2]}		      ;btnHide_[3]=${btnHide[3]}		
			   btnStaRew_[2]=${btnStaRew[2]}	    ;btnStaRew_[3]=${btnStaRew[3]}		
			   btnStaFfw_[2]=${btnStaFfw[2]}	    ;btnStaFfw_[3]=${btnStaFfw[3]}		
			   btnStaDec_[2]=${btnStaDec[2]}	    ;btnStaDec_[3]=${btnStaDec[3]}		
			   btnStaInc_[2]=${btnStaInc[2]}	    ;btnStaInc_[3]=${btnStaInc[3]}		
			  btnStaSave_[2]=${btnStaSave[2]}	   ;btnStaSave_[3]=${btnStaSave[3]}		
			  btnStaLoad_[2]=${btnStaLoad[2]}	   ;btnStaLoad_[3]=${btnStaLoad[3]}		
			btnSelectArc_[2]=${btnSelectArc[2]}	 ;btnSelectArc_[3]=${btnSelectArc[3]}	;btnSelectCon_[2]=${btnSelectCon[2]} ;btnSelectCon_[3]=${btnSelectCon[3]}
			 btnStartArc_[2]=${btnStartArc[2]}	  ;btnStartArc_[3]=${btnStartArc[3]}	 ;btnStartCon_[2]=${btnStartCon[2]}	  ;btnStartCon_[3]=${btnStartCon[3]}
			       btnL3_[2]=${btnL3[2]}		        ;btnL3_[3]=${btnL3[3]}			    ;btnL3Low_[2]=${btnL3Low[2]}	     ;btnL3Low_[3]=${btnL3Low[3]}
			       btnR3_[2]=${btnR3[2]}		        ;btnR3_[3]=${btnR3[3]}			    ;btnR3Low_[2]=${btnR3Low[2]}	     ;btnR3Low_[3]=${btnR3Low[3]}
			     btnOrie_[2]=${btnOrie[2]}		      ;btnOrie_[3]=${btnOrie[3]}		
			     btnMenu_[2]=${btnMenu[2]}		      ;btnMenu_[3]=${btnMenu[3]}		
			;;
		"${orie[1]}")
			## Position Switch (Portrait)
			# Group 1 (Top)												# Group 2 (Sav)												# Group 3A (Tmb)											# Group 4 (Btm)
			bgpTopX_[0]=${bgpTopX_P[0]} ;bgpTopY_[0]=${bgpTopY_P[0]}	;bgpSavX_[0]=${bgpSavX_P[0]} ;bgpSavY_[0]=${bgpSavY_P[0]}	;bgpTmbX_[0]=${bgpTmbX_P[0]} ;bgpTmbY_[0]=${bgpTmbY_P[0]}	;bgpBtmX_[0]=${bgpBtmX_P[0]} ;bgpBtmY_[0]=${bgpBtmY_P[0]}
			bgpTopX_[1]=${bgpTopX_P[1]} ;bgpTopY_[1]=${bgpTopY_P[1]}	;bgpSavX_[1]=${bgpSavX_P[1]} ;bgpSavY_[1]=${bgpSavY_P[1]}	;bgpTmbX_[1]=${bgpTmbX_P[1]} ;bgpTmbY_[1]=${bgpTmbY_P[1]}	;bgpBtmX_[1]=${bgpBtmX_P[1]} ;bgpBtmY_[1]=${bgpBtmY_P[1]}
			bgpTopX_[2]=${bgpTopX_P[2]} ;bgpTopY_[2]=${bgpTopY_P[2]}	;bgpSavX_[2]=${bgpSavX_P[2]} ;bgpSavY_[2]=${bgpSavY_P[2]}	
			bgpTopX_[3]=${bgpTopX_P[3]} ;bgpTopY_[3]=${bgpTopY_P[3]}	;bgpSavX_[3]=${bgpSavX_P[3]} ;bgpSavY_[3]=${bgpSavY_P[3]}	# Group 3B (TmL)
			bgpTopX_[4]=${bgpTopX_P[4]} ;bgpTopY_[4]=${bgpTopY_P[4]}	;bgpSavX_[4]=${bgpSavX_P[4]} ;bgpSavY_[4]=${bgpSavY_P[4]}	;bgpTmLX_[0]=${bgpTmLX_P[0]} ;bgpTmLY_[0]=${bgpTmLY_P[0]}
			bgpTopX_[5]=${bgpTopX_P[5]} ;bgpTopY_[5]=${bgpTopY_P[5]}	;bgpSavX_[5]=${bgpSavX_P[5]} ;bgpSavY_[5]=${bgpSavY_P[5]}	;bgpTmLX_[1]=${bgpTmLX_P[1]} ;bgpTmLY_[1]=${bgpTmLY_P[1]}

			## Size Switch (Portrait)
			# Radial Shape																# Rectangular Shape
			     btnShow_[2]=${btnShow[3]}		      ;btnShow_[3]=${btnShow[2]}		     ;btnBtnM_[2]=${btnBtnM[5]}		      ;btnBtnM_[3]=${btnBtnM[6]}
			     btnHide_[2]=${btnHide[3]}		      ;btnHide_[3]=${btnHide[2]}		
			   btnStaRew_[2]=${btnStaRew[3]}	    ;btnStaRew_[3]=${btnStaRew[2]}		
			   btnStaFfw_[2]=${btnStaFfw[3]}	    ;btnStaFfw_[3]=${btnStaFfw[2]}		
			   btnStaDec_[2]=${btnStaDec[3]}	    ;btnStaDec_[3]=${btnStaDec[2]}		
			   btnStaInc_[2]=${btnStaInc[3]}	    ;btnStaInc_[3]=${btnStaInc[2]}		
			  btnStaSave_[2]=${btnStaSave[3]} 	   ;btnStaSave_[3]=${btnStaSave[2]}		
			  btnStaLoad_[2]=${btnStaLoad[3]} 	   ;btnStaLoad_[3]=${btnStaLoad[2]}		
			btnSelectArc_[2]=${btnSelectArc[3]}	 ;btnSelectArc_[3]=${btnSelectArc[2]}	;btnSelectCon_[2]=${btnSelectCon[5]} ;btnSelectCon_[3]=${btnSelectCon[6]}
			 btnStartArc_[2]=${btnStartArc[3]}	  ;btnStartArc_[3]=${btnStartArc[2]}	 ;btnStartCon_[2]=${btnStartCon[5]}	  ;btnStartCon_[3]=${btnStartCon[6]}
			       btnL3_[2]=${btnL3[3]} 		        ;btnL3_[3]=${btnL3[2]}			    ;btnL3Low_[2]=${btnL3Low[5]}	     ;btnL3Low_[3]=${btnL3Low[6]}
			       btnR3_[2]=${btnR3[3]} 		        ;btnR3_[3]=${btnR3[2]}			    ;btnR3Low_[2]=${btnR3Low[5]}	     ;btnR3Low_[3]=${btnR3Low[6]}
			     btnOrie_[2]=${btnOrie[3]} 		      ;btnOrie_[3]=${btnOrie[2]}		
			     btnMenu_[2]=${btnMenu[3]} 		      ;btnMenu_[3]=${btnMenu[2]}		
			;;
	esac

	# Buttom Mode Specific Operations
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

	# Visualization Mode Specific Operations
	case "${tarId_show[$tarCount]}" in
		"${show[0]}")
			;;
		"${show[1]}")
			;;
		"${show[2]}")
			;;
	esac

	# Target Head (Commons)
	echo ""																																							| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "# Overlay "$tarCount" - "${tarId_Name[$tarCount]}																											| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo ""																																							| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_descs = "$descTot																														| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
#	echo ${tarId_show_orie[$tarCount]}","${orie[0]}","${orie[1]}

	# Visualization Mode - _Initial Buttons (Commons)
	echo ""																																							| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc0 = \""${btnShow[0]}","${bgpTopX_[0]}","${bgpTopY_[0]}","${btnShow[1]}","${btnShow_[2]}","${btnShow_[3]}"\""						| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc0_overlay = "${btnShow[4]}																											| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc0_next_target = \""${tarTableShow[$tarCount]}"\""																					| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc1 = \""${btnHide[0]}","${bgpTopX_[5]}","${bgpTopY_[5]}","${btnHide[1]}","${btnHide_[2]}","${btnHide_[3]}"\""						| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc1_overlay = "${btnHide[4]}																											| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc1_next_target = \""${tarTableHide[$tarCount]}"\""																					| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo ""																																							| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc2 = \""${btnStaInc[0]}","${bgpSavX_[0]}","${bgpSavY_[0]}","${btnStaInc[1]}","${btnStaInc_[2]}","${btnStaInc_[3]}"\""				| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc2_overlay = "${btnStaInc[4]}																										| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc3 = \""${btnStaDec[0]}","${bgpSavX_[1]}","${bgpSavY_[1]}","${btnStaDec[1]}","${btnStaDec_[2]}","${btnStaDec_[3]}"\""				| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc3_overlay = "${btnStaDec[4]}																										| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo ""																																							| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc4 = \""${btnStaSave[0]}","${bgpSavX_[2]}","${bgpSavY_[2]}","${btnStaSave[1]}","${btnStaSave_[2]}","${btnStaSave_[3]}"\""			| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc4_overlay = "${btnStaSave[4]}																										| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc5 = \""${btnStaLoad[0]}","${bgpSavX_[3]}","${bgpSavY_[3]}","${btnStaLoad[1]}","${btnStaLoad_[2]}","${btnStaLoad_[3]}"\""			| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc5_overlay = "${btnStaLoad[4]}																										| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo ""																																							| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc6 = \""${btnStaRew[0]}","${bgpSavX_[4]}","${bgpSavY_[4]}","${btnStaRew[1]}","${btnStaRew_[2]}","${btnStaRew_[3]}"\""				| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc6_overlay = "${btnStaRew[4]}																										| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc7 = \""${btnStaFfw[0]}","${bgpSavX_[5]}","${bgpSavY_[5]}","${btnStaFfw[1]}","${btnStaFfw_[2]}","${btnStaFfw_[3]}"\""				| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo "overlay"$tarCount"_desc7_overlay = "${btnStaFfw[4]}																										| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
	echo ""																																							| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null

	# Console Specific Buttons
	echo "overlay"$tarCount"_desc8 = \""${btnSelectCon[0]}","${bgpBtmX_[0]}","${bgpBtmY_[0]}","${btnSelectCon[1]}","${btnSelectCon_[2]}","${btnSelectCon_[3]}"\""	| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt"																					> /dev/null
	echo "overlay"$tarCount"_desc8_overlay = "${btnSelectCon[4]}																									| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt"																					> /dev/null
	echo "overlay"$tarCount"_desc9 = \""${btnStartCon[0]}","${bgpBtmX_[1]}","${bgpBtmY_[1]}","${btnStartCon[1]}","${btnStartCon_[2]}","${btnStartCon_[3]}"\""		| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt"																					> /dev/null
	echo "overlay"$tarCount"_desc9_overlay = "${btnStartCon[4]}																										| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt"																					> /dev/null

	# Console Specific Buttons
	echo "overlay"$tarCount"_desc8 = \""${btnSelectArc[0]}","${bgpBtmX_[0]}","${bgpBtmY_[0]}","${btnSelectArc[1]}","${btnSelectArc_[2]}","${btnSelectArc_[3]}"\""	| tee -a "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"																					> /dev/null
	echo "overlay"$tarCount"_desc8_overlay = "${btnSelectArc[4]}																									| tee -a "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"																					> /dev/null
	echo "overlay"$tarCount"_desc9 = \""${btnStartArc[0]}","${bgpBtmX_[1]}","${bgpBtmY_[1]}","${btnStartArc[1]}","${btnStartArc_[2]}","${btnStartArc_[3]}"\""		| tee -a "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"																					> /dev/null
	echo "overlay"$tarCount"_desc9_overlay = "${btnStartArc[4]}																										| tee -a "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"																					> /dev/null

	# Visualization Mode - Partial Buttons (Adds to previous)
	case "${tarId_show[$tarCount]}" in
		"${show[1]}"|"${show[2]}")
			# Normal Thumbs Buttons
			echo ""																																					| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt"																								> /dev/null
			echo "overlay"$tarCount"_desc10 = \""${btnL3__[0]}","${bgpTmbX_[0]}","${bgpTmbY_[0]}","${btnL3__[1]}","${btnL3__[2]}","${btnL3__[3]}"\""				| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt"																								> /dev/null
			echo "overlay"$tarCount"_desc10_overlay = "${btnL3__[4]}																								| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt"																								> /dev/null
			echo "overlay"$tarCount"_desc11 = \""${btnR3__[0]}","${bgpTmbX_[1]}","${bgpTmbY_[1]}","${btnR3__[1]}","${btnR3__[2]}","${btnR3__[3]}"\""				| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt"																								> /dev/null
			echo "overlay"$tarCount"_desc11_overlay = "${btnR3__[4]}																								| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt"																								> /dev/null

			# Low Thumbs Buttons
			echo ""																																					| tee -a "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"								  										> /dev/null
			echo "overlay"$tarCount"_desc10 = \""${btnL3Low__[0]}","${bgpTmLX_[0]}","${bgpTmLY_[0]}","${btnL3Low__[1]}","${btnL3Low__[2]}","${btnL3Low__[3]}"\""	| tee -a "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"								  										> /dev/null
			echo "overlay"$tarCount"_desc10_overlay = "${btnL3Low__[4]}																								| tee -a "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"								  										> /dev/null
			echo "overlay"$tarCount"_desc11 = \""${btnR3Low__[0]}","${bgpTmLX_[1]}","${bgpTmLY_[1]}","${btnR3Low__[1]}","${btnR3Low__[2]}","${btnR3Low__[3]}"\""	| tee -a "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"								  										> /dev/null
			echo "overlay"$tarCount"_desc11_overlay = "${btnR3Low__[4]}																								| tee -a "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"								  										> /dev/null
			;;
	esac
	
	# Visualization Mode - Full Buttons (Adds to previous)
	case "${tarId_show[$tarCount]}" in
		"${show[2]}")
			echo ""																																					| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
			echo "overlay"$tarCount"_desc12 = \""${btnBtnM[0]}","${bgpTopX_[2]}","${bgpTopY_[2]}","${btnBtnM[1]}","${btnBtnM_[2]}","${btnBtnM_[3]}"\""				| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
			echo "overlay"$tarCount"_desc12_overlay = "${btnBtnM[4]}																								| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
			echo "overlay"$tarCount"_desc12_next_target = \""${tarTableChgBtnM[$tarCount]}"\""																		| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
			echo "overlay"$tarCount"_desc13 = \""${btnMenu[0]}","${bgpTopX_[3]}","${bgpTopY_[3]}","${btnMenu[1]}","${btnMenu_[2]}","${btnMenu_[3]}"\""				| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
			echo "overlay"$tarCount"_desc13_overlay = "${btnMenu[4]}																								| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
			echo "overlay"$tarCount"_desc14 = \""${btnOrie[0]}","${bgpTopX_[4]}","${bgpTopY_[4]}","${btnOrie[1]}","${btnOrie_[2]}","${btnOrie_[3]}"\""				| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
			echo "overlay"$tarCount"_desc14_overlay = "${btnOrie[4]}																								| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
			echo "overlay"$tarCount"_desc14_next_target = \""${tarTableChgOrie[$tarCount]}"\""																		| tee -a "$fileName$fileName_con.$fileExt" "$fileName$fileName_Low$fileName_con.$fileExt" "$fileName$fileName_arc.$fileExt" "$fileName$fileName_Low$fileName_arc.$fileExt"	> /dev/null
			;;
	esac

	# ((descTot-=1))
	# for descCount in `seq 0 $descTot`; do
	# 	echo "overlay"$tarCount"_desc"$descCount" = "
	# 	echo "overlay"$tarCount"_desc"$descCount"_overlay = "
	# done
done

IFS=$OLDIFS