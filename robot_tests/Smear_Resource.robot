*** Settings ***
Documentation    Smear_Resource.robot-file contains libraries, variables and keywords for the SMEAR-tests.
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

Open SMEAR searchpage
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    id=heading           timeout=10
    Wait Until Page Contains Element    id=footer-content    timeout=10
    Title Should Be                     SMEAR dashboard
    Click Link         Search
    Title Should Be    SMEAR search

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
Select next date
#By default "To"-field returns previous date.
#Click right button and check that current date returns to "To"-field.
    ${CurrentDate}    Get Current Date    result_format=%Y-%m-%d
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Click Button    xpath=//*[@id="datepicker1"]/button[2]
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${CurrentDate}

Select previous date
#By default "To"-field returns previous date.
#Increment -2 days to get correct date.
#Click left button and check that day before yesterday returns to "To"-field.
    ${CurrentDate}    Get Current Date    result_format=%Y-%m-%d
    ${NewDate}        Add Time To Date    ${CurrentDate}    -2 days    result_format=%Y-%m-%d
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Click Button    xpath=//*[@id="datepicker1"]/button[1]
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${NewDate}

Select next week
#By default "To"-field returns previous date.
#Increment +6 days to get correct date.
#Select "Week" and click right button and check that correct date returns to "To"-field.
    ${CurrentDate}    Get Current Date    result_format=%Y-%m-%d
    ${NewDate}        Add Time To Date    ${CurrentDate}    6 days    result_format=%Y-%m-%d
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Select From List By Value    id=pituus    week
    Sleep    2s
    Click Button    xpath=//*[@id="datepicker1"]/button[2]
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${NewDate}

Select previous week
#By default "To"-field returns previous date.
#Increment -8 days to get correct date.
#Select "Week" and click left button and check that correct date returns to "To"-field.
    ${CurrentDate}    Get Current Date    result_format=%Y-%m-%d
    ${NewDate}        Add Time To Date    ${CurrentDate}    -8 days    result_format=%Y-%m-%d
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Select From List By Value    id=pituus    week
    Sleep    2s
    Click Button    xpath=//*[@id="datepicker1"]/button[1]
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${NewDate}

Select previous month
#By default "To"-field returns previous date.
#Increment -1 month to get correct date.
#Select "Month" and click left button and check that correct date returns to "To"-field.
    ${Y}    Get Current Date    result_format=%Y
    ${m}    Get Current Date    result_format=%m    increment=-31 day
    ${d}    Get Current Date    result_format=%d    increment=-1 day
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Select From List By Value    id=pituus    month
    Sleep    2s
    Click Button    xpath=//*[@id="datepicker1"]/button[1]
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${Y}-${m}-${d}

Select previous year
#By default "To"-field returns previous date.
#Increment -1 year to get correct date.
#Select "Year" and click left button and check that correct date returns to "To"-field.
    ${Y}    Get Current Date    result_format=%Y    increment=-365 day
    ${m}    Get Current Date    result_format=%m
    ${d}    Get Current Date    result_format=%d    increment=-1 day
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Select From List By Value    id=pituus    year
    Sleep    2s
    Click Button    xpath=//*[@id="datepicker1"]/button[1]
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${Y}-${m}-${d}

Input date
#By default "To"-field returns previous date.
#Increment -2 days to get correct date.
#Select "To"-field and input day before yesterday and check that correct date returns to "To"-field.
#Date format has to be yyyy-mm-dd.
#RETURN has to be pressed in the input field.
    ${CurrentDate}    Get Current Date    result_format=%Y-%m-%d
    ${NewDate}        Add Time To Date    ${CurrentDate}    -2 days    result_format=%Y-%m-%d
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Click Element    xpath=//*[@id="datepicker1"]/input
    Sleep    2s
    Input Text    xpath=//*[@id="datepicker1"]/input    ${NewDate}
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${NewDate}
    Click Element    xpath=//*[@id="datepicker1"]/input
    Press Keys    None    RETURN

Input date GivenDate1
#Given date comes from the test variable.
#Date format has to be yyyy-mm-dd.
#RETURN has to be pressed in the input field.
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Click Element    xpath=//*[@id="datepicker1"]/input
    Sleep    2s
    Input Text    xpath=//*[@id="datepicker1"]/input    ${GivenDate1}
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${GivenDate1}
    Click Element    xpath=//*[@id="datepicker1"]/input
    Press Keys    None    RETURN

Input date GivenDate2
#Given date comes from the test variable.
#Date format has to be yyyy-mm-dd.
#RETURN has to be pressed in the input field.
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Click Element    xpath=//*[@id="datepicker1"]/input
    Sleep    2s
    Input Text    xpath=//*[@id="datepicker1"]/input    ${GivenDate2}
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${GivenDate2}
    Click Element    xpath=//*[@id="datepicker1"]/input
    Press Keys    None    RETURN

Input date GivenDate3
#Given date comes from the test variable.
#Date format has to be yyyy-mm-dd.
#RETURN has to be pressed in the input field.
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Click Element    xpath=//*[@id="datepicker1"]/input
    Sleep    2s
    Input Text    xpath=//*[@id="datepicker1"]/input    ${GivenDate3}
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${GivenDate3}
    Click Element    xpath=//*[@id="datepicker1"]/input
    Press Keys    None    RETURN

Select date from calendar
#By default "To"-field returns previous date.
#Select calendar and select first date of the month and check that correct date returns to "To"-field.
#Date format has to be yyyy-mm-dd.
    ${Y}    Get Current Date    result_format=%Y
    ${m}    Get Current Date    result_format=%m
#    ${d}    Get Current Date    result_format=%d
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Click Element    xpath=//*[@id="datepicker1"]/div/span
    Sleep    2s
    Click Element    xpath=//td[starts-with(text(),'1')]
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${Y}-${m}-01
