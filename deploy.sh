#!/bin/bash

kubectl create ns technical-test
kubectl apply -f deploy.yaml -n technical-test


