#!/usr/bin/env bash

function removeContainer() {
  local name=$1
  if [[ -z "$name" ]]; then return 1; fi

  docker stop "$name" && docker rm "$name"
  return 0
}

function removeDefaultContainers() {
  removeContainer 'nginx-proxy'
  removeContainer 'ghost-blog'
}

function addGhostBlog() {
  local name=$1
  local host=$2
  if [[ -z "$name" || -z "$host" ]]; then return 1; fi

  docker run -d -v ~/ghost-data/$name:/var/lib/ghost -e VIRTUAL_HOST=$host -e NODE_ENV=production --name $name ghost
  return 0
}
