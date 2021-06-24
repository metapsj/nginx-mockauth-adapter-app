require_relative 'helper'

scope do
  test "/" do
    get '/'

    assert last_response.ok?
  end

  test "/protected" do
    get '/protected'

    assert last_response.ok?
  end

  test '/test' do
    get "/test"

    assert last_response.ok?
  end

  test "/auth" do
    get '/auth'

    assert last_response.ok?
  end

  test "/auth/:provider" do
    get '/auth/provider'

    assert last_response.ok?
  end

  test "/auth/:provider/callback" do
    get '/auth/provider/callback'

    assert last_response.ok?
  end
end
