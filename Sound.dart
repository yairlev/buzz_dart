//#source('Buzz.dart');

class Sound {
 
  String source;
  SoundOptions options;
  AudioElement soundElement;
  
  Sound (this.source, this.options) {
     soundElement = new Element.tag('audio');
  }
  
  Sound load() {
      if (! Buzz.isSupported) {
        return this;
      }
      
      this.soundElement.play();
      return this;
  }
  
  Sound play() { 
    if (! Buzz.isSupported) {
      return this;
    }
    
    this.soundElement.play();
  }
  
}


class SoundOptions {
  
}
