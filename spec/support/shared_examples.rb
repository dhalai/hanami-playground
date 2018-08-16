shared_examples "protected resource" do
  it 'redirects to the root page' do
    response = action.call(params)

    expect(response[0]).to eq 302
    expect(response[1]['Location']).to eq '/'
  end
end

shared_examples "protected page" do
  it 'redirects to the root page' do
    expect(current_path).to eq('/')
  end
end
