troubleshooting process:

- First I checked the os version, user permission, and switch to the superuser. Check the status for Redis and the
corresponding logs. Found out the error log.

What's wrong:

- There is a mismatch the redis-server log file in systemd service config file and Redis config 
file in /etc directory.

fix:

 - modified the "redis.conf" log directory to /var/log/redis/redis-server.log.

 - granted appropriate permission for the Redis log file.
 
