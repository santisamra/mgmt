module Github

  module User

    def github
      @github ||= ::Github.new(oauth_token: token)
    end

  end

end