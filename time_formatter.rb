class TimeFormatter
  attr_reader :status, :message

  VALID_TIME_FORMATS = {
    'year' => '%Y-', 'month' => '%m-', 'day' => '%d',
    'hour' => '%H:', 'minute' => '%M:', 'second' => '%S'
  }.freeze

  def initialize(params)
    @valid_formats = ''
    @invalid_formats = []
    @message = time_format(params)
  end

  def time_format(params)
    get_formats(params['format'])
    if @invalid_formats.any?
      return bad_params
    else
      get_time
    end
  end

  def bad_params
    @status = 400
    @message = "Invalid formats: #{@invalid_formats.join(",")}"
  end

  def get_time
    @status = 200
    if @valid_formats.empty?
      @message = Time.now
    else
      @message = Time.now.strftime(@valid_formats)
    end
  end

  def get_formats(formats)
    if formats
      formats = formats.split(',')

      formats.each do |a|
        f = VALID_TIME_FORMATS[a]
        f ? @valid_formats << f : @invalid_formats << a
      end
    end
  end
end
