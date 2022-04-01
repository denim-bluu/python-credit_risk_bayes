#!/bin/bash

mkdir data/
curl https://www.openml.org/data/get_csv/31/dataset_31_credit-g.csv \
    -o data/german_credit_risk_data.csv
