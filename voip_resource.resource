*** Settings ***
Library                VoIP.py


*** Keywords ***
Start FreeSwitch
    Log      "TODO"

Register
    ${register}             VoIP.Register
    Should Be True          ${register}

Make A Call With Number     
    [Arguments]             ${target_number}    ${timeout}
    ${call}                 Make Call           ${target_number}    ${timeout}
    Log                     ${call}
    
Record Sample
    ${record_sample}        Record Audio    
    Should Be True          ${record_sample}

Check Quality First Sample
    ${test}                 Check Sample Quality
    Log                     ${test}