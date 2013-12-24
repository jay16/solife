#encoding: utf-8
# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
# comment require_tree .

# 仅repl中使用,已在reply.coffee中引用
# require jquery.atwho 
#= require jquery
#= require jquery.iframe-transport
#= require jquery_ujs
#= require jquery.remotipart
#= require bootstrap
#= require bootstrap-scrollspy
#= require bootstrap-tooltip
#= require bootstrap-datepicker
#= require jquery.tips
#= require paginate
#= require segments
#= require ace
#= require showdown
#= require highcharts
#= require chosen-jquery
#= require jquery_hotkeys
#= require jquery_timeago
#= require jquery_timeago_settings
#= require solife-base
#= require_self

$ ->

  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '100px'

  $("#locale_chzn").css("width","100px");

  $("a[data-toggle=tooltip]").each ->
    $(this).tooltip();

  #使用ajax响应动作时，处理flash信息
  #默认隐藏flash-div
  $(".#{type}").hide("fast") for type in ['loading'] #'notice', 'alert', 'error', 'loading']

  #显示函数
  #show_ajax_flash=(msg,type) ->
  #  t = $(".#{type}") 
  #  t.show(0).delay(5000).hide("slow").fadeOut("slow");

  #监视ajax动作
  #$(document).ajaxComplete((event, request) -> 
  #  msg = request.getResponseHeader('X-Message');
  #  type = request.getResponseHeader('X-Message-Type');
  #   
  #  show_ajax_flash(msg,type) if type
  #);

  show_loading = () ->
    $(".loading").css("display","block");
    
  hide_loading = () ->
    $(".loading").css("display","none");

  $(".alert").alert()
  $(".alert .close").click () ->
    $(".alert").fadeOut("slow").remove()

  #$(".alert .close").bind("close", () ->
  #  $(".alert").alert("close")
  #) 
