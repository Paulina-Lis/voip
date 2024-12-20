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
    Make A Call With Number         55555    10

Record Audio Sample
    Record Sample                   first_audio_sample.wav

Check Quality Of Recorded Audio Sample
    Check Quality                   first_audio_sample.wav

#Quality Audio Sample
#    Audio Sample Quality            4.2

Record Second Audio Sample
    Register
    Make A Call With Number         55555    10
    Record Sample                   second_audio_sample.wav
#    Compare Audio Samples

Check Quality Of Recorded Second Audio Sample
    Check Quality                   second_audio_sample.wav