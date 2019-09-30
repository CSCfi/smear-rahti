*** Settings ***
Documentation     Smear_Searchpage_Functionalities.robot tests searches from different stations with different variables using different search options.
Resource          Smear_Resource.robot
Default Tags      Searchpage
Suite Setup       Open SMEAR searchpage
Suite Teardown    Close SMEAR

*** Variables ***

*** Test Cases ***
Search data from Värriö
#Select Värriö, Aerosol, Particle concentration, Click "Plot", check that correct graph appears.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Particle concentration')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Particle concentration

Search data from Värriö - Select two variables
#Select Värriö, Gas, NO concentration 9 m and O3 concentration 9 m, Click "Plot", check that correct graphs appear.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[2]/ul/li[2]/div/span[contains(text(),'NO concentration 9 m')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[2]/ul/li[10]/div/span[contains(text(),'O3 concentration 9 m')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Wait Until Page Contains Element    id=id1
    Element Should Contain              id=id0    NO concentration 9 m
    Element Should Contain              id=id1    O3 concentration 9 m

Search data from Värriö - Change day by left arrow button
#Select Värriö, Meteorology, Wind speed 16 m, Click "Plot", check that correct graph appears.
    Click Link    Search
    Select previous day
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[3]/ul/li[3]/div/span[contains(text(),'Wind speed 16 m')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Wind speed 16 m

Search data from Värriö - Change day by left arrow button - Select two variables
#Select Värriö, Radiation, UVA radiation and UVB radiation, Click "Plot", check that correct graphs appear.
    Click Link    Search
    Select previous day
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[4]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[4]/ul/li[5]/div/span[contains(text(),'UVA radiation')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[4]/ul/li[6]/div/span[contains(text(),'UVB radiation')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Wait Until Page Contains Element    id=id1
    Element Should Contain              id=id0    UVA radiation
    Element Should Contain              id=id1    UVB radiation

Search data from Värriö - Change week by left arrow button
#Select Värriö, Soil, Soil temperature 10 cm, Click "Plot", check that correct graph appears.
    Click Link    Search
    Select previous week
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[5]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[5]/ul/li[4]/div/span[contains(text(),'Soil temperature 10 cm')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Soil temperature 10 cm

Search data from Värriö - Change week by left arrow button - Select two variables
#Select Värriö, Tree, H2O in shoot chamber 0 and H2O in shoot chamber 1, Click "Plot", check that correct graphs appear.
    Click Link    Search
    Select previous week
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[6]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[6]/ul/li[6]/div/span[contains(text(),'H2O in shoot chamber 0')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[6]/ul/li[12]/div/span[contains(text(),'H2O in shoot chamber 1')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Wait Until Page Contains Element    id=id1
    Element Should Contain              id=id0    H2O in shoot chamber 0
    Element Should Contain              id=id1    H2O in shoot chamber 1

Search data from Värriö - Change month by left arrow button
#Select Värriö, Flux, CO2 flux, Click "Plot", check that correct graph appears.
    Click Link    Search
    Select previous month
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[7]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[7]/ul/li[7]/div/span[contains(text(),'CO2 flux')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    CO2 flux

Search data from Värriö - Change year by left arrow button
#Select Värriö, Flux ancillary data, Air temperature, Click "Plot", check that correct graph appears.
    Click Link    Search
    Select previous year
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[8]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[8]/ul/li[10]/div/span[contains(text(),'Air temperature')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    10s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Air temperature

Search data from Värriö - No data
#Select Värriö, Aerosol, Pressure, Click "Plot", check that graph doesn't appear.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[9]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[9]/ul/li[22]/div/span[contains(text(),'Pressure')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Not Contain          id=id0    Pressure

Search data from Hyytiälä
#Select Hyytiälä, Flux, Sensible heat storage flux, Click "Plot", check that correct graph appears.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[2]/div/span[contains(text(),'Hyytiälä')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Sensible heat storage flux')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Sensible heat storage flux

Search data from Hyytiälä - Change week by left arrow button and change day by right arrow button
#Select Hyytiälä, Flux, Latent heat storage flux, Click "Plot", check that correct graph appears.
    Click Link    Search
    Select previous week and next day
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[2]/div/span[contains(text(),'Hyytiälä')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[1]/ul/li[2]/div/span[contains(text(),'Latent heat storage flux')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Latent heat storage flux

Search data from Hyytiälä - Change year by left arrow button - Select quality checked
#Select Hyytiälä, Radiation, Global radiation 67 m, Click "Plot", check that correct graph appears.
    Click Link    Search
    Select previous year
    Select From List By Value    id=quality    2
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[2]/div/span[contains(text(),'Hyytiälä')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[6]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[6]/ul/li[1]/div/span[contains(text(),'Global radiation 67 m')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    10s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Global radiation 67 m

Search data from Hyytiälä - Select averaging 30min - Select geometric
#Select Hyytiälä, Soil, Soil surface temperature (ICOS), Click "Plot", check that correct graph appears.
    Click Link    Search
    Select previous day
    Select From List By Value    id=avg    30min
    Select From List By Value    id=avgtype    1
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[2]/div/span[contains(text(),'Hyytiälä')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[7]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[7]/ul/li[1]/div/span[contains(text(),'Soil surface temperature (ICOS)')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Soil surface temperature (ICOS)

Search data from Hyytiälä - Select averaging 30min - Select arithmetic
#Select Hyytiälä, Soil, Soil temperature A (ICOS), Click "Plot", check that correct graph appears.
    Click Link    Search
    Select previous day
    Select From List By Value    id=avg    30min
    Select From List By Value    id=avgtype    2
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[2]/div/span[contains(text(),'Hyytiälä')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[7]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[7]/ul/li[2]/div/span[contains(text(),'Soil temperature A (ICOS)')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Soil temperature A (ICOS)

Search data from Hyytiälä - Select averaging 30min - Select sum
#Select Hyytiälä, Soil, Soil temperature B1 (ICOS), Click "Plot", check that correct graph appears.
    Click Link    Search
    Select previous day
    Select From List By Value    id=avg    30min
    Select From List By Value    id=avgtype    3
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[2]/div/span[contains(text(),'Hyytiälä')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[7]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[7]/ul/li[3]/div/span[contains(text(),'Soil temperature B1 (ICOS)')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Soil temperature B1 (ICOS)

Search data from Hyytiälä - Select averaging 1h - Select median
#Select Hyytiälä, Soil, Soil temperature B2 (ICOS), Click "Plot", check that correct graph appears.
    Click Link    Search
    Select previous day
    Select From List By Value    id=avg    1h
    Select From List By Value    id=avgtype    4
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[2]/div/span[contains(text(),'Hyytiälä')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[7]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[7]/ul/li[4]/div/span[contains(text(),'Soil temperature B2 (ICOS)')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Soil temperature B2 (ICOS)

Search data from Hyytiälä - Select averaging 1h - Select max
#Select Hyytiälä, Soil, Soil temperature C (ICOS), Click "Plot", check that correct graph appears.
    Click Link    Search
    Select previous day
    Select From List By Value    id=avg    1h
    Select From List By Value    id=avgtype    5
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[2]/div/span[contains(text(),'Hyytiälä')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[7]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[7]/ul/li[5]/div/span[contains(text(),'Soil temperature C (ICOS)')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Soil temperature C (ICOS)

Search data from Hyytiälä - Select averaging 1h - Select min
#Select Hyytiälä, Soil, Soil temperature C2 (ICOS), Click "Plot", check that correct graph appears.
    Click Link    Search
    Select previous day
    Select From List By Value    id=avg    1h
    Select From List By Value    id=avgtype    6
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[2]/div/span[contains(text(),'Hyytiälä')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[7]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[7]/ul/li[6]/div/span[contains(text(),'Soil temperature C2 (ICOS)')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Soil temperature C2 (ICOS)

Search data from Kumpula
#Select Kumpula, Gas, CO concentration, Click "Plot", check that correct graph appears.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[3]/div/span[contains(text(),'Kumpula')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[2]/ul/li[5]/div/span[contains(text(),'CO concentration')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    CO concentration

Search data from Kumpula - Change date by text input
#Select Kumpula, Meteorology, Relative humidity, Click "Plot", check that correct graph appears.
    Click Link    Search
    Input date
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[3]/div/span[contains(text(),'Kumpula')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[3]/ul/li[3]/div/span[contains(text(),'Relative humidity')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Relative humidity

Search data from Kumpula - Change date by using calendar
#Select Kumpula, Meteorology, Snowfall, Click "Plot", check that correct graph appears.
    Click Link    Search
    Select date from calendar
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[3]/div/span[contains(text(),'Kumpula')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[3]/ul/li[13]/div/span[contains(text(),'Snowfall')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Snowfall

Search data from Puijo - Change year to 2016 by left arrow button
#Select Puijo, Meteorology, Matlab time, Click "Plot", check that correct graph appears.
#To get some data from Puijo date has to be from the year 2016.
    Click Link    Search
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Select From List By Value    id=pituus    year
    Click Button    xpath=//*[@id="datepicker1"]/button[1]
    Click Button    xpath=//*[@id="datepicker1"]/button[1]
    Click Button    xpath=//*[@id="datepicker1"]/button[1]
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[4]/div/span[contains(text(),'Puijo')]
    Click Element    xpath=//*[@id="tree"]/ul/li[4]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[4]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[4]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Matlab time')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    10s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Matlab time

Search data from Erottaja - No data
#Select Erottaja, Flux, Sensible heat flux, Click "Plot", check that correct graph appears(?).
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[5]/div/span[contains(text(),'Erottaja')]
    Click Element    xpath=//*[@id="tree"]/ul/li[5]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[5]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[5]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Sensible heat flux')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Not Contain          id=id0    Sensible heat flux

Search data from Torni
#Select Torni, Flux, Wind speed, Click "Plot", check that correct graph appears.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[6]/div/span[contains(text(),'Torni')]
    Click Element    xpath=//*[@id="tree"]/ul/li[6]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[6]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[6]/ul/li[2]/ul/li[12]/div/span[contains(text(),'Wind speed')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Wind speed

Search data from Siikaneva 1
#Select Siikaneva 1, Meteorology, Rainfall, Click "Plot", check that correct graph appears.
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[7]/div/span[contains(text(),'Siikaneva 1')]
    Click Element    xpath=//*[@id="tree"]/ul/li[7]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[7]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[7]/ul/li[3]/ul/li[1]/div/span[contains(text(),'Rainfall')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Rainfall

Search data from Siikaneva 2 - Change year to 2017 by left arrow button
#Select Siikaneva 2, Radiation, Net radiation, Click "Plot", check that correct graph appears.
#To get some data from Siikaneva 2 date has to be from the year 2017.
    Click Link    Search
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Select From List By Value    id=pituus    year
    Click Button    xpath=//*[@id="datepicker1"]/button[1]
    Click Button    xpath=//*[@id="datepicker1"]/button[1]
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[8]/div/span[contains(text(),'Siikaneva 2')]
    Click Element    xpath=//*[@id="tree"]/ul/li[8]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[8]/ul/li[4]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[8]/ul/li[4]/ul/li[1]/div/span[contains(text(),'Net radiation')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    10s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Net radiation

Search data from Kuivajärvi - No data
#Select Kuivajärvi, Water, Water temperature 1.0 m, Click "Plot", check that correct graph appears(?).
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[9]/div/span[contains(text(),'Kuivajärvi')]
    Click Element    xpath=//*[@id="tree"]/ul/li[9]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[9]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[9]/ul/li[3]/ul/li[3]/div/span[contains(text(),'Water temperature 1.0 m')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    5s
    Wait Until Page Contains Element    id=id0
    Element Should Not Contain          id=id0    Water temperature 1.0 m

Search data from Dome_C - Change year to 2018 by left arrow button
#Select Dome_C, Meteorology, Air temperature, Click "Plot", check that correct graph appears.
#To get some data from Dome_C date has to be from the year 2018.
    Click Link    Search
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Select From List By Value    id=pituus    year
    Click Button    xpath=//*[@id="datepicker1"]/button[1]
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[10]/div/span[contains(text(),'Dome_C')]
    Click Element    xpath=//*[@id="tree"]/ul/li[10]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[10]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[10]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Air temperature')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    10s
    Wait Until Page Contains Element    id=id0
    Element Should Contain              id=id0    Air temperature
