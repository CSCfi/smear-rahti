*** Settings ***
Documentation     Smear_Frontpage_Functionalities.robot tests changing date using day/week option, arrow buttons, date input field and calendar.
Resource          Smear_Resource.robot
Default Tags      frontpage
Suite Setup       Open SMEAR
Suite Teardown    Close SMEAR

*** Variables ***

*** Test Cases ***
Change time option to week
#Update test when application is fixed.
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Select From List By Value    id=pituus    week
    Sleep    2s
    Check graphs

Change time option to day
#Update test when application is fixed.
    Wait Until Page Contains Element    id=datepicker1
    Wait Until Page Contains Element    id=pituus
    Select From List By Value    id=pituus    day
    Sleep    2s
    Check graphs

Change date by right button
    Click Link    Dashboard
    Select next date
    Check graphs

Change date by left button
    Click Link    Dashboard
    Select previous date
    Check graphs

Change week by right button
    Click Link    Dashboard
    Select next week
    Check graphs

Change week by left button
    Click Link    Dashboard
    Select previous week
    Check graphs

Change date by text input
    Click Link    Dashboard
    Input date
    Check graphs

Change date by using calendar
    Click Link    Dashboard
    Select date from calendar
    Check graphs
