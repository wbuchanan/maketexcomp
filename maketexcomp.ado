********************************************************************************
* Description of the Program -												   *
* Utility to build a LaTeX compilation script.								   *
*                                                                              *
* Program Output -                                                             *
*     Bash/Batch script calling pdflatex on a given LaTeX source code file     *
*                                                                              *
* Lines -                                                                      *
*     80                                                                       *
*                                                                              *
********************************************************************************
		
*! maketexcomp
*! v 0.0.0
*! 27OCT2015

// Drop program from memory if it is already loaded
cap prog drop maketexcomp

// Define program
prog def maketexcomp, rclass

	// Version Stata should use to interpret the code
	version 14 
	
	// Define syntax structure for subroutine
	syntax anything(name=filenm id="Name of LaTeX Source Code File"),		 ///   
	SCRiptname(string) [ PDFlatex(string asis) ]
	
	// Check for null PDFLaTeX argument
	if `"`pdflatex'"' == "" {
	
		// If null use the binary name
		loc pdflatex pdflatex
		
	} // End IF Block for null pdflatex binary reference
	
	// Check if user is running on Windoze
	if `"`c(os)'"' == "Windows" {
	
		loc compile `scriptname'.bat
	
		// Write a Windoze batch script to compile a given LaTeX document
		file open comp using `"`scriptname'.bat"', w replace
		file write comp "::Batch file to compile LaTeX source" _n
		file write comp `"`pdflatex'.exe `filenm'"' _n
		file write comp `"`pdflatex'.exe `filenm'"' _n
		file write comp `"`pdflatex'.exe `filenm'"' _n
		file write comp "" _n
		file write comp "" _n
		file close comp
			
	} // End IF Block for Windoze-based systems
	
	// For all other computer systems on the planet
	else {
	
		loc compile `scriptname'.sh

		// Write a bash script to compile the LaTeX document 
		file open comp using `"`scriptname'.sh"', w replace
		file write comp "#!/bin/bash" _n
		file write comp `"`pdflatex' `filenm'"' _n
		file write comp `"`pdflatex' `filenm'"' _n
		file write comp `"`pdflatex' `filenm'"' _n
		file write comp "" _n
		file close comp

		// Make the bash script executable
		! sudo chmod a+x "`scriptname'.sh"

	} // End of ELSE Block for non Windoze based systems
	
	// Return the fully defined script name in a local macro
	ret loc comp ! pdflatex `compile'
	
// End of subroutine definition	
end
	
