# Transport Deluxe

## Port Index

| Port | Service |
|------|---------|
| 8000 | Casdoor (Identity Provider / OAuth 2.0) |

## Authentication

Casdoor is the identity provider for this project. The admin console is available at `http://localhost:8000`.

Default admin credentials (change after first login):
- **Username**: `admin`
- **Password**: `123`

### Get a Test Token

Use the CLI script to generate a JWT for any role:

```bash
python scripts/get_token.py cost-configurator
python scripts/get_token.py margin-configurator
python scripts/get_token.py predictor
```

The JWT is printed to stdout. Requires `httpx`: `pip install httpx`.
