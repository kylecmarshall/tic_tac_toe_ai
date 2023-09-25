local List = require 'pl.List'
local seq  = require 'pl.seq'

local M = {}

local Board

---@class Board
---@field state BoardState
---@field winning_places pl.List
---@overload fun(strBoardState: BoardState): Board
Board = setmetatable({}, {
    -- Transform constructor
    __call = function(T, strBoardState)
        ---@cast Board Board
        local board = setmetatable({},Board)
        board.state = strBoardState
        board.winning_places = List()
        return board
    end
})
Board.__index = Board

-- definitions
---@alias pieces 'x' | 'o'
---@alias places 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
---@alias outcome 'x' | 'o' | 'draw'
---@alias PlaceState 'x' | 'o' | '-'
---@alias BoardState string


local byteX <const> = ("x"):byte(1)
local byteO <const> = ("o"):byte(1)
local byteDash <const> = ("-"):byte(1)
local cntPlaces <const> = 9

---pick a place to play and update the board state
---@param piece pieces
---@param place places
function Board:pick(piece, place)
    local state = self.state
    self.state =  state:sub(1, place - 1) .. piece .. state:sub(place + 1)
end

--- returns all possible places to pick
---@return places[]
function Board:get_possible_moves()
    local res = {}

    local state = self.state
    for i = 1, cntPlaces do
        if state:byte(i) == byteDash then
            res[#res + 1] = i
        end
    end

    return res
end

local winning_positions <const> = {
    { 1, 2, 3 },
    { 4, 5, 6 },
    { 7, 8, 9 },
    { 1, 4, 7 },
    { 2, 5, 8 },
    { 3, 6, 9 },
    { 1, 5, 9 },
    { 3, 5, 7 },
}
--- checks the board to see if the game is over and 
---returns the winner
---@return boolean finished, outcome?
function Board:is_finished()
    local state = self.state
    
    for strPlayer, player in pairs({x = byteX, o = byteO}) do
        for _, positions in ipairs(winning_positions) do
            local win =     state:byte(positions[1]) == player and
                            state:byte(positions[2]) == player and
                            state:byte(positions[3]) == player
            if win then
                self.winning_places:extend(positions)
                return true, strPlayer
            end
        end
    end
    if #self:get_possible_moves() == 0 then
        return true, 'draw'
    end
    return false
end

--calculate minimax score
-- 'o' is the maximizer and
-- 'x' is the minimizer
local minimax_player_data = {
    o = { next_player = 'x', reducer = function (iter) local _, max = seq.minmax(iter); return max end },
    x = { next_player = 'o', reducer = function (iter) local min, _ = seq.minmax(iter); return min end },

    scores = { o = 1, x = -1, draw = 0}
}
function Board:calculate_score(player)
    local finished, winner = self:is_finished()
    if finished then return minimax_player_data.scores[winner] end

    local p = minimax_player_data[player]

    -- calculate the following:
    -- [1] the possible moves
    -- [2] the possible board for each possible move
    -- [3] scores from possible boards
    -- [4] return the min (for x) or the max (for o) of the scores
    --     this is what the reducer does
    local moves = self:get_possible_moves()

    local boards = seq.map(function (move)
        local board = Board(self.state)
        board:pick(player, move)
        return board
    end, seq.list(moves))

    local scores = seq.map(function (board)
        -- We use the next player to calculate the score
        -- because this board came from picking a move out
        -- of the possible moves.
        -- So from the board's perpspective, it is the next
        -- players turn.
        return board:calculate_score(p.next_player)
    end, boards)

    -- calculate min (for x) or max (for o) of the scores
    return p.reducer(scores)
end

M.Board = Board

return M