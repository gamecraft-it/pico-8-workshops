import? 'pico-8-carts.just'

help:
  just --list

# Fetch pico-8-carts.just
fetch:
  curl https://raw.githubusercontent.com/micktwomey/pico-8-carts-justfile/refs/heads/main/justfile > pico-8-carts.just
