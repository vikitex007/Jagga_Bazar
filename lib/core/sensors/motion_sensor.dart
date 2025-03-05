import 'package:sensors_plus/sensors_plus.dart';

class MotionSensorService {
  Function()? onShakeDetected;

  void startListening() {
    accelerometerEvents.listen((event) {
      const shakeThreshold = 15.0;

      if (event.x.abs() > shakeThreshold ||
          event.y.abs() > shakeThreshold ||
          event.z.abs() > shakeThreshold) {
        onShakeDetected?.call();
      }
    });
  }
}
