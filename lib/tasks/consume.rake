#encoding: utf-8

namespace :consume do 

  desc "update user_id"
  task :update => :environment do 
    Consume.all.each_with_index do |consume,index|
      puts consume.update_attributes({:user_id => consume.users.first.id})
    end
  end

end
