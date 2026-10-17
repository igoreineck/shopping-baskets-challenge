require 'json'

# @TODO: improve the parser and the file input to work with a bigger lists (NICE TO HAVE)
#
class Parser
  def self.parse_file(file_name:)
    File.foreach(file_name) do |line|
      content = JSON.parse(line.strip)
      # Call some sort of service here
      puts content
    rescue JSON::ParserError => error
      puts "Failed to parse line: #{line.strip}. Error: #{error.message}"
    end
  end
end
