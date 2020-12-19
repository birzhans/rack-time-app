require_relative 'time_formatter'

class App
  def call(env)
    @request = Rack::Request.new(env)

    if valid_request?(@request)
      process_response
    else
      response(404, "Invalid path or method")
    end
  end

  private

  def response(status, message)
    Rack::Response.new(
      status,
      { 'Content-Type' => 'text/plain' },
      "#{message}\n"
    )
  end

  def process_response
    time = TimeFormatter.new(@request.params)
    time.call

    if time.success?
      response(200, time.time_string)
    else
      response(400, "Unknown formats: #{time.invalid_string}")
    end
  end

  def valid_request?(request)
    request.path_info.eql?("/time") && request.get?
  end
end
