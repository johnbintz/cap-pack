desc "Connect via SSH and end up in the app's directory"
task :ssh do
  tty_ssh_command_in_current_host("bash")
end

