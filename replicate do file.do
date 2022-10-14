
//winsorize all continuous variables in our analysis at the top and bottom 1 percent of their distributions //
winsor2 NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 InfoEnviron Gaapdiff enforcement change_in_FVP Exposure Restrictiveness ,cuts(1 99) replace
//TABLE 1  Sample Distribution//
count  if (type=="non financial firm"&group=="Mandatory IFRS Adopters"&country=="Australia")
count  if (type=="non financial firm"&group=="Mandatory IFRS Adopters"&country=="Philippines")


//TABLE 2  Descriptive Statistics//

//summarize//
estpost summarize NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="non financial firm"&group=="Mandatory IFRS Adopters")
eststo a1
. esttab a1, cells(" mean median sd ") noobs
eststo clear
estpost summarize NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="non financial firm"&group=="Non-IFRS Adopters")
eststo a1
. esttab a1, cells(" mean median sd ") noobs
eststo clear
estpost summarize NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="non financial firm"&group=="PSM Non-IFRS Adopters")
eststo a1
. esttab a1, cells(" mean median sd ") noobs
eststo clear
estpost summarize NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="non financial firm"&group=="Voluntary IFRS Adopters")
eststo a1
. esttab a1, cells(" mean median sd ") noobs
eststo clear



estpost summarize NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="financial firm"&group=="Mandatory IFRS Adopters")
eststo a1
. esttab a1, cells(" mean median sd ") noobs
eststo clear
estpost summarize NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="financial firm"&group=="Non-IFRS Adopters")
eststo a1
. esttab a1, cells(" mean median sd ") noobs
eststo clear
estpost summarize NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="financial firm"&group=="PSM Non-IFRS Adopters")
eststo a1
. esttab a1, cells(" mean median sd ") noobs
eststo clear
estpost summarize NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="financial firm"&group=="Voluntary IFRS Adopters")
eststo a1
. esttab a1, cells(" mean median sd ") noobs
eststo clear

//PANEL A,B: Descriptive Statistics//

. estpost tabstat NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 ,by(group) listwise statistics(n sd mean median)
eststo a1
. esttab, cells(" NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 ")
eststo clear


//TABLE 3 //
generate POST=0
replace POST=1 if year>2005 | year==2005

gen MandatoryAdopters=0
replace MandatoryAdopters=1 if (group=="Mandatory IFRS Adopters")

gen DID= MandatoryAdopters * POST

//Panel A: Nonfinancial Firms//

reg NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="non financial firm" & (group=="Mandatory IFRS Adopters"| group=="Non-IFRS Adopters") )
eststo model1
estadd local year_fe "No"
estadd local industry_fe "No"
estadd local country_fe "No"

xi: reg NCSKEWt DID i.year i.industry i.country if (type=="non financial firm" & (group=="Mandatory IFRS Adopters"| group=="Non-IFRS Adopters") )
eststo model2
estadd local year_fe "yes"
estadd local industry_fe "yes"
estadd local country_fe "yes"

xi: reg NCSKEWt DID DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 i.year i.country i.industry if (type=="non financial firm" & (group=="Mandatory IFRS Adopters"| group=="Non-IFRS Adopters") )
eststo model3
estadd local year_fe "yes"
estadd local industry_fe "yes"
estadd local country_fe "yes"


reg NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="non financial firm" & (group=="Mandatory IFRS Adopters"| group=="PSM Non-IFRS Adopters") )
eststo model4
estadd local year_fe "No"
estadd local industry_fe "No"
estadd local country_fe "No"

xi: reg NCSKEWt DID i.year i.industry i.country if (type=="non financial firm" & (group=="Mandatory IFRS Adopters"| group=="PSM Non-IFRS Adopters") )
eststo model5
estadd local year_fe "yes"
estadd local industry_fe "yes"
estadd local country_fe "yes"

xi: reg NCSKEWt DID DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 i.year i.country i.industry if (type=="non financial firm" & (group=="Mandatory IFRS Adopters"| group=="PSM Non-IFRS Adopters") )
eststo model6
estadd local year_fe "yes"
estadd local industry_fe "yes"
estadd local country_fe "yes"


reg NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="non financial firm" & (group=="Mandatory IFRS Adopters"| group=="Voluntary IFRS Adopters") )
eststo model7
estadd local year_fe "No"
estadd local industry_fe "No"
estadd local country_fe "No"

xi: reg NCSKEWt DID i.year i.industry i.country if (type=="non financial firm" & (group=="Mandatory IFRS Adopters"| group=="Voluntary IFRS Adopters") )
eststo model8
estadd local year_fe "yes"
estadd local industry_fe "yes"
estadd local country_fe "yes"

