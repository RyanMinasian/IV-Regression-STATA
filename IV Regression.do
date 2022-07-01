
clear all


import delimited "C:\Users\DERMINA1\OneDrive - EY\Desktop\Uni\Master Thesis\Python\07 Accounting Data\Accounting_Data_Winsorized.csv"

drop isin1
encode isin, gen(isin1)
xtset isin1 year

label variable rd_w1 "R&D"
label variable intangibles_w1 "Intangibles"
label variable operating_margin_w1 "Operating Margin"
label variable stock_price_w1 "Stock Price"
label variable log_assets_w1 "Firm Size"
label variable roa_w1 "ROA"
label variable roe_w1 "ROE"
label variable capex_w1 "Capex"
label variable log_market_cap_w1 "Log (Market Cap)"
label variable leverage_w1 "Leverage"
label variable mtbratio_w1 "Market-to-Book Ratio"
label variable pteratio_w1 "Price-to-Earnings Ratio"
label variable pegratio_w1 "Price/Earnings-to-Growth Ratio"
label variable tobins_q_w1 "Tobin's Q"
label variable total_q_w1 "Total Q"
label variable lead_total_q_w1 "Total Q (Lead)"
label variable g_netincome_w1 "Net Income Growth"
label variable g_netsales_w1 "Sales Growth"
label variable biggest_blockholder "Biggest Blockholder"
label variable blackrock_holdings "BlackRock Holdings"
label variable big_three_holdings "Big Three Holdings"
label variable degree_weighted "Degree"
label variable degree_largest "Degree (Largest)"
label variable relative_degree_weighted "Relative Degree"
label variable relative_degree_largest "Relative Degree (largest)"
label variable eigenvector "Eigenvector"
label variable mscidummy "MSCI"

label variable lag_rd_w1 "R&D"
label variable lag_intangibles_w1 "Intangibles"
label variable lag_operating_margin_w1 "Operating Margin"
label variable lag_stock_price_w1 "Stock Price"
label variable lag_log_assets_w1 "Firm Size"
label variable lag_roa_w1 "ROA"
label variable lag_roe_w1 "ROE"
label variable lag_capex_w1 "Capex"
label variable lag_log_market_cap_w1 "Log (Market Cap)"
label variable lag_leverage_w1 "Leverage"
label variable lag_mtbratio_w1 "Market-to-Book Ratio"
label variable lag_pteratio_w1 "Price-to-Earnings Ratio"
label variable lag_pegratio_w1 "Price/Earnings-to-Growth Ratio"
label variable lag_tobins_q_w1 "Tobin's Q"
label variable lag_total_q_w1 "Total Q"
label variable lag_g_netincome_w1 "Net Income Growth"
label variable lag_g_netsales_w1 "Sales Growth"

*************** VARIABLES ***************

*** Dependant Variables
global yTQ1 tobins_q_w1
global yMtB1 mtbratio_w1
global ypeg1 pegratio_w1

*** Explaining Variables Combinations

global contrlist_lag lag_log_assets_w1 lag_rd_w1 lag_intangibles_w1 lag_roa_w1 lag_capex_w1 lag_leverage_w1 g_netsales_w1

global sortlist degree_weighted lag_degree_weighted relative_degree_weighted lag_relative_degree_weighted blackrock_holdings lag_blackrock_holdings big_three_holdings lag_big_three_holdings eigenvector lag_eigenvector


// Exporting Filetypes
global Filetype excel tex(frag)
global vcetype cluster(isin1)


*************** MODELS ***************





************ IV REGRESSION 1 ****************


// *** Degree
// xtreg degree_weighted mscidummy i.year, fe $vcetype
// outreg2 using IVRegI, $Filetype replace label keep(mscidummy) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni nocons sortvar($sortlist) stats(coef pval) pdec(3) nonotes addnote(Instrumental variables regressions of Tobin's Q on network centrality - predicted by the instrumental variable MSCI., This binary instrument takes the value of 1 if the firm was included in the MSCI All Country World index in the year under review., All control variables are winsorized at 1% level and lagged by one year - except for Sales Growth. All models include firm and year fixed effects., Standard errors are clustered at firm level and p-values are in parantheses. *** p<0.01; ** p<0.05; * p<0.1.)
//
// xi: xtivreg2 tobins_q_w1 i.year (degree_weighted = mscidummy), fe $vcetype first endog(degree_weighted)
// outreg2 using IVRegI, $Filetype append label keep(degree_weighted mscidummy) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes
//
// xtreg degree_weighted mscidummy $contrlist_lag i.year, fe $vcetype
// outreg2 using IVRegI, $Filetype append label keep(mscidummy $contrlist_lag) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni nocons sortvar($sortlist) stats(coef pval) pdec(3) nonotes
//
// xi: xtivreg2 tobins_q_w1 $contrlist_lag i.year (degree_weighted = mscidummy), fe $vcetype first endog(degree_weighted)
// outreg2 using IVRegI, $Filetype append label keep(degree_weighted mscidummy $contrlist_lag) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes
//
//
// *** Relative Degree
// xtreg relative_degree_weighted mscidummy i.year, fe $vcetype
// outreg2 using IVRegI, $Filetype append label keep(mscidummy) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni nocons sortvar($sortlist) stats(coef pval) pdec(3) nonotes
//
// xi: xtivreg2 tobins_q_w1 i.year (relative_degree_weighted = mscidummy), fe $vcetype first ffirst endog(relative_degree_weighted)
// outreg2 using IVRegI, $Filetype append label keep(relative_degree_weighted mscidummy) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes
//
// xtreg relative_degree_weighted mscidummy $contrlist_lag i.year, fe $vcetype
// outreg2 using IVRegI, $Filetype append label keep(mscidummy $contrlist_lag) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni nocons sortvar($sortlist) stats(coef pval) pdec(3) nonotes
//
// xi: xtivreg2 tobins_q_w1 $contrlist_lag i.year (relative_degree_weighted = mscidummy), fe $vcetype first endog(relative_degree_weighted)
// outreg2 using IVRegI, $Filetype append label keep(relative_degree_weighted mscidummy $contrlist_lag) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes




