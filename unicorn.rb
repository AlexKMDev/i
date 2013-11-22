worker_processes 1

@dir = File.dirname(__FILE__)
working_directory @dir

listen "#{@dir}/unicorn.sock", :backlog => 64
timeout 30

pid "#{@dir}/unicorn.pid"

stderr_path "#{@dir}/log/unicorn.stderr.log"
stdout_path "#{@dir}/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false
