#!/bin/bash

tar -xzf Start.tar.gz
./doitall.condor
tar -czf End.tar.gz --exclude '*.tar.gz' *
