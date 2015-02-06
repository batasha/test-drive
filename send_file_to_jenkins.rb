#! /usr/bin/env ruby

require 'jenkins_api_client'
require 'uuidtools'

@client = JenkinsApi::Client.new :server_url => '***REMOVED***',
                                  :username => '***REMOVED***',
                                  :password => '***REMOVED***',
                                  :log_level => 1

tracking_id = UUIDTools::UUID.random_create.to_s
id_param = {'name' => 'TRACKING_ID', 'value' => tracking_id}
build = 0
start = 0

res = `curl -i ***REMOVED***/job/***REMOVED***/build -F file0=@patch -F json='{"parameter": [{"name":"patch", "file":"file0"}, {"name":"TRACKING_ID", "value":"#{tracking_id}"}]}' --user '***REMOVED***':'***REMOVED***'`


12.times do
  sleep 10
  if @client.job.get_build_details('***REMOVED***', 0)['actions'][0]['parameters'].include?(id_param)
    build = @client.job.get_current_build_number '***REMOVED***'
    break
  end
end

loop do
  job_output = @client.job.get_console_output('***REMOVED***', build, start)

  print job_output['output']
  break unless job_output['more']

  start = job_output['size']
end

result = @client.job.get_build_details('***REMOVED***', build)['result']

# `git push origin master` if result == 'SUCCESS' || result == 'UNSTABLE'
`rm patch`
