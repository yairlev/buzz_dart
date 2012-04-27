#import('dart:html');

class buzz_dart {

  buzz_dart() {
  }

  void run() {
    write("Hello World!");
  }

  void write(String message) {
    // the HTML library defines a global "document" variable
    document.query('#status').innerHTML = message;
  }
}

void main() {
  new buzz_dart().run();
}
