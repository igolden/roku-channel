#!/bin/bash

rm dist.zip

cd app

zip -r dist.zip .

cd .. && mv app/dist.zip .
