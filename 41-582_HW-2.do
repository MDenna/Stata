** Development and Growth 582 - Homework 1 **
** Matthew Dennahower **
** 103728472 **
** Part 2 **

** Q1 **

cd "C:\Users\Dennzy\Desktop\Development And Growth 582\HW1"
insheet using realgdp.csv, clear

// Drop all variables under the year 1980 
keep if year >=1980
// Group countries by name using Country ID numbers in order to utilize xtset
egen cid = group(country)
// Declare cid to be panel variable using year as timevar
xtset cid year
// Calculate Real GDP growth
gen realgdpg=(realgdp-l.realgdp)/l.realgdp
// Calculate mean of Real GDP growth of each country
collapse realgdpg, by(country)
list
// Save data 
save rgdpg.dta, replace
// One to one merge using dataset1 containing various measurements such as population growth, logrgdp1980, etc
merge 1:1 country using dataset1
// Drop all other variables but those specified
keep country realgdpg logrgdp1980
// Create two way scatter plot with realgdpg on the vertical axis, logrgdp1980 on the horizontal axis and a fitted line according to the data
twoway(scatter realgdpg logrgdp1980) (lfit realgdpg logrgdp1980)
clear 

** Q2 **

use rgdpg
// One to one merge using OECD dataset
merge 1:1 country using OECD
// Drop the _merge variable that was created
drop _merge
// One to one merge using dataset1
merge 1:1 country using dataset1
// Drop all other variables but those specified
keep country realgdpg logrgdp1980 oecd
// NOTE: oecd is a dummy variable taking the value 0 if the country is non a member of the OECD and 1 if the country is a member of the OECD 
// Create two way scatter plot of OECD countries with realgdpg on the vertical axis, logrgdp1980 on the horizontal axis and a fitted line according to the data 
twoway(scatter realgdpg logrgdp1980) (lfit realgdpg logrgdp1980) if oecd == 1

** Q3 **

// Create a simple regression with realgdpg as the dependent variable and logrgdp1980 as the independent (exogenous) variable
reg realgdpg logrgdp1980

** Q4 **

// One to one merge using dataset1
merge 1:1 country using dataset1
// Drop all other variables but those specified
keep country realgdpg logrgdp1980 logsk logsg
// Create a regression with realgdpg as the dependent variable and logrgdp1980, logsk and logsg as the independent (exogenous) variables
reg realgdpg logrgdp1980 logsk logsg

** Q5 **

// Provide summary statistics on logrgdp1980
summ logrgdp1980
