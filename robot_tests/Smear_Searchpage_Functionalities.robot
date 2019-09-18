*** Settings ***
Documentation    Smear_Searchpage_Functionalities.robot.
Resource         Smear_Resource.robot

*** Variables ***

*** Test Cases ***
Open SMEAR
    Open SMEAR

### Search data from Värriö ###
Search data from Värriö
#Select Värriö, select Aerosol, select Particle concentration, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Sleep    2s
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[1]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Particle concentration')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Particle concentration

### Search data from Hyytiälä ###
Search data from Hyytiälä
#Select Hyytiälä, select Flux, select Sensible heat storage flux, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Sleep    2s
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[2]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Sensible heat storage flux')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Sensible heat storage flux

### Search data from Kumpula ###
Search data from Kumpula
#Select Kumpula, select Gas, select NO concentration, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Sleep    2s
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[2]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[3]/ul/li[2]/ul/li[2]/div/span[contains(text(),'NO concentration')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    NO concentration

### Search data from Puijo ###
Search data from Puijo
#Select Puijo, select Meteorology, select Matlab time, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Sleep    2s
    Click Element    xpath=//*[@id="tree"]/ul/li[4]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[4]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[4]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Matlab time')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Not Contain         id=id0    Matlab time

### Search data from Erottaja ###
Search data from Erottaja
#Select Erottaja, select Flux, select Sensible heat flux, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Sleep    2s
    Click Element    xpath=//*[@id="tree"]/ul/li[5]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[5]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[5]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Sensible heat flux')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Not Contain         id=id0    Sensible heat flux

### Search data from Torni ###
Search data from Torni
#Select Torni, select Flux ancillary data, select Std of streamwise wind, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Sleep    2s
    Click Element    xpath=//*[@id="tree"]/ul/li[6]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[6]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[6]/ul/li[3]/ul/li[3]/div/span[contains(text(),'Std of vertical wind')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Std of vertical wind

### Search data from Siikaneva 1 ###
Search data from Siikaneva 1
#Select Siikaneva 1, select Meteorology, select Rainfall, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Sleep    2s
    Click Element    xpath=//*[@id="tree"]/ul/li[7]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[7]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[7]/ul/li[3]/ul/li[1]/div/span[contains(text(),'Rainfall')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element    id=id0
    Element Should Contain         id=id0    Rainfall

### Search data from Siikaneva 2 ###
Search data from Siikaneva 2
#Select Siikaneva 2, select Radiation, select Net radiation, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Sleep    2s
    Click Element    xpath=//*[@id="tree"]/ul/li[8]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[8]/ul/li[4]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[8]/ul/li[4]/ul/li[1]/div/span[contains(text(),'Net radiation')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Not Contain         id=id0    Net radiation

### Search data from Kuivajärvi ###
Search data from Kuivajärvi
#Select Kuivajärvi, select Water, select Water temperature 1.0 m, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
#No data?
    Click Link    Search
    Sleep    2s
    Click Element    xpath=//*[@id="tree"]/ul/li[9]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[9]/ul/li[3]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[9]/ul/li[3]/ul/li[3]/div/span[contains(text(),'Water temperature 1.0 m')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Not Contain         id=id0    Water temperature 1.0 m

### Search data from Dome_C ###
Search data from Dome_C
#Select Dome_C, select Meteorology, select Air temperature, Click "Plot", check that correct graph appears
#Fix arrow-signs to readable links when application is fixed.
    Click Link    Search
    Sleep    2s
    Click Element    xpath=//*[@id="tree"]/ul/li[10]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[10]/ul/li[1]/div/a[contains(text(),'►')]
    Click Element    xpath=//*[@id="tree"]/ul/li[10]/ul/li[1]/ul/li[1]/div/span[contains(text(),'Air temperature')]
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Sleep    2s
    Page Should Contain Element        id=id0
    Element Should Not Contain         id=id0    Air temperature

Close SMEAR
    Close SMEAR