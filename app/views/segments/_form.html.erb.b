<div id="segment_form">  
  <%= javascript_include_tag "jquery.js" %>
  <%= stylesheet_link_tag    "bootstrap.css" %>
  <%= javascript_include_tag "bootstrap.js" %>
  <%= stylesheet_link_tag    "bootstrap-datepicker.css" %>
  <%= javascript_include_tag "bootstrap-datepicker.js" %>
  <%= stylesheet_link_tag    "bootstrap-markdown.css" %>
  <%= javascript_include_tag "bootstrap-markdown.js" %>
<hr/>
<style>
.span8 {
    width: 740px;
    max-width: 740px;
    margin-left: 25px;
}
.span3 {
    width: 255px;
    max-width: 255px;
    margin-left: 0px;
}
.thumbnail {
  padding-bottom: 25px;
}
form .btn-group { 
display: inline-block;
    font-size: 0;
    position: relative;
    vertical-align: middle;
    white-space: nowrap;
 }

[class^="icon-"], [class*=" icon-"] {
    background-image: url('assets/glyphicons-halflings.png');
}
</style>
<% path_str = case params[:action]
   when "new"
     segments_create_path()
   when "edit"
     segments_update_path(@segment.id)
   when "append"
     segments_append_to_path(@segment.id) 
   end
%>
<%= form_tag(path_str,:remote => true) do %>
   <div id="segment_title">
      <input name="title" type="text" placeholder="Segment Title" size="40" value="<%= @segment.title %>"/>
      <span class="input-append date" id="lives_at" data-date="<%= @segment.life and @segment.life.lives_at.nil? ? Time.now.strftime('%Y-%m-%d') : @segment.life.lives_at.strftime('%Y-%m-%d') %>" data-date-format="yyyy-mm-dd">
	<input class="span2" size="16" type="text" name="lives_at" value="<%= @segment.life and @segment.life.lives_at.nil? ?  Time.now.strftime('%Y-%m-%d') :  @segment.life.lives_at.strftime('%Y-%m-%d') %>">
	<span class="add-on"><i class="icon-th"></i></span>
       </span>
    </div>

    <textarea name="content" data-provide="markdown" rows="10"><%= @segment.content %></textarea>

    <div class="md-footer" style="float:right;">
       <%= submit_tag "Submit", :class => "btn" %>
    </div>
<% end %> 

<script>
$(function(){
   $("#lives_at").datepicker();
	var d = new Date();
	var fullyear = d.getFullYear();
	//月份从0开始，应加1
	var month = d.getMonth()+1;
	//第几天
	var day = d.getDate();
        var today = String(fullyear)+"/"+String(month)+"/"+String(day);
        //alert(today);
   $("#lives_at").datepicker( "setDate", today);
   $("#lives_at").var(today);

 });
</script>
</div>
