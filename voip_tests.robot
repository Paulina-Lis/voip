*** Settings ***
Documentation    File containing tests - run FreeSwitch, Register Phone, Connect and record
...              audio, check quality audio sample...
...
Resource         voip_resource.resource


*** Test Cases ***
Run FreeSwitch
    Start FreeSwitch
    
Establish Connection
    Register
    Make A Call With Number     55555    10

Record Audio Sample
    Record Sample

Check Quality Of Recorded Audio Sample
