describe Web::Controllers::Users::Update, type: :action do
  let(:params) { Hash[] }
  let(:existent_user) { user }
  let(:repository) { instance_double("UserRepository", find: existent_user) }
  let(:interactor) { instance_double("Users::Updater", call: nil) }
  let(:action) do
    described_class.new(
      repository: repository,
      interactor: interactor
    )
  end

  let(:user) do
    OpenStruct.new(
      id: 1,
      email: "some@email.com",
      password: "some_password",
      role: role,
      admin?: role == "admin"
    )
  end

  let(:success) { true }
  let(:messages) { [] }
  let(:validation_result) do
    OpenStruct.new(
      success?: success,
      messages: messages
    )
  end

  let(:validator_instance) do
    instance_double("CreateUserValidator", validate: validation_result)
  end

  let(:id_validation_success) { true }
  let(:id_validator_result) { OpenStruct.new(success?: id_validation_success) }

  let(:id_validator_instance) do
    instance_double("IdValidator", validate: id_validator_result)
  end

  before do
    allow(IdValidator).to receive(:new).and_return(id_validator_instance)
    allow(CreateUserValidator).to receive(:new).and_return(validator_instance)
    sign_in user
  end

  context "as user" do
    let(:role) { "user" }
    it_behaves_like "protected resource"
  end

  context "as admin" do
    let(:role) { "admin" }

    context "with invalid id param" do
      let(:id_validation_success) { false }

      it 'redirects the user to the users listing' do
        response = action.call(params)

        expect(response[0]).to eq 302
        expect(response[1]['Location']).to eq '/users'
      end

      it 'does not call interactor' do
        expect(interactor).to_not receive(:call)
        action.call(params)
      end
    end

    context "with valid id param" do
      let(:id_validation_success) { true }

      context "with nonexistent user" do
        let(:existent_user) { nil }

        it 'does not calls interactor' do
          expect(interactor).to_not receive(:call)
          action.call(params)
        end

        it 'redirects the user to the users listing' do
          response = action.call(params)

          expect(response[0]).to eq 302
          expect(response[1]['Location']).to eq '/users'
        end
      end

      context "with existent user" do
        let(:existent_user) { user }

        context "with invalid user params" do
          let(:success) { false }
          let(:messages) { [{ some: :error }] }

          it 'redirects the user to the users listing' do
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

        context "with valid user params" do
          let(:success) { true }
          let(:messages) { [] }

          it 'calls interactor' do
            expect(interactor).to receive(:call)
            action.call(params)
          end

          it 'redirects the user to the users listing' do
            response = action.call(params)

            expect(response[0]).to eq 302
            expect(response[1]['Location']).to eq '/users'
          end
        end
      end
    end
  end
end
