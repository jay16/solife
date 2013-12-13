##= require jquery_hotkeys
##= require jquery_timeago
##= require jquery_timeago_settings
#= require jquery.atwho

$(document).ready ->

  #timeago
  ##################################################
  $("abbr.timeago").timeago()
  
  #默认提交按钮无效
  #name,content都不为空时，按钮有效
  #reply-submit点击后禁用
  ##################################################
  $("#reply-submit").attr("disabled","disabled")

  $("#reply-submit").click ->
    $("#reply-submit").attr("disabled","disabled")

  get_by_id = (id) ->
    document.getElementById(id)

  chk_submit_enable = () ->
    is_name_ok = get_by_id("reply_name").value.length > 0 ? true : false
    is_content_ok = get_by_id("reply_content").value.length > 0 ? true : false
    if is_name_ok and is_content_ok
      $("#reply-submit").removeAttr("disabled")
    else
      $("#reply-submit").attr("disabled","disabled")

  $("#reply_name").keyup () ->
    chk_submit_enable()

  $("#reply_content").keyup () ->
    chk_submit_enable()

  #ctrl + enter => 快捷键提交
  ##################################################
  $("#reply_content").bind "keydown","ctrl+return",(el) ->
    alert("ctrl+return")

  #jquery-atwho-rails
  #@自动补充
  ##################################################
  commenter = []
  commenter_exist = []
  $(".reply .infos .info .name").each () ->
    tmp_text = $(this).text().trim().replace(/\n/,"")
    if($.inArray(tmp_text, commenter_exist) < 0)
      commenter.push(tmp_text)
      commenter_exist.push(tmp_text)

  $("#reply_content").atwho({ at: "@", data: commenter })
