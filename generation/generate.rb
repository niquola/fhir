#!/usr/bin/env ruby

require_relative 'generate_types'
require_relative 'generate_resources'

generate_types
generate_resources
