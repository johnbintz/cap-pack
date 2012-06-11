desc "Tail all or a single remote file"
task :tail do
  pattern = ENV["LOGFILE_PATTERN"] || "*.log"
  run "tail -f #{shared_path}/log/#{pattern}" do |channel, stream, data|
    puts "#{data}"
    break if stream == :err
  end
end

