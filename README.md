zephyr-dev-env
--------------

This is a repo to play around with zephyr in your local machine.

# Building the image
```
docker build -t zephy-dev-env:0.1 .
```

# Running the container
```
docker run --mount type=bind,src=$PWD/zephyr,dst=/opt/zephyr -it zephyr-dev-env:0.14 bash
```

# Compiling a hello world example
```
cmake -Bbuild -DBOARD=native_sim/native/64 samples/hello_world
```
