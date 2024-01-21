Jekyll::Hooks.register :site, :after_init do |site|

  path = File.join(site.source, '_data', 'glossary.yml')

  # Check if the file exists
  if File.exists?(path)
    glossary_data = YAML.safe_load(File.read(path), permitted_classes: [Date])

    glossary_path = File.join(site.source, '_glossary')

    if Dir.exist?(glossary_path)
      print "\tRemoving existing glossary files\n"
      FileUtils.rm_rf(glossary_path)
    end

    print "\tCreating glossary files\n"
    Dir.mkdir(glossary_path)

    glossary_data.each do |definition|
      path = File.join( glossary_path, "#{Addressable::URI.encode(definition['title'].downcase)}.md")
      print("\t - #{definition['title']} in #{path}\n")

      File.open(path, "wb") do |file|
        file << "---\nlayout: glossary\ntitle: #{definition['title']}\n---\n\n#{definition['content']}\n"
      end
    end

  else
    Jekyll.logger.warn "Custom Plugin:", "glossary.yml not found in _data directory"
  end


end
