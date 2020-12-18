VALID_FORMAT_PATTERN = /^(format=)/
VALID_TIME_FORMATS = {
    'year' => '%Y-', 'month' => '%m-', 'day' => '%d',
    'hour' => '%H:', 'minute' => '%M:', 'second' => '%S'
  }.freeze

def get_args(args)
  invalid_args = []
  valid_args = ''
  return [invalid_args, valid_args] if args.empty?

  if VALID_FORMAT_PATTERN.match?(args)
    args = @args.sub(VALID_FORMAT_PATTERN, "")
  else
    return ["Invalid query pattern"]
  end

  args = args.split("%2C")

  args.each do |a|
    f = VALID_TIME_FORMATS[a]
    f ? valid_args << f : invalid_args << a
  end

  [invalid_args, valid_args]
end
