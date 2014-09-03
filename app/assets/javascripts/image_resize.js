$(window).load(function(){

  //resize photos 
  $('.js-img-resize').each(function() {

      //set size
      var th = $(this).height();//box height
      var tw = $(this).width();//box width
      var im = $(this).find('img');//image
      var ih = im.get(0).height;//inital image height
      var iw = im.get(0).width;//initial image width

      if (ih>=iw) {//if portrait
          im.addClass('ww').removeClass('wh');//set width 100%
      } else {//if landscape
          im.addClass('wh').removeClass('ww');//set height 100%
      }

      //set offset
      var nh = im.height();//new image height
      var nw = im.width();//new image width
      var hd = (nh-th)/2;//half dif img/box height
      var wd = (nw-tw)/2;//half dif img/box width

      if ((nh<nw) && (nh != 0 && nw != 0) ) {//if portrait
          im.css({marginLeft: '-'+wd+'px', marginTop: 0});//offset left
      } else {//if landscape
          im.css({marginTop: 0, marginLeft: 0});//offset top
      }
  });

});