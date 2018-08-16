describe Web::Controllers::Users::Destroy, type: :action do
  let(:params) { Hash[] }
  let(:found_user) { user }
  let(:repository) do
    instance_double("UserRepository", find: found_user, delete: true)
  end
  let(:action) { described_class.new(repository: repository) }

  let(:user) do
    OpenStruct.new(
      email: "some@email.com",
      password: "some_password",
      role: role,
      admin?: role == "admin"
    )
  end

  let(:id_validation_success) { true }
  let(:id_validator_result) { OpenStruct.new(success?: id_validation_success) }

  let(:id_validator_instance) do
    instance_double("IdValidator", validate: id_validator_result)
  end

  before do
    allow(IdValidator).to receive(:new).and_return(id_validator_instance)
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

      it 'redirects to the user list' do
        response = action.call(params)
        expect(response[0]).to eq 302
        expect(response[1]['Location']).to eq '/users'
      end
    end

    context "with valid id param" do
      let(:id_validation_success) { true }

      context "with nonexistent user" do
        let(:found_user) { nil }

        it 'redirects to the user list' do
          response = action.call(params)
          expect(response[0]).to eq 302
          expect(response[1]['Location']).to eq '/users'
        end
      end

      context "with existent user" do
        it 'deletes the user' do
          expect(repository).to receive(:delete)
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
