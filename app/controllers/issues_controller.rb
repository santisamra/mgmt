class IssuesController < ApplicationController
  inherit_resources
  respond_to :json
  actions :update
  
end