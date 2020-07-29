#Linux VM:

Troubleshooting process:

- First I checked the os version, user permission, and switch to the superuser. Check the status for Redis and the
corresponding logs. Found out the error log.

What's wrong:

- There is a mismatch the redis-server log file in systemd service config file and Redis config 
file in /etc directory.

Fix:

 - modified the "redis.conf" log directory to /var/log/redis/redis-server.log.

 - granted appropriate permission for the Redis log file.
 
# Windows VM:

Troubleshooting process:

 - First I have checked the localhost in the browser and noticed get a 503 exception.
 - After the I'm looking into IIS Manager settings.
 
What's wrong:

- There was a process model identity issue.

Fix:

- I had updated the with ApplicationPoolIdentity
- Started Application Pool. It's Working now.
