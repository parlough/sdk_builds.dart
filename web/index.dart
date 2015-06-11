library sdk_builds.web.index;

import 'dart:async';

import "package:angular2/angular2.dart";
import "package:angular2/src/reflection/reflection.dart" show reflector;
import "package:angular2/src/reflection/reflection_capabilities.dart"
    show ReflectionCapabilities;

import 'package:http/browser_client.dart';
import 'package:sdk_builds/sdk_builds.dart';

@Component(selector: "hello-app")
@View(templateUrl: 'template.html', directives: const [NgFor])
class HelloComponent {
  final _dd = new DartDownloads(client: new BrowserClient());
  bool working = false;
  List<String> versionInfo = <String>[];

  void updateLatestVersion() {
    _updateVersions();
  }

  Future _updateVersions() async {
    if (working) return;
    working = true;
    try {
      versionInfo.clear();
      versionInfo.add('Working...');
      var values = await Future.wait([_latest('stable'), _latest('dev')]);

      await new Future.delayed(const Duration(seconds: 5));

      versionInfo.clear();
      versionInfo.addAll(values);
    } finally {
      working = false;
    }
  }
  
  Future<String> _latest(String channel) async {
    var hash = await _dd.getVersionMap(channel, 'latest');

    return '$channel\t${hash['version']}';
  }
}

main() {
  reflector.reflectionCapabilities = new ReflectionCapabilities();
  bootstrap(HelloComponent);
}
