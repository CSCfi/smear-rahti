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
    Element Should Contain         id=F_c    CO₂ flux

    Page Should Contain Element    id=Hiilidioksidi
    Element Should Contain         id=Hiilidioksidi    CO₂

    Page Should Contain Element    id=E
    Element Should Contain         id=E    Evapotranspiration

    Page Should Contain Element    id=aerosolsize
    Element Should Contain         id=aerosolsize    Aerosol size distribution

    Page Should Contain Element    tconc
    Element Should Contain         id=tconc    Total aerosol concentration

    Page Should Contain Element    id=ozone
    Element Should Contain         id=ozone    Ozone

    Page Should Contain Element    id=SO2
    Element Should Contain         id=SO2    SO₂ 15-16m

    Page Should Contain Element    id=NO
    Element Should Contain         id=NO    NO 15-16m

    Page Should Contain Element    id=NOX
    Element Should Contain         id=NOX    NOx 15-16m

    Page Should Contain Element    id=Radiation
    Element Should Contain         id=Radiation    Global radiadiation

    Page Should Contain Element    id=temperature
    Element Should Contain         id=temperature    Temperature 15-16m

    Page Should Contain Element    id=airpressure
    Element Should Contain         id=airpressure    Air pressure

    Page Should Contain Element    id=windspeed
    Element Should Contain         id=windspeed    Windspeed 15-16m

    Page Should Contain Element    id=windrose
    Element Should Contain         id=windrose    Wind direction %

    Page Should Contain Element    id=Rhumidity
    Element Should Contain         id=Rhumidity    Relative humidity

    Page Should Contain Element    id=ts
    Element Should Contain         id=ts    Soil temperature

Close SMEAR
    Sleep    2s
    Close Browser