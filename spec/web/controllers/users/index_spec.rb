describe Web::Controllers::Users::Index, type: :action do
  let(:params) { Hash[] }
  let(:relation) { instance_double("UsersRelation") }
  let(:paginator_result) { Hash[] }
  let(:paginator) { instance_double("Paginator", call: paginator_result) }
  let(:action) do
    described_class.new(relation: relation, paginator: paginator)
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end

  it 'exposes paginator' do
    action.call(params)
    expect(action.exposures[:paginator]).to eq paginator_result
  end
end
