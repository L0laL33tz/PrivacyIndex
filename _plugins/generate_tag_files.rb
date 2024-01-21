Jekyll::Hooks.register :site, :after_init do |site|
  path = File.join(site.source, '_data', 'articles.yml')

  # Check if the file exists
  if File.exists?(path)
    articles_data = YAML.safe_load(File.read(path), permitted_classes: [Date])

    # extract the tags from every article in the articles_data
    tags = articles_data.map { |article| article['tags'] }.flatten.uniq.reject { |t| t.empty? }

    tags_path = File.join(site.source, '_tag')

    if Dir.exist?(tags_path)
      print "\tRemoving existing tag files\n"
      FileUtils.rm_rf(tags_path)
    end

    print "\tCreating tag files\n"
    Dir.mkdir(tags_path)

    tags.each do |tag|
      hashedTag = Digest::SHA256.hexdigest(tag.downcase)[0..6];
      path = File.join( tags_path, "#{hashedTag}.md")
      #path = File.join( tags_path, "#{Addressable::URI.encode(tag.downcase)}.md")
      print("\t - #{tag} in #{path}\n")

      File.open(path, "wb") do |file|
        file << "---\nlayout: articles_by_tag\ntitle: #{tag.capitalize}\ntag-name: #{tag}\nauto-links-id: #{hashedTag}\n---\n\n{% include auto_tag_glossary.liquid %}\n"
      end
    end

  else
    Jekyll.logger.warn "Custom Plugin:", "articles.yml not found in _data directory"
  end


end
