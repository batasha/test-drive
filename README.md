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

A simple command-line tool for running a Jenkins test job before pushing code to the remote repo

## Installation

    $ gem install test-drive

## Usage

    $ test-drive --help
    Usage: test-drive [options] jenkins_url user api_key
    
    A simple command-line tool for running a Jenkins test job before pushing code to the remote repo
    
    v0.0.1
    
    Options:
        -h, --help                       Show command line help
        -f, --file PATCH_FILE            Path to patch file
                                         (default: patch)
        -j, --target-job TARGET_JOB      Jenkins job to be triggered
                                         (default: TestDrive)
            --version                    Show help/version info
            --log-level LEVEL            Set the logging level
                                         (debug|info|warn|error|fatal)
                                         (Default: info)
    
    Arguments:
    
        jenkins_url
            URL for the Jenkins server
        user
            Jenkins user ID
        api_key
            Jenkins API token

## Contributing

1. Fork it ( https://github.com/[my-github-username]/test-drive/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
