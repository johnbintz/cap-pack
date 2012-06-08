Capistrano::Configuration.instance.load do
  _cset(:user_shell_method) { %{bash -l -c} }

  def tty_ssh_command_in_current_host(command, hostname = current_host)
    user_ssh_command = fetch(:user, nil) ? "-l #{fetch(:user)}" : ''

    exec %{ssh #{user_ssh_command} #{hostname} -t "#{user_shell_method} 'cd #{current_path} && #{command}'"}.tap { |o| p o }
  end

  def current_host
    find_servers_for_task(current_task).first
  end

  Dir[File.expand_path('../cap-pack/recipes/**/*.rb', __FILE__)].each { |f| load f }
end

