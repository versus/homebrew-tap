#!/usr/bin/env ruby
require 'erb'

# Get the latest version from command line or GitHub API
version = ARGV[0] || `curl -s https://api.github.com/repos/sequring/sculptor/releases/latest | jq -r '.tag_name | sub("^v"; "")'`.chomp

# Download checksums file
checksums_url = "https://github.com/sequring/sculptor/releases/download/v#{version}/checksums.txt"
checksums = {}

# Parse checksums file
`curl -sL "#{checksums_url}"`.each_line do |line|
  if match = line.match(/^([a-f0-9]+)\s+sculptor_#{version}_(darwin|linux)_(amd64|arm64)\.tar\.gz$/)
    checksum, platform, arch = match.captures
    checksums["#{platform}_#{arch}"] = checksum
  end
end

# Read the current formula
formula_path = File.join(__dir__, 'Formula', 'sculptor.rb')
formula = File.read(formula_path)

# Update the version
formula.gsub!(/^  version \".*?\"/, "  version \"#{version}\"")

# Update checksums
checksums.each do |key, checksum|
  platform, arch = key.split('_')
  formula.gsub!(/^(\s+sha256 \")[a-f0-9]+(\" # #{platform} #{arch})/, "\\1#{checksum}\" # #{platform} #{arch}")
  formula.gsub!(/^(\s+sha256 \")[a-f0-9]+(\"$)/, "\\1#{checksum}\"")
end

# Write the updated formula back to disk
File.write(formula_path, formula)

puts "Formula updated to v#{version} with the following checksums:"
checksums.each { |k, v| puts "  #{k}: #{v}" }
