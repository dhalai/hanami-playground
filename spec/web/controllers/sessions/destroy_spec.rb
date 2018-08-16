describe Web::Controllers::Sessions::Destroy, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'redirects to the log in page' do
    response = action.call(params)
    expect(response[0]).to eq 302
    expect(response[1]['Location']).to eq '/sessions/new'
  end
end
