xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do

    xml.title       "zpao.com | blog | comments"
    xml.link        "http://zpao.com"
    xml.webMaster   "paul@zpao.com (Paul O’Shannessy)"

    xml.pubDate     CGI.rfc1123_date @comments.first.created_at if @comments.any?
    xml.description "AWESOME"
    

    for comment in @comments do
      xml.item do
        xml.title       comment.article.title
        xml.link        article_url(comment.article) + "#comment-#{comment.id}"
        xml.description comment.body_html
        xml.pubDate     CGI.rfc1123_date comment.created_at
        xml.guid        article_url(comment.article) + "#comment-#{comment.id}"
        xml.author      "#{comment.email} (#{comment.name})"
      end
    end

  end
end