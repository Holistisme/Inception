# Inception: the project that never gonna ricks you up!

This project aims to broaden knowledge of system administration by using Docker. We will virtualize several Docker images, creating them in a new personal virtual machine.

## All services included in this Inception:

### 1) NGINX

NGINX acts as the primary entry point for the infrastructure. It handles HTTPS traffic (port 443) and routes requests to the correct service—most notably WordPress, Adminer, your static site, and any additional backends you configure. By managing SSL/TLS certificates, NGINX secures all incoming connections before passing them to other containers over the internal Docker network.

Key Points:

- Terminates TLS, handling encryption/decryption.
- Proxies requests to upstream containers by name (e.g., wordpress, adminer).
- Redirects all HTTP (port 80) to HTTPS (port 443) for improved security.

### 2) MariaDB

MariaDB is the database server. It stores WordPress data (e.g., posts, user information) in a structured way. By default, it listens on port 3306.

Key Points:

- Provides relational database capabilities to WordPress.
- Utilizes a dedicated volume for data persistence.
- Typically accessed internally by containers on the same Docker network (e.g., wordpress, adminer).

### 3) WordPress

WordPress is the CMS (Content Management System) that runs the main site. It uses PHP-FPM to serve dynamic pages and communicates with the MariaDB database to store and retrieve content.

Key Points:

- Installed in a dedicated container with PHP-FPM.
- Connects to MariaDB for database operations.
- Leverages a shared volume for persistent site files (themes, plugins, uploads).

### 4) Redis

Redis is an in-memory data store used to cache WordPress data. Caching can speed up page loads by reducing database queries.

Key Points:

- Runs as a standalone container, storing data in memory.
- Protects access with a password (set via environment variables).
- Improves performance for WordPress when configured as a caching backend.

### 5) Adminer

Adminer is a lightweight database management tool, accessed through a web interface. It lets view and manipulate MariaDB databases without needing a separate client application.

Key Points:

- Accessible via a subpath in NGINX (e.g., https://<domain>/adminer/).
- Allows to log into MariaDB using credentials and perform administrative tasks (view tables, run queries, etc.).

### 6) FTP (vsftpd)

The FTP container allows file transfers to the WordPress site via the FTP protocol. By default, it exposes port 21 and a configurable range of passive ports.

Key Points:

- Lets upload and modify WordPress files (e.g., wp-content/uploads).
- Secured with SSL/TLS, so credentials are not sent in cleartext.
- Uses environment variables to set FTP user credentials and passive port configuration.

### 7) Static Site

This is an example of a non-PHP website hosted via NGINX, with TLS configured. It’s completely separate from WordPress, demonstrating how to serve additional static content.

Key Points:

- Runs in its own container, exposing HTTPS on a separate port (e.g., 444).
- Hosts static assets (HTML, CSS, JavaScript, images).
- Illustrates best practices for containerizing simple web projects.

### 8) Ricounter (Custom Node.js Service)

Ricounter is a custom Node.js/Express application that tracks a “Rickroll” counter. It responds with the current count each time it receives a request, incrementing the total and persisting that data in a file.

Key Points:

- Uses Node.js and Express, serving content over HTTPS with a self-signed certificate.
- Provides a simple /rickroll endpoint to increment the counter.
- Demonstrates how to integrate a custom service beyond the typical LEMP stack.

## A few theoretical notions:
### 1) How Docker and Docker Compose work

- Docker is a platform that uses containerization to package and run applications. It creates standardized, lightweight, and isolated environments (containers), each containing the necessary application files and dependencies. These containers share the host OS kernel but remain logically separated from one another.

- Docker Compose is a tool built on top of Docker that simplifies multi-container orchestration. Instead of running a series of Docker commands for each container, you describe all containers, networks, and volumes in a single docker-compose.yml file. One command (docker compose up) can then build, configure, and start all services at once.

### 2) The difference between an image created with and without Compose

- Without Docker Compose: You manually run docker build commands (or pull from Docker Hub). Each image is built separately, and you manage container networking, volumes, and startup sequences individually with multiple Docker CLI commands.

- With Docker Compose: You specify everything (images, build contexts, environment variables, networks, volumes) in a docker-compose.yml file. Compose can build and run multiple images/services together. It remembers their configurations (such as links, health checks, and restart policies) so that you don’t need to issue multiple separate commands.

In essence, the underlying images can be identical, but Compose automates and tracks relationships among multiple containers more conveniently.

### 3) The benefit of a Docker container compared to a VM

- Lightweight: Containers share the host OS kernel, so they start up faster and require fewer resources than Virtual Machines (VMs), which each include a full guest operating system.
- Efficiency: Because they’re smaller and have minimal overhead, containers let you run more services on the same hardware than an equivalent number of VMs.
- Portability: Docker containers run the same way across different machines, making it easier to move workloads between different environments (development, staging, production).
- Faster development cycle: Spinning up or tearing down containers is quick, supporting rapid testing and deployment workflows.

### 4) The relevance of the project’s proposed structure

The project’s directory and service structure enforces clear separation of concerns:

- Each service (NGINX, WordPress, MariaDB, Redis, etc.) lives in its own container and has its own Dockerfile.
- Volumes are dedicated for persistent data (database files, WordPress content, etc.), avoiding data loss when containers are recreated.
- Environment variables and .env files keep secrets and configurations isolated, reducing the risk of exposing credentials.
- A single docker-compose.yml orchestrates all services, ensuring a maintainable setup where services can communicate via an internal Docker network.

Overall, it’s designed to teach best practices in containerized infrastructures—demonstrating how to keep services modular, cleanly configurable, and easily transportable.

### 5) Explanation of the Docker network

When you define services in a docker-compose.yml, Docker sets up a virtual network (usually a bridge network):

- Containers on this network can reach each other by container name (e.g., wordpress, mariadb) instead of by IP.
- Isolation: By default, containers in that network are not directly reachable from external networks unless you explicitly expose or publish ports.
- Communication: Each service references the other services via these container names. For instance, WordPress connects to mariadb by DNS name mariadb on the internal Docker network, rather than an IP address.

This network architecture reduces conflict with the host machine’s environment, simplifies service discovery, and promotes a microservices style approach where each container runs one discrete part of the stack.
