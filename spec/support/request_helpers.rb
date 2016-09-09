module RequestHelpers
  def access_token_for_user(user)
    Doorkeeper::AccessToken.create!(
      resource_owner_id: user.id,
      use_refresh_token: true,
      expires_in: 7200,
    )
  end

  def request_headers
    {
      "CONTENT_TYPE" => "application/vnd.api+json",
      "ACCEPT" => "application/vnd.api+json",
    }
  end

  def authenticated_request_headers(user)
    request_headers.merge(
      "AUTHORIZATION" => "bearer #{access_token_for_user(user).token}",
    )
  end

  def json
    JSON.parse(response.body)
  end
end
