Eye.application 'uyd' do
  working_dir '/home/ubuntu/uyd/current'
  trigger :flapping, times: 10, within: 1.minute, retry_in: 10.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes	
 
 2.times do |i|
    process("puma_#{i}") do
      pid_file "#{app.working_dir}/tmp/pids/puma.#{i}.pid"
      start_command "uyd_puma -e production -d -b unix://#{working_dir}/tmp/sockets/puma.#{i}.sock --pidfile #{working_dir}/tmp/pids/puma.#{i}.pid"
      stop_command  "uyd_pumactl --pidfile #{working_dir}/tmp/pids/puma.#{i}.pid stop"

      # logs
      stdout "#{working_dir}/log/puma.#{i}.out.log"
      stderr "#{working_dir}/log/puma.#{i}.error.log"
      start_timeout 60.seconds
      stop_grace 60.seconds
  #    uid = process.gid = '<%= node['seatbelts']['user'] %>'
    end
  end
end
