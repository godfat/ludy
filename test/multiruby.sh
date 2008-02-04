#!/bin/sh
multiruby -e 'require "rubygems"; require "rake"; Rake.application.run' test
