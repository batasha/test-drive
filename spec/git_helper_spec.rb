require 'test/drive'
include Test::Drive::GitHelper

describe 'GitHelper' do
  describe '#create_patch' do
    it 'raises an error when patch is not generated' do
      expect(self).to receive(:sh).and_return(64)
      expect { create_patch "temp-patch" }.to raise_error IOError
    end
  end
end