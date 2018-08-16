describe Web::Controllers::Sessions::Create, type: :action do
  let(:action) { described_class.new }
  let(:messages) { [] }
  let(:output) { {} }
  let(:validation_result) do
    OpenStruct.new(
      success?: success,
      messages: messages,
      output: output
    )
  end
  let(:validator_instance) do
    instance_double("CreateSessionValidator", validate: validation_result)
  end

  before do
    allow(CreateSessionValidator).to receive(:new).and_return(validator_instance)
  end

  context 'with valid params' do
    let(:success) { true }
    let(:output) { Hash[session: { email: user_params[:email] }] }
    let(:repository) { UserRepository.new }

    let(:user_params) do
      {
        email: "some@email.com",
        password: "some_password",
        role: "admin"
      }
    end

    let(:params) { { session: user_params.slice(:email, :password) } }
    let!(:user) { repository.create(user_params) }

    after { repository.clear }

    it 'redirects the user to the home page' do
      response = action.call(params)

      expect(response[0]).to eq 302
      expect(response[1]['Location']).to eq '/'
    end

    it 'exposes right params' do
      action.call(params)
      expect(action.exposures[:form_errors]).to be_nil
    end
  end

  context 'with invalid params' do
    let(:success) { false }
    let(:params) { Hash[session: {}] }
    let(:messages) { [{ some: :error }] }

    it 'returns errors' do
      response = action.call(params)
      expect(response[0]).to eq 422
    end

    it 'exposes errors' do
      action.call(params)
      expect(action.form_errors).to_not be_empty
    end
  end
end
