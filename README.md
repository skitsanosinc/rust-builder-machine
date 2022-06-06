# Rust Builder Machine
_When you really need to compile the Rust app against Linux, but you don't have one_

To build your app/library on this Docker container, simply execute the following line from your project directory:

```shell
docker run --rm -it -v "$(pwd)":/app skitsanos/rust-builder-machine cargo build --release
```

Or, to reuse the container:

```shell
docker run --name rust-project -it -v "$(pwd)":/app skitsanos/rust-builder-machine /root/.cargo/bin/cargo build --release
```

Just in case, the Rust binaries can be found on the Docker image at `/root/.cargo/bin`

## Lua support

This docker image comes with [LuaJIT](https://en.wikipedia.org/wiki/LuaJIT) preinstalled, so Lua modules can be compiled and tested on the same container.

You can execute your code on LuaJIT like this:

```shell
docker run --rm -it -v "$(pwd)":/app skitsanos/rust-builder-machine luajit -e "print('Testing the Lua')"
```

So the whole thing can be wrapped in the following shell script:

```shell
docker start rust-app || docker container create --name rust-app --rm -v "$(pwd)":/app skitsanos/rust-builder-machine
docker exec -it rust-app cargo build --release

mkdir -p "target/.linux/"

RAW_LIB_PATH=$(find target/release -name '*.so' -maxdepth 1 -type file)
mv $RAW_LIB_PATH target/.linux/my_module.so

docker exec -w /app/target/.linux/ rust-app luajit -e "require('my_module').hello('world')"
```

