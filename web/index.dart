library sdk_builds.web.index;

import 'dart:async';

import "package:angular2/angular2.dart";
import "package:angular2/src/reflection/reflection.dart" show reflector;
import "package:angular2/src/reflection/reflection_capabilities.dart"
    show ReflectionCapabilities;

import 'services.dart';

@Component(selector: "hello-app", appInjector: const [Store])
@View(templateUrl: 'template.html', directives: const [NgFor])
class HelloComponent {
  final _dd;
  bool working = false;
  List<String> versionInfo = <String>[];

  HelloComponent(Store store) : _dd = store.downloadClient;

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

  reflector..registerType(Store, {'factory': () => new LoudStore()});

  bootstrap(HelloComponent);
}
