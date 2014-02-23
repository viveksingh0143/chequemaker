root = "/home/vamika/apps/chequemaker/current"
working_directory root
pid "#{root}/tmp/pids/unicorn_chequemaker.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.chequemaker.sock"
worker_processes 2
timeout 30
