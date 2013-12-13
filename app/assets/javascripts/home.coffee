this.thumbnail_toggle = (segment_id,readMore) ->
  $thumbnail =   $("#segment_"+String(segment_id)+"_thumbnail")
  $segment   =   $("#segment_"+String(segment_id))
  $segment_box = $("#segment_"+String(segment_id)+"_box")

  if(readMore)
    $(".segment_box").hide();
    $segment_box.addClass("readmore");
    $thumbnail.hide();
    $segment.show();
    $segment_box.fadeIn();
  else
    $(".segment_box").show();
    $segment_box.removeClass("readmore");
    $thumbnail.show();
    $segment.hide();
    $segment_box.fadeIn();

  $('html,body').animate({scrollTop:70}, 800);

this.toggle_show = (self,target,one,two,klass) ->
  self = $(self);
  target = $(target);
  if(target.hasClass(klass))
    target.removeClass(klass);
    self.html(two);
  else
    target.addClass(klass);
    self.html(one);
  
this.scroll_down = () ->
  $('html,body').animate({scrollTop:$('.footer').offset().top}, 800)
