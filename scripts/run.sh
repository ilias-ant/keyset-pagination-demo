#!/bin/bash

while getopts n:i: flag
do
    case "${flag}" in
        n) numrows=${OPTARG};;
        i) iterations=${OPTARG};;
    esac
done

DBUSER="postgres"
DBNAME="demo-db"

echo "-----------------------------"
echo "number of rows: $numrows";
echo "iterations: $iterations";
echo "-----------------------------"

echo "populating tables..."
psql --username $DBUSER --dbname $DBNAME -c "select * from populate_tables($numrows);";

echo "setting up pgbench..."
pgbench -i -U $DBUSER $DBNAME

echo "running benchmark for keyset case..."
pgbench \
-f /var/lib/postgresql/scripts/pg_bench_keyset.sql \
--log \
--transactions=$iterations \
--username=$DBUSER $DBNAME

echo "running benchmark for offset case..."
pgbench \
-f /var/lib/postgresql/scripts/pg_bench_offset.sql \
--log \
--transactions=$iterations \
--username=$DBUSER $DBNAME

echo "experiment completed."