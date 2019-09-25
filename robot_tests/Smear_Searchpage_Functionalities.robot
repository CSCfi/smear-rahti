*** Settings ***
Documentation     Smear_Searchpage_Functionalities.robot tests searches from different stations with different variables using different search options.
Resource          Smear_Resource.robot
Default Tags      Searchpage
Suite Setup       Open SMEAR searchpage
Suite Teardown    Close SMEAR

*** Variables ***
${GivenDate1}    2016-01-01
${GivenDate2}    2017-01-01
${GivenDate3}    2019-01-01

*** Test Cases ***
Search data from Värriö
#Select Värriö, Aerosol, Particle concentration, Click "Plot", check that correct graph appears.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Particle concentration')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Particle concentration

Search data from Värriö - Select two variables
#Select Värriö, Gas, NO concentration 9 m and O3 concentration 9 m, Click "Plot", check that correct graphs appear.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[2]/ul/li[2]/div/span[contains(text(),'NO concentration 9 m')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[2]/ul/li[10]/div/span[contains(text(),'O3 concentration 9 m')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    NO concentration 9 m
    Page Should Contain Element    id=id1
    Element Should Contain         id=id1    O3 concentration 9 m

Search data from Värriö - Change date by left button
#Select Värriö, Meteorology, Wind speed 16 m, Click "Plot", check that correct graph appears.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Select previous date
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[3]/ul/li[3]/div/span[contains(text(),'Wind speed 16 m')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Wind speed 16 m

Search data from Värriö - Change date by left button - Select two variables
#Select Värriö, Radiation, UVA radiation and UVB radiation, Click "Plot", check that correct graphs appear.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Select previous date
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[4]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[4]/ul/li[5]/div/span[contains(text(),'UVA radiation')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[4]/ul/li[6]/div/span[contains(text(),'UVB radiation')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    UVA radiation
    Page Should Contain Element    id=id1
    Element Should Contain         id=id1    UVB radiation

Search data from Värriö - Change week by left button
#Select Värriö, Soil, Soil temperature 10 cm, Click "Plot", check that correct graph appears.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Select previous week
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[5]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[5]/ul/li[4]/div/span[contains(text(),'Soil temperature 10 cm')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Soil temperature 10 cm

Search data from Värriö - Change week by left button - Select two variables
#Select Värriö, Tree, H2O in shoot chamber 0 and H2O in shoot chamber 1, Click "Plot", check that correct graphs appear.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Select previous week
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[6]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[6]/ul/li[6]/div/span[contains(text(),'H2O in shoot chamber 0')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[6]/ul/li[12]/div/span[contains(text(),'H2O in shoot chamber 1')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    H2O in shoot chamber 0
    Page Should Contain Element    id=id1
    Element Should Contain         id=id1    H2O in shoot chamber 1

Search data from Värriö - Change month by left button
#Select Värriö, Flux, CO2 flux, Click "Plot", check that correct graph appears.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Select previous month
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[7]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[7]/ul/li[7]/div/span[contains(text(),'CO2 flux')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    CO2 flux

Search data from Värriö - Change year by left button
#Select Värriö, Flux ancillary data, Air temperature, Click "Plot", check that correct graph appears.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Select previous year
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[8]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[8]/ul/li[10]/div/span[contains(text(),'Air temperature')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Air temperature

Search data from Värriö - No data
#Select Värriö, Aerosol, Pressure, Click "Plot", check that correct graph appears.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[9]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[9]/ul/li[22]/div/span[contains(text(),'Pressure')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Not Contain     id=id0    Pressure

Search data from Hyytiälä
#Select Hyytiälä, Flux, Sensible heat storage flux, Click "Plot", check that correct graph appears.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[2]/div/span[contains(text(),'Hyytiälä')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Sensible heat storage flux')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Sensible heat storage flux

Search data from Kumpula
#Select Kumpula, Gas, NO concentration, Click "Plot", check that correct graph appears.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[3]/div/span[contains(text(),'Kumpula')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[2]/ul/li[2]/div/span[contains(text(),'NO concentration')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    NO concentration

Search data from Kumpula - Change date by text input
#Select Kumpula, Meteorology, Relative humidity, Click "Plot", check that correct graph appears.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Input date
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[3]/div/span[contains(text(),'Kumpula')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[3]/ul/li[3]/div/span[contains(text(),'Relative humidity')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Relative humidity

Search data from Kumpula - Change date by using calendar
#Select Kumpula, Meteorology, Snowfall, Click "Plot", check that correct graph appears.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Select date from calendar
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[3]/div/span[contains(text(),'Kumpula')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[3]/ul/li[13]/div/span[contains(text(),'Snowfall')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Snowfall

Search data from Puijo - Change date by text input - Given date from 2016
#Select Puijo, Meteorology, Matlab time, Click "Plot", check that correct graph appears.
#To get some data from Puijo date has to be from the year 2016.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Input date GivenDate1
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[4]/div/span[contains(text(),'Puijo')]
    Click Element    xpath=//*[@id="tree"]/ul/li[4]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[4]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[4]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Matlab time')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Contain             id=id0    Matlab time

Search data from Erottaja - No data
#Select Erottaja, Flux, Sensible heat flux, Click "Plot", check that correct graph appears.
#No data found from Erottaja.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[5]/div/span[contains(text(),'Erottaja')]
    Click Element    xpath=//*[@id="tree"]/ul/li[5]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[5]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[5]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Sensible heat flux')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Not Contain         id=id0    Sensible heat flux

Search data from Torni
#Select Torni, Flux, Wind speed, Click "Plot", check that correct graph appears.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[6]/div/span[contains(text(),'Torni')]
    Click Element    xpath=//*[@id="tree"]/ul/li[6]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[6]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[6]/ul/li[2]/ul/li[12]/div/span[contains(text(),'Wind speed')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Wind speed

Search data from Siikaneva 1
#Select Siikaneva 1, Meteorology, Rainfall, Click "Plot", check that correct graph appears.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[7]/div/span[contains(text(),'Siikaneva 1')]
    Click Element    xpath=//*[@id="tree"]/ul/li[7]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[7]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[7]/ul/li[3]/ul/li[1]/div/span[contains(text(),'Rainfall')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Rainfall

Search data from Siikaneva 2 - Change date by text input - Given date from 2017
#Select Siikaneva 2, Radiation, Net radiation, Click "Plot", check that correct graph appears.
#To get some data from Siikaneva 2 date has to be from the year 2017.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Input date GivenDate2
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[8]/div/span[contains(text(),'Siikaneva 2')]
    Click Element    xpath=//*[@id="tree"]/ul/li[8]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[8]/ul/li[4]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[8]/ul/li[4]/ul/li[1]/div/span[contains(text(),'Net radiation')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Contain             id=id0    Net radiation

Search data from Kuivajärvi - No data
#Select Kuivajärvi, Water, Water temperature 1.0 m, Click "Plot", check that correct graph appears.
#There should be data but it's not found. Maybe error in database, logs refer to that.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[9]/div/span[contains(text(),'Kuivajärvi')]
    Click Element    xpath=//*[@id="tree"]/ul/li[9]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[9]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[9]/ul/li[3]/ul/li[3]/div/span[contains(text(),'Water temperature 1.0 m')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Not Contain         id=id0    Water temperature 1.0 m

Search data from Dome_C - Change date by text input - Given date from 2019
#Select Dome_C, Meteorology, Air temperature, Click "Plot", check that correct graph appears.
#To get some data from Dome_C date has to be from the year 2019.
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Input date GivenDate3
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[10]/div/span[contains(text(),'Dome_C')]
    Click Element    xpath=//*[@id="tree"]/ul/li[10]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[10]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[10]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Air temperature')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Contain             id=id0    Air temperature
