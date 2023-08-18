# pglab

The script `pglab` is dedicated to make API calls to gitlab using just `jq` and `curl`.

This script works like AWS CLI, with a main command and its comands with its subcommands.

## Install script `pglab` in a linux machine


### Just read the full script in terminal

If you want get directly the full script in you terminal to just read, you can use the following `curl` command:

```sh
bash <(curl -s -L https://raw.githubusercontent.com/pethersonmoreno/linux-scripts/master/gitlab/bin/get-pglab)
```

You can put the content in a file too, with the following command:

```sh
bash <(curl -s -L https://raw.githubusercontent.com/pethersonmoreno/linux-scripts/master/gitlab/bin/get-pglab) > you-destiny-file
```

### Download script and configure it to run in terminal

If you want to download the full script and configure it to run, you can use the command:

```sh
bash <(curl -s -L https://raw.githubusercontent.com/pethersonmoreno/linux-scripts/master/gitlab/bin/get-pglab) your-desity-file
```

Example with a local file:

```sh
bash <(curl -s -L https://raw.githubusercontent.com/pethersonmoreno/linux-scripts/master/gitlab/bin/get-pglab) local-pglab
```

After it, you can run the `pglab` with the command:

```sh
./local-pglab
```

### Install `pglab` in a global path to use anywhere

Let's consider that the path has in it the directory `/usr/bin`, then to install `pglab` in this directory, you can run the command:

```sh
bash <(curl -s -L https://raw.githubusercontent.com/pethersonmoreno/linux-scripts/master/gitlab/bin/get-pglab) /usr/bin/pglab
```

If you need root permission to install the script, it will use the `sudo` command.


After it, you can use `pglab`, in the terminal, for example:

```sh
pglab
```
