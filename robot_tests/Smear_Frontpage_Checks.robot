*** Settings ***
Documentation    Smear_Frontpage_Checks.robot tests that header, navigation-panel, datepicker, graphs, side-text, side-map and footer are loaded on the frontpage.
Resource         Smear_Resource.robot

*** Variables ***

*** Test Cases ***
Open SMEAR
    Open SMEAR

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

#Side-map
#    Check side-map

Check footer
    Page Should Contain          Open science and research is an initiative funded by the Ministry of Education and Culture with the target of making Finland one of the leading countries in openness of science and research by the year 2017.
    Page Should Contain Image    /static/images/okm-logo-en.png
    Page Should Contain Link     http://okm.fi/OPM/?lang=en
    Page Should Contain Image    /static/images/ATT_pos_pysty_RGB_EN_transparent.png
    Page Should Contain Link     http://openscience.fi/
    Page Should Contain Image    /static/images/csc-logo.png
    Page Should Contain Link     https://www.csc.fi/en/

Close SMEAR
    Close SMEAR