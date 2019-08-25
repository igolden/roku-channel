#!/bin/bash

cd videos
aws s3 sync . s3://roku-test-channel
cd ..