xi: reg NCSKEWt DID DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 i.year i.country i.industry if (type=="non financial firm" & (group=="Mandatory IFRS Adopters"| group=="Voluntary IFRS Adopters") )
eststo model9
estadd local year_fe "yes"
estadd local industry_fe "yes"
estadd local country_fe "yes"

esttab model1 model2 model3 model4 model5 model6 model7 model8 model9 , r2 ar2 star(* 0.1 ** 0.05 *** 0.01) label title("Tabel 3:") mtitle("" "" """" "" """" "" "") drop(_Iyear* _Icountry* _Iindustry*) scalars("year_fe""country_fe""industry_fe")


//Panel B: Financial Firms//
reg NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="financial firm" & (group=="Mandatory IFRS Adopters"| group=="Non-IFRS Adopters") )
eststo model1
estadd local year_fe "No"
estadd local industry_fe "No"
estadd local country_fe "No"

xi: reg NCSKEWt DID i.year i.industry i.country if (type=="financial firm" & (group=="Mandatory IFRS Adopters"| group=="Non-IFRS Adopters") )
eststo model2
estadd local year_fe "yes"
estadd local industry_fe "yes"
estadd local country_fe "yes"

xi: reg NCSKEWt DID DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 i.year i.country i.industry if (type=="financial firm" & (group=="Mandatory IFRS Adopters"| group=="Non-IFRS Adopters") )
eststo model3
estadd local year_fe "yes"
estadd local industry_fe "yes"
estadd local country_fe "yes"


reg NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="financial firm" & (group=="Mandatory IFRS Adopters"| group=="PSM Non-IFRS Adopters") )
eststo model4
estadd local year_fe "No"
estadd local industry_fe "No"
estadd local country_fe "No"

xi: reg NCSKEWt DID i.year i.industry i.country if (type=="financial firm" & (group=="Mandatory IFRS Adopters"| group=="PSM Non-IFRS Adopters") )
eststo model5
estadd local year_fe "yes"
estadd local industry_fe "yes"
estadd local country_fe "yes"

xi: reg NCSKEWt DID DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 i.year i.country i.industry if (type=="financial firm" & (group=="Mandatory IFRS Adopters"| group=="PSM Non-IFRS Adopters") )
eststo model6
estadd local year_fe "yes"
estadd local industry_fe "yes"
estadd local country_fe "yes"


reg NCSKEWt DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 MBt_1 LEVt_1 ROAt_1 ABACCt_1 if (type=="financial firm" & (group=="Mandatory IFRS Adopters"| group=="Voluntary IFRS Adopters") )
eststo model7
estadd local year_fe "No"
estadd local industry_fe "No"
estadd local country_fe "No"

xi: reg NCSKEWt DID i.year i.industry i.country if (type=="financial firm" & (group=="Mandatory IFRS Adopters"| group=="Voluntary IFRS Adopters") )
eststo model8
estadd local year_fe "yes"
estadd local industry_fe "yes"
estadd local country_fe "yes"

xi: reg NCSKEWt DID DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 i.year i.country i.industry if (type=="financial firm" & (group=="Mandatory IFRS Adopters"| group=="Voluntary IFRS Adopters") )
eststo model9
estadd local year_fe "yes"
estadd local industry_fe "yes"
estadd local country_fe "yes"

