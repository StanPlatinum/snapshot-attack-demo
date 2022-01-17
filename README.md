# Snapshot Attack Demo

### Build the demo

#### Install Occlum and modified SGXSDK (optional)

First of all, anyone willing to run the demo must install Occlum and modified SGX SDK (optional). We provide a Dockerfile for fast Occlum/SDK installation. The modified SGX SDK is to help the attacker to decide the timing.


#### Build the target program

The target program is at the `bash_redis` folder.

The victim program is running a bash-shell script (`occlum_bash.sh`). It first fetches a provisioned password, to generate a customized Redis configuration file, with the "requirepass" entry filled. Then it invokes a Redis server, according to the customized config file.

To build the config generation program, run `make`. To build the Redis server, execute the following commands.

```
cd bash_redis
./download_and_build_redis_glibc.sh
```

### Run the demo

#### Make sure that the victim Redis program works

Open a terminal for the victim. Run `run_redis.sh`, checking if the Redis server works well.

Using command `redis-cli -h $Redis_Server_IP -p $Redis_Server_Port -a admin123456` to verify whether the password (admin123456) has been set in the config file.

Press `ctrl + C` to terminate the Redis server.

#### Snapshot capture

Prepare 2 terminals, one for the victim and one for the attacker. You can only open one more terminal (for the attacker) if one terminal has been opened already for the victim.

Run `run_redis.sh` at the victim terminal again. This script will start up the target program.

The attacker needs to take a snapshot (using `./take_snapshot_step-1.sh`) when he/she can determine that the snapshot is flushing. In the demo, the attacker can get a clear notice from the victim's terminal as follows.

```
...
Run ./take_snapshot_step-1.sh NOW!
Run ./take_snapshot_step-1.sh NOW!
line 4522: # passwords, then flags, or key patterns. However note that the additive
Run ./take_snapshot_step-1.sh NOW!
line 4523: # and subtractive rules will CHANGE MEANING depending on the ordering.
Run ./take_snapshot_step-1.sh NOW!
line 4524: # For instance see the following example:
Run ./take_snapshot_step-1.sh NOW!
...
```

Launch the `./take_snapshot_step-1.sh` script on the attacker's terminal.
 
If you build Occlum with our modified SGX SDK, you will see more hint message. This is because we modified the untrusted part of Intel SGX SDK, printing helper messages to facilitate the attacker to decide the timing.

After the Redis server is running, run `./take_snapshot_step-2.sh` to complete the snapshot collection.

#### Enclave replay

The attacker executes `replay_redis.sh` to replay the enclave using our collected snapshot. Any client can log onto the Redis server without authentication.

Example command for Redis client: 

```
redis-cli -h $Redis_Server_IP -p $Redis_Server_Port
```

#### Note

Sometimes the demo fails due to Occlum's integrity check. You probably see the following message.

```
Replaying ...
~/snapshot-demo/bash_redis_replay/occlum_instance ~/snapshot-demo/bash_redis_replay
In: writing meta-data in write_all_changes_to_disk
In: writing meta-data in write_all_changes_to_disk
Error: Os { code: 22, kind: InvalidInput, message: "Invalid argument" }
[ERROR] occlum-pal: The init process exit with code: 1 (line 59, file src/pal_api.c)
[ERROR] occlum-pal: Failed to run the init process: EINVAL (line 129, file src/pal_api.c)
```

Simply run the demo again (from the record phase). The error will gone for good.

GL & HF!
