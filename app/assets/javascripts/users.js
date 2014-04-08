  function create_user_submit(){
   //--user 
   var name     = $("#register_name").val();
   var email    = $("#register_email").val();
   var password = $("#register_password").val();
   var confirm  = $("#register_confirm").val();
   
   var alert_str="name:" + name+"\nemail:"+email+"\npassword:"+password;
     
   if(password==confirm && password.length > 0){
     alert("Yes:\n"+alert_str);
   }else{
    alert("Error:\n"+alert_str);
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
   var strurl = strprotocol+"//"+strhost+"/users/create";
   
    $.ajax({
    type: 'POST',
    url: strurl,
    contentType: 'multipart/form-data',
     headers: {
           'X-Transaction': 'POST Example',
           'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
         },
    datatype: 'json',
    data:{"name":              name,
          "email":             email,
          "password":          password,
          "password_confirm":  confirm},
    success:function(data)
    {
       switch(data){
       	case '0':{
           window.location.reload();
       	}
       	break;
       	case '-1':{
       		alert("Register Fail!");
       	}
       	break;
       	default:{
           window.location.reload();
       	}
       	break;
       }
    },
    error:function(xhr,r,e)
    {
       alert("Register Fail!");
    }
   });
   
 }
 
  function login_submit(){
   var name     = $("#login_name").val();
   var password = $("#login_password").val();
      
     
   if(name.length == 0){
     alert("Error:\nName is Empty!");
     return -1
   }else if(password.length == 0){
     alert("Error:\nPassword is Empty!");
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
   var strurl = strprotocol+"//"+strhost+"/users/login";
   
    $.ajax({
    type: 'POST',
    url: strurl,
    contentType: 'multipart/form-data',
     headers: {
           'X-Transaction': 'POST Example',
           'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
         },
    datatype: 'json',
    data:{"name":              name,
          "password":          password
        },
    success:function(data)
    {
      switch(data){
	      case '0': {
	        window.location.reload();
	      }
	      break;
	      case '-1': {
	      	alert("Error\nUser:"+name+" Not Exist!")
	      }
	      break;
	      case '-2': {
	      	alert("Error\nPassword is Wrong!")
	      }
	      break;
	      default: {
	       window.location.reload();
	      }
	      break;
      }
      
    },
    error:function(xhr,r,e)
    {
       alert("Login Fail!");
    }
   });
   
 }