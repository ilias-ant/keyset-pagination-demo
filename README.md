# keyset-pagination-demo
A nit comparison between offset-based pagination and keyset pagination.

```bash
docker compose up
```

```bash
docker compose exec -it db bash
```

```bash
psql --username postgres --dbname demo-db -c "select * from populate_tables(1000000);";
```

```bash
pgbench -i -U postgres demo-db
```

```bash
pgbench -f /var/lib/postgresql/scripts/pg_bench_offset.sql --log --transactions=100 --username=postgres demo-db
```

```bash
pgbench -f /var/lib/postgresql/scripts/pg_bench_keyset.sql --log --transactions=100 --username=postgres demo-db
```