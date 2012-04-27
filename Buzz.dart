class Buzz {
  
  //
  // Static Properties
  //
  static final defaults = const { 
    "autoplay"    : false,
    "duration"    : 5000,
    "formats"     : const [],
    "loop"        : false,
    "placeholder" : "--",
    "preload": "metadata",
    "volume": 80
  };
  
  static final types = const {
      "mp3": "audio/mpeg",
      "ogg": "audio/ogg",
      "wav": "audio/wav",
      "aac": "audio/aac",
      "m4a": "audio/x-m4a"
  };
  
  static var sounds = null;
  
  //
  // Instance Properties
  //
  var _el;
    
  //
  // Singelton Implementation
  //
  static Buzz _singleRef;
  
  static Buzz get Instance() => _singleRef != null ? _singleRef : new Buzz();
  
  factory Buzz() {
    if (_singleRef == null) {
      _singleRef = new Buzz._internal();
    }
    
    return _singleRef;
  }

  Buzz._internal() {
    sounds = new List<Sound>();
    
    // Create the audio tag
    _el = new Element.tag("audio");
    
    // Add the new element to the document
    document.body.nodes.add(_el);
  }
  
  
  //
  // Public Methods
  //
  
  
  /*
  * Check if the browser support for audio is present
  */
  bool get isSupported() {
    return (_el.canPlayType != null); 
  }
  
  bool get isOGGSupported() {
    return true;
    //return isSupported && (_el.canPlayType('audio/ogg; codecs="vorbis"', null) == "probably");
  }

  bool get isWAVSupported() {
    return true;
    //return isSupported && (_el.canPlayType('audio/wav; codecs="1"','')  == "probably");
  }

  bool get isMP3Supported() {
    return true;
    //return isSupported && (_el.canPlayType("audio/mpeg;",'')  == "probably");
  }

  bool get isAACSupported() {
    return true;
    //return isSupported && 
      //  ( (_el.canPlayType( 'audio/x-m4a;','' ) == "probably") ||
      //    (_el.canPlayType( 'audio/aac;','' ) )  == "probably");
  }
  
  String toTimer(num time, bool withHours ) {
    int h, m, s;
    h = ( time / 3600 ).floor().toInt();
    h = ( h ).isNaN() ? '--' : ( h >= 10 ) ? h : '0' + h;
    m = withHours ? ( time / 60 % 60 ).floor().toInt() : ( time / 60 ).floor().toInt();
    m = ( m ).isNaN() ? '--' : ( m >= 10 ) ? m : '0' + m;
    s = ( time % 60 ).floor();
    s = ( s ).isNaN() ? '--' : ( s >= 10 ) ? s : '0' + s;
    return withHours ? "$h:$m:$s" : "$m:$s";
  }

  num fromTimer(String time) {
    num retVal = 0;
    var splits = time.split( ':' );
    if ( splits != null && splits.length == 3 ) {
      retVal = ( Math.parseInt( splits[ 0 ]) * 3600 ) + ( Math.parseInt(splits[ 1 ]) * 60 ) + Math.parseInt( splits[ 2 ]);
        
    }
    if ( splits != null && splits.length == 2 ) {
      retVal = ( Math.parseInt(splits[ 0 ]) * 60 ) + Math.parseInt( splits[ 1 ]);
    }
    
    return retVal;
  }

  num toPercent( num value, num total, [num decimal = 0] ) {
    var r = Math.pow( 10, decimal );
    return ( ( ( value * 100 ) / total ) * r ).round() / r;
  }

  num fromPercent( num percent, num total, [num decimal = 0] ) {
    var r = Math.pow( 10, decimal );
    return  ( ( ( total / 100 ) * percent ) * r ).round() / r;
  }
}