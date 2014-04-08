task :test_units do

  RAILS_ENV = 'test' # Force the environment to test

  puts "Recreate the test database"
  Rake::Task['db:test:prepare'].invoke

  puts "Seed the database with fixtures"
  Rake::Task['db:fixtures:load'].invoke

  puts "Executing Unit Tests"
  Rake::Task['test:units'].prerequisites.clear 
  Rake::Task['test:units'].invoke
end
