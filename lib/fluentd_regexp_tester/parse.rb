require 'fluent/version'
require 'fluent/compat/parser'
require 'fluent/engine'

module FluentdRegexpTester
  def self.parse(input, regexp, time_format = nil)
    parsed_time = nil
    parsed = nil
    error = nil

    conf = {}
    if !time_format.nil?
      conf['time_format'] = time_format
    end

    begin
      regexp = Regexp.new(regexp.gsub(%r{^\/(.+)\/$}, '\1'))
      parser = Fluent::Compat::TextParser::RegexpParser.new(regexp)
      parser.configure(Fluent::Config::Element.new('', '', conf, []))
      parser.parse(input) do |pt, p|
        parsed_time = pt
        parsed = p
      end
    rescue Fluent::Plugin::Parser::ParserError, RegexpError => e
      error = e
    end
    [error, parsed, parsed_time]
  end
end
