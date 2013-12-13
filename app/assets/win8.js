var hoverEffect = true; // set true for hover effect, set false for no hover effect

var searchEngine = 'baidu'; // default search engine - set google for google search, bing for bing search, yahoo for yahoo search

var numberOfScreens = 3; // set number of screens (1 or 2 or 3)
 
var blockName = new Array(); // set names of blocks
blockName[1] = '代码仓库';
blockName[2] = '个人空间';
blockName[3] = '其他备用';

var bookmark = new Array();
bookmark[0] = new Array();
bookmark[1] = new Array();
bookmark[2] = new Array();

// set your bookmarks here: (If you do not fill 'thumb' for thumbnail will be used title)
// FIRST BLOCK
bookmark[0][0] = {
	'title':'CodeMirror 在线代码高亮',
	'url':'http://developer.51cto.com/art/201205/337525.htm',
	'thumb':'o1.png'
};
bookmark[0][1] = {
	'title':'EclipseColorer Eclipse的语法着色插件',
	'url':'http://developer.51cto.com/art/201205/337526.htm',
	'thumb':'o2.png'
};

bookmark[0][2] = {
	'title':'GeSHi 1.0.8.10版本 HTML代码高亮库',
	'url':'http://developer.51cto.com/art/201205/337527.htm',
	'thumb':'o3.png'
};
bookmark[0][3] = {
	'title':'Highlight 3.9发布 语法着色工具',
	'url':'http://developer.51cto.com/art/201205/337529.htm',
	'thumb':'o4.png'
};

bookmark[0][4] = {
	'title':'SyntaxHighlighter JavaScript语法着色库',
	'url':'http://developer.51cto.com/art/201205/337528.htm',
	'thumb':'o5.png'
};
bookmark[0][5] = {
	'title':'jQuery语法高亮插件 DlHighlight',
	'url':'http://developer.51cto.com/art/201205/337531.htm',
	'thumb':'o6.png'
};
bookmark[0][6] = {
	'title':'GNU Source-highlight 3.1.6发布',
	'url':'http://developer.51cto.com/art/201205/337530.htm',
	'thumb':'o7.png'
};
bookmark[0][7] = {
	'title':'Highlight.js 语法高亮',
	'url':'http://developer.51cto.com/art/201205/337532.htm',
	'thumb':'o8.png'
};
bookmark[0][8] = {
	'title':'Colorer Take Eclipse的语法着色插件',
	'url':'http://developer.51cto.com/art/201205/337533.htm',
	'thumb':'o9.png'
};

bookmark[0][9] = {
	'title':'Google Code Prettify 页面语法高亮JS库',
	'url':'http://developer.51cto.com/art/201205/337534.htm',
	'thumb':'o10.png'
};
bookmark[0][10] = {
	'title':'Source Insight利器',
	'url':'http://developer.51cto.com/art/201204/327479.htm',
	'thumb':'o11.png'
};
bookmark[0][11] = {
	'title':'',
	'url':'',
	'thumb':''
};
// end of FIRST BLOCK
// SECOND BLOCK
bookmark[1][0] = {
	'title':'Java灵活开发 语言混合编程',
	'url':'http://developer.51cto.com/art/201205/337214.htm',
	'thumb':'z1.png'
};
bookmark[1][1] = {
	'title':'Visual Studio 11应用开发指南',
	'url':'http://developer.51cto.com/art/201205/335275.htm',
	'thumb':'z2.png'
};
bookmark[1][2] = {
	'title':'JVM编程语言，你的选择？',
	'url':'http://developer.51cto.com/art/201205/334561.htm',
	'thumb':'z3.png'
};
bookmark[1][3] = {
	'title':'程序员们眼中的Java',
	'url':'http://developer.51cto.com/art/201204/329335.htm',
	'thumb':'z4.png'
};
bookmark[1][4] = {
	'title':'Java开源工具汇总,一个都不能少！',
	'url':'http://developer.51cto.com/art/201203/322895.htm',
	'thumb':'z5.png'
};
bookmark[1][5] = {
	'title':'宅男程序员给老婆的计算机课程',
	'url':'http://developer.51cto.com/art/201203/321936.htm',
	'thumb':'z6.png'
};
//end of SECOND BLOCK
// THIRD BLOCK


jQuery.extend({
    
    easing: 
    {

        circEaseOut:function(p, n, firstNum, diff) {
           // alert("p:"+String(p)+" n:"+String(n)+" firstNum:"+String(firstNum)+" diff:"+String(diff));
            var c=firstNum+diff;
            return c * Math.sqrt(1 - (p=p/1-1)*p) + firstNum;
        },
        
        circEaseInOut:function(p, n, firstNum, diff) {

            var c=firstNum+diff;
            
            if ((p/=0.5) < 1) 
                return -c/2 * (Math.sqrt(1 - p*p) - 1) + firstNum;
            else
                return c/2 * (Math.sqrt(1 - (p-=2)*p) + 1) + firstNum;
        },
        

    }
});



