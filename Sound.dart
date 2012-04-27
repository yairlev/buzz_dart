//#source('Buzz.dart');

class Sound {
  
  SoundOptions options;
  AudioElement sound;
  bool supported;
  num volume;
  num currentTime;
   
  Sound (var sources, [SoundOptions options = const SoundOptions()]) {
    
    List<String> sourceList;
    
    sound = new Element.tag('audio');
    supported = Buzz.Instance.isSupported;        

    if (sources is String) {
      sourceList = new List<String>();
      sourceList.add(sources);
    }
    else {
      sourceList = sources;
    }
    
    sourceList.forEach((s){
      
      _addSource(sound, s);
      
      if (options.loop) {
        sound.attributes['loop'] = 'loop';
      }
      
      if (options.autoplay) {
        sound.attributes['autoplay'] = 'autoplay';
      }
      
      if (options.preload == 'true') {
        sound.attributes['preload'] = 'auto';
      }
      else if ( options.preload == 'false' ) {
        sound.attributes['preload'] = 'none';
      } 
      else {
        sound.attributes['preload'] = options.preload;
      }       
      
      document.body.nodes.add(sound);
      
      this.setVolume( options.volume );
      
      Buzz.sounds.add(this);
      
    });    
    
  }
  
  Sound load() {
      if (! supported) {
        return this;
      }
      
      sound.load();
      return this;
  }
  
  Sound play() { 
    if (! supported) {
      return this;
    }
    
    this.sound.play();
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
  
  _addSource( sound, src ) {
    var srcElement = new Element.tag('source');
    srcElement.attributes['src'] = src;
    
    var soundType = Buzz.types[ _getExt( src ) ];
    
    if ( soundType != null && !soundType.isEmpty()) {
      srcElement.attributes['type'] = soundType;
    }
    sound.nodes.add( srcElement );  
  }
}


class SoundOptions {
  
   final List<String> formats;
   final String preload;
   final bool autoplay;
   final bool loop;
   final num volume;
   
   const SoundOptions([this.formats = const ['mp3', 'ogg', 'wav', 'aac', 'm4a'], 
       this.preload='metadata', this.autoplay=true, this.loop=false, this.volume = 80]);       
   
}


