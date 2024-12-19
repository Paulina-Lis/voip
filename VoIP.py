from pyVoIP.VoIP import VoIPPhone, CallState, InvalidStateError, PhoneStatus
from time import sleep, time
import audioop
import time
import wave

class VoIP:
    def __init__(self):
        self.call = None
        self.vp = VoIPPhone(
            server= '192.168.1.34',
            port = 5080,
            username= 'K',
            password= 'K',
            myIP="192.168.1.33"
        )

    def register(self) -> bool:
        now = time.time()
        while time.time()  <=  now + 5:
            self.vp.start()
            print(f"VoIp Phone status: {self.vp.get_status()}")
            if  self.vp.get_status() == PhoneStatus.REGISTERED:
                print("Register established ")
                return True
            time.sleep(0.1)
        else:
            print(f"VoIp Phone status: {self.vp.get_status()}")
            print("Register not established ")
            return False


    def make_call(self, target_number: str, timeout: int) -> bool | None:
        print(f"Connecting with {target_number} number")

        print(f"Łączenie z numerem {target_number}...")

        self.call = self.vp.call(target_number)
        now = time.time()
        while time.time() < now + timeout:
            if self.call.state == CallState.ANSWERED:
                print(f"Connection with the number {target_number} established successfully.")
                print(self.vp.get_status())
                return True

            elif self.call.state == CallState.DIALING:
                print(f"Connecting with {target_number} number")
                print(self.call.state)
            time.sleep(0.5)
        else:
            print("fuck")
            print(f"Connection with number {target_number} not established")
            self.vp.stop()
            return False

    def record_audio(self, filename='call_recording.wav') -> bool:
        try:
            w = wave.open('test_wave.wav', 'wb')
            w.setnchannels(1)
            w.setsampwidth(8 // 8)
            w.setframerate(8000)

            while self.call.state == CallState.ANSWERED:
                data = self.call.read_audio(blocking=False)
                if data != b"\x80" * len(data):
                    w.writeframes(data)
            print(f"Audio file save as {filename}")
            self.vp.stop()
            return True

        except Exception as e:
            print(f"Error while recording audio: {e}")
            self.vp.stop()
            return False


voip = VoIP()
print(voip.register())
print(voip.make_call('55555', 10))
print(voip.record_audio())
