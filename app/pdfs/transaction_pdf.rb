class TransactionPdf < Prawn::Document
   def initialize(transaction, view)
    super(:margin => 0, :page_size => [810, 360])
    @transaction = transaction
    @view = view
    logo
    print_date
    print_payee
    print_amount_in_words
    print_amount
    print_account_payee_sign
  end
  
  def logo
    logopath =  "#{Rails.root}/public" + @transaction.bank.cheque_image_url.to_s
    image logopath, :width => 810, :height => 360
  end
  
  def print_date
    character_spacing(13) do
      draw_text(@transaction.cheque_date.to_s(:cheque_date), :at => [(bounds.right-184), (bounds.top - 33)])
    end
  end
  
  def print_payee
    draw_text(@transaction.payee, :kerning => true, :at => [(bounds.left+65), (bounds.top - 88)])
  end
  
  def print_amount_in_words
    bounding_box([(bounds.left+65), (bounds.top - 113)], :width => 511, :height => 55) do
     text(to_words(@transaction.amount) + " Only", :indent_paragraphs => 60, :leading => 20, :kerning => true)
    end
  end
  
  def print_amount
    bounding_box([(bounds.right-182), (bounds.top - 123)], :width => 144, :height => 32) do
      text(@transaction.amount.to_s, :valign => :center, size: 14, :character_spacing => 1)
    end
  end

  def print_account_payee_sign
    character_spacing(3) do
      draw_text('A/C Payee', :at => [(bounds.left + 10), (bounds.top - 70)], :rotate => 45, :stroke_width => 1)
    end
    
    stroke do
      line_width 1
      line [(bounds.left), (bounds.top - 65)], [(bounds.left+65), (bounds.top)]
      line [(bounds.left), (bounds.top - 83)], [(bounds.left+83), (bounds.top)]
    end
  end
  
  def to_words number
    words = Array.new
    number = number.to_i
    if number.to_i == 0
     words << self.zero_string
    else

      number = number.to_s.rjust(33,'0')
      groups = number.scan(/.{3}/).reverse


      words << number_to_words(groups[0])

      (1..10).each do |number|
        if groups[number].to_i > 0
          case number
          when 1,3,5,7,9
            words << "Thousand"
          else
            words << (groups[number].to_i > 1 ? "#{self.quantities[number]}" : "#{self.quantities[number]}")
          end
          words << number_to_words(groups[number])
        end
      end
    end
    return "#{words.reverse.join(' ')}"
  end

  protected

  def and_string
    ""
  end

  def zero_string
    "zero"
  end

  def units
    %w[ ~ One Two Three Four Five Six Seven Eight Nine ]
  end

  def tens
    %w[ ~ Ten Twenty Thirty Fourty Fifty Sixty Seventy Eighty Ninety ]
  end

  def hundreds
    [ nil, 'One Hundred', 'Two Hundred', 'Three Hundred', 'Four Hundred', 'Five Hundred', 'Six Hundred',
'Seven Hundred', 'Eight Hundred', 'Nine Hundred']
  end

  def teens
    %w[ Ten Eleven Twelve Thirteen Fourteen Fifteen Sixteen Seventeen Eighteen Nineteen ]
  end

  def quantities
    %w[ ~ ~ Million ~ Billion ~ Trillion ~ ]
  end

  def number_to_words(number)

    hundreds = number[0,1].to_i
    tens = number[1,1].to_i
    units = number[2,1].to_i

    text = Array.new

    if hundreds > 0
      if hundreds == 1 && (tens + units == 0)
        text << self.hundreds[0]
      else
        text << self.hundreds[hundreds]
      end
    end

    if tens > 0
      case tens
        when 1
          text << (units == 0 ? self.tens[tens] : self.teens[units])
        else
          text << self.tens[tens]
      end
    end

    if units > 0
      if tens == 0
        text << self.units[units]
      elsif tens > 1
        text << "#{self.and_string}#{self.units[units]}"
      end
    end
    return text.join(' ')
  end
end