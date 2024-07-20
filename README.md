# Quick Dev Setups

This project provides tools to simplify the process of setting up a development environment for developers. With these tools, you can easily configure essential software and utilities, ensuring a smooth and efficient workflow.

## Project Structure

```
QUICK-DEV-SETUPS [GITHUB]
│
├── dev-stacks
│   ├── docker-entrypoint-initdb.d
│   ├── docker-compose.yaml
│   ├── pgadmin-servers.json
│
└── podman/windows
|    ├── windows-podman-installer.ps1
|
└── docker/macOS 
│
└── README.md
```

## Setup Podman, Podman Desktop, and Podman Compose

Follow these steps to set up Podman, Podman Desktop, and Podman Compose on your Windows machine:

1. Open PowerShell as an Administrator.
2. Execute the installation script:
   ```powershell
   .\podman\windows\windows-podman-installer.ps1
   ```
3. Podman Desktop App (UI) can be opened to validate it. 


## Setup Docker/Podman Compose for Development Tools

This section provides a `docker-compose.yaml` file to set up a development environment with various tools and services. These services include Zookeeper, Kafka, Schema Registry, Kafka UI, ActiveMQ, IBM MQ, PostgreSQL, PgAdmin, Redis, and Redis Insight.

### Services Overview

- **Zookeeper**: Coordinates and manages the Kafka cluster.
- **Kafka**: Distributed event streaming platform.
- **Schema Registry**: Centralized repository for managing and enforcing schemas.
- **Kafka UI**: Web UI for managing Kafka clusters.
- **Schema Registry UI**: Web UI for managing schemas in the Schema Registry.
- **ActiveMQ**: Open-source message broker.
- **IBM MQ**: Enterprise-grade message broker.
- **PostgreSQL**: Open-source relational database.
- **PgAdmin**: Web-based interface for managing PostgreSQL databases.
- **Redis**: In-memory data structure store.
- **Redis Insight**: Web UI for managing Redis databases.

### How to Use

1. **Clone the repository**:
   ```bash
   git clone <repository_url>
   cd <repository_directory>
   ```

2. **Start the services**:

   Docker: 
   ```bash
   docker-compose up -d
   ```

   Podman:
   ```bash
   podman-compose -f docker-compose.yaml up
   ```

3. **Access the services**:

   - **Zookeeper**: `localhost:2181`
   - **Kafka**: `localhost:9092`
   - **Schema Registry**: `localhost:8081`
   - **Kafka UI**: `http://localhost:8080`
   - **Schema Registry UI**: `http://localhost:8000`
   - **ActiveMQ**: `http://localhost:8161`
   - **IBM MQ**: `https://localhost:9443`
   - **PostgreSQL**: `localhost:5432`
   - **PgAdmin**: `http://localhost:5050`
   - **Redis**: `localhost:6379`
   - **Redis Insight**: `http://localhost:5540`

4. **Stop the services**:
   ```bash
   docker-compose down
   ```

   ```bash
   podman-compose -f docker-compose.yaml down
   ```

## Setup Docker and K8s for macOS

This project have necessary scripts to be able to setup Docker Community Edition and K8s on MacOS

1. Follow [text](docker/macOS/readme.md)

## Note: 
Feel free to adjust the README content as per your project's specific details and requirements.
