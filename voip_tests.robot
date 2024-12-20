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
    Make A Call With Number             55555                          10

Record Audio Sample
    Record Sample                       first_audio_sample.wav

Check Quality Of Recorded Audio Sample
    Check Quality                       first_audio_sample.wav

Quality Audio Sample
    PESQ Value Minimum                  4.2                            first_audio_sample.wav

Record Second Audio Sample
    Register
    Make A Call With Number              55555                         10
    Record Sample                        second_audio_sample.wav

Check Quality Of Recorded Second Audio Sample
    Check Quality                        second_audio_sample.wav

Quality Second Audio Sample
    PESQ Value Minimum                   5.3                           second_audio_sample.wav
    
Compare Quality Recorded Samples
    Compare Quality Recorded            first_audio_sample.wav        second_audio_sample.wav