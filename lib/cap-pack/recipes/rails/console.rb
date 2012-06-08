namespace :rails do
  desc "Open the rails console on one of the remote servers"
  task :console, :roles => :app do
    tty_ssh_command_in_current_host("script/rails c #{rails_env}")
  end
end

