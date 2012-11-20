Capistrano::Configuration.instance.load do
  _cset(:user_shell_method) { %{bash -l -c} }

  def tty_ssh_command_in_current_host(command, hostname = current_host)
    user_ssh_command = fetch(:user, nil) ? "-l #{fetch(:user)}" : ''

    user_ssh_command << " #{ENV['SSH_OPTS']}" if ENV['SSH_OPTS']

    exec %{ssh #{user_ssh_command} #{hostname} -t "#{user_shell_method} 'cd #{current_path} && #{command}'"}
  end

  def current_host
    ENV['HOST'] || find_servers_for_task(current_task).first
  end

  Dir[File.expand_path('../cap-pack/recipes/**/*.rb', __FILE__)].each { |f| load f }
end

