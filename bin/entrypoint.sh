#!/bin/sh

rm -rf ./static/*
cp -R ./public/* ./static/

bundle exec rake assets:precompile
bundle exec puma -C config/puma.rb
