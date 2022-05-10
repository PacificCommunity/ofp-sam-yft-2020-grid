#!/bin/bash

tar -xzf Start.tar.gz
./condor_doitall.sh
tar -czf End.tar.gz --exclude '*.tar.gz' *
