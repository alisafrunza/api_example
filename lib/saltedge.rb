class Saltedge
  attr_reader :client_id, :service_secret

  def initialize
    @client_id        = ENV["CLIENT_ID"]
    @service_secret   = ENV["SERVICE_SECRET"]
  end

  def request(method, url, params={})
    hash = {
      method:     method,
      url:        url,
      params:     as_json(params)
    }

    result = RestClient::Request.execute(
      method:  hash[:method],
      url:     hash[:url],
      payload: hash[:params],
      headers: {
        "Accept"         => "application/json",
        "Content-type"   => "application/json",
        "Client-id"      => client_id,
        "Service-secret" => service_secret
      }
    )
    JSON.parse(result.body)["data"]
  end

private

  def as_json(params)
    return "" if params.empty?
    params.to_json
  end
end