require_relative 'time_formatter'

class App
  def call(env)
    @request = Rack::Request.new(env)

    if valid_request?(@request)
      time = TimeFormatter.new(@request.params)
      response(time.status, time.message)
    else
      response(404, "Invalid path or method")
    end
  end

  private

  def response(status, message)
    [
      status,
      { 'Content-Type' => 'text/plain' },
      ["#{message}\n"]
    ]
  end

  def valid_request?(request)
    request.path_info.eql?("/time") && request.get?
  end
end
