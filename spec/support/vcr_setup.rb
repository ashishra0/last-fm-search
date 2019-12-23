class VCR::Cassette
  def sanitized_name
    name.to_s.gsub(/[^w\-\/]+/, '_').downcase
  end
end

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options = {record: :once, match_requests_on: %i[method query uri body]}
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
end