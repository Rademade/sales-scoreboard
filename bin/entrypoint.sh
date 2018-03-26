#!/bin/sh

rm -rf ./static/*
cp -R ./public/* ./static/

bundle exec puma -C config/puma.rb
