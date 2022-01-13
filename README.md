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

Prepare 2 terminals, one for the victim and one for the attacker.

Run `run_redis.sh` at the victim terminal. This script will start up the target program.

#### Record phase

The attacker needs to take a snapshot (using `./take_snapshot_step-1.sh`) when he/she can determine that the snapshot is flushing. In the demo, the attacker can get a clear notice from the victim's terminal to launch the 'take snapshot' script. This is because we modified the untrusted part of Intel SGX SDK, printing helper messages to facilitate the attacker to decide the timing.

After the Redis server is running, run `./take_snapshot_step-2.sh` to complete the snapshot collection.

#### Replay phase

The attacker executes `replay_redis.sh` to replay the enclave using our collected snapshot. Any client can log onto the Redis server without authentication.

Example command for Redis client: 

```
redis-cli -h $Redis_Server_IP -p $Redis_Server_Port
```
