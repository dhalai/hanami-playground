describe Users::Updater, type: :interactor do
  let(:password) { "encypted_password" }
  let(:encryptor_result) { OpenStruct.new(password: password) }
  let(:password_encryptor) { instance_double("Users::PasswordEncryptor", call: encryptor_result) }
  let(:interactor) do
    described_class.new(
      repository: repository,
      password_encryptor: password_encryptor
    )
  end
  let(:result) { interactor.call(params) }
  let(:user_params) do
    {
      email: "some@email.com",
      password: "some_password",
      role: "Admin"
    }
  end
  let(:params) { Hash[id: user_id, user: user_params] }

  context "valid input" do
    let(:repository) { instance_double("UserRepository", update: nil) }
    let(:user_id) { 1 }

    it "succeeds" do
      expect(result).to be_a_success
    end

    it "calls repository" do
      expect(repository).to receive(:update)
      result
    end
  end

  context "persistence" do
    let(:repository) { UserRepository.new }
    let!(:user) { repository.create(user_params) }
    let(:user_id) { user.id }

    after { repository.clear }

    it "save a User with correct data" do
      user_params.slice(:email, :role).each do |column, value|
        expect(result.user.send(column)).to eq value
      end

      expect(result.user.password).to eq password
    end
  end
end
