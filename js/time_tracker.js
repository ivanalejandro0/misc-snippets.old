;(function($, document, window, undefined){

  $.fn.time_tracker = function( options ) {  

    // Create some defaults, extending them with any options that were provided
    var settings = $.extend( {
      'autostart' : true,
    }, options);

    var Timer = {
        // fills a string with '0'.
        // example: zeroPad(4, 5) == '00004'
        zeroPad: function(num, numZeros) {
            var n = Math.abs(num);
            var zeros = Math.max(0, numZeros - Math.floor(n).toString().length);
            var zeroString = Math.pow(10, zeros).toString().substr(1);
            if (num < 0) {
                zeroString = '-' + zeroString;
            }

            return zeroString + n;
        },

        init: function(elem) {
            var self = this;
            var input = $(elem);
            this.time = 0;
            setInterval( function() { self.update(self, input); }, 1000);
        },

        update: function(self, input) {
            self.time += 1;

            var t = self.time;

            var hours = Math.floor(t / 3600).toString();
            t -= (hours * 3600);

            var minutes = Math.floor(t / 60).toString();
            t -= (minutes * 60);

            var seconds = t.toString();

            var time_string = self.zeroPad(hours, 2) + ":" + self.zeroPad(minutes, 2) + ":" + self.zeroPad(seconds, 2);
            input.val(time_string);
        }
    }

    // Iterate through each DOM element and return it
    return this.each(function() {
        var timer = Object.create(Timer);
        timer.init(this);
    });

  };
})(jQuery,document,window);
