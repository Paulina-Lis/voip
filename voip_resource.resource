*** Settings ***
Library                VoIP.py
Library                Collections

*** Variables ***
&{pesq_values}

*** Keywords ***
Start FreeSwitch
    Log                     "TODO"

Register
    ${register}             VoIP.Register
    Should Be True          ${register}

Make A Call With Number     
    [Arguments]             ${target_number}        ${timeout}
    ${call}                 Make Call               ${target_number}    ${timeout}
    Log                     ${call}
    
Record Sample
    [Arguments]             ${filename}
    ${record_sample}        Record Audio            ${filename}
    Should Be True          ${record_sample}

Check Quality
    [Arguments]             ${filename}
    ${sample}               Check Sample Quality    ${filename}
    Log                     ${sample}
    Set To Dictionary       ${pesq_values}          ${filename}        ${sample}
    Log                     ${pesq_values}

PESQ Value Minimum
    [Arguments]             ${pesq_value}           ${filename}
    ${file_value}           Get From Dictionary     ${pesq_values}      ${filename}
    ${result}               Audio Sample Quality    ${pesq_value}           ${file_value}    
    Should Be True          ${result}
    
Compare Quality Recorded 
    [Arguments]             ${1_file_name}          ${2_file_name}
    ${1_value}              Get From Dictionary     ${pesq_values}      ${1_file_name}
    ${2_value}              Get From Dictionary     ${pesq_values}      ${1_file_name}
    ${compared}             Compare                 ${1_value}          ${2_value}
    