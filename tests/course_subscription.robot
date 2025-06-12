*** Settings ***
Library           Browser
Library           Collections
Library           BuiltIn
Library           OperatingSystem
Library           String

Suite Setup       Open Browser And Perform Admin Login
Suite Teardown    Close Browser
Test Setup        Go To Base URL

*** Variables ***
${URL}                   https://dev341118.service-now.com/x/quo/qdx-course-hub/home
${BROWSER_TYPE}          chromium
${LEARNER_NAME}          Zane
${ADMIN_USERNAME}        admin
${ADMIN_PASSWORD}        nxWtL/HHf9-2

# Common selector prefixes
${ROOT_DOM}                      css=macroponent-aededa80c782201072b211d4d8c2604c
${COMMON_SELECTOR_PREFIX}        ${ROOT_DOM} >> sn-canvas-appshell-main >> macroponent-b66bf1075b31101016fd7c1bf481c7a7 >> sn-canvas-main >> sn-canvas-screen
${LEARNER_SECTION_PREFIX}        ${COMMON_SELECTOR_PREFIX} >> macroponent-d98c0a0a83bde6107969ba29feaad301
${COURSE_SECTION_PREFIX}         ${COMMON_SELECTOR_PREFIX} >> macroponent-674d4dfb83f52210519fc3b6feaad3fe

# Final specific selectors
${LEARNER_INPUT_SELECTOR}           ${LEARNER_SECTION_PREFIX} >> now-input#item-search_box >> input.now-input-native
${LEARNER_SEARCH_RESULT_ITEM}       ${LEARNER_SECTION_PREFIX} >> now-button-bare#item-search_results_0_search_result >> button.now-button-bare.-primary.-md
${COURSEHUB_LOGIN_BUTTON}           ${LEARNER_SECTION_PREFIX} >> now-button#item-login_button >> button.now-button.-primary.-lg
${AVAILABLE_COURSES_TITLE}          ${COURSE_SECTION_PREFIX} >> now-heading#item-title >> h1.now-heading.-header.-hero
${SUBSCRIBE_BUTTON}                 ${COURSE_SECTION_PREFIX} >> now-button#item-repeater_1_0_subscribe_button >> button.now-button.-primary.-md
${YES_BUTTON}                       ${ROOT_DOM} >> sn-canvas-appshell-root >> sn-canvas-modal-hoist >> now-modal >> seismic-hoist.now-modal-footer-button >> button.now-button.-primary.-md
${UNSUBSCRIBE_BUTTON}               ${COURSE_SECTION_PREFIX} >> now-button#item-repeater_1_0_unsubscribe_button >> button.now-button.-tertiary.-md
*** Test Cases ***
Learner Can Subscribe With Confirmation
    [Documentation]    Admin login, learner search, course title check, and subscription confirmation.
    Search For Learner    ${LEARNER_NAME}
    Select Learner From Search Results    ${LEARNER_NAME}
    Wait For Elements State    ${COURSEHUB_LOGIN_BUTTON}    enabled
    Click    ${COURSEHUB_LOGIN_BUTTON}
    Wait For Elements State    ${AVAILABLE_COURSES_TITLE}    visible
    Verify Page Title Is Present
    Verify And Click Subscribe Button

*** Keywords ***
Open Browser And Perform Admin Login
    New Browser    browser=${BROWSER_TYPE}    headless=False
    New Page    ${URL}
    Fill Text    id=user_name    ${ADMIN_USERNAME}
    Fill Text    id=user_password    ${ADMIN_PASSWORD}
    Click    id=sysverb_login
    Wait For Elements State    ${LEARNER_INPUT_SELECTOR}    visible

Go To Base URL
    Go To    ${URL}
    Wait For Elements State    ${LEARNER_INPUT_SELECTOR}    visible

Search For Learner
    [Arguments]    ${name}
    Fill Text    ${LEARNER_INPUT_SELECTOR}    ${name}
    Wait For Elements State    ${LEARNER_SEARCH_RESULT_ITEM}    visible

Select Learner From Search Results
    [Arguments]    ${name}
    Click    ${LEARNER_SEARCH_RESULT_ITEM}
    ${input_value}=    Get Property    ${LEARNER_INPUT_SELECTOR}    value
    Should Contain    ${input_value}    ${name}

Verify Page Title Is Present
    ${title_text}=    Get Text    ${AVAILABLE_COURSES_TITLE}
    Should Not Be Empty    ${title_text}
    Log    ✅ Page title found: ${title_text}

Verify And Click Subscribe Button
    Sleep   2s
    Wait For Elements State    ${SUBSCRIBE_BUTTON}    visible
    ${button_text}=    Get Text    ${SUBSCRIBE_BUTTON}
    Should Be Equal    ${button_text}    Subscribe
    Click    ${SUBSCRIBE_BUTTON}
    Wait For Elements State    ${YES_BUTTON}    visible
    Click    ${YES_BUTTON}
    Wait For Elements State    ${UNSUBSCRIBE_BUTTON}    visible
    ${button_text}=    Get Text    ${UNSUBSCRIBE_BUTTON}
    Should Be Equal    ${button_text}    Unsubscribe