library examples.src.todo.services.TodoStore;

import "package:angular2/angular2.dart";

import 'package:http/browser_client.dart';
import 'package:sdk_builds/sdk_builds.dart';

// Store manages any generic item that inherits from KeyModel
@Injectable()
class Store {
  final DartDownloads downloadClient =
      new DartDownloads(client: new BrowserClient());
}

class LoudStore extends Store {
  LoudStore() {
    print("creating store!");
  }

  DartDownloads get downloadClient {
    print("getting client!");
    return super.downloadClient;
  }
}
