*** Settings ***
Documentation    Smear_Searchpage_Functionalities.robot.
Resource         Smear_Resource.robot

*** Variables ***

*** Test Cases ***
Open SMEAR
    Open SMEAR

### Search data from Värriö ###
#Select Värriö, select Aerosol, select Particle concentration, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Värriö
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Particle concentration')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Particle concentration

### Search data from Värriö - Two variables ###
#Select Värriö, select Gas, select NO concentration 9 m and O3 concentration 9 m, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Värriö - Two variables
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

### Search data from Värriö - Change date ###
#By default "To"-field returns previous date.
#Increment -2 days to get correct date.
#Click left button and check that day before yesterday returns to "To"-field.
#Select Värriö, select Meteorology, select Wind speed 16 m, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Värriö - Change date
    Click Link    Search
    Select day before yesterday
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[3]/ul/li[3]/div/span[contains(text(),'Wind speed 16 m')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Wind speed 16 m

### Search data from Värriö - Change date - Select two variables ###
#By default "To"-field returns previous date.
#Increment -2 days to get correct date.
#Click left button and check that day before yesterday returns to "To"-field.
#Select Värriö, select Radiation, select UVA radiation and UVB radiation, Click "Plot", check that correct graphs appear
#Fix arrow-signs to readable links when application is fixed.
Search data from Värriö - Change date - Select two variables
    Click Link    Search
    Select day before yesterday
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

### Search data from Värriö - Change week ###
#By default "To"-field returns previous date.
#Increment -8 days to get correct date.
#Select "Week" and click left button and check that correct date returns to "To"-field.
#Select Värriö, select Soil, select Soil temperature 10 cm, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Värriö - Change week
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

### Search data from Värriö - Change week - Select two variables ###
#By default "To"-field returns previous date.
#Increment -8 days to get correct date.
#Select "Week" and click left button and check that correct date returns to "To"-field.
#Select Värriö, select Tree, select H2O in shoot chamber 0 and H2O in shoot chamber 1, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Värriö - Change week - Select two variables
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

### Search data from Värriö - Change month ###
#By default "To"-field returns previous date.
#Increment -1 month to get correct date.
#Select "Month" and click left button and check that correct date returns to "To"-field.
#Select Värriö, select Flux, select CO2 flux, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Värriö - Change month
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

### Search data from Värriö - Change year ###
#By default "To"-field returns previous date.
#Increment -1 year to get correct date.
#Select "Year" and click left button and check that correct date returns to "To"-field.
#Select Värriö, select Flux ancillary data, select Air temperature, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Värriö - Change year 
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

### Search data from Värriö - No data ###
#Select Värriö, select Aerosol, select Pressure, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Värriö - No data
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[1]/div/span[contains(text(),'Värriö')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[9]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[9]/ul/li[22]/div/span[contains(text(),'Pressure')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Not Contain     id=id0    Pressure

### Search data from Hyytiälä ###
#Select Hyytiälä, select Flux, select Sensible heat storage flux, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Hyytiälä
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[2]/div/span[contains(text(),'Hyytiälä')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Sensible heat storage flux')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Sensible heat storage flux

### Search data from Kumpula ###
#Select Kumpula, select Gas, select NO concentration, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Kumpula
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[3]/div/span[contains(text(),'Kumpula')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[2]/ul/li[2]/div/span[contains(text(),'NO concentration')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    NO concentration

### Search data from Puijo ###
#Select Puijo, select Meteorology, select Matlab time, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Puijo
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[4]/div/span[contains(text(),'Puijo')]
    Click Element    xpath=//*[@id="tree"]/ul/li[4]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[4]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[4]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Matlab time')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Not Contain         id=id0    Matlab time

### Search data from Erottaja ###
#Select Erottaja, select Flux, select Sensible heat flux, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Erottaja
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[5]/div/span[contains(text(),'Erottaja')]
    Click Element    xpath=//*[@id="tree"]/ul/li[5]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[5]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[5]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Sensible heat flux')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Not Contain         id=id0    Sensible heat flux

### Search data from Torni ###
#Select Torni, select Flux, select Wind speed, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Torni
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[6]/div/span[contains(text(),'Torni')]
    Click Element    xpath=//*[@id="tree"]/ul/li[6]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[6]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[6]/ul/li[2]/ul/li[12]/div/span[contains(text(),'Wind speed')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Wind speed

### Search data from Siikaneva 1 ###
#Select Siikaneva 1, select Meteorology, select Rainfall, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Siikaneva 1
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[7]/div/span[contains(text(),'Siikaneva 1')]
    Click Element    xpath=//*[@id="tree"]/ul/li[7]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[7]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[7]/ul/li[3]/ul/li[1]/div/span[contains(text(),'Rainfall')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Rainfall

### Search data from Siikaneva 2 ###
#Select Siikaneva 2, select Radiation, select Net radiation, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Siikaneva 2
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[8]/div/span[contains(text(),'Siikaneva 2')]
    Click Element    xpath=//*[@id="tree"]/ul/li[8]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[8]/ul/li[4]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[8]/ul/li[4]/ul/li[1]/div/span[contains(text(),'Net radiation')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Not Contain         id=id0    Net radiation

### Search data from Kuivajärvi ###
#Select Kuivajärvi, select Water, select Water temperature 1.0 m, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
#No data?
Search data from Kuivajärvi
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[9]/div/span[contains(text(),'Kuivajärvi')]
    Click Element    xpath=//*[@id="tree"]/ul/li[9]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[9]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[9]/ul/li[3]/ul/li[3]/div/span[contains(text(),'Water temperature 1.0 m')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Not Contain         id=id0    Water temperature 1.0 m

### Search data from Dome_C ###
#Select Dome_C, select Meteorology, select Air temperature, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
Search data from Dome_C
    Click Link    Search
    Wait Until Page Contains Element    xpath=//*[@id="tree"]/ul/li[10]/div/span[contains(text(),'Dome_C')]
    Click Element    xpath=//*[@id="tree"]/ul/li[10]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[10]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[10]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Air temperature')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Not Contain         id=id0    Air temperature

Close SMEAR
    Close SMEAR