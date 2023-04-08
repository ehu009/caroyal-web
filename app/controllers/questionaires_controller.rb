class QuestionairesController < ApplicationController

  def new_producer_questionaire
    @prod_q = ProducerQuestionaire.new
  end
  def new_distributor_questionaire
    @dist_q = DistributorQuestionaire.new
  end

  def questionaire_data
    u = User.find_by_id(session[:user_id])
    if u.nil?
      redirect_to :root, notice: "No access."
      return
    end
    unless u.administrator then
      redirect_to :root, notice: "No access."
      return
    end
    p = ProducerQuestionaire.all
    @prod_randomized = p.select(:commodities).shuffle
    @prod_cryp_bros = p.where(:pays_crypto => true).count
    @prod_card_bros = p.where(:pays_card => true).count
    @prod_wire_bros = p.where(:pays_wire => true).count
    @prod_depo_bros = p.where(:pays_deposit => true).count
    
    @prod_amount_sum = p.sum(:volume)
    @prod_amount_avg = p.average(:volume)
    pvol = p.select(:volume)
    @prod_amount_min = pvol.min
    @prod_amount_max = pvol.max

    d = DistributorQuestionaire.all
    @dist_cryp_bros = d.where(:pays_crypto => true).count
    @dist_card_bros = d.where(:pays_card => true).count
    @dist_wire_bros = d.where(:pays_wire => true).count
    @dist_depo_bros = d.where(:pays_deposit => true).count
    @dist_randomized = d.select(:other_products).shuffle

    @dist_amount_sum = d.sum(:yearly_amount)
    @dist_amount_avg = d.average(:yearly_amount)
    dvol = p.select(:yearly_amount)
    @dist_amount_min = dvol.min
    @dist_amount_max = dvol.max

    @dist_age_sum = d.sum(:length)
    @dist_age_avg = d.average(:length)
    dage = p.select(:length)
    @dist_age_min = dage.min
    @dist_age_max = dage.max
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

  private
  def producer_params
    params.require(:producer_questionaire).permit(:commodities, :volume, :pays_deposit, :pays_wire, :pays_card, :pays_crypto, :unit)
  end

  def distributor_params
    params.require(:distributor_questionaire).permit(:length, :yearly_amount, :other_products, :pays_deposit, :pays_wire, :pays_card, :pays_crypto, :unit)
  end
end