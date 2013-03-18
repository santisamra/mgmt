require 'digest/hmac'

class GithubNotificationsController < ApplicationController
  before_filter :verify_payload!

  def issues
    project = Project.by_full_name(params[:organization], params[:name])
    HandleIssueGithubNotificationContext.new(params[:issue], project).handle_issue
    render json: {}, status: 200
  end

  private 

    def verify_payload!
      key = AppConfiguration[:github].pubsub_secret
      payload = request.body.read
      signature = Digest::HMAC.hexdigest(payload, key, Digest::SHA1)
      render json: {}, status: 403 unless signature == request_signature
    end

    def request_signature
      request.headers['X-Hub-Signature'].split('=')[1]
    end

end