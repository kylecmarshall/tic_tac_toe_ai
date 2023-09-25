require 'pl.strict'
local seq = require 'pl.seq'
local List = require 'pl.List'
local pretty = require 'pl.pretty'
local wxDC = require "wxDC"
local Transform = require('transform').Transform
local Board = require('board').Board

local function unpack_pair(t1, t2)
    local res = {}
    table.move(t1, 1, 2, 1, res)
    table.move(t2, 1, 2, 3, res)
    return table.unpack(res)
end

local colors = {
    foreground = {217, 217, 217},
    background = { 31, 31, 31 },
    normal_piece =  {250, 250, 250},
    winning_piece = {78, 201, 176},
}

--add render methods to the wcDC metatable directly
--so that the pointer to the wcDC object doesn't have to
--be passed through to every render function
do
    ---@class wxDC
    local wxDC = wxDC.metatable

    wxDC.render_x = function(dc, transform)
        local model = {
            tl = { -1, -1 },
            tr = { 1, -1 },
            bl = { -1, 1 },
            br = { 1, 1 },
        }

        -- transform:model is equivalent to
        -- transforming each point in the model table
        -- local world = {
        --     tl = transform:point(tl),
        --     tr = transform:point(tr),
        --     bl = transform:point(bl),
        --     br = transform:point(br)
        -- }
        local world = transform:model(model)

        local u = unpack_pair
        dc:DrawLine(u(world.tl, world.br))
        dc:DrawLine(u(world.tr, world.bl))
    end

    wxDC.render_o = function(dc, transform)
        dc:DrawCircle(transform.x, transform.y, transform.scale)
    end

    local render_piece_dispatch = {
        ['x'] = wxDC.render_x,
        ['o'] = wxDC.render_o,
        ['-'] = function(...) end --noop
    }

    wxDC.render_piece = function(dc, transform, chPiece)
        render_piece_dispatch[chPiece](dc, transform)
    end


    ---Render board
    ---@param dc wxDC
    ---@param world_transform Transform
    ---@param board Board
    wxDC.render_board = function(dc, world_transform, board)
        local dc_cp <close> = dc:Checkpoint()

        --grid line coordinates
        local d1 = -1 + 2 / 3
        local d2 = 1 - 2 / 3
        local model = {
            { d1, -1 }, { d1, 1 },
            { d2, -1 }, { d2, 1 },
            { -1, d1 }, { 1, d1 },
            { -1, d2 }, { 1, d2 },
        }
        local world = world_transform:model(model)
        dc:DrawLine(unpack_pair(world[1], world[2]))
        dc:DrawLine(unpack_pair(world[3], world[4]))
        dc:DrawLine(unpack_pair(world[5], world[6]))
        dc:DrawLine(unpack_pair(world[7], world[8]))

        --place coordinates
        local l_x = -1 + 1 / 3
        local c_x = 0
        local r_x = 1 - 1 / 3
        --by diagonal symmetry
        local t_y = l_x
        local c_y = c_x
        local b_y = r_x

        local place_transform = Transform { scale = 1 / 3.89 }
        local place_idx = 1
        for y in seq.list { t_y, c_y, b_y } do
            for x in seq.list { l_x, c_x, r_x } do
                place_transform.x = x
                place_transform.y = y

                --set piece color
                if board.winning_places:contains(place_idx) then
                    dc:SetPenColor(colors.winning_piece)
                else
                    dc:SetPenColor(colors.normal_piece)
                end
                dc:render_piece(world_transform:transform(place_transform), board.state:sub(place_idx, place_idx))

                place_idx = place_idx + 1
            end
        end
    end
end

---@enum GameState
local GAME_STATE = {
    new_game = "new_game",
    o_turn = "o_turn",
    x_turn = "x_turn",
    game_over = "game_over",
    reset = "reset"
}

