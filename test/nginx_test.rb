require_relative 'helper'

scope do
  test '/hello' do
    get '/hello'

    assert last_response.ok?
  end

  test '/protected' do
    get '/protected'

    assert last_response.ok?
  end

  test '/test' do
    get '/test'

    assert last_response.ok?
  end

  test '/auth' do
    get 'auth'

    assert last_response.ok?
  end

  # /auth/:provider
  # /auth/:provider/callback
end
