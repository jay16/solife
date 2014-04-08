desc "deal with git"
namespace :git do

  desc "push files to githtup"
  task :push do
    timestamp = Time.now.strftime("%Y/%m/%d-%H:%M:%S")
    autommit = "auto commit - #{timestamp}"
    commit = ENV["commit"].nil? ? autommit : ENV["commit"]

    shell_content =<<SHELL
      git_path=$(which git)
      cd /home/work/solife
      ${git_path} init
      ${git_path} add -A .
      ${git_path} commit -a -m "#{commit}"
      ${git_path} push origin master -f
SHELL
    system(shell_content)
  end

end
