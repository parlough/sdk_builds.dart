library sdk_builds.web.index;

import "package:angular2/angular2.dart";
import "package:angular2/src/reflection/reflection.dart" show reflector;
import "package:angular2/src/reflection/reflection_capabilities.dart"
    show ReflectionCapabilities;

const _greetings = const ['hello', 'howdy', 'cherrio'];

@Component(selector: "hello-app")
@View(templateUrl: 'template.html')
class HelloComponent {
  String greeting = _greetings.first;

  void changeGreeting() {
    var nextIndex = (_greetings.indexOf(this.greeting) + 1) % _greetings.length;

    this.greeting = _greetings[nextIndex];
  }
}

main() {
  reflector.reflectionCapabilities = new ReflectionCapabilities();
  bootstrap(HelloComponent);
}
