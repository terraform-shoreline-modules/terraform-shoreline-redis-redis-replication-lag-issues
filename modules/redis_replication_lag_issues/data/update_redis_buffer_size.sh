

#!/bin/bash



# Set the Redis configuration file path

REDIS_CONF=${REDIS_CONF_FILE_PATH}



# Set the replication buffer size

REPL_BUFFER_SIZE=${NEW_BUFFER_SIZE}



# Update the Redis configuration file with the new replication buffer size

sed -i "s/^repl-backlog-size .*/repl-backlog-size $REPL_BUFFER_SIZE/" $REDIS_CONF



# Restart the Redis service to apply the changes

service redis restart