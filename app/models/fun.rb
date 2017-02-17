class Fun < ApplicationRecord
  belongs_to :player1, class_name: "User"
  belongs_to :player2, class_name: "User"
  serialize :board1, JSON
  serialize :board2, JSON
  serialize :board1_display, JSON
  serialize :board2_display, JSON
  after_initialize :init


  def init
    self.turn = 1
  end
  # b1 = self.self.board; b2 = self.self.board2
  # @self.board = [b1, b2]

  #=== fleet ===#

  # rows << ['Carrier!', 5, 1]
  # rows << ['Battleship', 4,1]
  # rows << ['Cruiser', 3,1]
  # rows << ['Destroyer', 2,2]
  # rows << ['Submarine', 1,2]

  def fit_checker(args={})
    s_p  = args["s_p"]
    direction = args["direction"]
    size_ship = args["size_ship"]
    board = args["board"]

    if  direction == 'right'  && ((s_p[0] + size_ship) > board.size)
      return false
    elsif  direction == 'down'  && ((s_p[1] + size_ship) > board.size)
      return false
    end

    if direction == 'right'
      return !((board[s_p[0]][(s_p[1])..size_ship]).include?("sheep"))
    elsif direction == 'down'
      return !((board.transpose[s_p[0]][(s_p[1])..size_ship]).include?("sheep"))
    end

  end

#args={"s_p" => [1,1],"direction"=>"right", "size_ship"=>4 }
  def sheep_placer(args={})
    s_p  = args["s_p"]
    direction = args["direction"]
    size_ship = args["size_ship"]
    board = args["board"]


    row=s_p[0].to_i; col=s_p[1].to_i
    if direction == "down" || direction == 0
      i= 0 ;
      while i < size_ship
        board[row+i][col]="sheep"; i+=1
      end
      return board
    elsif direction == "right" || direction == 1
      i= 0 ;
      while i < size_ship
        board[row][i+col]="sheep" ; i+=1
      end

      return board
    else
      return "Wrong input!!"
    end
  end

  def sheep_shooter(position,board)
    row=position[0].to_i; col=position[1].to_i
    if board[row][col] == "grass"
      board[row][col]="miss_ground"
    elsif board[row][col]=="sheep"
      board[row][col]="DeadSheep"
    else
      board[row][col]="!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

    end
  end

  def finished?(board)
    count=0; total_number_of_sheep=31
    board.each do |row|
      count += row.count("sheep")
    end
    total_number_of_sheep == count
  end

  def winner?
  end



end