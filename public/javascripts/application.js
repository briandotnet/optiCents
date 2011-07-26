(function( $ ) {
  
  // retrieves and injects into the DOM a collection of photos that belong to the given ID
  var getPhotos = function( id ) {
    var container = $('#container'),
      msg = $('#messaging');

    // always clear old messages
    msg.removeClass();
    
    // slide up and empty container view
    container.slideUp('slow', function(){container.empty});

    $.getJSON('/home/photos.json?n=' + id, function( data ) {

      // no results :(
      if( !data.length ) {
        msg.attr('class', 'error').html('No photos found for item <b>#' + id + '</b>!');
        // hide delete link
        $('#delete').hide();
      }

      // we have data!
      else {
        var items = [],
          gallery = $('<div/>', { id: 'gallery' });

        $.each(data, function( key, val ) {
          items.push('<li><img src="' + val + '" width="640" height="640"></li>');
        });

        $('<ul/>', { html: items.join('') }).appendTo(gallery);
        container.empty().append(gallery);
        // show delete button
        $('#delete').show();
        
        gallery.slideViewerPro({
          thumbs: 5, 
          thumbsPercentReduction: 15,
          buttonsWidth:10,
          galBorderWidth: 0,
          thumbsTopMargin: 10,
          thumbsRightMargin: 10,
          thumbsBorderWidth: 5,
          thumbsActiveBorderColor: "white",
          thumbsActiveBorderOpacity: 0.5,
          thumbsBorderOpacity: 0,
          buttonsTextColor: "#707070",
          leftButtonInner: "<",
          rightButtonInner: ">",
          autoslide: false
        });
        
        container.slideDown('slow');
      }
    });
  };

  // catch all form submissions and proxy them through an AJAX request
  $(document).ready(function() {
    $('#itemLookup').submit(function( e ) {
      if( e ) { e.preventDefault(); }
      if($('#itemNumber').val().trim().length > 0){
        getPhotos($('#itemNumber').val().trim());
      }
    });
    // load item if id is already specified
    if($('#itemNumber').val().trim().length > 0){
      getPhotos($('#itemNumber').val().trim());
    }
  });
})(jQuery);