class CodeBug < ActiveRecord::Base
  attr_accessible :action, :class, :controler, :file_name, :line_number, :message, :source_extract, :url
end
