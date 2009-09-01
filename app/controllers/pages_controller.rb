class PagesController < ApplicationController
  caches_page :about, :contact

end
