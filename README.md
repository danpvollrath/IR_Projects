# IR Projects
Projects for Institutional Research

snippet header
	## ************************************
	## Script name:
	## For:
	## Location: 
	## Author: Dan Vollrath
	## Email: danpvollrath@gmail.com
	## Date Created: `r paste(Sys.Date())`
	## ************************************
	##
	## Notes: 
	##
	##
	##
	## *************************************
		
	library(haven)
	library(DBI)
	
	con <- dbConnect(odbc::odbc(), "DPC_PROD")
		
		
snippet cgf 
	cgf <- read_sav("Q:/PIE/Mainframe Data Projects/Data Files/Grade Files/Current Grade File.sav")

snippet nsc
	nsc <- read_sav("Q:/PIE/Institutional Data/National Student Clearinghouse (Transfer Data)/Students who Transferred.sav")

snippet code
	"Q:/PIE/Research & Development/R Programming/"
	
snippet section_create
	# **************************************
	# Creating our data sets ----
	# **************************************
	
snippet section_combine
	# **************************************
	# Combining our data sets ----
	# **************************************
	
snippet section_analyse
	# **************************************
	# Analysis ----
	# **************************************
	
snippet section_save
	# **************************************
	#  Save ----
	# **************************************
	
snippet section_blank
	# **************************************
	#  ----
	# **************************************
	
	
	
snippet copy
	write.table( , "clipboard-16384", sep = '\t', row.names = FALSE)
