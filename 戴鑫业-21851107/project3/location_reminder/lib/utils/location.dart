import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class MyLocation {
  static void initLocation(Function onLocation) {
    ////
    // 1.  Listen to events (See docs for all 12 available events).
    //

    // Fired whenever a location is recorded
    // bg.BackgroundGeolocation.onLocation((bg.Location location) {
    //   print('[location] - $location');
    // });
    bg.BackgroundGeolocation.onLocation(onLocation);

    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
      // print('[motionchange] - $location');
    });

    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      // print('[providerchange] - $event');
    });

    ////
    // 2.  Configure the plugin
    //
    bg.BackgroundGeolocation.ready(bg.Config(
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter: 1.0,
            stopOnTerminate: false,
            startOnBoot: true,
            debug: false,
            // logLevel: bg.Config.LOG_LEVEL_VERBOSE,
            reset: true))
        .then((bg.State state) {
      if (!state.enabled) {
        ////
        // 3.  Start the plugin.
        //
        bg.BackgroundGeolocation.start();
      }
    });
  }
}
