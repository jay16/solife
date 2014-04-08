 
 //界面加载某指定邮箱
 function show_inbox(email){
     var strhost = window.location.host;
     var strprotocol = window.location.protocol;
     var strport = window.location.port;
     if(strport > 0){
       if(strhost.indexOf(strport)==-1){
        strhost = strhost + ":"+String(strport)
       }
     }
     var strurl = strprotocol+"//"+strhost+"/tools_mailer/show";
    
      $.ajax({
      type: 'POST',
      url: strurl,
      contentType: 'multipart/form-data',
       headers: {
             'X-Transaction': 'POST Example',
             'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
           },
      datatype: 'json',
      data:{"email" : email},
      success:function(data)
      {
         $("#inbox_zone").html(data);
      },
      error:function(xhr,r,e)
      {
         alert("Check Inbox - No");
      }
     });
 }  
  
 //查收收件箱
 function mail_checker(email){
     var strhost = window.location.host;
     var strprotocol = window.location.protocol;
     var strport = window.location.port;
     if(strport > 0){
       if(strhost.indexOf(strport)==-1){
        strhost = strhost + ":"+String(strport)
       }
     }
     var strurl = strprotocol+"//"+strhost+"/tools_mailer/mail_checker";
    
      $.ajax({
      type: 'POST',
      url: strurl,
      contentType: 'multipart/form-data',
       headers: {
             'X-Transaction': 'POST Example',
             'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
           },
      datatype: 'json',
      data:{"email" : email},
      success:function(data)
      {
         alert(data);
      },
      error:function(xhr,r,e)
      {
         alert("Check Inbox - No");
      }
     });
 }  
 
 //添加新邮箱
 function new_mail_submit(){
     var strhost = window.location.host;
     var strprotocol = window.location.protocol;
     var strport = window.location.port;
     if(strport > 0){
       if(strhost.indexOf(strport)==-1){
        strhost = strhost + ":"+String(strport)
       }
     }
     var strurl = strprotocol+"//"+strhost+"/tools_mailer/mail_create";
     
     var $model = $("#new_mail_modal");
     var email  = $("#mail_email").val();
     var pwd    = $("#mail_pwd").val();
     var pop    = $("#mail_pop").val();
     var pop_port  = $("#pop_port").val();
     var smtp      = $("#mail_smtp").val();
     var smtp_port = $("#smtp_port").val();
     
     alert("EMAIL:"+email+"\nPWD:"+pwd+"\nPOP"+pop+"\nPOP-Port:"+pop_port+"\nSMTP"+smtp+"\nSMTP-Port:"+smtp_port);
     
      $.ajax({
      type: 'POST',
      url: strurl,
      contentType: 'multipart/form-data',
       headers: {
             'X-Transaction': 'POST Example',
             'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
           },
      datatype: 'json',
      data:{"email" : email,
            "pwd"   : pwd,
            "pop"   : pop,
            "pport" : pop_port,
            "smtp"  : smtp,
            "sport" : smtp_port},
      success:function(data)
      {
          switch(data){
	       	case '1':{
	            alert("Fail:\n"+email+"\n Exist!");
	       	}
	       	break;
	       	case '2':{
	       		alert("Success:\n"+email+"\n Created!");
	       	}
	       	break;
	       	default:{
	           alert("Fail:\n"+email+"\n Created Fails!");
	       	}
	       	break;
	       }
      },
      error:function(xhr,r,e)
      {
         alert("Inbox - No");
      }
     });
 }
 
  //编辑邮箱信息
 function edit_mail(email){
     var strhost = window.location.host;
     var strprotocol = window.location.protocol;
     var strport = window.location.port;
     if(strport > 0){
       if(strhost.indexOf(strport)==-1){
        strhost = strhost + ":"+String(strport)
       }
     }
     var strurl = strprotocol+"//"+strhost+"/tools_mailer/edit";
    
      $.ajax({
      type: 'POST',
      url: strurl,
      contentType: 'multipart/form-data',
       headers: {
             'X-Transaction': 'POST Example',
             'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
           },
      datatype: 'json',
      data:{"email" : email},
      success:function(data)
      {
        $("#edit_mail_modal .modal-body").html(data);
        $("#edit_trigger").trigger("click");
      },
      error:function(xhr,r,e)
      {
         alert("FAIL-EDIT!");
      }
     });
 } 
 
   //提交邮箱信息
 function update_mail_submit(){
     var strhost = window.location.host;
     var strprotocol = window.location.protocol;
     var strport = window.location.port;
     if(strport > 0){
       if(strhost.indexOf(strport)==-1){
        strhost = strhost + ":"+String(strport)
       }
     }
     var strurl = strprotocol+"//"+strhost+"/tools_mailer/update";
     
     var email  = $("#edit_mail_email").val();
     var pwd    = $("#edit_mail_pwd").val();
     var pop    = $("#edit_mail_pop").val();
     var pop_port  = $("#edit_pop_port").val();
     var smtp      = $("#edit_mail_smtp").val();
     var smtp_port = $("#edit_smtp_port").val();
     
     alert("EMAIL:"+email+"\nPWD:"+pwd+"\nPOP"+pop+"\nPOP-Port:"+pop_port+"\nSMTP"+smtp+"\nSMTP-Port:"+smtp_port);
     
      $.ajax({
      type: 'POST',
      url: strurl,
      contentType: 'multipart/form-data',
       headers: {
             'X-Transaction': 'POST Example',
             'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
           },
      datatype: 'json',
      data:{"email" : email,
            "pwd"   : pwd,
            "pop"   : pop,
            "pport" : pop_port,
            "smtp"  : smtp,
            "sport" : smtp_port},
      success:function(data)
      {
          switch(data){
	       	case '1':{
	            alert("Update Fail:\n"+email);
	       	}
	       	break;
	       	case '2':{
	       		alert("Success:\n"+email+"\n Updated!");
	       	}
	       	break;
	       	default:{
	           alert("Fail:\n"+email+"\n Not Exist!");
	       	}
	       	break;
	       }
      },
      error:function(xhr,r,e)
      {
         alert("Inbox - No");
      }
     });
 }