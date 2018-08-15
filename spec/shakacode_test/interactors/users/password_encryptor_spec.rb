describe Users::PasswordEncryptor, type: :interactor do
  let(:password) { "some_password" }

  it 'succeed' do
    expect(described_class.new.call(password).success?).to be true
  end

  it 'exposes password' do
    encryptor = described_class.new.call(password)
    expect(encryptor).to respond_to(:password)
  end

  it 'exposes not nil password' do
    encryptor = described_class.new.call(password)
    expect(encryptor.password).to_not be nil
  end

  it 'encryptes the original string' do
    encryptor = described_class.new.call(password)
    expect(encryptor.password.length).to_not eq password.length
  end

  it 'does not change the original string' do
    encryptor = described_class.new.call(password)
    expect(encryptor.password).to eq password
  end
end
