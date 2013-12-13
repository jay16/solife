   //创建 tag
  function create_tag_within_model(){
   var label     = $("#label").val();
   var segment_id = $("#segment_id").val();
     
   if(label.length > 0){
     //alert("Yes:\n"+label);
   }else{
    alert("Error:\n"+label);
    return -1;
   }
   
   var strhost = window.location.host;
   var strprotocol = window.location.protocol;
   var strport = window.location.port;
   if(strport > 0){
     if(strhost.indexOf(strport)==-1){
      strhost = strhost + ":"+String(strport)
     }
   }
   var strurl = strprotocol+"//"+strhost+"/tags/create";
 
   
    $.ajax({
    type: 'POST',
    url: strurl,
    contentType: 'multipart/form-data',
     headers: {
           'X-Transaction': 'POST Example',
           'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
         },
    datatype: 'json',
    data:{"label": label },
    success:function(data)
    {
       update_tags_list(segment_id,"add_tags_list");
    },
    error:function(xhr,r,e)
    {
       alert("Create Tag Fail!");
    }
   });
   
 }
  
  //新创建tag后，通过ajax更新Model中tags_list内容的显示
  function update_tags_list(segment_id,idstr){
	   var strhost = window.location.host;
	   var strprotocol = window.location.protocol;
	   var strport = window.location.port;
	   if(strport > 0){
	     if(strhost.indexOf(strport)==-1){
	      strhost = strhost + ":"+String(strport)
	     }
	   }
     var strurl = strprotocol+"//"+strhost+"/tags/list";

      $.ajax({
      type: 'POST',
      url: strurl,
      contentType: 'multipart/form-data',
       headers: {
             'X-Transaction': 'POST Example',
             'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
           },
      datatype: 'json',
      data: { "segment_id":segment_id },
      success:function(data)
      {
        $("#"+idstr).html(data);
      },
      error:function(xhr,r,e)
      {
         alert("no");
         window.location.reload();
      }
     });
  }
  
  //触发attach tag modal 
  function attach_tags(segment_id){
     $("#segment_id").val(segment_id);
     
     var modal_trigger = document.getElementById("tag_modal_trigger");
     modal_trigger.click();
     
     update_tags_list(segment_id,"attach_tags_list");
 }
 
  //提交attach tags
  function attach_tags_submit(){
	   var strhost = window.location.host;
	   var strprotocol = window.location.protocol;
	   var strport = window.location.port;
	   if(strport > 0){
	     if(strhost.indexOf(strport)==-1){
	      strhost = strhost + ":"+String(strport)
	     }
	   }
     var strurl = strprotocol+"//"+strhost+"/tags/build";
  
     var segment_id = $("#segment_id").val();
     var tags_list = new Array();
     
     var checkbox_name = "solife_tags";
     var checkboxs = document.getElementsByName(checkbox_name); 
     for(i=0;i<checkboxs.length;i++){     
       var current_checkbox = checkboxs[i];
       if(current_checkbox.checked){     
          tags_list.push(String(current_checkbox.id).split("_")[1])
       }   
     }     
  
     if(tags_list.length == 0){
      alert("No Tags Selected!");
      return -1
     }
     
      $.ajax({
      type: 'POST',
      url: strurl,
      contentType: 'multipart/form-data',
       headers: {
             'X-Transaction': 'POST Example',
             'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
           },
      datatype: 'json',
      data:{"segment_id":segment_id,"tags_list":tags_list},
      success:function(data)
      {
         refresh_tags_zone(segment_id);
      },
      error:function(xhr,r,e)
      {
         alert("no");
      }
     });
     
            
     var close_modal_trigger = document.getElementById("attach_tag_model_close");
     close_modal_trigger.click();
 }

 //update tags zone
 function refresh_tags_zone(segment_id){
	   var strhost = window.location.host;
	   var strprotocol = window.location.protocol;
	   var strport = window.location.port;
	   if(strport > 0){
	     if(strhost.indexOf(strport)==-1){
	      strhost = strhost + ":"+String(strport)
	     }
	   }
     var strurl = strprotocol+"//"+strhost+"/tags/tags_zone";
     
     var $tags_zone = $("#segment_"+String(segment_id)+" .tags-zone");
     
      $.ajax({
      type: 'POST',
      url: strurl,
      contentType: 'multipart/form-data',
       headers: {
             'X-Transaction': 'POST Example',
             'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
           },
      datatype: 'json',
      data:{"segment_id":segment_id},
      success:function(data)
      {
         $tags_zone.html(data);
      },
      error:function(xhr,r,e)
      {
         alert("no");
      }
     });
     
 }

