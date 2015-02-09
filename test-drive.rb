#! /usr/bin/env ruby

require 'jenkins_api_client'
require 'uuidtools'
require 'artii'
require 'rainbow'

COLORS = [
    :red,
    :green,
    :yellow,
    :blue,
    :magenta,
    :cyan,
    :white
]

def jenkins_url
  '***REMOVED***'
end

def username
  '***REMOVED***'
end

def api_key
  '***REMOVED***'
end

@target_job = '***REMOVED***'

def get_build_number(id_param, timeout_in_seconds)
  (timeout_in_seconds/10).times do
    sleep 10
    if @client.job.get_build_details(@target_job, 0)['actions'][0]['parameters'].include?(id_param)
      return @client.job.get_current_build_number @target_job
    end
  end
end

def print_jenkins_output(build, offset)
  loop do
    job_output = @client.job.get_console_output(@target_job, build, offset)

    print job_output['output']
    break unless job_output['more']

    offset = job_output['size']
  end

  @client.job.get_build_details(@target_job, build)['result']
end

def start_test_driving(tracking_id)
  res = `curl -i #{jenkins_url}/job/#{@target_job}/build -F file0=@patch -F json='{"parameter": [{"name":"patch", "file":"file0"}, {"name":"TRACKING_ID", "value":"#{tracking_id}"}]}' --user '#{username}':'#{api_key}'`
  raise "Failed to send patch to Jenkins: \n#{res}" unless $? == 0
end

debug = false

def create_patch
  `git pull --rebase && git diff --binary origin > patch`
  unless $? == 0
    raise 'Failed to create patch'
  end
end

def rainbowize(string)
  rainbow_string = ''
  string.length.times { |i| rainbow_string << Rainbow(string[i]).color(COLORS[i % COLORS.length]) }
  rainbow_string
end

# repo_name = `basename $(git remote show -n origin | grep Fetch | cut -d: -f2-)`.split('.').first

@client = JenkinsApi::Client.new :server_url => jenkins_url,
                                 :username => username,
                                 :password => api_key,
                                 :log_level => 1


create_patch

if debug
  puts File.readlines File.open 'patch'
end

tracking_id = UUIDTools::UUID.random_create.to_s
id_param = {'name' => 'TRACKING_ID', 'value' => tracking_id}
offset = 0

start_test_driving(tracking_id)

build = get_build_number(id_param, 120)

result = print_jenkins_output(build, offset)

if result == 'SUCCESS' || result == 'UNSTABLE'
  puts rainbowize '*********************************************************************************************************************************************'
  puts rainbowize Artii::Base.new(font: 'slant').asciify('T E S T - D R I V E N .')
  puts rainbowize '*********************************************************************************************************************************************'

  # `git push origin master`
else
  puts Rainbow(Artii::Base.new.asciify result).red
end

`rm patch`
