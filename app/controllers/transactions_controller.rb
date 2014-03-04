class TransactionsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_transaction, only: [:show, :edit, :update, :destroy, :make_paid]
  layout 'backend'

  # GET /transactions
  # GET /transactions.json
  def index
    if params[:bank]
      @banks = current_user.banks.enabled.find_by_id(params[:bank])
    else
      @banks = current_user.banks.enabled
    end
    @transactions = Transaction.where(bank_id: @banks).by_debit(params[:paid_status]).search(params[:search_column], params[:search_text]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
    respond_to do |format|
      format.html
      format.json
      format.pdf do
        pdf = TransactionPdf.new(@transaction, view_context)
        send_data pdf.render, filename: "check_#{@transaction.created_at.strftime("%d/%m/%Y")}.pdf", type: "application/pdf", disposition: 'inline' 
      end
    end
  end
  
  # POST /transactions/1
  # POST /transactions/1.json
  def make_paid
    @transaction.paid_status = true
    @transaction.save
    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json
    end
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @transaction }
      else
        format.html { render action: 'new' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:payee, :cheque_date, :amount, :account_payee, :paid_status, :user_id, :bank_id)
    end
    
    def sort_column
      Transaction.column_names.include?(params[:sort]) ? params[:sort] : "cheque_date"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
    end
end
