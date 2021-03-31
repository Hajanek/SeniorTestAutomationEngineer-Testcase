*** Settings ***
Documentation       Task 2 - using selenium and firefox browser
Library             SeleniumLibrary

*** Variables ***
${BASE URL}         https://www.westwingnow.de/
${BROWSER}          Headless Firefox
${TIMEOUT}          15s

*** Test Cases ***
Assigned Test Scenario
    [Documentation]     Test steps:\n\n
    ...                 Open Bbrowser on westwingnow\n\n
    ...                 Wait for cookies and accept\n\n
    ...                 Search for möbel\n\n
    ...                 Close first login window\n\n
    ...                 Add first item to Wishlist\n\n
    ...                 Login with the second login window\n\n
    ...                 Add item to wishlist with icon\n\n
    ...                 Check wishlist counter\n\n
    ...                 Go to Wishlist\n\n
    ...                 Remoove item from the wishlist\n\n
    Open Browser    ${BASE URL}    ${BROWSER}
    Wait For Element And Click It    //*[@id="onetrust-accept-btn-handler"]                                                                         # Accept cookies                                
    Input Text    xpath: //*[@id="wwOneHeader"]/div/div[1]/header/div[6]/div[1]/form/input    möbel\n                                               # search for möbel                                                      
    Wait Until Keyword Succeeds    ${TIMEOUT}    1s    Get WebElement    xpath: //*[@id="app-root"]/div/div[1]/div[6]/div/div                       # Wait for listings
    Wait For Element And Click It    //*[@id="app-root"]/div/div[2]/div/div[1]/div/div/div/form/div[3]/button                                       # Wait for anmelden
    Wait For Element And Click It    //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[1]/button                                                    # Dissmis anmelden
    Click Element    xpath: //*[@id="app-root"]/div/div[1]/div[6]/div/div/main/div/div[2]/div[1]/a/div/div[2]/div[2]/div                            # Click add to wishlist
    Overlay Login
    Veryfi Wishlist Is Full
    Click Element    xpath: //*[@id="wwOneHeader"]/div/div[1]/header/div[8]/div[3]/div/span[1]                                                      # Go to wishlist
    Wait For Element And Click It    //*[@id="wishlistRoot"]/div/div[4]/div/ul/li/button                                                            # Wait for remoove icon and click it
    Wait Until Page Does Not Contain    //*[@id="wwOneHeader"]/div/div[1]/header/div[8]/div[3]/div/span[1]/span
    [Teardown]    Close Browser

*** Keywords ***
Wait For Element And Click It
    [Documentation]     This Keyword waits for page to contain an element and than clicks the element.
    [Arguments]    ${xpath}    ${timeout}=15
    Wait Until Keyword Succeeds    ${timeout}    1s    Get WebElement    xpath: ${xpath}
    Click Element    xpath: ${xpath}

Overlay Login
    [Documentation]     This keyword waits for window with account creation page, switches to login page.\n\n
    ...                 logs in with ${USER_EMAIL} and ${PASSWORD}.
    Wait Until Keyword Succeeds    ${TIMEOUT}    1s    Get WebElement    xpath: //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[2]/div[3]/button
    Click Element    xpath: //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[2]/div[3]/button
    Wait Until Keyword Succeeds    ${TIMEOUT}    1s    Get WebElement    xpath: //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[2]/form/div[1]/input
    ${email_locator}=    Get WebElement    xpath: //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[2]/form/div[1]/input
    Input Text    ${email_locator}    ${USER_EMAIL} 
    ${password_locator}=    Get WebElement    xpath: //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[2]/form/div[2]/input
    Input Text    ${password_locator}    ${PASSWORD} 
    Click Element    //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[2]/form/button

Veryfi Wishlist Is Full
    [Documentation]     This Keyword waits for wishlist_counter to apear and verifies that it contains one item.
    Wait Until Keyword Succeeds    ${TIMEOUT}    1s    Get WebElement    xpath: //*[@id="wwOneHeader"]/div/div[1]/header/div[8]/div[3]/div/span[1]/span
    ${inner_html}=    Get Element Attribute    xpath://*[@id="wwOneHeader"]/div/div[1]/header/div[8]/div[3]/div/span[1]/span   innerHTML
    Log    ${inner_html}
    Should Be Equal As Numbers    ${inner_html}    ${1}
