class QuestionairesController < ApplicationController

  def new_producer_questionaire
    @prod_q = ProducerQuestionaire.new
  end
  def new_distributor_questionaire
      @dist_q = DistributorQuestionaire.new
  end

  def fill_producer_questionaire        
      message = nil
      redir = new_producer_questionaire_path
      failure = false
      @prod_q = ProducerQuestionaire.new(producer_params)
      @prod_q.user = @current_user
      unless @prod_q.save
          message = @prod_q.errors.messages
          @prod_q = nil
          failure = true
      end
      unless failure then
          if @current_user.distributor then
              redir =  new_distributor_questionaire_path
          else
              message = "Thanks for taking the time to fill out our questionaire."
          end
      end
      redirect_to redir, notice: message
  end

  def fill_distributor_questionaire
      
      failure = false
      message = nil
      redir = new_distributor_questionaire_path
      @dist_q = DistributorQuestionaire.new(distributor_params)
      @dist_q.user = @current_user
      
      unless @dist_q.save
          message = @dist_q.errors.messages
          failure = true
          @dist_q = nil
      end
      unless failure then
          message = "Thanks for taking the time to fill out our questionaire."
          redir = account_overview_path
      end
      redirect_to redir, notice: message
  end

end