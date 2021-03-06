xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do

    xml.title       "zpao.com | blog | tag: #{@tag.name}"
    xml.link        "http://zpao.com"
    xml.webMaster   "paul@zpao.com (Paul O’Shannessy)"

    xml.pubDate     CGI.rfc1123_date @articles.first.updated_at if @articles.any?
    xml.description "AWESOME"

    for article in @articles do
      xml.item do
        xml.title       article.title
        xml.link        article_url(article)
        xml.description article.body_html
        xml.pubDate     CGI.rfc1123_date article.updated_at
        xml.guid        article_url(article)
        xml.author      "paul@zpao.com (Paul O’Shannessy)"
        if article.tags.length > 0
          for tag in article.tags
            xml.category tag
          end
        end
      end
    end

  end
end

