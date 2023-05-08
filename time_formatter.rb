class TimeFormatter
  attr_reader :status, :message

  VALID_TIME_FORMATS = {
    'year' => '%Y-', 'month' => '%m-', 'day' => '%d',
    'hour' => '%H:', 'minute' => '%M:', 'second' => '%S'
  }.freeze

  def initialize(params)
    @formats = params['format']
    @valid_formats = ''
    @invalid_formats = []
  end

  def call
    get_formats(@formats)
  end

  def success?
    @invalid_formats.empty?
  end

  def invalid_string
    @invalid_formats.join(",")
  end

  def time_string
    if @valid_formats.empty?
      Time.now
    else
      Time.now.strftime(@valid_formats)
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
