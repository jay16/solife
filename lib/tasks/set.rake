task :update_consume => :environment do
  user = User.find_by_email("jay_li@xsolife.com")
  raise "user not exist" if user.nil?
  Consume.all.each do |consume|
    puts consume.id
    UserConsume.create({ :user_id => user.id, :consume_id => consume.id })
  end
end
