
baseFiles = Dir.entries(ARGV[0])
baseFiles.each do |file|
  if !(file.include? '.')
    innerFolder = Dir.entries("#{ARGV[0]}/#{file}")
    baseFiles << innerFolder
    innerFolder.each do |f|
      if !(f.include? '.')
        baseFiles << Dir.entries("#{ARGV[0]}/#{file}/#{f}")
      end
    end
  end
end

files = baseFiles.flatten.select { |file| (file.include? '.zip') || (file.include? '.rar') }

otherFiles = Dir.entries(ARGV[1])
otherFiles.each do |file|
  if !(file.include? '.')
    otherFiles << Dir.entries("#{ARGV[1]}/#{file}")
  end
end
otherFiles
files.each do |file|
  missing = true
  otherFiles.flatten.each do |f|
    if f.include? file
      missing = false
      break
    end
  end
  if missing
    puts "#{file} is missing"
  end
end
