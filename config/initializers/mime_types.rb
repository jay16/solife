# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone
Mime::Type.register "application/vnd.ms-excel", :xls

unless defined? Mime::ZIP
  Mime::Type.register "application/zip", :zip
end
unless defined? Mime::PDF
  Mime::Type.register "application/pdf", :pdf
end

# Video
Mime::Type.register "video/x-flv", :flv
Mime::Type.register "video/webm", :webm
Mime::Type.register "video/mp4", :mp4
