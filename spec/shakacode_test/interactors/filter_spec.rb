describe Filter, type: :interactor do
  let(:relation) { instance_double("UserRelation") }
  let(:relations) { [[:relation_name, relation]] }
  let(:filtered_relation) { :filtered_relation }
  let(:repository) do
    instance_double(
      "UserRepository",
      relations: relations,
      filter_by_email: filtered_relation
    )
  end

  let(:filters) do
    {
      email: "some_email",
      unexistent_filter: "unexistent_filter",
      empty_filter: "",
      another_empty_filter: []
    }
  end

  let(:params) do
    {
      repository: repository,
      filters: filters
    }
  end

  let(:result) { described_class.new.call(params) }

  it "succeeds" do
    expect(result).to be_a_success
  end

  it "exposes relation" do
    expect(result).to respond_to(:relation)
  end

  it "expose right relation" do
    expect(result.relation).to eq filtered_relation
  end
end
