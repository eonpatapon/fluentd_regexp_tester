require 'thor'
require 'fluentd_regexp_tester/parse'

module FluentdRegexpTester

  class CLI < Thor
    package_name 'FluentdRegexpTester'

    desc 'test [--time-format TIME_FORMAT] REGEXP INPUT', 'Test a given regexp to an input string'
    option :time_format
    def test(regexp, input)
      error, parsed, parsed_time = FluentdRegexpTester.parse(input, regexp)
      if error != nil
        STDERR.puts error
        exit!
      end
      if parsed == nil
        STDERR.puts "Failed to parse '#{input}' with '#{regexp}'"
        exit!
      end
      puts parsed.inspect
      puts parsed_time.to_s
    end

    desc 'version', 'print gem version'
    def version
      puts FluentdRegexpTester::VERSION
    end
  end

end
