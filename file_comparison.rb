baseFiles = Dir.entries(ARGV[0])
baseFiles.each do |file|
  if !(file.include? '.')
    innerFolder = Dir.entries("#{ARGV[0]}/#{file}")
    baseFiles << innerFolder
    innerFolder.each {|f| baseFiles << Dir.entries("#{ARGV[0]}/#{file}/#{f}") if !(f.include? '.')}
  end
end

files = baseFiles.flatten.select { |file| (file.include? '.zip') || (file.include? '.rar') }

otherFiles = Dir.entries(ARGV[1])
otherFiles.each {|file| otherFiles << Dir.entries("#{ARGV[1]}/#{file}") if !(file.include? '.')}

files.each do |file|
  missing = true
  otherFiles.flatten.each do |f|
    if f.include? file
      missing = false
      break
    end
  end
  puts "#{file} is missing" if missing
end
