class GithubEventsSubscriber < SimpleDelegator

  class SubscriptionError < RuntimeError ; ; end

  SUPPORTED_EVENTS = [:issues]

  # Instance Methods

  def initialize(project, token)
    super(project)
    @project = project
    @token = token
  end

  # Public: Subscribes to the project's Github notifications
  # 
  # event         - A Symbol with the Github event for which this project 
  #                 will be subscribed.
  # callback_url  - A String with the callback url to which 
  #                 Github will send the notifications.
  #
  # Raises GithubEventsSubscriber::SubscriptionError if the subscription 
  #                                                   could not been performed.
  # Raises ArgumentError if the event is not supported.
  def subscribe!(event, callback_url)
    raise ArgumentError, "Unsupported event #{event}" unless SUPPORTED_EVENTS.include?(event)
    topic = send("#{event}_topic")
    params = subscribe_request_params(topic, callback_url)
    response = send_request(params)
    raise SubscriptionError unless (200..299) === response.code.to_i
  end

  private

    def subscribe_request_params(topic, callback_url)
      {
        "hub.mode" => "subscribe",
        "hub.topic" => topic,
        "hub.callback" => callback_url,
        "hub.secret" => AppConfiguration[:github].pubsub_secret
      }
    end

    def issues_topic
      endpoint = AppConfiguration[:github].endpoint
      "https://#{endpoint}/#{organization}/#{name}/events/issues"
    end

    def send_request(params)
      uri = URI(AppConfiguration[:github].hub_uri)
      request = Net::HTTP::Post.new(uri.path)
      request.set_form_data(params)
      request['Authorization'] = "token #{@token}"
      request['Accept'] = 'application/json'
      ssl = uri.scheme == 'https'
      Net::HTTP.start(uri.host, uri.port, use_ssl: ssl) { |http| http.request(request) }
    end

end