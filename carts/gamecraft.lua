function reset_log(message)
  printh(message, "gamecraft.log.txt", true)
end

function log(message)
  printh(message, "gamecraft.log.txt")
end

cartdata_loaded = false

cartdata_offsets = {
  game_seed = 0,
  current_game = 1,
  score = 2,
  state = 3
}

-- loader -> playing -> played_won | played_lost -> loader
-- played_won -> loader -> (move)
-- played_lost -> (reset) -> loader
-- played_won -> loader -> last game -> "you won" -> (reset)
cartdata_state = {
  init = 0,
  loader = 1,
  playing = 2,
  played_won = 3,
  played_lost = 4
}

CartData = {
  game_seed = 0,
  current_game = 1,
  score = 0,
  state = 0
}

function CartData:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function CartData:init()
  self.game_seed = flr(rnd(1000))
  self.current_game = 1
  self.score = 0
  self.state = cartdata_state.loader
end

function CartData:printh()
  log("CartData.game_seed: " .. self.game_seed)
  log("CartData.current_game: " .. self.current_game)
  log("CartData.score: " .. self.score)
  log("CartData.state: " .. self.state)
end

function CartData:load()
  if not cartdata_loaded then
    if not cartdata("gamecraft_loader") then
      cartdata_loaded = true
      return false
    end
    cartdata_loaded = true
  end
  self.state = dget(cartdata_offsets.state)
  self.game_seed = dget(cartdata_offsets.game_seed)
  srand(self.game_seed)
  self.current_game = dget(cartdata_offsets.current_game)
  self.score = dget(cartdata_offsets.score)
  return true
end

function CartData:save()
  dset(cartdata_offsets.game_seed, self.game_seed)
  dset(cartdata_offsets.current_game, self.current_game)
  dset(cartdata_offsets.score, self.score)
  dset(cartdata_offsets.state, self.state)
end

function CartData:start_game(game_number)
  self.current_game = game_number
  self.state = cart_data.playing
end
