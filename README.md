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
make local-client
```

To run the mole server, run;

```
make local-server
```

> Both commands assume you have docker installed on your machine