esttab model1 model2 model3 model4 model5 model6 model7 model8 model9 , r2 ar2 star(* 0.1 ** 0.05 *** 0.01) label title("Tabel 3:") mtitle("" "" """" "" """" "" "") drop(_Iyear* _Icountry* _Iindustry*) scalars("year_fe""country_fe""industry_fe")

//TABLE 4 //

//Panel A,B: Analysis Conditional on Firm-Level Information Environment, Using Non-IFRS Adopters as the Benchmark//

egen median_InfoEnviron= median(InfoEnviron)

gen RichInfoEnviron=0
replace RichInfoEnviron=1 if InfoEnviron>median_InfoEnviron | InfoEnviron==median_InfoEnviron

gen PoorInfoEnviron=0
replace PoorInfoEnviron=1 if InfoEnviron<median_InfoEnviron

xi: reg NCSKEWt DID DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 i.year i.country i.industry if (type=="non financial firm" & (group=="Mandatory IFRS Adopters"| group=="Non-IFRS Adopters")& RichInfoEnviron==1 )
eststo model1
estadd local year_fe "yes"
estadd local count_fe "yes"
estadd local ind_fe "yes"
estadd local Firm_level "yes"	

xi: reg NCSKEWt DID DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 i.year i.country i.industry if (type=="non financial firm" & (group=="Mandatory IFRS Adopters"| group=="Non-IFRS Adopters")& PoorInfoEnviron==1 )
eststo model2
estadd local year_fe "yes"
estadd local count_fe "yes"
estadd local ind_fe "yes"
estadd local Firm_level "yes"	

esttab model1 model2 , r2 ar2 star(* 0.1 ** 0.05 *** 0.01) label title("Tabel 4:") mtitle("RichInfoEnviron" "PoorInfoEnviron") drop(_Iyear* _Icountry* _Iindustry* DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 _cons) scalars("year_fe""count_fe""ind_fe""Firm_level") labcol2(-, title("" PredSign))

//Panel C,D: Analysis Conditional on Country-Level GAAP Change and Enforcement, Mandatory Adopters Only//
egen median_enforcement= median(enforcement)
egen median_Gaapdiff= median(Gaapdiff)

gen StrongEnforcement=0
replace StrongEnforcement=1 if enforcement>median_enforcement | enforcement==median_enforcement
gen Weakenforcement=0
replace Weakenforcement=1 if enforcement<median_enforcement

gen LargeGAAPchange=0
replace LargeGAAPchange=1 if Gaapdiff>median_Gaapdiff | Gaapdiff==median_Gaapdiff
gen SmallGAAPchange=0
replace SmallGAAPchange=1 if Gaapdiff<median_Gaapdiff

xi: reg NCSKEWt POST DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1  i.country i.industry if (type=="non financial firm" & group=="Mandatory IFRS Adopters"& StrongEnforcement==1 & LargeGAAPchange==1)
eststo model1
estadd local year_fe "NO"
estadd local count_fe "yes"
estadd local ind_fe "yes"
estadd local Firm_level "yes"

xi: reg NCSKEWt POST DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1  i.country i.industry if (type=="non financial firm" & group=="Mandatory IFRS Adopters"& Weakenforcement==1 & LargeGAAPchange==1)
eststo model2
estadd local year_fe "NO"
estadd local count_fe "yes"
estadd local ind_fe "yes"
estadd local Firm_level "yes"

xi: reg NCSKEWt POST DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1  i.country i.industry if (type=="non financial firm" & group=="Mandatory IFRS Adopters"& StrongEnforcement==1 & SmallGAAPchange==1)
eststo model3
estadd local year_fe "NO"
estadd local count_fe "yes"
estadd local ind_fe "yes"
estadd local Firm_level "yes"

xi: reg NCSKEWt POST DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1  i.country i.industry if (type=="non financial firm" & group=="Mandatory IFRS Adopters"& Weakenforcement==1 & SmallGAAPchange==1)
eststo model4
estadd local year_fe "NO"
estadd local count_fe "yes"
estadd local ind_fe "yes"
estadd local Firm_level "yes"

esttab model1 model2 model3 model4 , r2 ar2 star(* 0.1 ** 0.05 *** 0.01) label title("Tabel 4:") mtitle("Strong_Large" "Weak_Large" "Strong_Small" "Weak_Small") drop(_Icountry* _Iindustry* DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 _cons) scalars("year_fe""count_fe""ind_fe""Firm_level") labcol2(_, title("" PredSign))

//TABLE 5 //

//Panel A: Analysis Conditional on Country-Level Change in IAS 39 Fair Value Provisions, Mandatory Adopters Only//
egen median_change_in_FVP= median(change_in_FVP)

gen Largechange=0
replace Largechange=1 if change_in_FVP>median_change_in_FVP | change_in_FVP==median_change_in_FVP
gen Smallchange=0
replace Smallchange=1 if change_in_FVP<median_change_in_FVP

xi: reg NCSKEWt POST DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1  i.country  if (type=="financial firm" & group=="Mandatory IFRS Adopters"& Largechange==1)
eststo model1
estadd local year_fe "NO"
estadd local count_fe "yes"
estadd local ind_fe "NO"
estadd local Firm_level "yes"

xi: reg NCSKEWt POST DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1  i.country  if (type=="financial firm" & group=="Mandatory IFRS Adopters"& Smallchange==1)
eststo model2
estadd local year_fe "NO"
estadd local count_fe "yes"
estadd local ind_fe "NO"
estadd local Firm_level "yes"

xi: reg NCSKEWt POST DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1  i.country  if (type=="financial firm" & group=="Mandatory IFRS Adopters"& Largechange==1 & PoorInfoEnviron==1)
eststo model3
estadd local year_fe "NO"
estadd local count_fe "yes"
estadd local ind_fe "NO"
estadd local Firm_level "yes"

xi: reg NCSKEWt POST DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1  i.country  if (type=="financial firm" & group=="Mandatory IFRS Adopters"& Largechange==1 & RichInfoEnviron==1)
eststo model4
estadd local year_fe "NO"
estadd local count_fe "yes"
estadd local ind_fe "NO"
estadd local Firm_level "yes"

xi: reg NCSKEWt POST DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1  i.country  if (type=="financial firm" & group=="Mandatory IFRS Adopters"& Smallchange==1 & PoorInfoEnviron==1)
eststo model5
estadd local year_fe "NO"
estadd local count_fe "yes"
estadd local ind_fe "NO"
estadd local Firm_level "yes"

xi: reg NCSKEWt POST DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1  i.country  if (type=="financial firm" & group=="Mandatory IFRS Adopters"& Smallchange==1 & RichInfoEnviron==1)
eststo model6
estadd local year_fe "NO"
estadd local count_fe "yes"
estadd local ind_fe "NO"
estadd local Firm_level "yes"

esttab model1 model2 model3 model4 model5 model6 , r2 ar2 star(* 0.1 ** 0.05 *** 0.01) label title("Tabel 5:") mtitle("Largechange" "Smallchange" "Large_Poor" "Large_Rich" "Small_Poor" "Small_Rich") drop(_Icountry* DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 _cons) scalars("year_fe""count_fe""ind_fe""Firm_level") labcol2(?, title("" PredSign))

//Panel B: Analysis Conditional on Firm-Level Fair Value Exposure, Using Non-IFRS Adopters as Benchmark//

egen median_Exposure= median(Exposure)

gen MoreExposure=0
replace MoreExposure=1 if Exposure>median_Exposure | Exposure==median_Exposure
gen LessExposure=0
replace LessExposure=1 if Exposure<median_Exposure

xi: reg NCSKEWt DID DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 i.year i.country  if (type=="financial firm" & (group=="Mandatory IFRS Adopters"| group=="Non-IFRS Adopters") & MoreExposure==1 )
eststo model1
estadd local year_fe "yes"
estadd local count_fe "yes"
estadd local ind_fe "NO"
estadd local Firm_level "yes"

xi: reg NCSKEWt DID DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 i.year i.country  if (type=="financial firm" & (group=="Mandatory IFRS Adopters"| group=="Non-IFRS Adopters") & LessExposure==1 )
eststo model2
estadd local year_fe "yes"
estadd local count_fe "yes"
estadd local ind_fe "NO"
estadd local Firm_level "yes"

esttab model1 model2 , r2 ar2 star(* 0.1 ** 0.05 *** 0.01) label title("Tabel 5:") mtitle("More Exposure" "Less Exposure") drop(_Iyear* _Icountry* DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 _cons) scalars("year_fe""count_fe""ind_fe""Firm_level") labcol2(?, title("" PredSign))

//Panel C: Analysis Conditional on Country-Level Restrictiveness of Banking Regulations, Using Non-IFRS Adopters as Benchmark//

egen median_Restrictiveness= median(Restrictiveness)

gen Morerestrictive=0
replace Morerestrictive=1 if Restrictiveness>median_Restrictiveness | Restrictiveness==median_Restrictiveness
gen Lessrestrictive=0
replace Lessrestrictive=1 if Restrictiveness<median_Restrictiveness

xi: reg NCSKEWt DID DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 i.year i.country  if (type=="financial firm" & (group=="Mandatory IFRS Adopters"| group=="Non-IFRS Adopters") & Lessrestrictive==1 )
eststo model1
estadd local year_fe "yes"
estadd local count_fe "yes"
estadd local ind_fe "NO"
estadd local Firm_level "yes"

xi: reg NCSKEWt DID DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 i.year i.country  if (type=="financial firm" & (group=="Mandatory IFRS Adopters"| group=="Non-IFRS Adopters") & Morerestrictive==1 )
eststo model2
estadd local year_fe "yes"
estadd local count_fe "yes"
estadd local ind_fe "NO"
estadd local Firm_level "yes"

esttab model1 model2 , r2 ar2 star(* 0.1 ** 0.05 *** 0.01) label title("Tabel 5:") mtitle("Less restrictive" "More restrictive") drop(_Iyear* _Icountry* DTURNt_1 NCSKEWt_1 SIGMAt_1 RETt_1 SIZEt_1 LEVt_1 ROAt_1 ABACCt_1 _cons) scalars("year_fe""count_fe""ind_fe""Firm_level") labcol2(?, title("" PredSign))









