worker_processes 4
# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy

# listen 8082, :tcp_nopush => true