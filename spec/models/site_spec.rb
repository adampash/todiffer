require 'rails_helper'

RSpec.describe Site, type: :model do
  it "extracts domain (including subdomain) from urls" do
    url = "http://gawker.com/sjwiojsdf"
    domain = Site.get_domain(url)
    expect(domain).to eq 'gawker.com'

    url = "http://dog.gawker.com/sjwiojsdf"
    domain = Site.get_domain(url)
    expect(domain).to eq 'dog.gawker.com'

    url = "http://foo.gawker-labs.com/sjwiojsdf"
    domain = Site.get_domain(url)
    expect(domain).to eq 'foo.gawker-labs.com'

    url = "ftps://1235.gawker_labs1.com/sjwiojsdf"
    domain = Site.get_domain(url)
    expect(domain).to eq '1235.gawker_labs1.com'

    url = "https://www.nytimes.com/sjwiojsdf"
    domain = Site.get_domain(url)
    expect(domain).to eq 'nytimes.com'
  end
end
