require 'features_helper'

describe 'Visit home page' do
  it 'is successfull' do
    visit '/'

    expect(page.body).to include('Hello world!')
  end
end
