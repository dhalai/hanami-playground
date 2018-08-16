describe Paginator, type: :interactor do
  let(:per_page) { 10 }
  let(:items) { [{}, {}] }
  let(:items_count) { items.count }
  let(:offset) { instance_double("UserRelation", to_a: items) }
  let(:limit) { instance_double("UserRelation", offset: offset) }
  let(:relation) do
    instance_double("UserRelation", count: items_count, limit: limit)
  end

  let(:params) do
    {
      relation: relation,
      page: 1,
      params: OpenStruct.new(env: { "REQUEST_PATH" => "some_path" })
    }
  end

  let(:result) { described_class.new(limit: per_page).call(params) }

  it "succeeds" do
    expect(result).to be_a_success
  end

  it "exposes right params" do
    expect(result).to respond_to(:result)
    expect(result).to respond_to(:pagination)
  end

  it "has right result" do
    expect(result.result).to eq items
  end
end
