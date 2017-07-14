** Senior Research Workshop 407 - Assignment 1 **
** Matthew Dennahower **
** 103728472 **

** Question 2 **

insheet using "C:\Users\Dennzy\Desktop\MA-Economics\407\Assign1\Assn1_Q2.csv"


// Generate log of Output, Consumption and Investment

gen lny = ln(y)
gen lnc = ln(c)
gen lni = ln(i)

// Create labels for these variables

label variable lny "Natural log of Output"
label variable lnc "Natural log of Consumption"
label variable lni "Natural log of Investment"

// Create variable id for time corresponding to each quarter

gen t = _n

// Regress lny on time

reg lny t

// Calculate the residuals

predict dlny, residual

// Calculate the linear prediction from fitted model

predict trend_lny, xb

// Create two-way scatterplot using trend_lny and t

twoway (scatter trend_lny t)

// Regress lnc on time

reg lnc t

// Calculate the residuals

predict dlnc, residual

// Regress lni on  time

reg lni t

// Calculate the residuals

predict dlni, residual

// Calculate covariance matrix for dlny dlnc and dlni 

correlate dlny dlnc dlni

// Calculate pairwise correlation coefficients

pwcorr dlny dlnc dlni

