# Test::Drive

[![Gem Version](http://img.shields.io/gem/v/test-drive.svg)][gem]
[![Build Status](http://img.shields.io/travis/amplify-education/test-drive.svg)][travis]
[![Dependency Status](http://img.shields.io/gemnasium/amplify-education/test-drive.svg)][gemnasium]
[![Code Climate](http://img.shields.io/codeclimate/github/amplify-education/test-drive/badges/gpa.svg)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/amplify-education/test-drive/badge.svg)][testcoverage]

[gem]: https://rubygems.org/gems/test-drive
[travis]: http://travis-ci.org/amplify-education/test-drive
[gemnasium]: https://gemnasium.com/amplify-education/test-drive
[codeclimate]: https://codeclimate.com/github/amplify-education/test-drive
[testcoverage]: https://coveralls.io/r/amplify-education/test-drive

A simple command-line tool for running a Jenkins test job before pushing code to a remote repo

## Installation

    $ gem install test-drive

## Usage

    $ test-drive -h
    
    Usage: test-drive [options]
    
    A simple command-line tool for running a Jenkins test job before pushing code to a remote repo
    
    v0.0.3
    
    Options:
        -h, --help                       Show command line help
        -s, --server JENKINS_URL         URL for the Jenkins server
        -u, --user USER                  Jenkins user ID
        -p, --password API_KEY           Jenkins password or API token
        -j, --job TARGET_JOB             Jenkins job to be triggered
        -n, --[no-]push                  Option to enable (or suppress) pushing to the remote repo
            --version                    Show help/version info
            --log-level LEVEL            Set the logging level
                                         (debug|info|warn|error|fatal)
                                         (Default: info)
    
    Default values can be placed in ~/.test-drive.yml

## Jenkins Config

This app assumes that you have a Jenkins job already configured as follows:

* It takes a file parameter called 'patch'
* It pulls or your source code from origin/master and executes a shell command that runs


      echo "" >> ${WORKSPACE}/patch
      git apply ${WORKSPACE}/patch

* It then executes your desired test suite and runs


      git apply --reverse ${WORKSPACE}/patch

  to teardown (optional but recommended)

## Local Config

On first run, you will have the option of saving your Jenkins credentials to a config 
file at `~/.test-drive.yml`. This file may be edited to include any of the allowed 
options as defaults.

    ---
    server: https://jenkins.your_org.com/
    user: user@your_org.com
    password: xxxxxxxxxxxxxxxxxxxxxxxxx
    job: YourDefaultJob
    push: false

## Contributing

1. Fork it ( https://github.com/[my-github-username]/test-drive/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
