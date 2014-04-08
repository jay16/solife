#encoding: utf-8

namespace :segment do

  #segment write to markdown file
  task :markdown => :environment do
    Segment.all.each do |segment|
      next if segment.tags.size > 0 and segment.tags.select { |t| [1,3].include? t.tag_type }.size > 0

      markdown = "---\n"
      markdown << "layout: post\n"
      markdown << "title: " + segment.title.gsub(":"," -") + "\n"
      markdown << "date: " + segment.updated_at.strftime("%Y-%m-%d %H:%M:%S") + "\n"
      markdown << "comments: true\n"
      markdown << "categories: " + segment.tags.map {|t| t.label }.join(",") + "\n"
      markdown << "---\n"
      markdown << segment.content
      filename = segment.updated_at.strftime("%Y-%m-%d") + "-" + segment.permlink + ".markdown"
      basepath = "/home/tools/segments"
      File.open(File.join(basepath,filename),"w") do |file|
        file.puts markdown
      end
    end
  end
end