// ************ IV REGRESSION 1 (LAGGED) ****************
//
//
// *** Degree
// xtreg lag_degree_weighted mscidummy i.year, fe $vcetype
// outreg2 using IVRegI_LAG, $Filetype replace label keep(mscidummy) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni nocons sortvar($sortlist) stats(coef pval) pdec(3) nonotes
//
// xi: xtivreg2 tobins_q_w1 i.year (lag_degree_weighted = mscidummy), fe $vcetype first endog(lag_degree_weighted)
// outreg2 using IVRegI_LAG, $Filetype append label keep(lag_degree_weighted mscidummy) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes
//
// xtreg lag_degree_weighted mscidummy $contrlist_lag i.year, fe $vcetype
// outreg2 using IVRegI_LAG, $Filetype append label keep(mscidummy $contrlist_lag) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni nocons sortvar($sortlist) stats(coef pval) pdec(3) nonotes
//
// xi: xtivreg2 tobins_q_w1 $contrlist_lag i.year (lag_degree_weighted = mscidummy), fe $vcetype first endog(lag_degree_weighted)
// outreg2 using IVRegI_LAG, $Filetype append label keep(lag_degree_weighted mscidummy $contrlist_lag) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes
//
//
// *** Relative Degree
// xtreg lag_relative_degree_weighted mscidummy i.year, fe $vcetype
// outreg2 using IVRegI_LAG, $Filetype append label keep(mscidummy) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni nocons sortvar($sortlist) stats(coef pval) pdec(3) nonotes
//
// xi: xtivreg2 tobins_q_w1 i.year (lag_relative_degree_weighted = mscidummy), fe $vcetype first ffirst endog(lag_relative_degree_weighted)
// outreg2 using IVRegI_LAG, $Filetype append label keep(lag_relative_degree_weighted mscidummy) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes
//
// xtreg lag_relative_degree_weighted mscidummy $contrlist_lag i.year, fe $vcetype
// outreg2 using IVRegI_LAG, $Filetype append label keep(mscidummy $contrlist_lag) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni nocons sortvar($sortlist) stats(coef pval) pdec(3) nonotes
//
// xi: xtivreg2 tobins_q_w1 $contrlist_lag i.year (lag_relative_degree_weighted = mscidummy), fe $vcetype first endog(lag_relative_degree_weighted)
// outreg2 using IVRegI_LAG, $Filetype append label keep(lag_relative_degree_weighted mscidummy $contrlist_lag) addtext(Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes






************ IV REGRESSION 2 ****************

xi: xtivreg2 tobins_q_w1 $contrlist_lag i.year (degree_weighted = mscidummy), fe $vcetype first endog(degree_weighted)
outreg2 using IVRegII, $Filetype replace label keep(degree_weighted) addtext(Control Variables, Yes, Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes addnote(Second stage results of instrumental variables regressions of Tobin's Q and Total Q on network centrality - predicted by the instrumental variable MSCI., This binary instrument takes the value of 1 if the firm was included in the MSCI All Country World index in the year under review., All control variables are winsorized at 1% level and lagged by one year - except for Sales Growth. All models include firm and year fixed effects., Standard errors are clustered at firm level and p-values are in parantheses. *** p<0.01; ** p<0.05; * p<0.1.)

xi: xtivreg2 tobins_q_w1 $contrlist_lag i.year (relative_degree_weighted = mscidummy), fe $vcetype first endog(relative_degree_weighted)
outreg2 using IVRegII, $Filetype append label keep(relative_degree_weighted) addtext(Control Variables, Yes, Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes

xi: xtivreg2 tobins_q_w1 $contrlist_lag i.year (eigenvector = mscidummy), fe $vcetype first endog(eigenvector)
outreg2 using IVRegII, $Filetype append label keep(eigenvector) addtext(Control Variables, Yes, Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes

*** Append TOTAL Q ***

xi: xtivreg2 total_q_w1 $contrlist_lag i.year (degree_weighted = mscidummy), fe $vcetype first endog(degree_weighted)
outreg2 using IVRegII, $Filetype append label keep(degree_weighted) addtext(Control Variables, Yes, Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes

xi: xtivreg2 total_q_w1 $contrlist_lag i.year (relative_degree_weighted = mscidummy), fe $vcetype first endog(relative_degree_weighted)
outreg2 using IVRegII, $Filetype append label keep(relative_degree_weighted) addtext(Control Variables, Yes, Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes

xi: xtivreg2 total_q_w1 $contrlist_lag i.year (eigenvector = mscidummy), fe $vcetype first endog(eigenvector)
outreg2 using IVRegII, $Filetype append label keep(eigenvector) addtext(Control Variables, Yes, Firm FE, Yes, Year FE, Yes) addstat(F-statistic, e(F)) nor2 noni sortvar($sortlist) stats(coef pval) pdec(3) nonotes





































