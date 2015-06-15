library sdk_builds.web.index;

import 'dart:async';

import 'package:stack_trace/stack_trace.dart';

import "package:angular2/angular2.dart";
import "package:angular2/src/reflection/reflection.dart" show reflector;
import "package:angular2/src/reflection/reflection_capabilities.dart"
    show ReflectionCapabilities;

import 'package:http/browser_client.dart';
import 'package:sdk_builds/sdk_builds.dart' as sdk;

@Component(selector: "hello-app", lifecycle: const [onInit])
@View(templateUrl: 'template.html', directives: const [formDirectives, NgFor])
class ArchiveComponent {
  final _dd = new sdk.DartDownloads(client: new BrowserClient());

  String channel = 'dev';

  String osCurrent = 'Mac';

  final ControlGroup form = new ControlGroup(
      {'selectedOs': new Control(''), 'selectedVersion': new Control('')});

  bool loading = true;

  final List<String> operatingSystems = new List<String>.unmodifiable(
      new List.from(sdk.platforms)..insert(0, 'All'));

  final List<String> releases = <String>[];

  void onInit() {
    _updateVersions();
  }

  Future _updateVersions() async {
    var items = await _dd.getVersions(channel);

    releases.add('All');
    releases.addAll(items.reversed.map((v) => v.toString()));

    // work-around for https://github.com/angular/angular/issues/2520
    // not awaiting this – want it run async
    new Future.delayed(const Duration(seconds: 0)).then((_) {
      (this.form.find('selectedOs') as Control).updateValue('Mac');
      (this.form.find('selectedVersion') as Control)
          .updateValue(items.last.toString());

      loading = false;
    });
  }

}

main() {
  Chain.capture(() {
    reflector.reflectionCapabilities = new ReflectionCapabilities();
    bootstrap(ArchiveComponent);
  }, onError: (error, Chain chain) {
    print(error);
    print(chain.terse);
  });
}
