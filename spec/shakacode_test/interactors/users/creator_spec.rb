describe Users::Creator, type: :interactor do
  let(:user_params) do
    {
      email: "some@email.com",
      password: "some_password",
      role: "Admin"
    }
  end

  let(:interactor) { described_class.new(repository: repository) }
  let(:result) { interactor.call(user_params) }

  context "valid input" do
    let(:repository) { instance_double("UserRepository", create: nil) }

    it "succeeds" do
      expect(result).to be_a_success
    end

    it "calls repository" do
      expect(repository).to receive(:create)
      result
    end
  end

  context "persistence" do
    let(:repository) { UserRepository.new }
    after { repository.clear }

    it "save a User with correct data" do
      user_params.slice(:email, :role).each do |column, value|
        expect(result.user.send(column)).to eq value
      end
    end
  end
end
