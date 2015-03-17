require 'spec_helper'
require 'json'
include Test::Drive

describe 'JenkinsClient' do

  build_details = JSON.parse(File.read 'spec/fixtures/build_details.json')
  output1 = JSON.parse(File.read 'spec/fixtures/console_output1.json')
  output2 = JSON.parse(File.read 'spec/fixtures/console_output2.json')

  let(:test_client) {
    test_client = JenkinsClient.new '0.0.0.0', 'user', 'api_key'
    test_client.client = instance_double JenkinsApi::Client, job: double(JenkinsApi::Client::Job)
    allow(test_client.client.job).to receive(:get_build_details).and_return(build_details)
    allow(test_client.client.job).to receive(:get_console_output).and_return(output1, output2)
    test_client
  }

  describe '#new' do
    it 'creates a new Jenkins client' do
      expect(test_client).to be_an_instance_of JenkinsClient
    end
  end

  describe '#get_build_number' do
    it 'returns build number' do
      id_hash = {'name' => 'TRACKING_ID', 'value' => 'ab301010-0368-4440-88d4-4da91641d46f'}
      build_number = test_client.get_build_number 'TestDrive', id_hash, 10, 0
      expect(build_number).to eq 60
    end

    it 'raises an error if job is not found' do
      id_hash = {'name' => 'TRACKING_ID', 'value' => 'xxxxxxxx'}
      expect { test_client.get_build_number 'TestDrive', id_hash, 10, 0 }.to raise_error
    end
  end

  describe '#print_output' do
    it 'prints Jenkins progressive console output to the terminal' do
      expected_output = "Test Console Output\r\nStarted by user Test User\r\nFinished: SUCCESS\r\n"
      expect { test_client.print_output 'TestDrive', 1, 0 }.to output(expected_output).to_stdout
    end
  end

  describe '#wait_for_job_status' do
    it 'returns the build result' do
      build_result = test_client.wait_for_job_status 'TestDrive', 10
      expect(build_result).to eq 'SUCCESS'
    end
  end
end
