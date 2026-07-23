# Local development services

## Setup

1. Copy `.env.example` to `.env` in this directory.
2. Set `POSTGRES_PASSWORD` and `REDIS_PASSWORD` to long, unique local-development passwords.
3. From the repository root, start the stack with:

   ```text
   docker compose --env-file services/.env -f services/compose.yml up -d
   ```

The same command works in PowerShell, WSL, and macOS terminals. The explicit
`--env-file` avoids depending on the directory from which Compose is invoked.

`services/.env` is ignored by Git and is only intended for local development.
It is not encrypted, so do not reuse production credentials in it or commit it.

All published service ports bind to `127.0.0.1`, making them accessible from
this computer only rather than from other devices on the local network.
