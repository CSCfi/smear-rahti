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
### Open and Close ###
Open SMEAR
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    id=heading           timeout=10
    Wait Until Page Contains Element    id=footer-content    timeout=10
    Title Should Be                     SMEAR dashboard

Close SMEAR
    Sleep    2s
    Close Browser

### Check keywords ###
Check header
    Page Should Contain Image    /static/images/AVAA.png
    Page Should Contain Link     https://avaa.tdata.fi/web/avaa/etusivu

Check navigation
    Page Should Contain Link    etusivu
    Page Should Contain Link    Dashboard
    Page Should Contain Link    search.html
    Page Should Contain Link    Search
#Others are not developed yet

Check datepicker
    Page Should Contain Element    id=datepicker1

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

Check footer
    Page Should Contain          Open science and research is an initiative funded by the Ministry of Education and Culture with the target of making Finland one of the leading countries in openness of science and research by the year 2017.
    Page Should Contain Image    /static/images/okm-logo-en.png
    Page Should Contain Link     http://okm.fi/OPM/?lang=en
    Page Should Contain Image    /static/images/ATT_pos_pysty_RGB_EN_transparent.png
    Page Should Contain Link     http://openscience.fi/
    Page Should Contain Image    /static/images/csc-logo.png
    Page Should Contain Link     https://www.csc.fi/en/

### Functionality keywords ###
