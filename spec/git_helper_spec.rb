require 'test/drive'
include Test::Drive::GitHelper

describe 'GitHelper' do

  it 'fails to creates patch' do
    expect(self).to receive(:sh).and_return(64)

    expect { create_patch "temp-patch" }.to raise_error IOError
  end


end