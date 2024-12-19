from pyVoIP.VoIP import VoIPPhone, CallState, InvalidStateError, PhoneStatus
from time import sleep, time
from robot.api import logger
import audioop
import time
import wave
import os
from pesq import pesq
from scipy.io import wavfile

class VoIP:
    """
    User written keyword library.
    """

    ROBOT_LIBRARY_SCOPE = 'SUITE'

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
            logger.info(f"VoIp Phone status: {self.vp.get_status()}", also_console=True)
            if  self.vp.get_status() == PhoneStatus.REGISTERED:
                logger.info("Register established :)", also_console=True)
                return True
            time.sleep(0.1)
        else:
            logger.info(f"VoIp Phone status: {self.vp.get_status()}", also_console=True)
            logger.info("Register not established :(", also_console=True)
            return False


    def make_call(self, target_number: str, timeout: int) -> bool | None:
        logger.info(f"Connecting with {target_number} number", also_console=True)

        self.call = self.vp.call(target_number)
        now = time.time()
        while time.time() < now + timeout:
            if self.call.state == CallState.ANSWERED:
                logger.info(f"Connection with the number {target_number} established successfully.",
                            also_console=True)
                return True

            elif self.call.state == CallState.DIALING:
                logger.info(f"Connecting with {target_number} number", also_console=True)
                logger.info(f"Call state: {self.call.state}")
            time.sleep(0.5)
        else:
            logger.info(f"Connection with number {target_number} not established", also_console=True)
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
            logger.info(f"Audio file save as {filename}", also_console=True)
            self.vp.stop()
            return True

        except Exception as e:
            logger.info(f"Error while recording audio: {e}", also_console=True)
            self.vp.stop()
            return False

    @staticmethod
    def check_sample_quality():
        output_path = os.path.join(os.getcwd(), "test_wave.wav")
        logger.info(f"{output_path}", also_console=True)
        try:
            rate, ref = wavfile.read(output_path)
            rate, deg = wavfile.read(output_path)
            p = pesq(rate, ref, deg, "nb")
            logger.info(f"Pesq: {p}")
            return p
        except IOError:
            logger.info(f"Io Error", also_console=True)



# voip = VoIP()
# print(voip.register())
# print(voip.make_call('55555', 10))
# print(voip.record_audio())
