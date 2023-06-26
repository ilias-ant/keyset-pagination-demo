# keyset-pagination-demo
A nit comparison between offset-based pagination and keyset pagination.

## Setup

Spin up a PostgreSQL instance with:

```bash
docker compose up -d
```

Then, open a bash shell inside the running db container with:

```bash
docker compose exec -it db bash
```

and run the following commands to perform a benchmark comparison between offset-based pagination and keyset pagination, 
with 10 million rows as a testbed and 100 iterations for the benchmarking:

```bash
# -n: number of rows to insert
# -i: number of benchmarking iterations
sh /var/lib/postgresql/scripts/run.sh \
-n 10000000 \
-i 100
```

Feel free to change `-n` and `-i` values to your liking.
