# Snapshot Attack Demo

### Build the demo

#### Install Occlum and modified SGXSDK (optional)

We provide a Dockerfile for fast SDK/Occlum installation.

#### Target program

The victim program is running a bash-shell script (`occlum_bash.sh`). It first fetch a provisioned password, to genarate a customized Redis configuration file, with the "requirepass" entry filled. Then it invokes a Redis server, according to the customized config file.

To build the config generation program, run `make`. To build the Redis server, execute the following commands.

```
cd bash_redis
./download_and_build_redis_glibc.sh
```

### Run the demo

Prepare 2 terminals, one for the victim and one for the attacker.

Run `run_redis.sh` at the victim terminal. This script will start up the target program.

#### Record

The attacker needs to take snapshot (using `./take_snapshot_step-1.sh`) when he/she can determine that the snapshot is flushing. In our demo, we modified the untrusted part of Intel SGXSDK, to facilitate the attacker to decide the timing.

After the Redis server is running, run `./take_snapshot_step-2.sh` to complete the snapshot collection.

#### Replay

The attacker executes `replay_redis.sh` to replay the enclave using our collected snapshot. Any client can log onto the Redis server without authentication.
