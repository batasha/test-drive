#! /usr/bin/env ruby

repo_name = `basename $(git remote show -n origin | grep Fetch | cut -d: -f2-)`.split('.').first

`git pr && git diff origin > patch`

patch_file = File.open 'patch'

puts File.readlines patch_file