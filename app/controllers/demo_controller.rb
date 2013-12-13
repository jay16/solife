#encoding: utf-8
class DemoController < ApplicationController
  layout "layout_v2/application"

  respond_to :html, :js

  #faye
  def im_new
    @message = params[:message]
  end
  def im
    @message = params[:message]
  end

  def markdown_editor; end

  def ruby_in_100_minutes
    respond_to { |format| format.html { render :layout => false } }
  end

  def guides_rubyonrails_org
    respond_to { |format| format.html { render :layout => "guides.rubyonrails.org" } }
  end

  def topic
    @segment = Segment.find_by_permlink(params[:permlink]) 
    respond_to do |format|
      format.html { 
        render :layout => "ruby_in_100_minutes",#"guides.rubyonrails.org",
               :template => "segments/show"
      }
    end
  end

  def video; end
  def resume; end
  def pragmatic; end
  def shell; end
  def login
    flash[:notice] = 'Your dd!'
    @user = User.first
  end

  def shell_input
    input = params["shell-input"]
    allow = %w(whois which whereis date echo figlet)

    if input and allow.include?(input.split(" ")[0].downcase)
       @result = run_command(input)
    else
       @result = allow.unshift("Warning:(only allow the command below)")
    end
     
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def run_command(cmd, exit_on_error=false)
      ret = Array.new
      begin
	      IO.popen(cmd) do |stdout|
		stdout.each { |line|  ret.push(line) }
	      end
      rescue => e
              ret.push(e.message)
      else
              ret.push("command failed:\n#{cmd}")  if exit_on_error && ($?.exitstatus != 0)
      end
      return ret
  end

end

