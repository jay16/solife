 //toggle以指定方式显示或隐藏指定id
 function toggle_show(this_id,that_id,show_class){
 	var $this      = $("#"+this_id);
 	var $that      = $("#"+that_id);
 	var hide_class = "hide";
 	var is_hide    = $this.hasClass(hide_class);

 	
 	if(is_hide){
 		$this.removeClass(hide_class);
 		$this.addClass(show_class);
 		$that.addClass(hide_class);
 	}else{
 		$this.removeClass(show_class);
 		$this.addClass(hide_class);
 		$that.removeClass(hide_class);
 	}
 }
 
 //toggle以指定方式显示或隐藏指定id
 function toggle_show_self(id,show_class){
 	var $this      = $("#"+id);
 	var hide_class = "hide";
 	var is_hide    = $this.hasClass(hide_class);
 	
 	if(is_hide){
 		$this.removeClass(hide_class);
 		$this.addClass(show_class);
 	}else{
 		$this.removeClass(show_class);
 		$this.addClass(hide_class);
 	}
 }

 //toggle转换指定id的显示内容
 function toggle_id_text(id,text1,text2){
 	var $this     = $("#"+String(id));
 	//use text() get div's innerText with JQuery
 	var text = $this.text();
 	
 	if(text == text1){
 		$this.text(text2)
 	}else{
 		$this.text(text1);
 	}
 }


 //toggle转换自己的显示内容
 function toggle_self_text(self,text1,text2){
 	var $this     = $(self);
 	//use text() get div's innerText with JQuery
 	var text = $this.text();
 	
 	if(text == text1){
 		$this.text(text2)
 	}else{
 		$this.text(text1);
 	}
 }
