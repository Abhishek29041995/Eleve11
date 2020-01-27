package paveleng.com;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;
import io.flutter.plugin.platform.PlatformViewsController;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
      // Use the GeneratedPluginRegistrant to add every plugin that's in the pubspec.
      GeneratedPluginRegistrant.registerWith(new ShimPluginRegistry(flutterEngine));
  }
}
