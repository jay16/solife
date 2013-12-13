# solife.com网站全局功能代码
$ ->

  # 快捷键: Ctrl + F9 - 弹出登陆框 
  $("body").bind "keypress", "ctrl+f9", (el) ->
    $.get("/users/sign_in.js")
