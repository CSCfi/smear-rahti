*** Settings ***
Documentation     Smear_Frontpage_Checks.robot tests that header, navigation, datepicker, graphs, side-text, side-map and footer are loaded on the frontpage.
Resource          Smear_Resource.robot
Default Tags      Frontpage
Suite Setup       Open SMEAR
Suite Teardown    Close SMEAR

*** Variables ***

*** Test Cases ***
Check header
    [Tags]    Smoke
    Check header

Check navigation
    Check navigation

Check datepicker
    Check datepicker

Check graphs
    Check graphs

Check side-text
    Page Should Contain         SmartSMEAR is data visualization and download tool for the database of continuous atmospheric, flux, soil,
    Page Should Contain         tree physiological and water quality measurements at
    Page Should Contain Link    http://www.atm.helsinki.fi/SMEAR
    Page Should Contain Link    SMEAR research stations
    Page Should Contain         of the University of Helsinki. Air mass back-trajectories are also provided for
    Page Should Contain         studying the connection between air mass movements and atmospheric observations at the stationary
    Page Should Contain         measurement sites. Detailed information on the measurements is provided at
    Page Should Contain Link    https://wiki.helsinki.fi/display/SMEAR/The+SMEAR+Wikispace
    Page Should Contain Link    SMEAR wikispace
    Page Should Contain         and the Download page.
    Page Should Contain         Users are encouraged to contact the
    Page Should Contain Link    https://wiki.helsinki.fi/display/SMEAR/Data+contact+persons
    Page Should Contain Link    original data contributors
    Page Should Contain         or
    Page Should Contain Link    mailto:atm-data@helsinki.fi
    Page Should Contain         atm-data@helsinki.fi
    Page Should Contain         for questions or
    Page Should Contain         clarifications.
    Page Should Contain         Terms of use for the data and its usage can be found from the
    Page Should Contain Link    /web/smart/smear/terms-of-use
    Page Should Contain Link    terms of use page

#Check side-map
#    Check side-map

Check footer
    [Tags]    Smoke
    Check footer