local function random_player(game, player)
    local board = game.board
    local moves = board:get_possible_moves()
    assert(#moves > 0)
    local place = moves[math.random(#moves)]
    --board:pick('o', place)
    game:pick(place)
end

local function minimax_player(game, player)
    local next_player = player == 'o' and 'x' or 'o'

    --find all moves that produce the minimum score
    --pick one at random
    local possible_moves = game.board:get_possible_moves()
    
    --the first move is irrelevant to the score so
    --pick at random
    if #possible_moves == 9 then
        local move = possible_moves[math.random(#possible_moves)]
        game:pick(move)
        return
    end
    --the second move takes a while to compute so
    --pick middle or corner squares on first move
    -- if #possible_moves == 8 then
    --     local possible_moves = List(possible_moves)
    --     if possible_moves:contains(5) then
    --         game:pick(5)
    --     else
    --         game:pick(1)
    --     end
    --     return
    -- end

    local outcomes = List()
    
    for _, move in ipairs(possible_moves) do
        local board = Board(game.board.state)
        board:pick(player, move)
        local score = board:calculate_score(next_player)
        outcomes:append({ move = move, score = score})
    end

    local min, max = seq.minmax(seq.map(function(o) return o.score end, seq.list(outcomes)))
    local best_score; if player == 'o' then best_score = max else best_score = min end
    local best_outcomes = seq.copy(seq.filter(seq.list(outcomes), function(o) return o.score == best_score end))
    local move = (best_outcomes[math.random(#best_outcomes)]).move
    game:pick(move)
end



local game = {
    ---@type GameState
    state = GAME_STATE.new_game,
    board = Board '---------',
    state_data = {},
    board_history = List(),
    o_player = random_player,
    x_player = minimax_player,
}

function game:reset()
    self.board = Board '---------'
    self.state_data = {}
end

local game_state_piece = {
    o_turn = 'o',
    x_turn = 'x'
}

function game:pick(place)
    local piece = assert(game_state_piece[self.state])
    self.board:pick(piece, place)

    --TODO make an "overload" copy constructor
    --FIXME: have to call is_finished on board to fill in
    --winning places before we clone it
    self.board:is_finished()
    local board = Board(self.board.state)
    board.winning_places = self.board.winning_places:clone()
    
    self.board_history:append(board)
    while #self.board_history > 8 do
        self.board_history:remove(1)
    end

    
end

local game_state_machine = {

    ---@param board Board
    new_game = function (board)
        game.state = GAME_STATE.o_turn
    end,

    ---@param board Board
    o_turn = function (board)
        game.o_player(game, 'o')

        if board:is_finished() then
            game.state = GAME_STATE.game_over
        else
            game.state = GAME_STATE.x_turn
        end
    end,

    ---@param board Board
    x_turn = function (board)
        game.x_player(game, 'x')

        if board:is_finished() then
            game.state = GAME_STATE.game_over
        else
            game.state = GAME_STATE.o_turn
        end
    end,

    ---@param board Board
    game_over = function(board)
        game.state = GAME_STATE.reset
    end,

    ---@param board Board
    reset = function(board)
        local count = game.state_data.reset_count
        if count then
            count = count + 1
        else
            count = 1
        end
        game.state_data.reset_count = count

        if count > 1 then
            game:reset()
            game.state = GAME_STATE.new_game
        end
    end
}

function game:tick()
    --dispatch to the state machine
    game_state_machine[self.state](self.board)
end



---main render functions
---@param dc wxDC
local function render(dc)
    local width, height = dc:GetSize()
    --define colors
    local rgbBackground = { 31, 31, 31 }
    local rgbForeground = {217, 217, 217}

    --draw background
    dc:SetBrush({ rgb = rgbBackground, style = wxDC.BRUSHSTYLE_SOLID })
    dc:DrawRectangle(0, 0, width, height)

    --draw foreground
    -- draw shapes without fill
    dc:SetBrush({ style = wxDC.BRUSHSTYLE_TRANSPARENT })
    dc:SetPen({ rgb = rgbForeground, width = 1 })

    do
        local transform = Transform { x = 40, y = 40, scale = 30 }

        do
            local num = 1
            local board = game.board_history[num]
            if board then dc:render_board(transform, board) end
        end

        transform.y = transform.y + 70
        do
            local num = 2
            local board = game.board_history[num]
            if board then dc:render_board(transform, board) end
        end

        transform.y = transform.y + 70
        do
            local num = 3
            local board = game.board_history[num]
            if board then dc:render_board(transform, board) end
        end

        transform.y = transform.y + 70
        do
            local num = 4
            local board = game.board_history[num]
            if board then dc:render_board(transform, board) end
        end

        transform.y = transform.y + 70
        do
            local num = 5
            local board = game.board_history[num]
            if board then dc:render_board(transform, board) end
        end

        transform.y = transform.y + 70
        do
            local num = 6
            local board = game.board_history[num]
            if board then dc:render_board(transform, board) end
        end

        transform.y = transform.y + 70
        do
            local num = 7
            local board = game.board_history[num]
            if board then dc:render_board(transform, board) end
        end

        transform.y = transform.y + 70
        do
            local num = 8
            local board = game.board_history[num]
            if board then dc:render_board(transform, board) end
        end

        dc:SetPen({ rgb = rgbForeground, width = 5 })
        transform.x = 400
        transform.y = 275
        transform.scale = 205
        dc:render_board(transform, game.board)
    end
end

wxDC.set_render_func(render)

-- global Tick function that is called every 100ms
Tick = nil
local tick_count = 0
function Tick()
    game:tick()
    wxDC.refresh()

    tick_count = tick_count + 1
    if tick_count % 100 == 0 then
        warn("Lua memory: ", collectgarbage("count"), " kB")
    end
end

