#= require jquery
#= require jquery_ujs
#= require blog/jquery.tabSlideOut.v1.3
#= require blog/sidebar
#= require bootstrap
# 仅repl中使用,已在reply.coffee中引用
# require jquery.atwho
#= require jquery_hotkeys
#= require jquery_timeago
#= require jquery_timeago_settings
#= require reply
#= require segments
#= require solife-base
#= require_self

$(document).ready ->

  #文章中的table都使用bootstrap的table样式
  $(".content table:not(.CodeRay)").addClass("table table-bordered")

  #文章中内容正常显示
  $(".thumbnail").css("display","none")
  $(".segment").css("display","block")
  $(".segment_box .edit-pane").css("display","none")
  $(".segment .readless").css("display","none")
  $(".CodeRay").parent("div").addClass("xsolife-code")

  #文章显示框架js
  $(".slide-out-div").tabSlideOut({
    tabHandle: ".handle",                     #class of the element that will become your tab
    pathToTabImage: "/assets/feedback_tabv2.png", #path to the image for the tab #Optionally can be set using css
    imageHeight: "130px",                     #height of tab image           #Optionally can be set using css
    imageWidth: "36px",                       #width of tab image            #Optionally can be set using css
    tabLocation: "left",                      #side of screen where tab lives, top, right, bottom, or left
    speed: 300,                               #speed of animation
    action: "click",                          #options: "click" or "hover", action to trigger animation
    topPos: "200px",                          #position from the top/ use if tabLocation is left or right
    leftPos: "20px",                          #position from left/ use if tabLocation is bottom or top
    fixedPosition: true                       #options: true makes it stick(fixed position) on scroll
  })
