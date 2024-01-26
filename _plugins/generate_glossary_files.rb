require_relative 'shared_helpers'

Jekyll::Hooks.register :site, :after_init do |site|

  glossary_data = SharedHelpers.load_all_glossary_data(site)

  if glossary_data && glossary_data.length > 0
    glossary_path = File.join(site.source, '_glossary')

    if Dir.exist?(glossary_path)
      print "\tRemoving existing glossary files\n"
      FileUtils.rm_rf(glossary_path)
    end

    print "\tCreating glossary files\n"
    Dir.mkdir(glossary_path)

    glossary_data.each do |definition|
      hashedTitle = Digest::SHA256.hexdigest(definition['title'].downcase)[0..6];
      path = File.join( glossary_path, "#{hashedTitle}.md")
      #path = File.join( glossary_path, "#{Addressable::URI.encode(definition['title'].downcase)}.md")
      print("\t - #{definition['title']} in #{path}\n")

      File.open(path, "wb") do |file|
        file << "---\nlayout: glossary\ntitle: #{definition['title']}\nauto-links-id: #{hashedTitle}\nauto-links: true\nauto-links-use-tags: true\n---\n\n#{definition['content']}\n"
      end
    end

  else
    Jekyll.logger.warn "Custom Plugin:", "glossary.yml not found in _data directory"
  end


end

