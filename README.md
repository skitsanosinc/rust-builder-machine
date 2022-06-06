# Rust Builder Machine
_When you really need to compile the Rust app against Linux, but you don't have one_

To build your app/library on this docker machine, simply execute the following line from your project directory:

```shell
docker run --rm -it -v "$(pwd)":/app skitsanos/rust-builder-machine cargo build --release
```

Or, to reuse the container:

```shell
docker run --name rust-project --rm -it -v "$(pwd)":/app skitsanos/rust-builder-machine /root/.cargo/bin/cargo build --release
```

For just in case, the Rust binaries can be found at `/root/.cargo/bin`
