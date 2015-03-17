require 'jenkins_api_client'

module Test
  module Drive
    class JenkinsClient
      attr_accessor :client

      def initialize jenkins_url, user, api_key
        @server_url = jenkins_url
        @user = user
        @api_key = api_key

        @client = JenkinsApi::Client.new :server_url => jenkins_url,
                               :username => user,
                               :password => api_key,
                               :log_level => 1
      end

      def get_build_number(target_job, tracking_id, timeout_in_seconds, sleep_interval=10)
        (timeout_in_seconds/10).times do
          sleep sleep_interval
          build_details = @client.job.get_build_details(target_job, 0)
          if build_details['actions'][0]['parameters'].include?(tracking_id)
            return build_details['number']
          end
        end
        raise 'Build number not found within the time specified!'
      end

      def print_output(build_number, target_job, sleep_interval=5)
        offset = 0
        loop do
          job_output = @client.job.get_console_output(target_job, build_number, offset)

          print job_output['output']
          break unless job_output['more']

          offset = job_output['size']
          sleep sleep_interval
        end
      end

      def wait_for_job_status(target_job, build_number)
        loop do
          details = @client.job.get_build_details(target_job, build_number)
          return details['result'] if details['result']
          sleep 5
        end
      end

      def upload_file_to_job(target_job, tracking_id, path_to_file)
        res = `curl -i #{@server_url}/job/#{target_job}/build -F file0=@#{path_to_file} -F json='{"parameter": [{"name":"#{path_to_file}", "file":"file0"}, {"name":"TRACKING_ID", "value":"#{tracking_id}"}]}' --user '#{@user}':'#{@api_key}'`
        raise "Failed to send patch to Jenkins: \n#{res}" unless $? == 0
      end
    end
  end
end
