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
    [Arguments]             ${filename}
    ${record_sample}        Record Audio        ${filename}
    Should Be True          ${record_sample}

Check Quality
    [Arguments]             ${filename}
    ${first_sample}         Check Sample Quality    first_audio_sample.wav
    Log                     ${first_sample}
    Set Suite Variable      ${first_sample}

Audio Sample Quality Above
    [Arguments]             ${pesq_value}
    Audio Sample Quality    ${pesq_value}
#Compare Audio Samples
    