RSpec.describe Web::Controllers::Users::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:repository) { UserRepository.new }

  let(:user_params) do
    {
      email: SecureRandom.hex,
      password: SecureRandom.hex,
      role: "admin"
    }
  end

  let!(:user) { repository.create(user_params) }

  after { repository.clear }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end

  it 'exposes all users' do
    action.call(params)
    expect(action.exposures[:users]).to eq [user]
  end
end