/* 
(c) 2011 Lubomir Krupa, CC BY-ND 3.0
*/

$(document).ready(function(){
	var num = numberOfScreens;

	for(var i=1;i<=num;i++){
		$('#name'+i).html(blockName[i]);
	}

	
	if(hoverEffect){
		for(i=1;i<=num;i++){
			$('<style>#wrapper'+i+' div.site:hover{border: 1px #fff solid;box-shadow: 0px 0px 5px #fff;margin-left:4px;margin-top:4px;}</style>').appendTo('head');
		};
	};
	

	var windowWidth = $(window).width();
	var windowHeight = $(window).height();
	var left1 = Math.floor((windowWidth - 960)/2);
	var left2 = left1 - 1040;
	var left3 = left1 - 2080;
	var wrapperTop = Math.floor((windowHeight - 480)/2)-60;
	
	$('#place').css({'left':left1,'top':wrapperTop});
	var wrapperPos = 1;
	var animDone = true;
	
	function anim1to2(){
		animDone = false;
		$('#place').animate({
			left: left2,
		},1000,'circEaseOut',function() {
			animDone = true;
			wrapperPos = 2;
		});
		$('#button1to2').hide();			
		$('#button2to1').show();
		if(num>2){
			$('#button2to3').show();
			$('#button3to2').hide();
		};
	};
	
	function anim2to1(){
		animDone = false;
		$('#place').animate({
			left: left1
		},1000,'circEaseOut',function() {
			animDone = true;
			wrapperPos = 1;
		});
		$('#button1to2').show();			
		$('#button2to1').hide();
		if(num>2){
			$('#button2to3').hide();
			$('#button3to2').hide();
		};		
	};
	
	function anim2to3(){
		animDone = false;
		$('#place').animate({
			left: left3
		},1000,'circEaseOut',function() {
			animDone = true;
			wrapperPos = 3;
		});
		$('#button1to2').hide();
		$('#button3to2').show();
		$('#button2to1').hide();
		$('#button2to3').hide();	
	};
	
	function anim3to2(){
		$('#wrapper3 input:text').focusout();
		animDone = false;
		$('#place').animate({
			left: left2
		},1000,'circEaseOut',function() {
			$('#wrapper2 input:text').focus();
			animDone = true;
			wrapperPos = 2;
		});
		$('#button1to2').hide();
		$('#button3to2').hide();
		$('#button2to1').show();
		$('#button2to3').show();			
	};
	
	if(num>1){
		$('#button1to2').click(function(){
   //alert("2");
			anim1to2();
		});
		
		$('#button2to1').click(function(){
			anim2to1();
		});
		
		if(num>2){
			$('#button2to3').click(function(){
				anim2to3();
			});
			
			$('#button3to2').click(function(){
				anim3to2();
			});
		};
	};

	$(document).bind('keydown',function(event){ 
		if(event.keyCode == '39' || event.keyCode == '37'){
			event.preventDefault();
		}
		if(event.which=='39' && animDone){
			
			if(wrapperPos==1 && num>1){
				anim1to2();
			};
			if(wrapperPos==2 && num>2){
				anim2to3();
			};
		};
		if(event.which=='37' && animDone){
			
			if(wrapperPos==3){
				anim3to2();
			};
			if(wrapperPos==2){
				anim2to1();
			};			
		};
	}); 

 

(function(c) {
    var a = ["DOMMouseScroll", "mousewheel"];
    c.event.special.mousewheel = {
        setup: function() {
            if (this.addEventListener) {
                for (var d = a.length; d;) {
                    this.addEventListener(a[--d], b, false)
                }
            } else {
                this.onmousewheel = b
            }
        },
        teardown: function() {
            if (this.removeEventListener) {
                for (var d = a.length; d;) {
                    this.removeEventListener(a[--d], b, false)
                }
            } else {
                this.onmousewheel = null
            }
        }
    };
    c.fn.extend({
        mousewheel: function(d) {
            return d ? this.bind("mousewheel", d) : this.trigger("mousewheel")
        },
        unmousewheel: function(d) {
            return this.unbind("mousewheel", d)
        }
    });
    function b(f) {
        var d = [].slice.call(arguments, 1),
            g = 0,
            e = true;
        f = c.event.fix(f || window.event);
        f.type = "mousewheel";
        if (f.wheelDelta) {
            g = f.wheelDelta / 120
        }
        if (f.detail) {
            g = -f.detail / 3
        }
        d.unshift(f, g);
        return c.event.handle.apply(this, d)
    }
})(jQuery);


	$(document).mousewheel(function(event, delta) {
		if (delta > 0 && animDone){
			if(wrapperPos==3){
				anim3to2();
			};
			if(wrapperPos==2){
				anim2to1();
			};
		}
		else if (delta < 0 && animDone){
			if(wrapperPos==1 && num>1){
				anim1to2();
			};
			if(wrapperPos==2 && num>2){
				anim2to3();
			};
		};		
		event.preventDefault();		
	});



});


