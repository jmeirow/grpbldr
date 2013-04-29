

God.watch do |w|
  w.name = "mailman_server"

  w.start = "mongrel_rails start -c #{RAILS_ROOT} -p #{port} \
    -P #{RAILS_ROOT}/log/mongrel.#{port}.pid  -d"
  w.stop = "mongrel_rails stop -P #{RAILS_ROOT}/log/mongrel.#{port}.pid"
  w.restart = "mongrel_rails restart -P #{RAILS_ROOT}/log/mongrel.#{port}.pid"

  w.pid_file = File.join(RAILS_ROOT, "log/mongrel.#{port}.pid")

  ...
end