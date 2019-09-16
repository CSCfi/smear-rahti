*** Settings ***
Documentation    Smear_Resource-file contains variables and keywords for the SMEAR-tests.
Library          SeleniumLibrary
Library          DateTime

*** Variables ***
${URL}           http://avaa-smear-test.rahtiapp.fi/smear/etusivu
${BROWSER}       Chrome
#${BROWSER}       headlesschrome
#${BROWSER}       Firefox

*** Keywords ***
Open SMEAR
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    id=heading           timeout=10
    Wait Until Page Contains Element    id=footer-content    timeout=10
    Title Should Be                     SMEAR dashboard

Check graphs
    Page Should Contain Element    id=F_c
    Page Should Contain Element    id=highcharts-information-region-2
    Page Should Contain            CO₂ flux

    Page Should Contain Element    id=Hiilidioksidi
    Page Should Contain Element    id=highcharts-information-region-7
    Page Should Contain            CO₂

    Page Should Contain Element    id=E
    Page Should Contain Element    id=highcharts-information-region-3
    Page Should Contain            Evapotranspiration

    Page Should Contain Element    id=aerosolsize
    Page Should Contain Element    id=highcharts-information-region-1
    Page Should Contain            Aerosol size distribution

    Page Should Contain Element    tconc
    Page Should Contain Element    id=highcharts-information-region-15
    Page Should Contain            Total aerosol concentration

    Page Should Contain Element    id=ozone
    Page Should Contain Element    id=highcharts-information-region-14
    Page Should Contain            Ozone

    Page Should Contain Element    id=SO2
    Page Should Contain Element    id=highcharts-information-region-9
    Page Should Contain            SO₂ 15-16m

    Page Should Contain Element    id=NO
    Page Should Contain Element    id=highcharts-information-region-4
    Page Should Contain            NO 15-16m

    Page Should Contain Element    id=NOX
    Page Should Contain Element    id=highcharts-information-region-10
    Page Should Contain            NOx 15-16m

    Page Should Contain Element    id=Radiation
    Page Should Contain Element    id=highcharts-information-region-5
    Page Should Contain            Global radiadiation

    Page Should Contain Element    id=temperature
    Page Should Contain Element    id=highcharts-information-region-11
    Page Should Contain            Temperature 15-16m

    Page Should Contain Element    id=airpressure
    Page Should Contain Element    id=highcharts-information-region-12
    Page Should Contain            Air pressure

    Page Should Contain Element    id=windspeed
    Page Should Contain Element    id=highcharts-information-region-13
    Page Should Contain            Windspeed 15-16m

    Page Should Contain Element    id=windrose
    Page Should Contain Element    id=highcharts-information-region-0
    Page Should Contain            Wind direction %

    Page Should Contain Element    id=Rhumidity
    Page Should Contain Element    id=highcharts-information-region-6
    Page Should Contain            Relative humidity

    Page Should Contain Element    id=ts
    Page Should Contain Element    id=highcharts-information-region-8
    Page Should Contain            Soil temperature

Close SMEAR
    Sleep    2s
    Close Browser