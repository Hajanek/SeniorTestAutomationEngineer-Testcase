*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${BASE URL}         https://www.westwingnow.de/
${BROWSER}          Firefox
${USER_EMAIL}       jiri.janous@seznam.cz
${PASSWORD}         Tester      

*** Test Cases ***
Valid Login
    Open Browser    ${BASE URL}    ${BROWSER}
    # Accept cookies
    Wait For Element And Click It    //*[@id="onetrust-accept-btn-handler"]

    # search for möbel
    ${search_locator}=    Get WebElement   xpath: //*[@id="wwOneHeader"]/div/div[1]/header/div[6]/div[1]/form/input
    Input Text    ${search_locator}    möbel\n
    
    # Wait for listings
    Wait Until Keyword Succeeds    5    1s    Get WebElement    xpath: //*[@id="app-root"]/div/div[1]/div[6]/div/div

    # Wait for anmelden
    Wait For Element And Click It    //*[@id="app-root"]/div/div[2]/div/div[1]/div/div/div/form/div[3]/button

    # Dissmis anmelden
    Wait For Element And Click It    //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[1]/button

    # click wishlist
    ${wishlist_icon}=    Get WebElement    xpath: //*[@id="app-root"]/div/div[1]/div[6]/div/div/main/div/div[2]/div[1]/a/div/div[2]/div[2]/div
    Click Element    ${wishlist_icon}
    Overlay Login
    Veryfi Wishlist Is Full
    # Go to wishlist icon
    Click Element    xpath: //*[@id="wwOneHeader"]/div/div[1]/header/div[8]/div[3]/div/span[1]
    # Wait for remoove icon and click it
    Wait For Element And Click It    //*[@id="wishlistRoot"]/div/div[4]/div/ul/li/button
    Wait Until Page Does Not Contain    //*[@id="wwOneHeader"]/div/div[1]/header/div[8]/div[3]/div/span[1]/span
    #[Teardown]    Close Browser

*** Keywords ***
Wait For Element And Click It
    [Arguments]    ${xpath}    ${timeout}=5
    Wait Until Keyword Succeeds    ${timeout}    1s    Get WebElement    xpath: ${xpath}
    #${element}=    Get WebElement    xpath: ${xpath}
    Click Element    xpath: ${xpath}

Overlay Login
    Wait Until Keyword Succeeds    5    1s    Get WebElement    xpath: //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[2]/div[3]/button
    Click Element    xpath: //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[2]/div[3]/button

    Wait Until Keyword Succeeds    5    1s    Get WebElement    xpath: //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[2]/form/div[1]/input
    ${email_locator}=    Get WebElement    xpath: //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[2]/form/div[1]/input
    
    Input Text    ${email_locator}    ${USER_EMAIL} 
    ${password_locator}=    Get WebElement    xpath: //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[2]/form/div[2]/input
    Input Text    ${password_locator}    ${PASSWORD} 
    Click Element    //*[@id="app-root"]/div/div[2]/div/div[1]/div/div[2]/form/button

Veryfi Wishlist Is Full
    Wait Until Keyword Succeeds    5    1s    Get WebElement    xpath: //*[@id="wwOneHeader"]/div/div[1]/header/div[8]/div[3]/div/span[1]/span
    ${inner_html}=    Get Element Attribute    xpath://*[@id="wwOneHeader"]/div/div[1]/header/div[8]/div[3]/div/span[1]/span   innerHTML
    Log    ${inner_html}
    Should Be Equal As Numbers    ${inner_html}    ${1}
