(function( $ ) {
  
  // retrieves and injects into the DOM a collection of photos that belong to the given ID
  var getPhotos = function( id ) {
    var container = $('#container'),
      msg = $('#messaging');

    // always clear old messages
    msg.removeClass();
    
    // slide up and empty container view
    container.fadeOut('slow', function(){container.empty});
    // hide delete link and item number h2
    $('#delete, h2').fadeOut('slow');
    $("#itemNumber").val('');
    $.getJSON('/home/photos.json?n=' + id, function( data ) {

      // no results :(
      if( !data.length ) {
        msg.attr('class', 'error').html('No photos found for item <b>#' + id + '</b>!');
        
        
      }

      // we have data!
      else {
        $("#itemNumberLabel").empty().append(id)
        var gallery = $('<div/>', { id: 'gallery', 'class':'content'});
        var slideshowContainer = $('<div/>', {'class':'slideshow-container'});
        var loading = $('<div/>', { id: 'loading','class':'loader'});
        var slideshow = $('<div/>', { id: 'slideshow','class':'slideshow'});
        var thumbs = $('<div/>', { id: 'thumbs','class':'navigation'});

        slideshowContainer.append(loading).append(slideshow);
        gallery.append(slideshowContainer);
        
        var items = [];
        $.each(data, function( key, val ) {
          items.push('<li><a class="thumb" href="'+ val +'"><img src="' + val + '"></a></li>');
        });

        $('<ul/>', {'class':'thumbs noscript' ,html: items.join('') }).appendTo(thumbs);

        container.empty().append(thumbs).append(gallery);

        // show complete & delete button
        $('#delete').attr('href','/home/delete?id='+id);
        $('#delete, h2').fadeIn('slow');
        $('#done').attr('href','/home/done?id='+id);
        $('#done, h2').fadeIn('slow');
        
        // We only want these styles applied when javascript is enabled
        $('div.navigation').css({'width' : '240px', 'float' : 'left', 'margin':'0 20px'});
        $('div.content').css('display', 'block');

        // Initially set opacity on thumbs and add
        // additional styling for hover effect on thumbs
        var onMouseOutOpacity = 0.67;
        $('#thumbs ul.thumbs li').opacityrollover({
                mouseOutOpacity:   onMouseOutOpacity,
                mouseOverOpacity:  1.0,
                fadeSpeed:         'fast',
                exemptionSelector: '.selected'
        });

        // Initialize Advanced Galleriffic Gallery
        var gallery = $('#thumbs').galleriffic({
                delay:                     2500,
                numThumbs:                 10,
                preloadAhead:              10,
                enableTopPager:            true,
                enableBottomPager:         false,
                maxPagesToShow:            7,
                imageContainerSel:         '#slideshow',
                controlsContainerSel:      '#controls',
                loadingContainerSel:       '#loading',
                renderSSControls:          false,
                renderNavControls:         false,
                nextPageLinkText:          'Next &rsaquo;',
                prevPageLinkText:          '&lsaquo; Prev',
                enableHistory:             false,
                autoStart:                 false,
                syncTransitions:           true,
                defaultTransitionDuration: 900,
                onSlideChange:             function(prevIndex, nextIndex) {
                        // 'this' refers to the gallery, which is an extension of $('#thumbs')
                        this.find('ul.thumbs').children()
                                .eq(prevIndex).fadeTo('fast', onMouseOutOpacity).end()
                                .eq(nextIndex).fadeTo('fast', 1.0);
                },
                onTransitionIn:            function(slide, caption, isSync) {
                    slide.fadeTo('slow',1.0);
                    $('#slideshow img').attr('width','640').attr('height','640');
                    
                },
                onPageTransitionOut:       function(callback) {
                        this.fadeTo('fast', 0.0, callback);
                },
                onPageTransitionIn:        function() {
                        this.fadeTo('fast', 1.0);
                }
        });

        container.fadeIn('slow');
      }
    });

  };

  // catch all form submissions and proxy them through an AJAX request
  $(document).ready(function() {
    //$('#itemLookup').submit(function( e ) {
      //if( e ) { e.preventDefault(); }
      //if($('#itemNumber').val().trim().length > 0){
        //getPhotos($('#itemNumber').val().trim());
      //}
    //});
    // load item if id is already specified
    if($('#itemNumber').val().trim().length > 0){
      getPhotos($('#itemNumber').val().trim());
    }
  });
  
  
  
})(jQuery);