*** Settings ***
Library                VoIP.py


*** Keywords ***
Start FreeSwitch
    Log      "TODO"

Register
    ${register}             Voip.Register
    Should Be True          ${register}

Make A Call With Number     
    [Arguments]             ${target_number}    ${timeout}
    ${call}                 Make Call           ${target_number}    ${timeout}
    Log                     ${call}
    
    