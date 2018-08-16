describe Web::Controllers::Registrations::New, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end

  it 'exposes right params' do
    action.call(params)
    expect(action.exposures[:form_errors]).to be_nil
  end

  context 'signed in' do
    let(:user) { "some_user" }

    before { sign_in user }

    it 'redirects to the root page' do
      response = action.call(params)
      expect(response[0]).to eq 302
      expect(response[1]['Location']).to eq '/'
    end
  end
end
