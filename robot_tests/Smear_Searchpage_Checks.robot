*** Settings ***
Documentation     Smear_Searchpage_Checks tests that header, navigation, datepicker, tree structure and footer are loaded on the searchpage.
Resource          resources/Smear_Resource.robot
Force Tags        Searchpage
Suite Setup       Open SMEAR
Suite Teardown    Close SMEAR

*** Variables ***

*** Test Cases ***
Check header searchpage
    [Tags]    Smoke
    Click Link         Search
    Title Should Be    SMEAR search
    Check header

Check navigation
    Check navigation

Check datepicker
    Check datepicker

Check tree structure
    [Tags]    Smoke
    Click Link         Search
    Wait Until Page Contains Element    id=tree
    Wait Until Element Contains    id=tree    Värriö
    Element Should Contain         id=tree    Värriö
    Element Should Contain         id=tree    Hyytiälä
    Element Should Contain         id=tree    Kumpula
    Element Should Contain         id=tree    Puijo
    Element Should Contain         id=tree    Erottaja
    Element Should Contain         id=tree    Torni
    Element Should Contain         id=tree    Siikaneva 1
    Element Should Contain         id=tree    Siikaneva 2
    Element Should Contain         id=tree    Kuivajärvi
    Element Should Contain         id=tree    Dome_C

Check footer searchpage
    Check footer

Check plot
#Tests that clicking "Plot" doesn't create any graphs when graphs are not selected.
    Wait Until Page Contains Element    id=graph-list
    Page Should Not Contain Element     id=id0
    Click Element    xpath=//*[@id="datepicker1"]/button[3]
    Wait Until Page Contains Element    id=graph-list
    Page Should Not Contain Element     id=id0
