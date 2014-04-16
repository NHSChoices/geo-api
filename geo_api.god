app_path = '/var/apps/geoapi/current'
app_env = 'prod'
ruby_path = 'ruby'
pid_file = '/var/apps/geoapi/shared/goliath.pid'

God.watch do |w|
  # script that needs to be run to start, stop and restart
  w.name          = "geoapi" 
  w.interval      = 60.seconds
  w.keepalive

  w.start         = "cd #{app_path} && #{ruby_path} geo_api.rb -e #{app_env} -p 8080 -P #{pid_file} -d" 

  # QUIT gracefully shuts down workers
  w.stop = "kill -QUIT `cat #{pid_file}`"

  w.restart = "#{w.stop} && #{w.start}"

  w.start_grace   = 20.seconds
  w.pid_file      = "#{pid_file}" 

  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 60.seconds
      c.running = false
    end
  end

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 300.megabytes
        c.times = [3, 5]
      end

    restart.condition(:cpu_usage) do |c|
      c.above = 50.percent
      c.times = 5
    end
  end

  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end
