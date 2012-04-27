//#source('Buzz.dart');

class Sound {
 
  var source;
  SoundOptions options;
  List<AudioElement> soundElements;
   
  Sound (var source, [SoundOptions options = const SoundOptions()]) {
    
    this.soundElements = new List<AudioElement>();
    
    if (source is String) {
      this.source = new List<String>();
      this.source.add(source);
    }
    else {
      this.source = source;
    }
   
    this.source.forEach((s){
      var elem = new Element.tag('audio');
      elem.attributes['src'] = s;
      elem.attributes['type'] = SoundTypes[_getExt(s)];
      
      if (options.loop) {
        elem.attributes['loop'] = 'loop';
      }
      
      if (options.autoplay) {
        elem.attributes['autoplay'] = 'autoplay';
      }
      
      document.body.nodes.add(elem);
      this.soundElements.add(elem);
    });  
           
  }
  
  Sound load() {
      if (! Buzz.Instance.isSupported) {
        return this;
      }
      
      this.soundElements.forEach((s){ s.load(); });
      return this;
  }
  
  Sound play() { 
    if (! Buzz.Instance.isSupported) {
      return this;
    }
    
    this.soundElements.forEach((s){ s.play(); });
  }
  
  Sound togglePlay() {
    
  }
  
  Sound pause() {
  
  }
  
  bool isPaused() {
    
  }
  
  Sound stop() {
    
  }
  
  bool isEnded() {
    
  }
  
  Sound loop() {
    
  }
  
  Sound unloop() {
    
  }
  
  Sound mute() {
    
  }
  
  Sound unmute() {
    
  }
  
  Sound toggleMute() {
    
  }
  
  bool isMuted() {
    
  }
  
  Sound setVolume(num volume) {
    
  }
  
  num getVolume() {
    
  }
  
  Sound increaseVolume(num value) {
    
  }
  
  Sound decreaseVolume(num value) {
    
  }
  
  Sound setTime(num time) {
    
  }
  
  num getTime() {
    
  }
  
  Sound setPercent(num percent) {
    
  }
  
  num getPercent() {
    
  }
  
  Sound setSpeed(num duration) {
    
  }
  
  num getSpeed() {
    
  }
  
  num getDuration() {
    
  }
  
  getPlayed() {
    
  }
  
  getBuffered() {
    
  }
  
  getSeekable() {
    
  }
  
  num getErrorCode() {
    
  }
  
  String getErrorMessage() {
    
  }
  
  getStateCode() {
    
  }
  
  String getStateMessage() {
    
  }
  
  getNetworkStateCode() {
    
  }
  
  String getNetworkStateMessage() {
    
  }
  
  void setElementAttr(String key, var value) {
    
  }
  
  getElementAttr(String key) {
    
  }
  
  Sound bind(List<String> types, Function func) {
    
  }
  
  Sound unbind(List<String> types) {
    
  }
  
  Sound bindOnce(List<String> types) {
    
  }
  
  Sound trigger(List<String> types) {
    
  }
  
  Sound fadeTo(num to, num duration, Function callback) {
    
  }
  
  Sound fadeIn(num to, Function callback) {
    
  }
  
  Sound fadeOut(num to, Function callback) {
    
  }
  
  void whenReady(Function func) {
    
  }
  
  //Privates
  
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

var SoundTypes = const {
  'mp3': 'audio/mpeg',
  'ogg': 'audio/ogg',
  'wav': 'audio/wav',
  'aac': 'audio/aac',
  'm4a': 'audio/x-m4a'
};
