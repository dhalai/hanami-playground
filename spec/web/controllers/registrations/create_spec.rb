describe Web::Controllers::Registrations::Create, type: :action do
  let(:params) { Hash[] }
  let(:interactor_result) { OpenStruct.new(user: user) }
  let(:interactor) { instance_double("Users::Creator", call: interactor_result) }
  let(:action) { described_class.new(interactor: interactor) }
  let(:user) do
    OpenStruct.new(
      email: "some@email.com",
      password: "some_password"
    )
  end

  let(:success) { true }
  let(:messages) { [] }

  let(:validation_result) do
    OpenStruct.new(
      success?: success,
      messages: messages,
      output: Hash[user: user.to_h]
    )
  end

  let(:validator_instance) do
    instance_double("CreateUserValidator", validate: validation_result)
  end

  before do
    allow(RegistrationUserValidator).to receive(:new).and_return(validator_instance)
  end

  context 'with valid params' do
    let(:success) { true }
    let(:messages) { [] }

    it 'calls interactor' do
      expect(interactor).to receive(:call)
      action.call(params)
    end

    it 'redirects to the root page' do
      response = action.call(params)

      expect(response[0]).to eq 302
      expect(response[1]['Location']).to eq '/'
    end
  end

  context 'with invalid params' do
    let(:success) { false }
    let(:messages) { [{ some: :error }] }

    it 'returns error' do
      response = action.call(params)
      expect(response[0]).to eq 422
    end

    it 'does not call interactor' do
      expect(interactor).to_not receive(:call)
      action.call(params)
    end

    it 'exposes errors' do
      action.call(params)
      expect(action.form_errors).to_not be_empty
    end
  end
end
