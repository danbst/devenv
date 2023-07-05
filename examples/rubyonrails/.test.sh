#!/bin/sh
set -ex
rails new blog -d=postgresql
devenv up&
timeout 20 bash -c 'until echo > /dev/tcp/localhost/5100; do sleep 0.5; done'
pushd blog
    rails db:create
popd
curl -s http://localhost:5100/ | grep "version"