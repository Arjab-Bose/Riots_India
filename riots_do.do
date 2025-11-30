clear all

cd "F:\SMU_sem_3\Labor_econ\Ps_git"

import excel acled, firstrow clear 

keep if COUNTRY == "India"

rename ADMIN1 state

lab var state "State"

save acled_india.dta, replace



keep if EVENT_TYPE == "Riots"

gen year = year(WEEK)

lab var year "Year"

drop if year == 2015

lab var EVENTS "Total Incidents"

preserve

collapse(sum) EVENTS, by(year)

twoway (connected EVENTS year, ///
    lcolor(navy) mcolor(navy) msymbol(circle) msize(medium) lwidth(medium)), ///
    title("Number of Riot Events", size(medium)) ///
    xtitle("Year") xlabel(2016(1)2025, grid) ///
    ytitle("Total Events") ylabel(, grid) ///
    graphregion(color(white)) bgcolor(white) ///
    note("Source: ACLED Data")
	
graph export riots_plot.pdf, replace

restore 










gen state_abbr = ""

replace state_abbr = "AP"  if state == "Andhra Pradesh"
replace state_abbr = "AR"  if state == "Arunachal Pradesh"
replace state_abbr = "AS"  if state == "Assam"
replace state_abbr = "BR"  if state == "Bihar"
replace state_abbr = "CG"  if state == "Chhattisgarh"
replace state_abbr = "GA"  if state == "Goa"
replace state_abbr = "GJ"  if state == "Gujarat"
replace state_abbr = "HR"  if state == "Haryana"
replace state_abbr = "HP"  if state == "Himachal Pradesh"
replace state_abbr = "JH"  if state == "Jharkhand"
replace state_abbr = "KA"  if state == "Karnataka"
replace state_abbr = "KL"  if state == "Kerala"
replace state_abbr = "MP"  if state == "Madhya Pradesh"
replace state_abbr = "MH"  if state == "Maharashtra"
replace state_abbr = "MN"  if state == "Manipur"
replace state_abbr = "ML"  if state == "Meghalaya"
replace state_abbr = "MZ"  if state == "Mizoram"
replace state_abbr = "NL"  if state == "Nagaland"
replace state_abbr = "OD"  if state == "Odisha"
replace state_abbr = "PB"  if state == "Punjab"
replace state_abbr = "RJ"  if state == "Rajasthan"
replace state_abbr = "SK"  if state == "Sikkim"
replace state_abbr = "TN"  if state == "Tamil Nadu"
replace state_abbr = "TS"  if state == "Telangana"
replace state_abbr = "TR"  if state == "Tripura"
replace state_abbr = "UP"  if state == "Uttar Pradesh"
replace state_abbr = "UK"  if state == "Uttarakhand"
replace state_abbr = "WB"  if state == "West Bengal"


replace state_abbr = "AN" if state == "Andaman and Nicobar Islands"
replace state_abbr = "CH" if state == "Chandigarh"
replace state_abbr = "DN" if state == "Dadra and Nagar Haveli and Daman and Diu"
replace state_abbr = "DL" if state == "Delhi"
replace state_abbr = "JK" if state == "Jammu and Kashmir"
replace state_abbr = "LA" if state == "Ladakh"
replace state_abbr = "LD" if state == "Lakshadweep"
replace state_abbr = "PY" if state == "Puducherry"

collapse (sum) EVENTS , by(state_abbr)

egen state_num = group(state_abbr)



twoway ///
    (scatter EVENTS state_num, ///
        mcolor(navy) msymbol(circle) msize(medlarge) ///
        mlabel(state_abbr) mlabcolor(black) mlabsize(small) mlabpos(12)) ///
    , ///
    xlabel("", noticks) xtitle("") ///
    ytitle("Total Riots") ///
    title("Riots Across Indian States") ///
    scheme(s2mono)
	
graph export riots_state.pdf, replace




