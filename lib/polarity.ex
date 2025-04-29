defmodule Polarity do

  @moduledoc """
    Add your solver function below. You may add additional helper functions if you desire. 
    Test your code by running 'mix test --seed 0' from the simple_tester_ex directory.
  """
  def polarity(board, specs) do Polarity.polarity(board, specs, board, tuple_size(board) - 1, String.length(elem(board, tuple_size(board) - 1)) - 1) end
  def polarity(board, specs, prevBoard, -1, _col) do if Polarity.validBoard?(board, specs) do board else prevBoard end end
  def polarity(board, specs, prevBoard, row, -1) do Polarity.polarity(board, specs, prevBoard, row - 1, String.length(elem(board, tuple_size(board) - 1)) - 1) end
  def polarity(board, specs, prevBoard, row, col) do
    initBoard = board
    if String.equivalent?(Polarity.getTile(board, row, col), "+") or String.equivalent?(Polarity.getTile(board, row, col), "-") or String.equivalent?(Polarity.getTile(board, row, col), "X") do
      Polarity.polarity(board, specs, prevBoard, row, col - 1)
    else
      board = if Polarity.isPossible(board, specs, row, col, "+") do
        Polarity.polarity(Polarity.placeTile(board, "+", row, col), specs, initBoard, row, col - 1)
      else
        board
      end
      board = if board == initBoard do
        if Polarity.isPossible(board, specs, row, col, "-") do
          Polarity.polarity(Polarity.placeTile(board, "-", row, col), specs, initBoard, row, col - 1)
        else
          board
        end
      else
        board
      end
      board = if board == initBoard do
        if Polarity.isPossible(board, specs, row, col, "X") do
          Polarity.polarity(Polarity.placeTile(board, "X", row, col), specs, initBoard, row, col - 1)
        else
          board
        end
      else
        board
      end
      if board == initBoard do
        prevBoard
      else
        board
      end
    end
  end

  def getTile(board, row, col) do String.at(elem(board, row), col) end
  def getSpec(specs, row, "left") do elem(specs["left"], row) end
  def getSpec(specs, row, "right") do elem(specs["right"], row) end
  def getSpec(specs, col, "top") do elem(specs["top"], col) end
  def getSpec(specs, col, "bottom") do elem(specs["bottom"], col) end

  def checkPlaceTile(board, specs, pol, row, col) do if isPossible(board, row, col, pol) and isPossibleSpec(board, specs, row, col, pol) do placeTile(board, pol, row, col) else board end end

  def placeTile(board, pol, row, col) do Polarity.placeTile(board, pol, row, col, Polarity.getTile(board, row, col)) end
  def placeTile(board, "+", row, col, "L") do Tuple.delete_at(Tuple.insert_at(board, row, String.slice(elem(board, row), 0, col) <> "+-" <> String.slice(elem(board, row), col + 2, String.length(elem(board, row)))), row + 1) end
  def placeTile(board, "+", row, col, "R") do Tuple.delete_at(Tuple.insert_at(board, row, String.slice(elem(board, row), 0, col - 1) <> "-+" <> String.slice(elem(board, row), col + 1, String.length(elem(board, row)))), row + 1) end
  def placeTile(board, "+", row, col, "T") do
    tempBoard = Tuple.delete_at(Tuple.insert_at(board, row, String.slice(elem(board, row), 0, col) <> "+" <> String.slice(elem(board, row), col + 1, String.length(elem(board, row)))), row + 1)
    Tuple.delete_at(Tuple.insert_at(tempBoard, row + 1, String.slice(elem(tempBoard, row + 1), 0, col) <> "-" <> String.slice(elem(tempBoard, row + 1), col + 1, String.length(elem(tempBoard, row + 1)))), row + 2)    
  end
  def placeTile(board, "+", row, col, "B") do
    tempBoard = Tuple.delete_at(Tuple.insert_at(board, row, String.slice(elem(board, row), 0, col) <> "+" <> String.slice(elem(board, row), col + 1, String.length(elem(board, row)))), row + 1)
    Tuple.delete_at(Tuple.insert_at(tempBoard, row - 1, String.slice(elem(tempBoard, row - 1), 0, col) <> "-" <> String.slice(elem(tempBoard, row - 1), col + 1, String.length(elem(tempBoard, row - 1)))), row)
  end
  def placeTile(board, "-", row, col, "L") do Tuple.delete_at(Tuple.insert_at(board, row, String.slice(elem(board, row), 0, col) <> "-+" <> String.slice(elem(board, row), col + 2, String.length(elem(board, row)))), row + 1) end
  def placeTile(board, "-", row, col, "R") do Tuple.delete_at(Tuple.insert_at(board, row, String.slice(elem(board, row), 0, col - 1) <> "+-" <> String.slice(elem(board, row), col + 1, String.length(elem(board, row)))), row + 1) end
  def placeTile(board, "-", row, col, "T") do
    tempBoard = Tuple.delete_at(Tuple.insert_at(board, row, String.slice(elem(board, row), 0, col) <> "-" <> String.slice(elem(board, row), col + 1, String.length(elem(board, row)))), row + 1)
    Tuple.delete_at(Tuple.insert_at(tempBoard, row + 1, String.slice(elem(tempBoard, row + 1), 0, col) <> "+" <> String.slice(elem(tempBoard, row + 1), col + 1, String.length(elem(tempBoard, row + 1)))), row + 2)    
  end
  def placeTile(board, "-", row, col, "B") do
    tempBoard = Tuple.delete_at(Tuple.insert_at(board, row, String.slice(elem(board, row), 0, col) <> "-" <> String.slice(elem(board, row), col + 1, String.length(elem(board, row)))), row + 1)
    Tuple.delete_at(Tuple.insert_at(tempBoard, row - 1, String.slice(elem(tempBoard, row - 1), 0, col) <> "+" <> String.slice(elem(tempBoard, row - 1), col + 1, String.length(elem(tempBoard, row - 1)))), row)
  end
  def placeTile(board, "X", row, col, "L") do Tuple.delete_at(Tuple.insert_at(board, row, String.slice(elem(board, row), 0, col) <> "XX" <> String.slice(elem(board, row), col + 2, String.length(elem(board, row)))), row + 1) end
  def placeTile(board, "X", row, col, "R") do Tuple.delete_at(Tuple.insert_at(board, row, String.slice(elem(board, row), 0, col - 1) <> "XX" <> String.slice(elem(board, row), col + 1, String.length(elem(board, row)))), row + 1) end
  def placeTile(board, "X", row, col, "T") do
    tempBoard = Tuple.delete_at(Tuple.insert_at(board, row, String.slice(elem(board, row), 0, col) <> "X" <> String.slice(elem(board, row), col + 1, String.length(elem(board, row)))), row + 1)
    Tuple.delete_at(Tuple.insert_at(tempBoard, row + 1, String.slice(elem(tempBoard, row + 1), 0, col) <> "X" <> String.slice(elem(tempBoard, row + 1), col + 1, String.length(elem(tempBoard, row + 1)))), row + 2)    
  end
  def placeTile(board, "X", row, col, "B") do
    tempBoard = Tuple.delete_at(Tuple.insert_at(board, row, String.slice(elem(board, row), 0, col) <> "X" <> String.slice(elem(board, row), col + 1, String.length(elem(board, row)))), row + 1)
    Tuple.delete_at(Tuple.insert_at(tempBoard, row - 1, String.slice(elem(tempBoard, row - 1), 0, col) <> "X" <> String.slice(elem(tempBoard, row - 1), col + 1, String.length(elem(tempBoard, row - 1)))), row)
  end

  def getRowPolCount(board, pol, row) do Polarity.getRowPolCount(board, pol, row, String.length(elem(board, tuple_size(board) - 1)) - 1, 0) end
  def getRowPolCount(board, pol, row, 0, res) do if String.equivalent?(Polarity.getTile(board, row, 0), pol) do res + 1 else res end end
  def getRowPolCount(board, pol, row, col, res) do if String.equivalent?(Polarity.getTile(board, row, col), pol) do Polarity.getRowPolCount(board, pol, row, col - 1, res + 1) else Polarity.getRowPolCount(board, pol, row, col - 1, res) end end

  def getColPolCount(board, pol, col) do Polarity.getColPolCount(board, pol, tuple_size(board) - 1, col, 0) end
  def getColPolCount(board, pol, 0, col, res) do if String.equivalent?(Polarity.getTile(board, 0, col), pol) do res + 1 else res end end
  def getColPolCount(board, pol, row, col, res) do if String.equivalent?(Polarity.getTile(board, row, col), pol) do Polarity.getColPolCount(board, pol, row - 1, col, res + 1) else Polarity.getColPolCount(board, pol, row - 1, col, res) end end

  def isPossible(board, specs, row, col, "X") do Polarity.isPossibleSpec(board, specs, row, col, "X") end
  def isPossible(board, specs, row, col, pol) do Polarity.isPossible(board, row, col, pol) and Polarity.isPossibleSpec(board, specs, row, col, pol) end
  def isPossible(board, row, col, "+") do
    if Polarity.adjecent?(board, "+", row, col) do 
      false
    else
      case Polarity.getTile(board, row, col) do
        "L" -> if Polarity.adjecent?(board, "-", row, col + 1) do false else true end
        "R" -> if Polarity.adjecent?(board, "-", row, col - 1) do false else true end
        "T" -> if Polarity.adjecent?(board, "-", row + 1, col) do false else true end
        "B" -> if Polarity.adjecent?(board, "-", row - 1, col) do false else true end
        _ -> false
      end
    end
  end
  def isPossible(board, row, col, "-") do
    if Polarity.adjecent?(board, "-", row, col) do 
      false
    else
      case Polarity.getTile(board, row, col) do
        "L" -> if Polarity.adjecent?(board, "+", row, col + 1) do false else true end
        "R" -> if Polarity.adjecent?(board, "+", row, col - 1) do false else true end
        "T" -> if Polarity.adjecent?(board, "+", row + 1, col) do false else true end
        "B" -> if Polarity.adjecent?(board, "+", row - 1, col) do false else true end
        _ -> false
      end
    end
  end
  
  def isPossibleSpec(board, specs, row, col, "+") do
    if Polarity.isPossibleSpecAlt(board, specs, row, col, "-") do
      posRow = Polarity.getRowPolCount(board, "+", row)
      posCol = Polarity.getColPolCount(board, "+", col)
      if Polarity.getSpec(specs, row, "left") == -1 do
        if Polarity.getSpec(specs, col, "top") == -1 do
          true
        else
          if Polarity.getSpec(specs, col, "top") > posCol do true else false end
        end
      else
        if Polarity.getSpec(specs, col, "top") == -1 do
          if Polarity.getSpec(specs, row, "left") > posRow do true else false end
        else
          if Polarity.getSpec(specs, row, "left") > posRow do if Polarity.getSpec(specs, col, "top") > posCol do true else false end else false end
        end
      end
    else
      false
    end
  end
  def isPossibleSpec(board, specs, row, col, "-") do
    if Polarity.isPossibleSpecAlt(board, specs, row, col, "+") do
      negRow = Polarity.getRowPolCount(board, "-", row)
      negCol = Polarity.getColPolCount(board, "-", col)
      if Polarity.getSpec(specs, row, "right") == -1 do
        if Polarity.getSpec(specs, col, "bottom") == -1 do
          true
        else
          if Polarity.getSpec(specs, col, "bottom") > negCol do true else false end
        end
      else
        if Polarity.getSpec(specs, col, "bottom") == -1 do
          if Polarity.getSpec(specs, row, "right") > negRow do true else false end
        else
          if Polarity.getSpec(specs, row, "right") > negRow do if Polarity.getSpec(specs, col, "bottom") > negCol do true else false end else false end
        end
      end
    else
      false
    end
  end
  def isPossibleSpec(board, specs, row, col, "X") do
    posRow = Polarity.getRowPolCount(board, "+", row)
    posCol = Polarity.getColPolCount(board, "+", col)
    negRow = Polarity.getRowPolCount(board, "-", row)
    negCol = Polarity.getColPolCount(board, "-", col)
    xRow = Polarity.getRowPolCount(board, "X", row)
    xCol = Polarity.getColPolCount(board, "X", col)
    remRow = String.length(elem(board, row)) - posRow - negRow - xRow
    remCol = tuple_size(board) - posCol - negCol - xCol
    rowsEffected = if String.equivalent?(Polarity.getTile(board, row, col), "L") or String.equivalent?(Polarity.getTile(board, row, col), "R") do 2 else 1 end
    colsEffected = if String.equivalent?(Polarity.getTile(board, row, col), "T") or String.equivalent?(Polarity.getTile(board, row, col), "B") do 2 else 1 end
    result = true
    result = if Polarity.getSpec(specs, row, "left") != 0 and Polarity.getSpec(specs, row, "left") - posRow > remRow - rowsEffected do
      false
    else
      result
    end
    result = if Polarity.getSpec(specs, row, "right") != 0 and Polarity.getSpec(specs, row, "right") - negRow > remRow - rowsEffected do
      false
    else
      result
    end
    result = if Polarity.getSpec(specs, col, "top") != 0 and Polarity.getSpec(specs, col, "top") - posCol > remCol - colsEffected do
      false
    else
      result
    end
    if Polarity.getSpec(specs, col, "bottom") != 0 and Polarity.getSpec(specs, col, "bottom") - negCol > remCol - colsEffected do
      false
    else
      result
    end
  end
  def isPossibleSpecAlt(board, specs, row, col, "+") do
    row = cond do
      String.equivalent?(Polarity.getTile(board, row, col), "T") -> row + 1
      String.equivalent?(Polarity.getTile(board, row, col), "B") -> row - 1
      true -> row
    end
    col = cond do
      String.equivalent?(Polarity.getTile(board, row, col), "L") -> col + 1
      String.equivalent?(Polarity.getTile(board, row, col), "R") -> col - 1
      true -> col
    end
    posRow = Polarity.getRowPolCount(board, "+", row)
    posCol = Polarity.getColPolCount(board, "+", col)
    if Polarity.getSpec(specs, row, "left") == -1 do
      if Polarity.getSpec(specs, col, "top") == -1 do
        true
      else
        if Polarity.getSpec(specs, col, "top") > posCol do true else false end
      end
    else
      if Polarity.getSpec(specs, col, "top") == -1 do
        if Polarity.getSpec(specs, row, "left") > posRow do true else false end
      else
        if Polarity.getSpec(specs, row, "left") > posRow do if Polarity.getSpec(specs, col, "top") > posCol do true else false end else false end
      end
    end
  end
  def isPossibleSpecAlt(board, specs, row, col, "-") do
    row = cond do
      String.equivalent?(Polarity.getTile(board, row, col), "T") -> row + 1
      String.equivalent?(Polarity.getTile(board, row, col), "B") -> row - 1
      true -> row
    end
    col = cond do
      String.equivalent?(Polarity.getTile(board, row, col), "L") -> col + 1
      String.equivalent?(Polarity.getTile(board, row, col), "R") -> col - 1
      true -> col
    end
    negRow = Polarity.getRowPolCount(board, "-", row)
    negCol = Polarity.getColPolCount(board, "-", col)
    if Polarity.getSpec(specs, row, "right") == -1 do
      if Polarity.getSpec(specs, col, "bottom") == -1 do
        true
      else
        if Polarity.getSpec(specs, col, "bottom") > negCol do true else false end
      end
    else
      if Polarity.getSpec(specs, col, "bottom") == -1 do
        if Polarity.getSpec(specs, row, "right") > negRow do true else false end
      else
        if Polarity.getSpec(specs, row, "right") > negRow do if Polarity.getSpec(specs, col, "bottom") > negCol do true else false end else false end
      end
    end
  end

  def adjecent?(board, pol, row, col) do
    result = false
    result = if (row > 0) do if String.equivalent?(Polarity.getTile(board, row - 1, col), pol) do true else result end else result end
    result = if (row < tuple_size(board) - 1) do if String.equivalent?(Polarity.getTile(board, row + 1, col), pol) do true else result end else result end
    result = if (col > 0) do if String.equivalent?(Polarity.getTile(board, row, col - 1), pol) do true else result end else result end
    if (col < String.length(elem(board, row)) - 1) do if String.equivalent?(Polarity.getTile(board, row, col + 1), pol) do true else result end else result end
  end

  def validBoard?(board, specs) do Polarity.validBoard?(board, specs, tuple_size(board) - 1, "row") and Polarity.validBoard?(board, specs, String.length(elem(board, tuple_size(board) - 1)) - 1, "col") end
  def validBoard?(_board, _specs, -1, "row") do true end
  def validBoard?(board, specs, row, "row") do
    posRow = Polarity.getRowPolCount(board, "+", row)
    negRow = Polarity.getRowPolCount(board, "-", row)
    if Polarity.getSpec(specs, row, "left") == -1 do
      if Polarity.getSpec(specs, row, "right") == -1 do
        Polarity.validBoard?(board, specs, row - 1, "row")
      else
        if Polarity.getSpec(specs, row, "right") == negRow do Polarity.validBoard?(board, specs, row - 1, "row") else false end
      end
    else
      if Polarity.getSpec(specs, row, "right") == -1 do
        if Polarity.getSpec(specs, row, "left") == posRow do Polarity.validBoard?(board, specs, row - 1, "row") else false end
      else
        if Polarity.getSpec(specs, row, "left") == posRow and Polarity.getSpec(specs, row, "right") == negRow do Polarity.validBoard?(board, specs, row - 1, "row") else false end
      end
    end
  end
  def validBoard?(_board, _specs, -1, "col") do true end
  def validBoard?(board, specs, col, "col") do
    posCol = Polarity.getColPolCount(board, "+", col)
    negCol = Polarity.getColPolCount(board, "-", col)
    if Polarity.getSpec(specs, col, "top") == -1 do
      if Polarity.getSpec(specs, col, "bottom") == -1 do
        Polarity.validBoard?(board, specs, col - 1, "col")
      else
        if Polarity.getSpec(specs, col, "bottom") == negCol do Polarity.validBoard?(board, specs, col - 1, "col") else false end
      end
    else
      if Polarity.getSpec(specs, col, "bottom") == -1 do
        if Polarity.getSpec(specs, col, "top") == posCol do Polarity.validBoard?(board, specs, col - 1, "col") else false end
      else
        if Polarity.getSpec(specs, col, "top") == posCol and Polarity.getSpec(specs, col, "bottom") == negCol do Polarity.validBoard?(board, specs, col - 1, "col") else false end
      end
    end
  end
end
