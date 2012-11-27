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

  def switch_user(new_user)
    old_user = user
    set :user, new_user
    close_sessions
    yield
    set :user, old_user
    close_sessions
  end

  def close_sessions
    sessions.values.each { |session| session.close }
    sessions.clear
  end

  def rake(cmd, env = {})
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} #{env.collect { |k, v| "#{k}=#{v}" }.join(' ')} bundle exec rake #{cmd}"
  end

  Dir[File.expand_path('../cap-pack/recipes/**/*.rb', __FILE__)].each { |f| load f }
end

