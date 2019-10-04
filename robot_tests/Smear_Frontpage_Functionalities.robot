*** Settings ***
Documentation     Smear_Frontpage_Functionalities.robot tests changing date using day/week option, arrow buttons, date input field and calendar.
Resource          Smear_Resource.robot
Default Tags      Frontpage
Suite Setup       Open SMEAR
Suite Teardown    Close SMEAR

*** Variables ***

*** Test Cases ***
Change time option to week
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Select From List By Value    id=pituus    week
    Check graphs

Change time option to day
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Select From List By Value    id=pituus    day
    Check graphs

Change day by right arrow button
    Click Link    Dashboard
    Select next day
    Check graphs

Change day by left arrow button
    Click Link    Dashboard
    Select previous day
    Check graphs

Change week by right arrow button
    Click Link    Dashboard
    Select next week
    Check graphs

Change week by left arrow button
    [Tags]    Smoke
    Click Link    Dashboard
    Select previous week
    Check graphs

Change week by left arrow button and change day by right arrow button
    Click Link    Dashboard
    Select previous week and next day
    Check graphs

Change date by text input
    Click Link    Dashboard
    Input date
    Check graphs

Change date by using calendar
    Click Link    Dashboard
    Select date from calendar
    Check graphs
