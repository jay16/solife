jQuery(document).ready(function(){
jQuery('.article h2 a').click(function(){
    jQuery(this).text('页面载入中……');
    window.location = jQuery(this).attr('href');
    });
});

// 滚屏
jQuery(document).ready(function(){
jQuery('#roll_top').click(function(){jQuery('html,body').animate({scrollTop: '0px'}, 800);}); 
jQuery('#ct').click(function(){jQuery('html,body').animate({scrollTop:jQuery('#comments').offset().top}, 800);});
jQuery('#fall').click(function(){jQuery('html,body').animate({scrollTop:jQuery('#footer').offset().top}, 800);});
});

//顶部导航下拉菜单
jQuery(document).ready(function(){
jQuery(".topnav ul li").hover(function(){
jQuery(this).children("ul").show();
jQuery(this).addClass("li01");
},function(){
jQuery(this).children("ul").hide();
jQuery(this).removeClass("li01");
});
});

//侧边栏TAB效果
jQuery(document).ready(function(){
jQuery('#tabnav li').click(function(){
	jQuery(this).addClass("selected").siblings().removeClass();
	jQuery("#tab-content > ul").eq(jQuery('#tabnav li').index(this)).fadeIn(800).siblings().hide();
});
});

//图片渐隐
jQuery(function () {
jQuery('.thumbnail img').hover(
function() {jQuery(this).fadeTo("fast", 0.5);},
function() {jQuery(this).fadeTo("fast", 1);
});
});

//新窗口打开
jQuery(document).ready(function(){
	jQuery("a[rel='external'],a[rel='external nofollow']").click(
	function(){window.open(this.href);return false})
});

//顶部微博等图标渐隐
jQuery(document).ready(function(){
			jQuery('.icon1,.icon2,.icon3,.icon4').wrapInner('<span class="hover"></span>').css('textIndent','0').each(function () {
				jQuery('span.hover').css('opacity', 0).hover(function () {
					jQuery(this).stop().fadeTo(350, 1);
				}, function () {
					jQuery(this).stop().fadeTo(350, 0);
				});
			});
});

//预加载广告
function speed_ads(loader, ad) {
var ad = document.getElementById(ad),
loader = document.getElementById(loader);
if (ad && loader) {
ad.appendChild(loader);
loader.style.display='block';
ad.style.display='block';
}
}
window.onload=function() {
speed_ads('adsense-loader1', 'adsense1');
speed_ads('adsense-loader2', 'adsense2');
speed_ads('adsense-loader3', 'adsense3');
};

//jQuery(function() {
//jQuery( "#sortable" ).sortable();
//jQuery( "#sortable" ).disableSelection();
//});

jQuery(document).ready(function(){
		if(jQuery.fn.avia_expand_element)
	{
		jQuery(".read-more-icon").avia_expand_element({subelements:'strong'});
		jQuery(".search_site").avia_expand_element({expandToWidth:298, speed:800});
	}
});
jQuery.extend( jQuery.easing,
{
	easeInOutCirc: function (x, t, b, c, d) {
		if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
		return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
	}
});
// -------------------------------------------------------------------------------------------
//  Expand element
// -------------------------------------------------------------------------------------------
(function($)
{
	$.fn.avia_expand_element = function(options) 
	{
		var defaults = 
			{
				expandToWidth: 'auto',
				subelements: false,
				easing: 'easeInOutCirc',
				speed: 600
			};
		
		var options = $.extend(defaults, options);
		
		return this.each(function(i)
		{
			var el = $(this),
				elWidthDefault = parseInt(el.width()),
				elNewWidth,
				sub;

			if(options.expandToWidth != 'auto')	
			{
				elNewWidth = parseInt(options.expandToWidth);
			}
			else
			{
				elNewWidth = parseInt(el.css({width:'auto'}).width());
				el.css({width:elWidthDefault});
			}
			
			if(options.subelements)
			{
				sub = el.find(options.subelements);
				sub.width(elNewWidth);
			}
			
			el.addClass('addapted');
			el.hover(function()
				{
					el.stop().animate({width: elNewWidth}, options.speed, options.easing);
				},
				
				function()
				{
					el.stop().animate({width: elWidthDefault}, options.speed, options.easing);
				}
			);
			
		});
	};
})(jQuery);

(function($)
{
	$.fn.kriesi_empty_input = function(options) 
	{
		return this.each(function()
		{
			var currentField = $(this);
			currentField.methods = 
			{
				startingValue:  currentField.val(),
				
				resetValue: function()
				{	
					var currentValue = currentField.val();
					if(currentField.methods.startingValue == currentValue) currentField.val('');
				},
				
				restoreValue: function()
				{	
					var currentValue = currentField.val();
					if(currentValue == '') currentField.val(currentField.methods.startingValue);
				}
			};
			
			currentField.bind('focus',currentField.methods.resetValue);
			currentField.bind('blur',currentField.methods.restoreValue);
		});
	};
})(jQuery);	

jQuery(document).ready(function($) {
	// improves comment forms 下面这两行是控制搜索框内文字消失显示的
	if(jQuery.fn.kriesi_empty_input)
	jQuery('input:text').kriesi_empty_input();
    
	//expand elements
	if(jQuery.fn.avia_expand_element)
	{
		jQuery(".read-more-icon").avia_expand_element({subelements:'strong'});
		jQuery(".search_site").avia_expand_element({expandToWidth:298, speed:800});
	}
});

//sidebar scroll
jQuery(document).ready(function($) {
    if (!isie6()) {
        var offset_height = 298;
        var rollStart = $('#rollstart'),
        rollSet = $('.hotarticle');
        rollStart.before('<div class="hotbox"></div>');
        var offset = rollStart.offset(),
        objWindow = $(window),
        rollBox = rollStart.prev();
        if (objWindow.width() > 960) {
            
            objWindow.scroll(function() {
                if (objWindow.scrollTop() > offset.top+offset_height) {
                    if (rollBox.html(null)) {
                        rollSet.clone().prependTo('.hotbox');
                    }

                    if ($(".hotarticle").size()>1)
                        $(".hotarticle").eq(1).hide();
                    rollBox.children().show();
                    rollBox.show().stop().animate({
                        top: 0,
                        paddingTop: 15
                    },
                    400);
                } else {
                    
                    rollBox.hide().stop().animate({
                        top: 0
                    },
                    400);
                    
                    if ($(".hotarticle").size()>1)
                        $(".hotarticle").eq(1).show();
                }
            })
        }
    }
    function isie6() {
        if ($.browser.msie) {
            if ($.browser.version == "6.0") return true;
        }
        return false;
    }
});

