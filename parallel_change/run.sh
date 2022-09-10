#!/usr/bin/env bash

rspec ./*_spec.rb &&
  ruby ./authentication_service.rb &&
  ruby ./shopping_cart.rb
