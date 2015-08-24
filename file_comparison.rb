baseFiles = Dir.entries('base')
baseFiles.each do |file|
  if !(file.include? '.')
    innerFolder = Dir.entries("base/#{file}")
    baseFiles << innerFolder
    innerFolder.each do |f|
      if !(f.include? '.')
        baseFiles << Dir.entries("base/#{file}/#{f}")
      end
    end
  end
end

files = baseFiles.flatten.select {|file| (file.include? '.zip') || (file.include? '.rar') }

otherFiles = Dir.entries('other')
otherFiles.each do |file|
  if !(file.include? '.')
    otherFiles << Dir.entries("other/#{file}")
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
