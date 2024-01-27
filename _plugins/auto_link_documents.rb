require_relative 'shared_helpers'

Jekyll::Hooks.register [:documents, :posts, :pages], :pre_render do |document|
  # Temporary storage for existing hyperlinks
  if document.data && document.data["auto-links"]

    # build index of all words we wanna create links for
    # tag links overide glossary, since the glossary is
    # part of the content of the tag page

    term_types = {}

    glossary_terms = SharedHelpers.load_all_glossary_terms(document.site)

    if glossary_terms && glossary_terms.size > 0
      glossary_terms = glossary_terms.map { |term| term.downcase }.filter{ |term| term != document.data['title'].downcase }

    end

    glossary_terms.each do |term|
      term_types[term] = 'glossary'
    end

    if document.data && document.data["auto-links-use-tags"]
      tag_terms = SharedHelpers.load_all_tags(document.site)

      if tag_terms && tag_terms.size > 0
        tag_terms = tag_terms.map { |term| term.downcase }
      end

      tag_terms.each do |term|
        term_types[term] = 'tag'
      end
    end


    existing_hyperlinks = {}

    # Replace existing hyperlinks with placeholders
    placeholder_counter = 0
    document.content = document.content.gsub(/<a\b[^>]*>(.*?)<\/a>/i) do |match|
      placeholder = "HYPERLINK_PLACEHOLDER_#{placeholder_counter}"
      existing_hyperlinks[placeholder] = match
      placeholder_counter += 1
      placeholder
    end

    # Replace terms with hyperlinks
    term_types.each do |term, type|
      hashedTerm = Digest::SHA256.hexdigest(term)[0..6];
      url = "#{document.site.baseurl}/#{type}/#{hashedTerm}"
      regex = /\b#{Regexp.escape(term)}\b/i
      document.content = document.content.gsub(regex) do |match|
        "<a class='#{type}' href='#{url}'>#{match}</a>"
      end
    end

    # Restore original hyperlinks from placeholders
    existing_hyperlinks.each do |placeholder, original_link|
      document.content = document.content.gsub(placeholder, original_link)
    end

  end

end
