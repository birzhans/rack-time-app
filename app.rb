require_relative 'time'

class App

  def call(env)
    get_params(env)
    response
  end

  private

  def get_params(env)
    @path = env["REQUEST_PATH"].to_s
    @request_method = env["REQUEST_METHOD"].to_s
    @args = env["QUERY_STRING"].to_s
  end

  def response
    if valid_request?
      check_time
    else
      set_404
    end

    [@status, headers, @body]
  end

  def valid_request?
    return @path.eql?("/time") && @request_method.eql?("GET")
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def set_404
    @status = 404
    @body = ["Invalid path or method!\n"]
  end

  def set_400(invalid_args)
    @status = 400
    @body = ["Invalid time format: #{invalid_args.to_s}\n"]
  end

  def check_time
    invalid_args, valid_args = get_args(@args)
    invalid_args == [] ? time(valid_args) : set_400(invalid_args)
  end

  def time(formats)
    @status = 200
    if formats.empty?
      @body = ["#{Time.now}\n"]
    else
      @body = ["#{Time.now.strftime(formats)}\n"]
    end
  end
end
