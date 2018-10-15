RSpec.describe Bowtie::ApiAdapter do
  it "has a version number" do
    expect(Bowtie::ApiAdapter::VERSION).not_to be nil
  end

  it "performs all API functions" do
    api = Bowtie::ApiAdapter.new(base_url: "https://jsonplaceholder.typicode.com/")
    expect(api.get path: "posts").not_to be nil
    expect(api.post path: "posts").not_to be nil
    expect(api.patch path: "posts/1").not_to be nil
    expect(api.put path: "posts/1").not_to be nil
    expect(api.delete path: "posts/1").not_to be nil
  end
end
