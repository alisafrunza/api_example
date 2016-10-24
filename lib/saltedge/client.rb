class Saltedge::Client
  def initialize
    @root_url = "https://www.saltedge.com/api/v3/"
  end

  def create_customer(email)
    url = "customers"
    payload = {
      data: {
        identifier: email
      }
    }
    post(url, payload)
  end

  def create_token(data={})
    url = 'tokens/create'
    payload = {
      data: {
        customer_id: data[:customer_id],
        fetch_type: "recent",
        return_login_id: true
      }
    }

    create(url, payload)
  end

  def show_login(login_id)
    url = "logins/#{login_id}"
    get_login(url)
  end

  def create_login(data={})
    url = "logins"
    payload = {
      data: {
        customer_id: data[:customer_id],
        country_code: data.fetch(:country_code, "XF"),
        provider_code: data.fetch(:provider_code, "fakebank_simple_xf"),
        credentials: {
          login: data[:username],
          password: data[:password]
        }
      }
    }

    post(url, payload)
  end

  def refresh_login(login)
    url = "logins/#{login.salt_id}/refresh"
    payload = {
      data: {
        fetch_type: "recent",
        include_fake_providers: true
      }
    }
    put(url, payload)
  end

  def destroy_login(login)
    url = "logins/#{login.salt_id}"
    delete(url)
  end

  def get_accounts(login)
    url = "accounts?login_id=#{login.salt_id}"
    get(url)
  end

  def get_transactions(login)
    url = "transactions?login_id=#{login.salt_id}"
    get(url)
  end

private
  def build_url(partial_url)
    @root_url + partial_url
  end

  def create(url, payload)
    Saltedge.new.request("POST", build_url(url), payload)
  end

  def post(url, payload)
    Saltedge.new.request("POST", build_url(url), payload)
  end

  def put(url, payload={})
    Saltedge.new.request("PUT", build_url(url), payload)
  end

  def delete(url)
    Saltedge.new.request("DELETE", build_url(url))
  end

  def get(url)
    Saltedge.new.request("GET", build_url(url))
  end

  def get_login(url)
    Saltedge.new.request("GET", build_url(url))
  end
end
