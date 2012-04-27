//#source('Buzz.dart');

class Sound {
 
  var source;
  SoundOptions options;
  AudioElement soundElement;
   
  Sound (var source, [SoundOptions options = const SoundOptions()]) {
    if (source is String) {
      this.source = new List<String>();
      this.source.add(source);
    }
    else {
      this.source = source;
    }
   
    this.source.forEach((s){
      soundElement = new Element.tag('audio');
      soundElement.attributes['src'] = s;
      soundElement.attributes['type'] = _getExt(s);
      document.query("body").nodes.add(soundElement);   
    });  
            
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
  
  String _getExt( String filename ) {
    return filename.split('.').last();
  }
  
}


class SoundOptions {
  
   final List<String> formats;
   final preload;
   final bool autoplay;
   final bool loop;
   
   const SoundOptions([this.formats = const ['mp3', 'ogg', 'wav', 'aac', 'm4a'], 
       this.preload='metadata', this.autoplay=true, this.loop=false]);       
   
}
