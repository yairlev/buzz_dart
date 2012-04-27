class Buzz {
  
  //
  // Static methods implementation
  //
  
  /*
  * Check if the browser support for audio is present
  */
  static bool isSupported() {
    return true; //!!buzz.el.canPlayType;
  }
  
  static bool isOGGSupported() {
    return false; //!!buzz.el.canPlayType && buzz.el.canPlayType( 'audio/ogg; codecs="vorbis"' );
  }

  static bool isWAVSupported() {
    return false; //!!buzz.el.canPlayType && buzz.el.canPlayType( 'audio/wav; codecs="1"' );
  }

  static bool isMP3Supported() {
    return false; //!!buzz.el.canPlayType && buzz.el.canPlayType( 'audio/mpeg;' );
  }

  static bool isAACSupported() {
    return false; //!!buzz.el.canPlayType && ( buzz.el.canPlayType( 'audio/x-m4a;' ) || buzz.el.canPlayType( 'audio/aac;' ) );
  }
  
  static String toTimer( time, withHours ) {
    /*
    var h, m, s;
    h = Math.floor( time / 3600 );
    h = isNaN( h ) ? '--' : ( h >= 10 ) ? h : '0' + h;
    m = withHours ? Math.floor( time / 60 % 60 ) : Math.floor( time / 60 );
    m = isNaN( m ) ? '--' : ( m >= 10 ) ? m : '0' + m;
    s = Math.floor( time % 60 );
    s = isNaN( s ) ? '--' : ( s >= 10 ) ? s : '0' + s;
    return withHours ? h + ':' + m + ':' + s : m + ':' + s;
    */
    return "";
  }

  static num fromTimer(time) {
    /*
    var splits = time.toString().split( ':' );
    if ( splits && splits.length == 3 ) {
        time = ( parseInt( splits[ 0 ], 10 ) * 3600 ) + ( parseInt(splits[ 1 ], 10 ) * 60 ) + parseInt( splits[ 2 ], 10 );
    }
    if ( splits && splits.length == 2 ) {
        time = ( parseInt( splits[ 0 ], 10 ) * 60 ) + parseInt( splits[ 1 ], 10 );
    }
    return time;
    */
    return 0;
  }

  static num toPercent( value, total, decimal ) {
    /*
    var r = Math.pow( 10, decimal || 0 );
    return Math.round( ( ( value * 100 ) / total ) * r ) / r;
    */
    return 0;
  }

  static num fromPercent( percent, total, decimal ) {
    /*
    var r = Math.pow( 10, decimal || 0 );
    return  Math.round( ( ( total / 100 ) * percent ) * r ) / r;
    */
    return 0;
  }
}