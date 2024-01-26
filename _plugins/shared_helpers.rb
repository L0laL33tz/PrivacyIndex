module SharedHelpers
  def self.load_all_glossary_data(site)
    path = File.join(site.source, '_data', 'glossary.yml')
    # Check if the file exists
    if File.exists?(path)
      glossary_data = YAML.safe_load(File.read(path), permitted_classes: [Date])
      return glossary_data
    end
  end

  def self.load_all_glossary_terms(site)
    glossary_data = self.load_all_glossary_data(site)
    if glossary_data && glossary_data.size > 0
      terms = glossary_data.map { |data| data['title'] }.flatten.uniq.reject { |t| t.empty? }
      print "Found #{terms.size} glossary terms #{terms}\n"
      return terms
    end
  end

  def self.load_all_tags(site)
    path = File.join(site.source, '_data', 'articles.yml')

    # Check if the file exists
    if File.exists?(path)
      articles_data = YAML.safe_load(File.read(path), permitted_classes: [Date])

      # extract the tags from every article in the articles_data
      tags = articles_data.map { |article| article['tags'] }.flatten.uniq.reject { |t| t.empty? }
      return tags
      end
  end
end
