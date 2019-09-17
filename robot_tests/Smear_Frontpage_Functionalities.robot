*** Settings ***
Documentation    Smear_Frontpage_Functionalities.robot.
Resource         Smear_Resource.robot

*** Variables ***

*** Test Cases ***
Open SMEAR
    Open SMEAR

### Change time option to week ###
#Update test when application is fixed.
Change time option to week
    Select From List By Value    id=pituus    week
    Sleep    2s
    Check graphs

### Change time option to day ###
#Update test when application is fixed.
Change time option to day
    Select From List By Value    id=pituus    day
    Sleep    2s
    Check graphs

### Change date by right button ###
#By default "To"-field returns previous date.
#Click right button and check that current date returns to "To"-field.
Change date by right button
    ${Y}    Get Current Date    result_format=%Y
    ${m}    Get Current Date    result_format=%m
    ${d}    Get Current Date    result_format=%d
    Click Link    Dashboard
    Click Button    xpath=//*[@id="datepicker1"]/button[2]
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${Y}-${m}-${d}
    Check graphs

### Change date by left button ###
#By default "To"-field returns previous date.
#Increment -2 days to get correct date.
#Click left button and check that day before yesterday returns to "To"-field.
Change date by left button
    ${Y}    Get Current Date    result_format=%Y
    ${m}    Get Current Date    result_format=%m
    ${d}    Get Current Date    result_format=%d    increment=-2 day
    Click Link    Dashboard
    Click Button    xpath=//*[@id="datepicker1"]/button[1]
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${Y}-${m}-${d}
    Check graphs

### Change week by right button ###
#By default "To"-field returns previous date.
#Increment +6 days to get correct date.
#Select "Week" and click right button and check that correct date returns to "To"-field.
Change week by right button
    ${Y}    Get Current Date    result_format=%Y
    ${m}    Get Current Date    result_format=%m
    ${d}    Get Current Date    result_format=%d    increment=+6 day
    Click Link    Dashboard
    Select From List By Value    id=pituus    week
    Sleep    2s
    Click Button    xpath=//*[@id="datepicker1"]/button[2]
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${Y}-${m}-${d}    
    Check graphs

### Change week by left button ###
#By default "To"-field returns previous date.
#Increment -8 days to get correct date.
#Select "Week" and click left button and check that correct date returns to "To"-field.
Change week by left button
    ${Y}    Get Current Date    result_format=%Y
    ${m}    Get Current Date    result_format=%m
    ${d}    Get Current Date    result_format=%d    increment=-8 day
    Click Link    Dashboard
    Select From List By Value    id=pituus    week
    Sleep    2s
    Click Button    xpath=//*[@id="datepicker1"]/button[1]
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${Y}-${m}-${d}
    Check graphs

### Change date by text input ###
#By default "To"-field returns previous date.
#Increment -2 days to get correct date.
#Select "To"-field and input day before yesterday and check that correct date returns to "To"-field.
#Date format has to be yyyy-mm-dd.
Change date by text input
    ${Y}    Get Current Date    result_format=%Y
    ${m}    Get Current Date    result_format=%m
    ${d}    Get Current Date    result_format=%d    increment=-2 day
    Click Link    Dashboard
    Click Element    xpath=//*[@id="datepicker1"]/input
    Sleep    2s
    Input Text    xpath=//*[@id="datepicker1"]/input    ${Y}-${m}-${d}
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${Y}-${m}-${d}
    Check graphs

### Change date by using calendar ###
#By default "To"-field returns previous date.
#Select calendar and select first date of the month and check that correct date returns to "To"-field.
#Date format has to be yyyy-mm-dd.
Change date by using calendar
    ${Y}    Get Current Date    result_format=%Y
    ${m}    Get Current Date    result_format=%m
#    ${d}    Get Current Date    result_format=%d
    Click Link    Dashboard
    Click Element    xpath=//*[@id="datepicker1"]/div/span
    Sleep    2s
    Click Element    xpath=//td[starts-with(text(),'1')]
    Sleep    2s
    Textfield Should Contain    xpath=//*[@id="datepicker1"]/input    ${Y}-${m}-01
    Check graphs

Close SMEAR
    Close SMEAR