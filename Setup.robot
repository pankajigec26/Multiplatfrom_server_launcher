*** Settings ***
Library    Collections
Library    Process
Library    handling_process.py

*** Variables ***
${terminal}    cmd

*** Keywords ***
Generic Suite Setup
    [Arguments]    &{options}
    ${keys}=   Get Dictionary Keys     ${options}
    ${Values}=  Get Dictionary Values     ${options}
    ${new1}=   Convert To List    ${keys}
    ${new2}=   Convert To List    ${Values}
    ${list4}=    Create List    ${var1}    ${var2}

    Log    ${new1}
    Log to console    ${new2}
    Log to console    ${list4}
    :FOR    ${key}    IN    @{new1}
    \    Set suite Variable    ${${key}}    ${${key}}

     @{userlist}=    Create list
    :FOR    ${key}    IN    @{new1}
    \    Set suite Variable    ${${key}}    ${${key}}
    \    Append To List    ${userlist}    ${${key}}
    Log to console    ${userlist}

#List to have ports for appium server
    @{appium_server_list}=    Create list    4723    4779    4762    4781    4782    4788    4791
    log to console    ${appium_server_list}

#counting the length of userlist
    ${lenlist}=    Get length    ${userlist}
    log to console    ${lenlist}

#list slicing
    ${list_input} =  Get Slice From List    ${appium_server_list}   0   ${lenlist}   # L5[2:4]
    log to console    ${list_input}

#Calling appium server to launch
    ${source_result} =    windows_open_appium    ${list_input}
#    ${result} =    kill_appium

kill server
#this will run during teardown
    ${result} =    kill_appium