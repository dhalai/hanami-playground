describe IdValidator, type: :validator do
  subject { described_class.new(params) }

  context 'with valid params' do
    let(:params) { { id: "1" } }

    it 'is valid' do
      expect(subject.validate.success?).to be true
    end
  end

  context 'with invalid params' do
    let(:params) { {} }

    it 'is invalid' do
      expect(subject.validate.success?).to be false
    end
  end
end
