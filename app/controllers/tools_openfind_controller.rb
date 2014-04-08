#encoding:utf-8
class ToolsOpenfindController < ApplicationController
require 'open-uri'
require 'zip/zip'
require 'zip/zipfilesystem'
require 'fileutils'

  def index
  end

  def dl_member
    url = params[:members_url]
    
    respond_to do |format|
      format.xls {
        send_data(xls_content_for(url),
                  :type => "text/excel; charset=utf-8; header=present",
                  :filename => "Openfind #{Time.now.strftime("%Y年%m月份名单")}.xls")
        }
    end

  end

  def dl_template
    openfind_url = params[:openfind_url]
    
    #openfind_url = 'http://cndemo.openfind.com/china/epaper/2012_12'
    
    #创建根目录
    ym = Time.now.strftime("%Y-%m")
    openfind_path = Rails.root.join("public","openfind #{ym}")  
    FileUtils.rm_r(openfind_path) if File.exist?(openfind_path)
    Dir.mkdir(openfind_path) unless File.exist?(openfind_path)
    images_path = File.join(openfind_path,"images")
    Dir.mkdir(images_path) unless File.exist?(images_path)
    
    #下载image并修改链接地址
    doc = Nokogiri::HTML(open(openfind_url).read)
    doc.css("img").each do |img|
      img_src = img.attr("src")
      next unless %w(.jpg .jpeg .gif .png).include?(File.extname(img_src).downcase)
      begin
      img_data = open(img_src){|f|f.read }
      rescue => e
       puts e.to_s
      else
        new_img = File.join(images_path,File.basename(img_src))
        open(new_img,"wb") do |f| 
          f.write(img_data)
        end
        img["src"] = File.join("images",File.basename(img_src))
      end
    end
    
    #创建index页面
    index_path = File.join(openfind_path,"index.html")
    openfind_index = File.new(index_path,'w')
    #src_code =  Nokogiri::HTML(open(openfind_url).read)
    #src_code = open(openfind_url).read
    #src_code = src_code.force_encoding('GBK')  
    #src_code = src_code.encode('UTF-8',{:invalid => :replace, :undef => :replace, :replace => ' '}) 
    openfind_index.puts(doc.to_s)
  
   zf_dir = Rails.root.join("public","openfind #{Time.now.strftime('%Y年%m月电子报模板')}.zip")
   File.delete(zf_dir) if File.exist?(zf_dir)
   generate_zip(openfind_path,zf_dir)
    
   if File.exist?(zf_dir)
     io = File.open(zf_dir)
     io.binmode
     send_data(io.read,:filename => "openfind #{Time.now.strftime('%Y年%m月电子报模板')}.zip",:disposition => 'attachment')
     io.close
   else
     render :inline => "创建[openfind #{Time.now.strftime('%Y年%m月电子报模板')}.zip]失败！"
   end   

  end


  def generate_zip(been_zip_dir,zf_dir)
    zf_dir = Rails.root.join("public","openfind #{Time.now.strftime('%Y年%m月电子报模板')}.zip")
    Zip::ZipFile.open zf_dir, Zip::ZipFile::CREATE do |zip|  
      encrypt_zip(been_zip_dir, "", zip) 
    end  
  end  
  
  def encrypt_zip(file_path, zip_dir, zip)
    base_name = File.basename(file_path)
    if File.directory?(file_path)
      zip_dir = zip_dir.present?? File.join(zip_dir,base_name) : base_name
      zip.dir.mkdir(zip_dir)
      Dir.foreach(file_path) do |sub_file|
        encrypt_zip(File.join(file_path,sub_file), zip_dir, zip) unless sub_file == '.' or sub_file == '..'   
      end
    else
      base_name = File.join(zip_dir,base_name) if zip_dir.present?
      zip.add(base_name, file_path)
      #zip.file.open(File.join(zip_dir,base_name), 'w') { |f| f << file_path }  
    end 
  end
  
  def xls_content_for(url)
    xls_report = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => "Sheet1"
    
    blue = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 10
    sheet1.row(0).default_format = blue
    sheet1.row(0).concat %w{name email}
    row_index = 1
    
    #url = 'http://cndemo.openfind.com/china/order/show.php'
    doc = Nokogiri::HTML(open(url).read)
    doc.css("p").each do |i|
     tmp = i.content.strip
     tmp.gsub!(/[' ']|[' ']|[';']/,'')
     sheet1[row_index,0] = tmp.split('@')[0]
     sheet1[row_index,1] = tmp
     row_index += 1
    end

    book.write xls_report
    xls_report.string
  end

end
