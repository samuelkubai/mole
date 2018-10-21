# Mole (Your friendly tunnel borer)

## Development

To develop and contribute for the mole project here are the various commands to run to start the various apps on the mole project.

First go to the root of the application

```
cd <projet-location>/mole
```

Create a network for the _mole_ local environment

```
docker network create -d bridge mole-local-network
```

> We need both environments to use the same network to be able to create a tunnel to each other.

To run the mole client, run;

```
// Start the mole client
make local-client

// Access the mole client environment
make client-ssh

// Run the mole client commands
../../bin/client [COMMAND]
```

To run the mole server, run;

```
make local-server
```

> Both commands assume you have docker installed on your machine
