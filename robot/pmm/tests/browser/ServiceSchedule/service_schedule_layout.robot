*** Settings ***

Resource       robot/pmm/resources/pmm.robot
Library        cumulusci.robotframework.PageObjects
...            robot/pmm/resources/ServiceSchedulePageObject.py
...            robot/pmm/resources/ServicePageObject.py
Suite Setup     Run Keywords
...             Open Test Browser
...             Setup Test Data
Suite Teardown  Capture Screenshot and Delete Records and Close Browser

*** Keywords ***
Setup Test Data
    ${ns} =                         Get PMM Namespace Prefix
    Set suite variable              ${ns}
    ${contact1}                     API Create Contact
    Set suite variable              ${contact1}
    ${contact2}                     API Create Contact
    Set suite variable              ${contact2}
    ${contact3}                     API Create Contact
    Set suite variable              ${contact3}
    ${program} =                    API Create Program
    Set suite variable              ${program}
    ${service} =                    API Create Service                  ${Program}[Id]
    Set suite variable              ${service}
    ${service_schedule} =           API Create Service Schedule         ${service}[Id]
    Set suite variable              ${service_schedule}
    ${program_engagement} =         API Create Program Engagement   ${Program}[Id]     ${contact1}[Id]
    Set suite variable              ${program_engagement}
    ${service_participant1} =       API Create Service Participant  ${contact1}[Id]   ${service_schedule}[Id]  ${service}[Id]
    Set suite variable              ${service_participant1}


*** Test Cases ***
Add Service Participant quick action
    [Documentation]                        Navigates to service schedule details page, creates two PE using API and clicks on Add service
    ...                                    Participants quick action, add more participants and Save. Validates that the contact name is 
    ...                                    displayed on the service schedule page
    [tags]                                 W-8720124        feature:Service Schedule
    Go To PMM App   
    Go To Page                              Details                        ServiceSchedule__c           object_id=${service_schedule}[Id]
    API Create Program Engagement   ${Program}[Id]  ${contact2}[Id]
    API Create Program Engagement   ${Program}[Id]  ${contact3}[Id]
    Reload Page
    Click Quick Action Button               Add More Participants
    Load Page Object                        New             ServiceSchedule__c
    Verify Wizard Screen Title              Add Service Participants
    Select Service Participant              ${contact2}[Name]
    Select Service Participant              ${contact3}[Name]
    Click Dialog Button                     Add Service Participants    
    Validate Participant Is Added           ${contact1}[Name]
    Validate Participant Is Added           ${contact2}[Name]
    Validate Participant Is Added           ${contact3}[Name]
    Click Dialog Button                     Save
    Wait Until Modal is Closed
    Page Should Contain                     ${service_participant1}[Name]
    Page Should Contain                     ${contact2}[Name] - ${service_schedule}[Name]
    Page Should Contain                     ${contact3}[Name] - ${service_schedule}[Name]
