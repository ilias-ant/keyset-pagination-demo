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

and run the following command to perform a benchmark comparison between offset-based pagination and keyset pagination, 
with 10 million rows as a testbed and 100 iterations for the benchmarking:

```bash
# -n: number of rows to insert
# -i: number of benchmarking iterations
sh /var/lib/postgresql/scripts/run.sh \
-n 10000000 \
-i 100
```

Feel free to change `-n` and `-i` values to your liking.

# Notes

- `db/init.sql` has been created by prompting [chatGPT](https://en.wikipedia.org/wiki/ChatGPT) (out of boredom), 
so `populate_tables` function may not be optimal.
- [pgbench](https://www.postgresql.org/docs/current/pgbench.html), a simple program for running benchmark tests on 
PostgreSQL, is used for the benchmarking.
- `results/` contain the original benchmarking experiments.

