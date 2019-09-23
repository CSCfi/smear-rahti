*** Settings ***
Documentation     Smear_Searchpage_Checks.robot tests that header, navigation, datepicker, tree structure and footer are loaded on the searchpage.
Resource          Smear_Resource.robot
Default Tags      Searchpage
Suite Setup       Open SMEAR searchpage
Suite Teardown    Close SMEAR

*** Variables ***

*** Test Cases ***
Check header
    Check header

Check navigation
    Check navigation

Check datepicker
    Check datepicker

Check tree structure
    Page Should Contain Element    id=tree
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

Check footer
    Check footer
