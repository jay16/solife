jQuery.fn.paginate = function(options) {
  defaults = { childNodeName: 'li'}
  var opts = $.extend(defaults, options);
  
  var childNodeName = opts["childNodeName"];
  this.each(function(){
    var currentPage = 0;
    var numPerPage  = 10;
    var $con = $(this);
    $con.bind('repaginate',function(){
       //$con..find('ol li').show
       $con.children(childNodeName).show()
       //.lt(currentPage*numPerPage)
       .slice(0, currentPage * numPerPage)
       .hide()
       .end()
       //.gt((currentPage+1)*numPerPage-1)
       .slice((currentPage + 1) * numPerPage)
       .hide()
       .end();
     });
     
     var numRows  = $con.children(childNodeName).length;
     var numPages = Math.ceil(numRows/numPerPage);
     var $pager = $('<div class="pager"></div>');
     for(var page = 0; page < numPages; page++) {
       $('<span class="page-number btn">'+(page+1)+'</span>')
       .bind('click', {'newPage':page},function(event){
          currentPage = event.data['newPage'];
          $con.trigger('repaginate'); 
          $(this).addClass('active').siblings().removeClass('active');
        })
       .appendTo($pager).addClass('clickable');
     }
     $pager.find('span.page-number:first').addClass('active');
     $pager.insertAfter($con);
     $con.trigger('repaginate');
  });
}

