class SearchController < ApplicationController

  def search
    @query = params[:q]
    @results = PgSearch.multisearch(@query).select("ts_headline(pg_search_documents.content, plainto_tsquery('english', ''' ' || unaccent('#{@query}') || ' ''' || ':*'),  'MaxFragments=3, MinWords=10, MaxWords=12, FragmentDelimiter=\" ... \", StartSel=\"<b class=highlight>\", StopSel=\"</b>\"') AS excerpt").page(params[:page])
  end
end
