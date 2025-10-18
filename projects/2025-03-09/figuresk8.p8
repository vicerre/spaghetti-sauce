pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- figuresk8
--by [redacted]

-->8
-- constants

cardinals = {
  up = "up",
  left = "left",
  right = "right",
  down = "down",
}

diagonals = {
  up_left = "up_left",
  up_right = "up_right",
  down_left = "down_left",
  down_right = "down_right",
  from_cardinals = function(self, ud, lr)
    if (ud == cardinals.up and lr == cardinals.left) return self.up_left
    if (ud == cardinals.up and lr == cardinals.right) return self.up_right
    if (ud == cardinals.down and lr == cardinals.left) return self.down_left
    if (ud == cardinals.down and lr == cardinals.right) return self.down_right

    assert(false, "Can't create diagonal from cardinals: " .. ud .. " + " .. lr)
  end,
}

colors = {
  black = 0,
  blue = 12,
  brown = 4,
  dark_blue = 1,
  dark_gray = 5,
  dark_green = 3,
  green = 11,
  light_gray = 6,
  maroon = 2,
  orange = 9,
  peach = 15,
  pink = 14,
  puce = 13,
  red = 8,
  transparent = 11, -- = green
  white = 7,
  yellow = 10,
}

k_left = 0
k_right = 1
k_up = 2
k_down = 3
k_o = 4
k_x = 5
k_ox = 0b110000

pids = {
  -- indexed values
  "p1",
  "p2",
  -- keyed values
  p1 = "p1",
  p2 = "p2",
}

sprites = {
  c = {
    arrow_down = 25,
    arrow_down_left = 26,
    arrow_down_right = 27,
    arrow_left = 24,
    arrow_right = 9,
    arrow_up = 8,
    arrow_up_left = 10,
    arrow_up_right = 11,
    cursor = 1,
    heart1 = 2,
    heart2 = 2 + 16,
  },
  flags = {
    obstruction = 1,
  },
}

stats = {
  frame_rate = 7,
  target_frame_rate = 8,
  mouse_x = 32,
  mouse_y = 33,
  mouse_b = 34,
}

s_default = "default"
s_outline = "outline"
s_outline_selected = "outline_selected"
s_reflection = "reflection"

tiles = {
  map = {
    offset_celx = 16,
    offset_cely = 0,
  },
  frame = {
    offset_celx = 0,
    offset_cely = 16,
  },
  obstruction = {
    offset_celx = 48,
    offset_cely = 0,
  }
}

-- parameters

params = {
  layout = {
    map_height = 256,
    map_width = 256,
    player_coffset = 2,
    tile_size = 8,
    viewport_size = 128,
  },
  physics = {
    accel = 2 / 16,
    bounce_mul = 2,
    friction = 61 / 64,
    g = 1,
  },
  scuffs = {
    expiry = 6,
    samples = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    speed_mul = 4,
    x_jitter = 8,
  },
  shavings = {
    angle_jitter = 1 / 4, -- 1 / 4 of the unit circle
    expiry = 4,
    jitter_duration = 1 / 2,
    r_jitter = {0, 0, 0, 1, 0, 0, 0},
    samples = {0, 0, 0, 0, 1, 1, 1},
    speed_mul = 4,
    x_jitter = 8,
    y_jitter = 2,
  },
  sprites = {
    accel_alt_duration = 1 / 16,
    idle_delay = 1,
    idle_speed = 1,
    stretch_ratio = 20 / 16,
  },
}

z_indices = {
  map = -(1 << 5),
  scuff = -(1 << 4),
  reflection = -(1 << 3),
  obstruction = -(1 << 2),
  -- indices 0 - [...] are reserved for 2D layers
  shaving = params.layout.map_height + (1 << 0),
  heart = params.layout.map_height + (1 << 1),
  frame = params.layout.map_height + (1 << 2),
}

-- globals

cam = {
  x = 0,
  y = 0,
}

cursor = {
  b = 0,
  enabled = false,
  x = 0,
  y = 0,
}

dbg = {
  enabled = false,
  debug_print_value = "",
}

keys = {
  up = false,
  up_start_t = nil,
  up_t = nil,
  left = false,
  left_start_t = nil,
  left_t = nil,
  right = false,
  right_start_t = nil,
  right_t = nil,
  down = false,
  down_start_t = nil,
  down_t = nil,
}

player_proto = {
  id = 0,
  idle = {
    is_idle = true,
    start_t = 0,
  },
  position = {
    angle = 0,
    speed = 0,
    x = params.layout.map_width / 2,
    y = params.layout.map_height / 2,
  },
  skills = {
    bounce = false,
    warp = false,
  },
}

player_meta_proto = {
  flags = {
    at_max_speed = false,
    is_facing_left = false,
    is_idling = true,
    is_looping_top_bottom_border = false,
    is_looping_left_right_border = false,
    is_speedy = false,
  },
  physics = {
    max_speed = 2,
    max_wrap_steps = 128,
    min_speed_cutoff = 1 / 16,
  },
  renders = {
    scuffs = {
      color = colors.transparent,
    },
    shavings = {
      color = colors.white,
      r_jitter = {0},
    },
    sprites = {
      offset = 0,
    },
    stretch = {
      color = colors.white,
    },
  },
}

world = {
  dt = 1,
  end_t = nil,
  pi = 2,
  t = 0,
  arrows = {},
  hearts = {},
  players = {},
  player_metas = {},
  scuffs = {},
  shavings = {},
}

-- utils

function deb(...)
  local args = {...}

  local strbuf = ""
  for i = 1, #args do
    if (i ~= 1) then
      strbuf ..= ", "
    end
    strbuf ..= tostr(args[i])
  end
  return strbuf
end

function deepmerge(table1, table2)
  local merged = {}
  for k, v in pairs(table1) do
    merged[k] = v
  end

  for k, v in pairs(table2) do
    local v1 = merged[k]
    local v2 = v

    local t1 = type(v1)
    local t2 = type(v2)

    if (t1 == "nil" and t2 == "table") then
      merged[k] = deepmerge({}, v2)
    elseif (t1 == "nil") then
      merged[k] = v2
    elseif (t1 == "table" and t2 == "table") then
      merged[k] = deepmerge(v1, v2)
    elseif (t1 == t2) then
      merged[k] = v2
    else
      assert(false, "Can't merge key with differing types: " .. k)
    end
  end

  return merged
end

function deepcopy(t)
  return deepmerge({}, t)
end

function deepmerge_test()
  local empty1 = {}
  local empty2 = {}
  local empty_merge = deepmerge(empty1, empty2)
  assert(empty_merge ~= empty1)
  assert(empty_merge ~= empty2)

  local shallow1 = {foo = 1}
  local shallow2 = {foo = 2}
  local shallow_merge = deepmerge(shallow1, shallow2)
  assert(shallow1.foo == 1)
  assert(shallow2.foo == 2)
  assert(shallow_merge.foo == 2)

  shallow_merge.foo = 3
  assert(shallow1.foo == 1)
  assert(shallow2.foo == 2)
  assert(shallow_merge.foo == 3)

  local nested1 = {}
  local nested2 = {foo = {bar = 1}}
  local nested_merge = deepmerge(nested1, nested2)
  assert(nested_merge.foo.bar == 1)

  nested2.foo.bar = 2
  assert(nested2.foo.bar == 1)
  assert(nested2.foo.bar == 2)

  local deep1 = {foo = {bar = 1}}
  local deep2 = {foo = {bar = 2}}
  local deep_merge = deepmerge(deep1, deep2)
  assert(deep1.foo.bar == 1)
  assert(deep2.foo.bar == 2)
  assert(deep_merge.foo.bar == 2)

  deep_merge.foo.bar = 3
  assert(deep1.foo.bar == 1)
  assert(deep2.foo.bar == 2)
  assert(deep_merge.foo.bar == 3)

  local missing1 = {foo = {bar = 1}}
  local missing2 = {foo = {}}
  local missing_merge = deepmerge(missing1, missing2)
  assert(missing_merge.foo.bar == 1)
end

if (dbg.enabled) then
  deepmerge_test()
end

function hypot(x, y)
  -- non-overflowing hypot
  -- https://stackoverflow.com/a/4381530
  local mx = abs(x)
  local my = abs(y)
  local larger = max(mx, my)
  local smaller = min(mx, my)

  local r = smaller / larger
  return larger * sqrt(1 + r * r)
end

function mean(...)
  -- non-overflowing average
  local args = {...}

  local m = 0
  for n in all(args) do
    m += n / #args
  end
  return m
end

function mean_test()
  local zero = mean()
  assert(zero == 0)

  local one = mean(1)
  assert(one == 1)

  local two = mean(-1, 1)
  assert(two == 0)
end

if (dbg.enabled) then
  mean_test()
end

-- Show alt sprites every [duration] seconds
function pick_t(arr, t, duration)
  local size = #arr
  local i = (t % (duration * size)) \ duration
  i = (i == 0) and size or i
  return arr[i]
end

function pick_t_test()
  local one = pick_t({1}, 0, 2)
  assert(one == 1)

  local two = pick_t({1, 2}, 0, 2)
  assert(two == 2)

  local two_next = pick_t({1, 2}, 2, 2)
  assert(two_next == 1)

  local two_next_next = pick_t({1, 2}, 4, 2)
  assert(two_next_next == 2)
end

if (dbg.enabled) then
  pick_t_test()
end

function p_reset()
  palt()
 -- reset transparency
  palt(colors.black, false)
  palt(colors.transparent, true)
end

function stable_sort_inner(t, low, high, acc)
  -- mergesort
  if (low == high) return {t[low]}

  local mid = low + (high - low) \ 2

  local sortedleft = stable_sort_inner(t, low, mid, acc)
  local sortedright = stable_sort_inner(t, mid + 1, high, acc)

  local merged = {}

  for _ = low, high do
    local nextleft = sortedleft[1]
    local nextright = sortedright[1]

    local next
    if (nextleft == nil) then
      next = nextright
      deli(sortedright, 1)
    elseif (nextright == nil) then
      next = nextleft
      deli(sortedleft, 1)
    else
      assert(nextleft ~= nil)
      assert(nextright ~= nil)

      local cmp = acc(nextleft) - acc(nextright)
      if (cmp <= 0) then
        next = nextleft
        deli(sortedleft, 1)
      else
        next = nextright
        deli(sortedright, 1)
      end
    end

    add(merged, next)
  end
  return merged
end

function stable_sort(t, acc)
  if (#t == 0) then
    return t
  end
  return stable_sort_inner(t, 1, #t, acc)
end

function stable_sort_test()
  local acc = function(e) return e end

  local empty = stable_sort({}, acc)
  assert(#empty == 0)

  local one = stable_sort({1}, acc)
  assert(one[1] == 1)

  local two = stable_sort({2, 1}, acc)
  assert(two[1] == 1)
  assert(two[2] == 2)

  local reversed = stable_sort({4, 3, 2, 1}, acc)
  assert(reversed[1] == 1)
  assert(reversed[2] == 2)
  assert(reversed[3] == 3)
  assert(reversed[4] == 4)
end

if (dbg.enabled) then
  stable_sort_test()
end

-- classes

arrows = {
  padding = 2,
  locate = function(x, y)
    local cx = cam.x
    local cy = cam.y

    local inset_height = frames.inset_height
    local inset_left = frames.inset_left
    local inset_top = frames.inset_top
    local inset_width = frames.inset_width

    local inset_min_x = cx + inset_left
    local inset_min_y = cy + inset_top
    local inset_max_x = cx + inset_left + inset_width
    local inset_max_y = cy + inset_top + inset_height

    local ax = mid(inset_min_x, x, inset_max_x)
    local ay = mid(inset_min_y, y, inset_max_y)

    -- TODO: distance is currently unused.
    local distance = hypot(x - ax, y - ay);
    local lr = (ax == inset_min_x and cardinals.left) or 
      (ax == inset_max_x and cardinals.right) or nil
    local ud = (ay == inset_min_y and cardinals.up) or
      (ay == inset_max_y and cardinals.down) or nil

    if (lr == nil and ud == nil) then
    -- (x, y) is on screen
      return
    elseif (lr == nil or ud == nil) then
      -- arrow is a cardinal
      return {
        distance = distance,
        intercardinal = lr or ud,
        x = ax,
        y = ay,
      }
    else
      -- arrow is a diagonal
      return {
        distance = distance,
        intercardinal = diagonals:from_cardinals(ud, lr),
        x = ax,
        y = ay,
      }
    end
  end,
}

bounces = {
  compute = function(v, p)
    local bounce_mul = params.physics.bounce_mul

    local max_speed = p.max_speed

    local angle = v.angle
    local speed = v.speed

    local angle_reflected_ud = (1 - angle) % 1
    local angle_reflected_lr = (0.5 - angle) % 1
    local angle_opposite = (angle + 0.5) % 1

    local bspeed = min(speed * bounce_mul, max_speed)

    return {
      default = { angle = angle, speed = speed }, -- not bspeed
      ud = { angle = angle_reflected_ud, speed = bspeed },
      lr = { angle = angle_reflected_lr, speed = bspeed },
      udlr = { angle = angle_opposite, speed = bspeed },
    }
  end,
  compute_test = function(self)
    local p = {max_speed = 2}

    local zero = self.compute({angle = 0, speed = 0}, p)

    assert(zero.ud.angle == 0)
    assert(zero.ud.speed == 0)
    assert(zero.lr.angle == 0.5)
    assert(zero.lr.speed == 0)
    assert(zero.udlr.angle == 0.5)
    assert(zero.udlr.speed == 0)

    local orthogonal = self.compute({angle = 1 / 8, speed = 1}, p)
    assert(orthogonal.ud.angle == 7 / 8)
    assert(orthogonal.lr.angle == 3 / 8)
    assert(orthogonal.udlr.angle == 5 / 8)

    local fast = self.compute({angle = 0, speed = 10}, p)
    assert(fast.ud.speed == 2)
    assert(fast.lr.speed == 2)
    assert(fast.udlr.speed == 2)
  end,
  locate = function(x, y, bs)
    local v_default = bs.default
    local v_ud = bs.ud
    local v_lr = bs.lr
    local v_udlr = bs.udlr

    local dx = cos(v_default.angle) * v_default.speed
    local dy = sin(v_default.angle) * v_default.speed
    local ud_dx = cos(v_ud.angle) * v_ud.speed
    local ud_dy = sin(v_ud.angle) * v_ud.speed
    local lr_dx = cos(v_lr.angle) * v_lr.speed
    local lr_dy = sin(v_lr.angle) * v_lr.speed
    local udlr_dx = cos(v_udlr.angle) * v_udlr.speed
    local udlr_dy = sin(v_udlr.angle) * v_udlr.speed

    local ds = physics.daxes(v_default)
    local dmajor = ds.major
    local dminor = ds.minor

    local can_pass = not obstructions:present(x + dx, y + dy)
    local can_bounce_ud = not obstructions:present(x + ud_dx, y + ud_dy)
    local can_bounce_lr = not obstructions:present(x + lr_dx, y + lr_dy)
    local can_bounce_udlr = not obstructions:present(x + udlr_dx, y + udlr_dy)

    if (can_pass) then
      return {
        cardinals = {},
        velocity = v_default,
      }
    end

    if (can_bounce_ud or can_bounce_lr) then
      -- We're moving exclusively along one axis
      if (dmajor ~= nil and dminor == nil) then
        local is_ud = dmajor == cardinals.up or dmajor == cardinals.down
        local is_lr = dmajor == cardinals.left or dmajor == cardinals.right
        if (dbg.enabled) assert(is_ud or is_lr)
        return {
          cardinals = {dmajor},
          velocity = (is_ud and can_bounce_ud and v_ud) or (is_lr and can_bounce_lr and v_lr)
        }
      end

      -- We're moving predominantly along the y-axis. Prioritize U/D bounces.
      if ((dmajor == cardinals.up or dmajor == cardinals.down) and
          (dminor == cardinals.left or dminor == cardinals.right)) then
        if (can_bounce_ud) then
          return {
            cardinals = {dmajor},
            velocity = v_ud,
          }
        end
        if (can_bounce_lr) then
          return {
            cardinals = {dminor},
            velocity = v_lr,
          }
        end
      end

      -- We're predominantly moving along the x-axis. Prioritize L/R bounces.
      if ((dmajor == cardinals.left or dmajor == cardinals.right) and
          (dminor == cardinals.up or dminor == cardinals.down)) then
        if (can_bounce_lr) then
          return {
            cardinals = {dmajor},
            velocity = v_lr,
          }
        end
        if (can_bounce_ud) then
          return {
            cardinals = {dminor},
            velocity = v_ud,
          }
        end
      end

      -- We're moving equally among a set of orthogonal axes.
      -- If we can bounce on both ud and lr, bounce along both.
      if (can_bounce_ud and can_bounce_lr and can_bounce_udlr) then
        return {
        -- TODO: calculate
          cardinals = {},
          velocity = v_udlr,
        }
      end
      if (can_bounce_ud) then
        return {
        -- TODO: calculate
          cardinals = {},
          velocity = v_ud,
        }
      end
      if (can_bounce_lr) then
        return {
        -- TODO: calculate
          cardinals = {},
          velocity = v_lr,
        }
      end
    end

    if (can_bounce_udlr) then
      return {
        cardinals = {dmajor, dminor},
        velocity = v_udlr,
      }
    end

    assert(false, "Can't move to a valid coordinate!")

    return {
      cardinals = {},
      velocity = v_default,
    }
  end
}

if (dbg.enabled) then
  bounces:compute_test()
end

cameras = {
  straggle = 0.1,
  center_on = function(x, y)
    local viewport_size = params.layout.viewport_size

    cam.x = x - viewport_size / 2
    cam.y = y - viewport_size / 2
  end,
  follow = function(self, player, player_meta)
    local cx = cam.x
    local cy = cam.y

    local p_x = player.position.x
    local p_y = player.position.y

    -- TODO: clamp camera range to map boundaries + inset size

    -- local map_height = params.layout.map_height
    -- local map_width = params.layout.map_width
    local viewport_size = params.layout.viewport_size

    -- local target_x = mid(0, p_x - viewport_size / 2, map_width - viewport_size)
    -- local target_y = mid(0, p_y - viewport_size / 2, map_height - viewport_size)

    local target_x = p_x - viewport_size / 2
    local target_y = p_y - viewport_size / 2

    local final_x = cx + (target_x - cx) * self.straggle
    local final_y = cy + (target_y - cy) * self.straggle

    -- Dejitter camera by rounding to the nearest pixel
    -- https://www.lexaloffle.com/bbs/?pid=66567#p
    cam.x = flr(final_x + 0.5)
    cam.y = flr(final_y + 0.5)
  end,
}

frames = {
  inset_height = 12 * params.layout.tile_size,
  inset_left = 1 * params.layout.tile_size,
  inset_top = 1 * params.layout.tile_size,
  inset_width = 14 * params.layout.tile_size,
  get_rect = function(self)
    local cx = cam.x
    local cy = cam.y

    local inset_height = self.inset_height
    local inset_left = self.inset_left
    local inset_top = self.inset_top
    local inset_width = self.inset_width

    return {
      height = cy + inset_top + inset_height,
      left = cx + inset_left,
      top = cy + inset_top,
      width = cx + inset_left + inset_width,
    }
  end,
}

hearts = {
  hover_y = -4,
  radius = 20,
  locate = function(self, x1, y1, x2, y2)
    local t = world.t

    if (hypot(x2 - x1, y2 - y1) <= self.radius) then
      return {
        start_t = t,
        x = mean(x1, x2),
        y = mean(y1, y2) + self.hover_y,
      }
    else
      return nil
    end
  end,
}

obstructions = {
  border_buffer = 8,
  present = function(self, x, y)
    local tile_size = params.layout.tile_size

    local offset_celx = tiles.obstruction.offset_celx
    local offset_cely = tiles.obstruction.offset_cely

    local celx = x / tile_size
    local cely = y / tile_size

    local tile = mget(celx + offset_celx, cely + offset_cely)
    if (tile == 0) return false
    local is_obstruction = fget(tile, sprites.flags.obstruction)
    if (is_obstruction) return true
    return false
  end
}

physics = {
  by_edge = function(x, y, cardinal, buffer)
    local dx = 0
    local dy = 0

    if (cardinal == cardinals.up) dy = -1
    if (cardinal == cardinals.left) dx = -1
    if (cardinal == cardinals.right) dx = 1
    if (cardinal == cardinals.down) dy = 1

    for i = 1, buffer do
      local next_x = x + dx * i
      local next_y = y + dy * i

      if obstructions:present(next_x, next_y) then
        return true
      end
    end
    return false
  end,
  daxes = function(v)
    local angle = v.angle
    local speed = v.speed

    if (speed == 0) return {major = nil, minor = nil}

    local eighth = 1 / 8
    if (angle == 0) then
      return {major = cardinals.right, minor = nil}
    elseif (angle < 1 * eighth) then
      return {major = cardinals.right, minor = cardinals.up}
    elseif (angle == 1 * eighth) then
      return {major = nil, minor = nil}
    elseif (angle < 2 * eighth) then
      return {major = cardinals.up, minor = cardinals.right}
    elseif (angle == 2 * eighth) then
      return {major = cardinals.up, minor = nil}
    elseif (angle < 3 * eighth) then
      return {major = cardinals.up, minor = cardinals.left}
    elseif (angle == 3 * eighth) then
      return {major = nil, minor = nil}
    elseif (angle < 4 * eighth) then
      return {major = cardinals.left, minor = cardinals.up}
    elseif (angle == 4 * eighth) then
      return {major = cardinals.left, minor = nil}
    elseif (angle < 5 * eighth) then
      return {major = cardinals.left, minor = cardinals.down}
    elseif (angle == 5 * eighth) then
      return {major = nil, minor = nil}
    elseif (angle < 6 * eighth) then
      return {major = cardinals.down, minor = cardinals.left}
    elseif (angle == 6 * eighth) then
      return {major = cardinals.down, minor = nil}
    elseif (angle < 7 * eighth) then
      return {major = cardinals.down, minor = cardinals.right}
    elseif (angle == 7 * eighth) then
      return {major = nil, minor = nil}
    elseif (angle < 1) then
      return {major = cardinals.right, minor = cardinals.down}
    end

    assert(false, "Invalid value for angle found: " .. angle)
  end,
  daxes_test = function(self)
    local empty = self.daxes({angle = 0, speed = 0})
    assert(empty.major == nil, empty.minor == nil)

    local orthogonal = self.daxes({angle = 0, speed = 1})
    assert(orthogonal.major == cardinals.right)
    assert(orthogonal.minor == nil)

    local diagonal = self.daxes({angle = 1 / 8, speed = 1})
    assert(diagonal.major == nil)
    assert(diagonal.minor == nil)

    local inbetween = self.daxes({angle = 1 / 16, speed = 1})
    assert(inbetween.major == cardinals.right)
    assert(inbetween.minor == cardinals.up)
  end,
  v_add = function (v1, v2)
    local angle_1 = v1.angle
    local speed_1 = v1.speed

    local angle_2 = v2.angle
    local speed_2 = v2.speed

    local dx1 = cos(angle_1) * speed_1
    local dy1 = sin(angle_1) * speed_1

    local dx2 = cos(angle_2) * speed_2
    local dy2 = sin(angle_2) * speed_2

    local dx = dx1 + dx2
    local dy = dy1 + dy2

    if (dx == 0 and dy == 0) then
      return {
        angle = 0,
        speed = 0,
      }
    end

    local angle = atan2(dx, dy)
    local speed = hypot(dx, dy)

    return {
      angle = angle,
      speed = speed,
    }
  end,
  v_add_test = function(self)
    local zero = self.v_add({angle = 0, speed = 0}, {angle = 0, speed = 0})
    assert(zero.angle == 0)
    assert(zero.speed == 0)

    local orthogonal = self.v_add({angle = 0, speed = 1}, {angle = 0.25, speed = 1})
    assert(orthogonal.angle == 0.125)
    assert(orthogonal.speed == sqrt(2))

    local opposite = self.v_add({angle = 0, speed = 1}, {angle = 0.5, speed = 1})
    assert(opposite.angle == 0)
    assert(opposite.speed == 0)

    local parallel = self.v_add({angle = 0, speed = 1}, {angle = 0, speed = 1})
    assert(parallel.angle == 0)
    assert(parallel.speed == 2)
  end,
  v_process = function(v, p)
    local friction = params.physics.friction

    local max_speed = p.max_speed
    local min_speed_cutoff = p.min_speed_cutoff

    local raw_angle = v.angle
    local raw_speed = v.speed

    raw_speed = mid(0, raw_speed * friction, max_speed)
    raw_speed = (raw_speed < min_speed_cutoff) and 0 or raw_speed

    return {
      angle = raw_angle,
      speed = raw_speed,
    } 
  end,
  v_process_test = function(self)
    local p = {max_speed = 2, min_speed_cutoff = 1 / 16}

    local zero = self.v_process({angle = 0, speed = 0}, p)
    assert(zero.angle == 0)
    assert(zero.speed == 0)

    local slow = self.v_process({angle = 0, speed = 0.01}, p)
    assert(slow.angle == 0)
    assert(slow.speed == 0)

    local fast = self.v_process({angle = 0, speed = 10}, p)
    assert(fast.angle == 0)
    assert(fast.speed == 2)

    local friction = self.v_process({angle = 0, speed = 1}, p)
    assert(friction.angle == 0)
    assert(friction.speed == 0.953125)
  end,
}

if (dbg.enabled) then
  physics:daxes_test()
  physics:v_add_test()
  physics:v_process_test()
end

players = {
  check_idle = function(player, player_meta)
    local max_speed = player_meta.physics.max_speed

    local speed = player.position.speed

    return speed / max_speed <= 0
  end,
  create = function(p)
    local base = deepcopy(player_proto)
    for k, v in pairs(p) do
      base[k] = v
    end
    return base
  end,
  create_meta = function(pm)
    local base = deepcopy(player_meta_proto)
    for k, v in pairs(pm) do
      base[k] = v
    end
    return base
  end,
  update_idle = function(player, player_meta, is_idle)
    local t = world.t

    if (player.idle.is_idle == is_idle) then
      -- no change requested
      return
    end
    if (player.idle.is_idle and not is_idle) then
      -- stop idling
      player.idle.is_idle = false
      player.idle.start_t = 0
    end
    if (not player.idle.is_idle and is_idle) then
      -- start idling
      player.idle.is_idle = true
      player.idle.start_t = t
    end
  end,
  update_position = function(player, player_meta)
    local map_height = params.layout.map_height
    local map_width = params.layout.map_width

    local max_wrap_steps = player_meta.physics.max_wrap_steps

    local angle = player.position.angle
    local speed = player.position.speed
    local p_x = player.position.x
    local p_y = player.position.y
    local can_warp = player.skills.warp

    local dx = cos(angle) * speed
    local dy = sin(angle) * speed

    local x
    local y
    if (can_warp) then
      -- phase through obstructions
      for i = 1, max_wrap_steps + 1 do
        -- abort and set player position to original position
        if (i == max_wrap_steps + 1) then
          x = p_x
          y = p_y
        else
          x = (p_x + dx * i) % map_width
          y = (p_y + dy * i) % map_height
        end
        if (not obstructions:present(x, y)) break
      end
    else
      x = (p_x + dx) % map_width
      y = (p_y + dy) % map_height
    end

    -- merge?
    player.position.x = x
    player.position.y = y
  end,
  update_velocity = function(player, player_meta, v_accel)
    local max_speed = player_meta.physics.max_speed
    local min_speed_cutoff = player_meta.physics.min_speed_cutoff

    local angle = player.position.angle
    local speed = player.position.speed
    local x = player.position.x
    local y = player.position.y
    local can_bounce = player.skills.bounce

    local v = {angle = angle, speed = speed}

    local v_raw = physics.v_add(v, v_accel)
    local v_params = {max_speed = max_speed, min_speed_cutoff = min_speed_cutoff}

    local v_next = physics.v_process(v_raw, v_params)

    local b_params = {max_speed = max_speed}
    local bs = bounces.compute(v_next, b_params)

    local located = bounces.locate(x, y, bs)

    local updated = can_bounce and located.velocity or v_next
    local updated_angle = updated.angle
    local updated_speed = updated.speed

    -- merge?
    player.position.angle = updated_angle
    player.position.speed = updated_speed
  end,
}

scuffs = {
  generate = function(x, y, v, t, p)
    local scuffs_expiry = params.scuffs.expiry
    local scuffs_speed_mul = params.scuffs.speed_mul
    local scuffs_x_jitter = params.scuffs.x_jitter

    local x_jitter = rnd(scuffs_x_jitter)

    local start_x = x - scuffs_x_jitter / 2 + x_jitter

    if (v.speed == 0) then
      return nil
    end

    return {
      angle = v.angle,
      color = p.color,
      end_t = t + scuffs_expiry,
      length = v.speed * scuffs_speed_mul,
      start_t = t,
      start_x = start_x,
      start_y = y,
    }
  end,
  refresh = function(self, existings, x, y, v, t, p)
    local scuffs_samples = params.scuffs.samples

    local updated = {}

    -- Add a few particles every tick based on the player's trajectory
    for _ = 1, rnd(scuffs_samples) do
      local new = self.generate(x, y, v, t, p)

      if (new ~= nil) add(updated, new)
    end

    -- Add existing particles if they haven't expired
    for existing in all(existings) do
      if (t < existing.end_t) add(updated, existing)
    end

    return updated
  end
}

shavings = {
  generate = function(x, y, v, t, p)
    local shavings_angle_jitter = params.shavings.angle_jitter
    local shavings_expiry = params.shavings.expiry
    local shavings_jitter_duration = params.shavings.jitter_duration
    local shavings_speed_mul = params.shavings.speed_mul
    local shavings_x_jitter = params.shavings.x_jitter
    local shavings_y_jitter = params.shavings.y_jitter

    local angle_jitter = rnd(shavings_angle_jitter)
    local x_jitter = rnd(shavings_x_jitter)
    local y_jitter = rnd(shavings_y_jitter)

    local jittered_angle = (v.angle - shavings_angle_jitter / 2 + angle_jitter) % 1
    local adjusted_speed = v.speed * shavings_speed_mul
    local start_x = x - shavings_x_jitter / 2 + x_jitter
    local start_y = y - shavings_y_jitter / 2 + y_jitter

    return {
      angle = jittered_angle,
      color = p.color,
      end_t = t + shavings_expiry,
      r_jitter = p.r_jitter,
      r_jitter_duration = shavings_jitter_duration,
      speed = adjusted_speed,
      start_t = t,
      start_x = start_x,
      start_y = start_y,
    }
  end,
-- find the trajectory of a given shaving
  locate = function(shaving)
    local t = world.t

    local g = params.physics.g

    local angle = shaving.angle
    local speed = shaving.speed
    local start_t = shaving.start_t
    local start_x = shaving.start_x
    local start_y = shaving.start_y

    local dx = cos(angle) * speed
    local dy = sin(angle) * speed
    local dt = t - start_t

    local end_x = start_x + dx * dt
    local end_y = start_y - dy * dt + g * dt * dt

    -- don't throw shavings if we're not moving
    if (speed == 0) then
      return nil
    end
    if (obstructions:present(end_x, end_y)) then
      return nil
    end

    return {x = end_x, y = end_y}
  end,
  refresh = function(self, existings, x, y, v, t, p)
    local shavings_samples = params.shavings.samples

    local updated = {}

    -- Add a few particles every tick based on the player's trajectory
    for _ = 1, rnd(shavings_samples) do
      local new = self.generate(x, y, v, t, p)

      add(updated, new)
    end
    
    -- Add existing particles if they haven't expired
    for existing in all(existings) do
      local can_draw = shavings.locate(existing) ~= nil

      if (not can_draw) then
        -- pass
      elseif (t > existing.end_t) then
        -- pass
      else
        add(updated, existing)
      end
    end

    return updated
  end
}

strings = {
  c_height = 6,
  c_width = 4,
  c_width_double = 8,
  get_rect = function(self, c)
    return {
      height = self.c_height,
      -- https://pico-8.fandom.com/wiki/Print#Character_size_and_screen_capacity
      width = (ord(c) < 128) and self.c_width or self.c_width_double
    }
  end
}

-->8
-- init

function init_players()
  local p1 = players.create({
    id = pids.p1,
    position = {
      angle = 0,
      speed = 0,
      x = params.layout.map_width - params.layout.tile_size * params.layout.player_coffset,
      y = params.layout.tile_size * params.layout.player_coffset,
    },
    skills = {
      bounce = false,
      warp = true,
    },
  })
  local pm1 = players.create_meta({
    flags = {
      is_facing_left = true,
    },
    renders = {
      scuffs = {
        color = colors.transparent,
      },
      shavings = {
        color = colors.white,
        r_jitter = {0},
      },
      sprites = {
        offset = 64,
      },
      stretch = {
        color = colors.blue,
      },
    },
  })

  local p2 = players.create({
    id = pids.p2,
    position = {
      angle = 0,
      speed = 0,
      x = params.layout.tile_size * params.layout.player_coffset,
      y = params.layout.tile_size * params.layout.player_coffset,
    },
    skills = {
      bounce = true,
      warp = false,
    },
  })
  local pm2 = players.create_meta({
    flags = {
      is_facing_left = false,
    },
    renders = {
      scuffs = {
        color = colors.white,
      },
      shavings = {
        color = colors.puce,
        r_jitter = params.shavings.r_jitter,
      },
      sprites = {
        offset = 72,
      },
      stretch = {
        color = colors.orange,
      },
    },
  })

  world.players = {p1, p2}
  world.player_metas = {pm1, pm2}
end

function _init()
  -- Enable dev cursor tracking
  -- https://www.lexaloffle.com/bbs/?tid=3549
  -- https://nerdyteachers.com/PICO-8/Guide/MOUSE
  poke(0x5f2d, 0xb111)

  init_players()

  local p_selected = world.players[world.pi]
  cameras.center_on(p_selected.position.x, p_selected.position.y)

  p_reset()
end

-->8
-- update

function update_cursor()
  local mb = stat(stats.mouse_b)
  local mx = stat(stats.mouse_x)
  local my = stat(stats.mouse_y)

  local enabled = cursor.enabled
  
  if (mx ~= cursor.x or my ~= cursor.y) enabled = true
  if (btn() > 0) enabled = false

  cursor = {
    b = mb,
    enabled = enabled,
    x = mx,
    y = my,
  }
end

function update_debug()
  -- TODO: move this into update_keys()
  if (btnp() == k_ox) dbg.enabled = not dbg.enabled
end

function update_keys()
  local t = time()

  local up = btn(k_up)
  local up_start_t
  local up_t
  if (up) then
    if (keys.up_start_t == nil) then
      up_start_t = t
    else
      up_start_t = keys.up_start_t
    end
    up_t = t
  else
    up_start_t = nil
    up_t = nil
  end

  local left = btn(k_left)
  local left_start_t
  local left_t
  if (left) then
    if (keys.left_start_t == nil) then
      left_start_t = t
    else
      left_start_t = keys.left_start_t
    end
    left_t = t
  else
    left_start_t = nil
    left_t = nil
  end

  local right = btn(k_right)
  local right_start_t
  local right_t
  if (right) then
    if (keys.right_start_t == nil) then
      right_start_t = t
    else
      right_start_t = keys.right_start_t
    end
    right_t = t
  else
    right_start_t = nil
    right_t = nil
  end

  local down = btn(k_down)
  local down_start_t
  local down_t
  if (down) then
    if (keys.down_start_t == nil) then
      down_start_t = t
    else
      down_start_t = keys.down_start_t
    end
    down_t = t
  else
    down_start_t = nil
    down_t = nil
  end

  keys = {
    up = up,
    up_start_t = up_start_t,
    up_t = up_t,
    left = left,
    left_start_t = left_start_t,
    left_t = left_t,
    right = right,
    right_start_t = right_start_t,
    right_t = right_t,
    down = down,
    down_start_t = down_start_t,
    down_t = down_t,
  }
end

function update_pi()
  -- TODO: move this into update_keys()
  if btnp(k_o) or btnp(k_x) then
    local next = (world.pi + 1) % #world.players
    world.pi = (next == 0) and #world.players or next
  end
end

function update_time()
  -- https://pico-8.fandom.com/wiki/Stat
  -- https://pico-8.fandom.com/wiki/Time
  -- local frame_rate = stat(stats.frame_rate)
  -- local target_frame_rate = stat(stats.target_frame_rate)
  world.dt = 1 -- target_frame_rate / frame_rate <-- seems broken when called here
  world.t = time()
end

function extract_accel(p_x, p_y)
  local mb = cursor.b
  local mx = cursor.x
  local my = cursor.y

  local cx = cam.x
  local cy = cam.y

  local accel = params.physics.accel

  local dt = world.dt

  local raw_angle = 0
  local raw_speed = 0

  if (mb == 1) then

    local viewport_px = p_x - cx
    local viewport_py = p_y - cy

    local m_angle = atan2(mx - viewport_px, my - viewport_py)

    raw_angle = m_angle
    raw_speed = accel
  else
    local dx = 0
    local dy = 0

    if (keys.up) dy = -1
    if (keys.left) dx = -1
    if (keys.right) dx = 1
    if (keys.down) dy = 1

    if (dx == 0 and dy == 0) then
      raw_angle = 0
      raw_speed = 0
    else
      raw_angle = atan2(dx, dy)
      raw_speed = accel
    end
  end

  return {
    angle = raw_angle,
    speed = raw_speed * dt,
  }
end

function update_hearts()
  local players = world.players

  local result = {}

  for i = 1, #players do
    for j = i + 1, #players do
      local p1 = players[i]
      local p2 = players[j]

      local x1 = p1.position.x
      local y1 = p1.position.y
      local x2 = p2.position.x
      local y2 = p2.position.y

      local located = hearts:locate(x1, y1, x2, y2)

      if (located ~= nil) add(result, located)
    end
  end

  world.hearts = result
end

function update_scuffs(player, player_meta)
  local t = world.t

  local tile_size = params.layout.tile_size

  local angle = player.position.angle
  local speed = player.position.speed
  local p_x = player.position.x
  local p_y = player.position.y

  local color = player_meta.renders.scuffs.color

  local opposite_angle = (angle + 0.5) % 1
  local x = p_x
  local y = p_y + tile_size / 2
  local v = {angle = opposite_angle, speed = speed}
  local p = {color = color}

  world.scuffs = scuffs:refresh(world.scuffs, x, y, v, t, p)
end

function update_shavings(player, player_meta)
  local t = world.t

  local tile_size = params.layout.tile_size

  local angle = player.position.angle
  local speed = player.position.speed
  local p_x = player.position.x
  local p_y = player.position.y

  local color = player_meta.renders.shavings.color
  local r_jitter = player_meta.renders.shavings.r_jitter

  local opposite_angle = (angle + 0.5) % 1
  local x = p_x
  local y = p_y + tile_size / 2
  local v = {angle = opposite_angle, speed = speed}
  local p = {color = color, r_jitter = r_jitter}

  world.shavings = shavings:refresh(world.shavings, x, y, v, t, p)
end

function update_flags(player, player_meta)
  local t = world.t

  local max_speed = player_meta.physics.max_speed
  local sprite_idle_delay = params.sprites.idle_delay

  local is_idle = player.idle.is_idle
  local idle_t = player.idle.start_t

  local angle = player.position.angle
  local speed = player.position.speed
  local x = player.position.x
  local y = player.position.y

  local dmajor = physics.daxes({angle = angle, speed = speed}).major

  local is_primarily_moving_up = dmajor == cardinals.up
  local is_primarily_moving_left = dmajor == cardinals.left
  local is_primarily_moving_right = dmajor == cardinals.right
  local is_primarily_moving_down = dmajor == cardinals.down

  local is_by_top_edge = physics.by_edge(x, y, cardinals.up, obstructions.border_buffer)
  local is_by_left_edge = physics.by_edge(x, y, cardinals.left, obstructions.border_buffer)
  local is_by_right_edge = physics.by_edge(x, y, cardinals.right, obstructions.border_buffer)
  local is_by_bottom_edge = physics.by_edge(x, y, cardinals.down, obstructions.border_buffer)

  -- merge?
  player_meta.flags.at_max_speed = speed / max_speed >= 1
  player_meta.flags.is_idling = is_idle and (t - idle_t) >= sprite_idle_delay
  player_meta.flags.is_looping_top_bottom_border = (is_by_top_edge or is_by_bottom_edge) and (is_primarily_moving_up or is_primarily_moving_down)
  player_meta.flags.is_looping_left_right_border = (is_by_left_edge or is_by_right_edge) and (is_primarily_moving_left or is_primarily_moving_right)
  player_meta.flags.is_speedy = speed / max_speed >= 0.5
end

function update_facing(player, player_meta, angle)
  local should_face_left = 0.25 < angle and angle < 0.75
  local should_face_right = (0 <= angle and angle < 0.25) or (0.75 < angle and angle <= 1)

  local is_facing_left = player_meta.flags.is_facing_left

  if (should_face_right) is_facing_left = false
  if (should_face_left) is_facing_left = true

  player_meta.flags.is_facing_left = is_facing_left
end

function update_facing_other(player_1, player_meta_1, player_2, player_meta_2)
  local p1x = player_1.position.x
  local p1y = player_1.position.y

  local p2x = player_2.position.x
  local p2y = player_2.position.y

  local p1_angle = atan2(p2x - p1x, p2y - p1y)
  local p2_angle = (p1_angle + 0.5) % 1

  update_facing(player_1, player_meta_1, p1_angle)
  update_facing(player_2, player_meta_2, p2_angle)
end

function update_arrows(players)
  local t = world.t

  local existing = world.arrows

  local updated = {}
  for i = 1, #players do
    local p = players[i]

    local p_x = p.position.x
    local p_y = p.position.y

    local previous
    for a in all(existing) do
      if (a.pid == p.id) previous = a
    end

    local new = arrows.locate(p_x, p_y)

    if (new == nil) then
      -- pass
    elseif (previous == nil) then
      -- arrow is new, create new arrow.

      local arrow = deepmerge(new, {
        pid = p.id,
        start_t = t,
      })
      add(updated, arrow)
    else
      -- arrow was visible in previous update, update arrow with new (x, y).

      local arrow = deepmerge(new, {
        pid = previous.pid,
        start_t = previous.start_t,
      })
      add(updated, arrow)
    end
  end
  world.arrows = updated
end

function _update()
  -- Update inputs
  update_cursor()
  update_debug()
  update_keys()
  update_pi()
  update_time()

  -- Update state
  local p_selected = world.players[world.pi]
  local pm_selected = world.player_metas[world.pi]

  local x = p_selected.position.x
  local y = p_selected.position.y

  local v_accel = extract_accel(x, y)
  local v_zero = {angle = 0, speed = 0}

  for i = 1, #world.players do
    local p = world.players[i]
    local pm = world.player_metas[i]

    local is_idle = players.check_idle(p, pm)
    local delta = (p == p_selected) and v_accel or v_zero

    players.update_velocity(p, pm, delta)
    players.update_position(p, pm)
    players.update_idle(p, pm, is_idle)

    update_scuffs(p, pm)
    update_shavings(p, pm)
    update_flags(p, pm)
  end

  if (#world.players == 2) then
    update_facing_other(
      world.players[1],
      world.player_metas[1],
      world.players[2],
      world.player_metas[2])
  end

  update_hearts()

  if (world.end_t == nil and #world.hearts > 0) world.end_t = world.t

  -- Update UI
  cameras:follow(p_selected, pm_selected)
  update_arrows(world.players)
end

-->8
-- draw

heart_renderer = {
  idle_duration = 1,
  sprites = {sprites.c.heart1, sprites.c.heart2},
}

player_renderer = {
  -- TODO: offset never changes, so these tables can be cached.
  _sprite_table = function(player, player_meta)
    local offset = player_meta.renders.sprites.offset

    local c_offsets = {
      [cardinals.up] = offset,
      [cardinals.left] = offset + 16,
      [cardinals.right] = offset + 32,
      [cardinals.down] = offset + 48,
    }

    local result = {
      default = c_offsets[cardinals.right],
      idle = c_offsets[cardinals.right] + 4,
    }
    local ordered = {cardinals.up, cardinals.left, cardinals.right, cardinals.down}
    for cardinal in all(ordered) do
      local c_o = c_offsets[cardinal]
      result[cardinal] = {
        default = c_o,
        accel = c_o + 1,
        accel_max = c_o + 2,
        accel_max_alt = c_o + 3,
      }
    end
    return result
  end,
  get_sprite = function(self, player, player_meta, is_selected)
  -- https://nerdyteachers.com/PICO-8/Guide/SPRITE_SHEET
  -- https://carsonk.net/PICO-8-Spritesheet-Shenanigans/

    local t = world.t

    local sprite_accel_alt_duration = params.sprites.accel_alt_duration
    local sprite_idle_speed = params.sprites.idle_speed

    local at_max_speed = player_meta.flags.at_max_speed
    local flip = player_meta.flags.is_facing_left
    local is_idling = player_meta.flags.is_idling
    local is_speedy = player_meta.flags.is_speedy

    local idle_t = player.idle.start_t

    local sprites = self._sprite_table(player, player_meta)

    local use_alt_sprite = pick_t({true, false}, t, sprite_accel_alt_duration)
    local use_idle_sprite = pick_t({is_idling, false}, t - idle_t, sprite_idle_speed)

    local c_sprites

    -- If we're facing left, use the opposite direction.
    -- We flip the sprite we're using when we render it.
    if (is_selected) then
      if (false) then
        -- pass
      elseif (flip and keys.left) then
        c_sprites = sprites[cardinals.right]
      elseif (flip and keys.right) then
        c_sprites = sprites[cardinals.left]
      elseif (keys.right) then
        c_sprites = sprites[cardinals.right]
      elseif (keys.left) then
        c_sprites = sprites[cardinals.left]
      elseif (keys.up) then
        c_sprites = sprites[cardinals.up]
      elseif (keys.down) then
        c_sprites = sprites[cardinals.down]
      end
    end

    if (c_sprites == nil) then
      if (use_idle_sprite) then
        return sprites.idle
      else
        return sprites.default
      end
    elseif (at_max_speed and use_alt_sprite) then
      return c_sprites.accel_max_alt
    elseif (at_max_speed) then
      return c_sprites.accel_max
    elseif (is_speedy) then
      return c_sprites.accel
    else
      return c_sprites.default
    end
  end,
}

rendering = {
  _draw_outline = function(sprite, x, y)
      for dx = -1, 1 do
        for dy = -1, 1 do
          spr(sprite, x + dx, y + dy)
        end
      end
  end,
  _with_color = function(color, callback)
    for i = 0, 15 do
      if i ~= colors.transparent then
        pal(i, color)
      end
    end
    callback()
    pal()
    p_reset()
  end,
  all = function(
    self,
    arrows,
    hearts,
    players,
    player_metas,
    selected_pid,
    scuffs,
    shavings)
    local drawns = {}

    -- arrows
    for arrow in all(arrows) do
      local drawn = self:arrow(arrow)
      add(drawns, drawn)
    end

    -- frames
    local drawn = self.frames()
    add(drawns, drawn)

    -- hearts
    for heart in all(hearts) do
      local drawn = self:heart(heart)
      add(drawns, drawn)
    end

    -- map
    local drawn = self.map()
    add(drawns, drawn)

    -- obstructions
    local drawn = self.obstructions()
    add(drawns, drawn)

    -- players
    local p_selected = players[selected_pid]
    local pm_selected = player_metas[selected_pid]

    for i = 1, #players do
      local p = players[i]
      local pm = player_metas[i]
      local is_selected = p == p_selected
      local p_sprite = player_renderer:get_sprite(p, pm, is_selected)

      local outline = is_selected and s_outline_selected or s_outline

      local drawn_reflection = self:player(p, pm, p_sprite, s_reflection)
      add(drawns, drawn_reflection)

      local drawn_outline = self:player(p, pm, p_sprite, outline)
      add(drawns, drawn_outline)

      local drawn_player = self:player(p, pm, p_sprite, s_default)
      add(drawns, drawn_player)
    end

    -- scuffs
    for scuff in all(scuffs) do
      local drawn = self.scuff(scuff)
      add(drawns, drawn)
    end

    -- shavings
    for shaving in all(shavings) do
      local drawn = self.shaving(shaving)
      add(drawns, drawn)
    end

    return drawns
  end,
  arrow = function(self, arrow)
    local tile_size = params.layout.tile_size

    local arrow_padding = arrows.padding

    local x = arrow.x
    local y = arrow.y
    local sprite
    if (false) then
      -- pass
    elseif (arrow.intercardinal == diagonals.up_left) then
      sprite = sprites.c.arrow_up_left
    elseif (arrow.intercardinal == cardinals.up) then
      sprite = sprites.c.arrow_up
    elseif (arrow.intercardinal == diagonals.up_right) then
      sprite = sprites.c.arrow_up_right
    elseif (arrow.intercardinal == cardinals.left) then
      sprite = sprites.c.arrow_left
    elseif (arrow.intercardinal == cardinals.right) then
      sprite = sprites.c.arrow_right
    elseif (arrow.intercardinal == diagonals.down_left) then
      sprite = sprites.c.arrow_down_left
    elseif (arrow.intercardinal == cardinals.down) then
      sprite = sprites.c.arrow_down
    elseif (arrow.intercardinal == diagonals.down_right) then
      sprite = sprites.c.arrow_down_right
    else
      assert(false, "Invalid value for intercardinal: " .. arrow.intercardinal)
    end

    if (arrow.intercardinal == diagonals.up_left or
      arrow.intercardinal == cardinals.left or
      arrow.intercardinal == diagonals.down_left) then
      x += arrow_padding
    end
    if (arrow.intercardinal == diagonals.up_left or
      arrow.intercardinal == cardinals.up or
      arrow.intercardinal == diagonals.up_right) then
      y += arrow_padding
    end
    if (arrow.intercardinal == diagonals.up_right or
      arrow.intercardinal == cardinals.right or
      arrow.intercardinal == diagonals.down_right) then
      x -= arrow_padding
      x -= tile_size
    end
    if (arrow.intercardinal == diagonals.down_left or
      arrow.intercardinal == cardinals.down or
      arrow.intercardinal == diagonals.down_right) then
      y -= arrow_padding
      y -= tile_size
    end

    local _draw_outline = function() self._draw_outline(sprite, x, y) end

    local draw = function()
      self._with_color(colors.white, _draw_outline)
      spr(sprite, x, y, 1, 1)
    end

    return {
      draw = draw,
      type = "arrow",
      z_index = z_indices.frame,
    }
  end,
  frames = function(self)
    local map_height = params.layout.map_height
    local map_width = params.layout.map_width
    local tile_size = params.layout.tile_size

    local cx = cam.x
    local cy = cam.y

    local offset_celx = tiles.frame.offset_celx
    local offset_cely = tiles.frame.offset_cely

    local r = frames:get_rect()

    local draw = function()
      map(offset_celx, offset_cely, cx, cy, map_width / tile_size, map_height / tile_size)
      rect(r.left - 1, r.top - 1, r.width, r.height, colors.dark_blue)
    end

    return {
      draw = draw,
      type = "frame",
      z_index = z_indices.frame,
    }
  end,
  heart = function(self, heart)
    local tile_size = params.layout.tile_size

    local heart_idle_duration = heart_renderer.idle_duration
    local heart_sprites = heart_renderer.sprites

    local start_t = heart.start_t
    local x = heart.x - tile_size / 2
    local y = heart.y - tile_size / 2

    local sprite = pick_t(heart_sprites, start_t, heart_idle_duration)

    local draw_outline = function() self._draw_outline(sprite, x, y) end

    local draw = function()
      self._with_color(colors.white, draw_outline)
      spr(sprite, x, y)
    end

    return {
      draw = draw,
      type = "heart",
      z_index = z_indices.heart,
    }
  end,
  map = function()
    local map_height = params.layout.map_height
    local map_width = params.layout.map_width
    local tile_size = params.layout.tile_size

    local offset_celx = tiles.map.offset_celx
    local offset_cely = tiles.map.offset_cely

    local draw = function()
      map(offset_celx, offset_cely, 0, 0, map_width / tile_size, map_height / tile_size)
    end

    return {
      draw = draw,
      type = "map",
      z_index = z_indices.map,
    }
  end,
  obstructions = function()
    -- Drawing each map tile one-by-one produces significant frame drops.
    -- Draw them in a single operation instead.
    local offset_celx = tiles.obstruction.offset_celx
    local offset_cely = tiles.obstruction.offset_cely

    local map_height = params.layout.map_height
    local map_width = params.layout.map_width
    local tile_size = params.layout.tile_size

    local draw = function()
      map(offset_celx, offset_cely, 0, 0, map_width / tile_size, map_height / tile_size)
    end

    return {
      draw = draw,
      type = "obstruction",
      z_index = z_indices.obstruction,
    }
  end,
  player_inner = function(sprite, cx, cy, stretch_h, stretch_v, flip_h, flip_v)
    local sprite_stretch_ratio = params.sprites.stretch_ratio
    local tile_size = params.layout.tile_size

    local rh = (stretch_h and sprite_stretch_ratio or 1.0) * tile_size
    local rv = (stretch_v and sprite_stretch_ratio or 1.0) * tile_size

    local left = cx - rh / 2
    local top = cy - rv / 2

    local sx = (sprite % 16) * 8
    local sy = (sprite \ 16) * 8

    sspr(sx, sy, tile_size, tile_size, left, top, rh, rv, flip_h, flip_v)
  end,
  player = function(self, player, player_meta, sprite, variant)
    local tile_size = params.layout.tile_size

    local p_x = player.position.x
    local p_y = player.position.y

    local flip = player_meta.flags.is_facing_left
    local stretch_h = player_meta.flags.is_looping_left_right_border
    local stretch_v = player_meta.flags.is_looping_top_bottom_border
    local flash = player_meta.renders.stretch.color

    if (variant == s_outline) then
      local draw_outline = function()
        for dx = -1, 1 do
          for dy = -1, 1 do
            self.player_inner(sprite, p_x + dx, p_y + dy, stretch_h, stretch_v, flip, false)
          end
        end
      end

      local draw = function()
        self._with_color(colors.white, draw_outline)
      end

      return {
        draw = draw,
        type = variant,
        z_index = p_y + tile_size / 2,
      }
    end

    if (variant == s_outline_selected) then
      local draw_outline_selected = function()
        for dx = -1, 1 do
          for dy = -1, 1 do
            self.player_inner(sprite, p_x + dx, p_y + dy, stretch_h, stretch_v, flip, false)
          end
        end
      end

      local draw = function()
        self._with_color(colors.yellow, draw_outline_selected)
      end

      return {
        draw = draw,
        type = variant,
        z_index = p_y + tile_size / 2,
      }
    end
    if (variant == s_reflection) then
      local draw_reflection = function()
        self.player_inner(sprite, p_x, p_y + tile_size, stretch_h, stretch_v, flip, true)
      end

      local draw = function()
        self._with_color(colors.dark_blue, draw_reflection)
      end

      return {
        draw = draw,
        type = variant,
        z_index = z_indices.reflection,
      }
    end

    if (stretch_h or stretch_v) then
      local draw_stretched = function()
        self.player_inner(sprite, p_x, p_y, stretch_h, stretch_v, flip, false)
      end

      local draw = function()
        self._with_color(flash, draw_stretched)
      end

      return {
        draw = draw,
        type = variant,
        z_index = p_y + tile_size / 2,
      }
    end

    local draw = function()
      self.player_inner(sprite, p_x, p_y, stretch_h, stretch_v, flip, false)
    end

    return {
      draw = draw,
      type = variant,
      z_index = p_y + tile_size / 2,
    }
  end,
  scuff = function(scuff)
    local angle = scuff.angle
    local color = scuff.color
    local length = scuff.length
    local start_x = scuff.start_x
    local start_y = scuff.start_y

    local end_x = start_x + cos(angle) * length
    local end_y = start_y + sin(angle) * length

    local draw = function()
      if (color ~= colors.transparent) then
        line(start_x, start_y, end_x, end_y, color)
      end
    end

    return {
      draw = draw,
      type = "scuff",
      z_index = z_indices.scuff,
    }
  end,
  shaving = function(shaving)
    local t = world.t

    local color = shaving.color
    local r_jitter = shaving.r_jitter
    local r_jitter_duration = shaving.r_jitter_duration
    local start_t = shaving.start_t
    local loc = shavings.locate(shaving)

    if (loc == nil) then
      return {
        draw = function() end,
        type = "shaving",
        z_index = 0,
      }
    end

    local x = loc.x
    local y = loc.y
    local r = pick_t(r_jitter, t - start_t, r_jitter_duration)

    local draw = function()
      circ(x, y, r, color)
    end

    return {
      draw = draw,
      type = "shaving",
      z_index = z_indices.shaving,
    }
  end,
}

function draw_layered()
  local drawns = rendering:all(
    world.arrows,
    world.hearts,
    world.players,
    world.player_metas,
    world.pi,
    world.scuffs,
    world.shavings)

  local acc = function(drawn)
    return drawn.z_index
  end
  local sorted = stable_sort(drawns, acc)

  for drawn in all(sorted) do
    drawn.draw()
  end
end

function draw_record()
  local fr = frames:get_rect()
  local sr = strings:get_rect(" ")
  local s_height = sr.height
  local s_width = sr.width

  if (world.end_t ~= nil) then
    local s = "t: " .. world.end_t .. "s"
    rectfill(fr.left, fr.top, fr.left + #s * s_width - 1, fr.top + s_height - 1, colors.dark_blue)
    print(s, fr.left, fr.top, colors.white)
  end
end

function draw_debug_position(player)
  local p_x = player.position.x
  local p_y = player.position.y

  pset(p_x, p_y, colors.transparent)
end

function draw_debug(player)
  local tile_size = params.layout.tile_size
  local viewport_size = params.layout.viewport_size

  local cx = cam.x
  local cy = cam.y

  local pid = player.id
  local angle = player.position.angle
  local speed = player.position.speed
  local p_x = player.position.x
  local p_y = player.position.y

  local mb = cursor.b
  local mx = cursor.x
  local my = cursor.y
  local m_enabled = cursor.enabled and "true" or "false"

  local debug_print_value = dbg.debug_print_value

  local lines = {
    "pid: " .. pid,
    "trajectory: " .. deb(angle, speed),
    "(x, y): " .. deb(p_x, p_y),
    "cursor: ".. deb(mx, my, mb, m_enabled),
    "buttons: " .. btn(),
    "debug: " .. debug_print_value,
  }

  for i = 1, #lines do
    rectfill(cx,
      cy + tile_size * i,
      cx + viewport_size / 2,
      cy + tile_size * (i + 1),
      colors.black)
    print(lines[i],
      cx,
      cy + tile_size * i,
      colors.light_gray)
  end
end

function draw_cursor()
  local cx = cam.x
  local cy = cam.y

  if (cursor.enabled) spr(sprites.c.cursor, cx + cursor.x, cy + cursor.y)
end

function _draw()
  cls(colors.black)

  local p_selected = world.players[world.pi]
  local pm_selected = world.player_metas[world.pi]

  camera(cam.x, cam.y)
  draw_layered()
  draw_record()

  if (dbg.enabled) draw_debug_position(p_selected)
  if (dbg.enabled) draw_debug(p_selected)

  draw_cursor()
end

__gfx__
0022002255bbbbbbbbbbbbbbccccccccccccccccb777777b7777777777777777bbb55bbbbbb55bbb5555555bb555555500000000000000000000000000000000
002200225a5bbbbbbbbbbbbbcccccccccccccc7c7c77ccc77777777777767777bb5aa5bbbbb5a5bb5aaaaa5bb5aaaaa500000000000000000000000000000000
220022005a95bbbbbb88b88bccccccccccccc77c777ccc777777777777667767b5aaaa5bbbb5aa5b5aaaa5bbbb5aaaa500000000000000000000000000000000
220022005aa95bbbbb88888bcccccccccccc77cc77ccc77777777777777777775aaaa995bbb5aaa55aaa5bbbbbb5aaa500000000000000000000000000000000
002200225aa995bbbbb888bbcccccccccccccccc7ccc77c7777777777777777755555555bbb5aa9559a5bbbbbbbb5a9500000000000000000000000000000000
002200225aaa55bbbbbb8bbbcccccccccccccccc7cc77cc77777777776776677bbbbbbbbbbb5a95b595bbbbbbbbbb59500000000000000000000000000000000
2200220055595bbbbbbbbbbbcccccccccc77cccc7777cc777777777777776777bbbbbbbbbbb595bb55bbbbbbbbbbbb5500000000000000000000000000000000
22002200bb555bbbbbbbbbbbccccccccc77cccccb777777b7777777777777777bbbbbbbbbbb55bbbbbbbbbbbbbbbbbbb00000000000000000000000000000000
0000000000000000bbbbbbbb00000000cccccccc771111770000000077777777bbb55bbbbbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000
0000000000000000bbbbbbbb00000000cccc7ccc711111170000000077777767bb5a5bbbbbbbbbbb55bbbbbbbbbbbb5500000000000000000000000000000000
0000000000000000b88b88bb00000000cc7ccccc711cc1170000000076677777b5aa5bbbbbbbbbbb5a5bbbbbbbbbb5a500000000000000000000000000000000
0000000000000000b88888bb00000000c77ccccc71cc111700000000776777775aaa5bbb555555555aa5bbbbbbbb5aa500000000000000000000000000000000
0000000000000000bb888bbb00000000c7ccc7cc7cc111c7000000007777767759aa5bbb5aaaaa955aaa5bbbbbb5aaa500000000000000000000000000000000
0000000000000000bbb8bbbb00000000cccc77cc7c111cc70000000077777667b59a5bbbb5aaa95b5aaaa5bbbb5aaaa500000000000000000000000000000000
0000000000000000bbbbbbbb00000000c7cc7ccc7111cc170000000076777777bb595bbbbb5a95bb599aaa5bb5aaa99500000000000000000000000000000000
0000000000000000bbbbbbbb00000000cccccccccc1cc1cc0000000077777777bbb55bbbbbb55bbb5555555bb555555500000000000000000000000000000000
66666666777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777766666666
66666666111177777777777777777777777771117717771777711777777711177777761777777777777777777777777777777776177616761677777766666666
66666666177771777777777777777777777717771717717777177177777177717777771777777777777777777777777777777777177717771717777766666666
66666666177777771177177171716711777717777717177777177177777177777711771771177171177711777771177171177711177717771777711766666666
666666661d1761717717177171177177177771117711777777711771777711177177171717717117717177177717717117717177177771717617177166666666
6666666617777171771717717177711117777777171717711717717777777771717717177d1171777177d117777d117177717177177771717717177766666666
66666666177771717717177171777177777717771717717777177177777177717177171717717177717177177717717177717177177777177717177166666666
66666666177771771177711171777711d77771117717771777711771777711177711771771117177717711177771117177717711177777177717711766666666
66666666777777717777777766666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
6666666677777771dd17777766666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66666666777777717771777766666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66666666777777717771777766666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66666666777777771117777766666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66666666777777777777777766666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66666666777777777777777766666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66666666777777777777777766666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
bb44454bbb44454bbb44454bbb44454b00000000000000000000000000000000bb99989bbb99989bbb99989bbb99989b00000000000000000000000000000000
b444554bb444554bb444554bb444554b00000000000000000000000000000000b999889bb999889bb999889bb999889b00000000000000000000000000000000
4457ff7b4457ff7b4457ff7b4457ff7b00000000000000000000000000000000b987ff7bb987ff7bb987ff7bb987ff7b00000000000000000000000000000000
55fcffcb55fcffcb55fcffcb55fcffcb00000000000000000000000000000000b8f2ff2bb8f2ff2bb8f2ff2bb8f2ff2b00000000000000000000000000000000
b5fffffbb5fffffb55fffffb55fffffb0000000000000000000000000000000088fffffb88fffffbb8fffffbb8fffffb00000000000000000000000000000000
bb8822bbbb8822bbbb8822bbbb8822bb00000000000000000000000000000000bb8822bb888822bbb88822bbb88822bb00000000000000000000000000000000
bb8888bbbb8888bbbb8888bbbb8888bb00000000000000000000000000000000b98888bbb98888bbb98888bbb98888bb00000000000000000000000000000000
bbbdbdbbbbbdbdbbbb8dbdbbbb8dbdbb0000000000000000000000000000000099b5b5bb99b5b5bbb9b5b5bbb9b5b5bb00000000000000000000000000000000
bb44454bb44454bbb44454bbb44454bb00000000000000000000000000000000bb99989bb99989bbb99989bbb99989bb00000000000000000000000000000000
b444554b444554bb444554bb444554bb00000000000000000000000000000000b999889b999889bb999889bb999889bb00000000000000000000000000000000
4457ff7b457ff7bb457ff7bb457ff7bb00000000000000000000000000000000b987ff7b987ff79b987ff79b987ff79b00000000000000000000000000000000
55fcffcb5fcffcbb5fcffcbb5fcffcbb00000000000000000000000000000000b8f2ff2b8f2ff29b8f2ff29b882ff29900000000000000000000000000000000
b5fffffb5fffffbb5fffffbb5fffffbb0000000000000000000000000000000088fffffb8fffff9b88ffff998fffff9b00000000000000000000000000000000
bb8822bbbb8228bbbb82288bbb8228bb00000000000000000000000000000000bb8822bbbb8228bbbb8228bbbb8228bb00000000000000000000000000000000
bb8888bbbb8888bbbb8888bbbb88888b00000000000000000000000000000000b98888bbb98888bbb98888bbb98888bb00000000000000000000000000000000
bbbdbdbbbbdbdbbbbbdbdbbbbbdbdbbb0000000000000000000000000000000099b5b5bbb95b5bbbb95b5bbbb95b5bbb00000000000000000000000000000000
bb44454bbbb44454bb444454bb444454bbbbbbbb000000000000000000000000bb99989bbbb99989bbb99989bbb99989bbbbbbbb000000000000000000000000
b444554bbb444554b4444554b4444554bb44454b000000000000000000000000b999889bbb999889bb999889bb999889bb99989b000000000000000000000000
4457ff7bb4457ff744457ff744457ff7b444554b000000000000000000000000b987ff7bbb987ff7b9987ff7b9987ff7b999889b000000000000000000000000
55fcffcbb55fcffcb55fcffcb55fcffc4457ff7b000000000000000000000000b8f2ff2bbb8f2ff2b88f2ff2888f2ff2b987ff7b000000000000000000000000
b5fffffbbb5fffffbb5fffffbb5fffff55fcffcb00000000000000000000000088fffffbb88fffff888fffffb88fffffb8f2ff2b000000000000000000000000
bb8822bbbb88822bb888822bbb88822bb5fffffb000000000000000000000000bb8822bbbbb8822bbb98822b9998822b88fffffb000000000000000000000000
bb8888bbbb88888bbb88888bb888888bbb8822bb000000000000000000000000b98888bbbb98888b9998888bbb98888bbb8822bb000000000000000000000000
bbbdbdbbbbbdbdbbbbbdbdbbbbbdbdbbbb8888bb00000000000000000000000099b5b5bbb995b5bbbbb5b5bbbbb5b5bb998888bb000000000000000000000000
bb44454bb444454b4444454b4444454b00000000000000000000000000000000bb99989bbb99989bbb99989bbb99989b00000000000000000000000000000000
b444554b4444554b4444554b4444554b00000000000000000000000000000000b999889bb999889b8899889b8899889b00000000000000000000000000000000
4457ff7b4457ff7b5457ff7b5457ff7b00000000000000000000000000000000b987ff7b8887ff7b8887ff7b8887ff7b00000000000000000000000000000000
55fcffcb55fcffcbb5fcffcbb5fcffcb00000000000000000000000000000000b8f2ff2b88f2ff2bb8f2ff2bb8f2ff2b00000000000000000000000000000000
b5fffffbbbfffffbb8fffffbb8fffffb0000000000000000000000000000000088fffffbbbfffffbbbfffffbbbfffffb00000000000000000000000000000000
bb8822bbbb8822bbb88822bbb88822bb00000000000000000000000000000000bb8822bb9b8822bb9b8822bb9b8822bb00000000000000000000000000000000
bb8888bbbb8888bbbb8888bbbb8888bb00000000000000000000000000000000b98888bb998888bb998888bb998888bb00000000000000000000000000000000
bbbdbdbbbbbdbdbbbbbdbdbbbbbdbdbb0000000000000000000000000000000099b5b5bbbbb5b5bbbbb5b5bbbbb5b5bb00000000000000000000000000000000
__label__
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777767777777777776777777777777777777777777777777777777777777777777776777777777777777777777777777777777
77777777777777777777777776677777777777777766776777777777777777777777777777777777777777777667777777777777777777777777777777777777
77777777777777777777777777677777777777777777777777777777777777777777777777777777777777777767777777777777777777777777777777777777
77777777777777777777777777777677777777777777777777777777777777777777777777777777777777777777767777777777777777777777777777777777
77777777777777777777777777777667777777777677667777777777777777777777777777777777777777777777766777777777777777777777777777777777
77777777777777777777777776777777777777777777677777777777777777777777777777777777777777777677777777777777777777777777777777777777
77777771111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111117777777
77777771ccccccccccccccccccccccccccccccccccccccccccccccccc777777cc777777ccccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccccc7ccccccccccccccccccccccccccccccccccc7c77ccc77c77ccc7cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccc7ccccccccccccccccccccccccccccccccccccc777ccc77777ccc77cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccc77ccccccccccccccccccccccccccccccccccccc77ccc77777ccc777cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccc7ccc7ccccccccc7777777cccccccccccccccccc7ccc77c77ccc77c7cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccccc77cccccccc77999897cccccccccccccccccc7cc77cc77cc77cc7cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccc7cc7ccccccccc79998897cccccccccccccccccc7777cc777777cc77cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccccccccccccccc7987ff77ccccccccccccccccccc777777cc777777ccccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccccccccccccccc778f2ff27ccccccccccccccccccc777777cc777777ccccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccccccccccccccc788fffff7cccccccccccccccccc7c77ccc77c77ccc7cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccccccccccccccc777882277cccccccccccccccccc777ccc77777ccc77cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccccccccccccccc79988887ccccccccccccccccccc77ccc77777ccc777cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccccccccccccccc77777777ccccccccccccccccccc7ccc77c77ccc77c7cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccccccccccccccccc1111cccccccccccccccccccc7cc77cc77cc77cc7cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccccccccccccccc1111111ccccccccccccccccccc7777cc777777cc77cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccccccccccccccccc111111cccccccccccccccccccc777777cc777777ccccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccccccccccc77777711777777cccccccccccccccccc777777cc777777cccccccccccccccccc777777cc777777ccccccccccccccccc17777777
77777771cccccccccccccccc7c77ccc77c77ccc7cccccccccccccccc7c77ccc77c77ccc7cccccccccccccc7c7c77ccc77c77ccc7cccccccccccccccc17777777
77777771cccccccccccccccc777ccc77777ccc77cccccccccccccccc777ccc77777ccc77ccccccccccccc77c777ccc77777ccc77cccccccccccccccc17777777
77777771cccccccccccccccc77ccc77777ccc777cccccccccccccccc77ccc77777ccc777cccccccccccc77cc77ccc77777ccc777cccccccccccccccc17777777
77777771cccccccccccccccc7ccc77c77ccc77c7cccccccccccccccc7ccc77c77ccc77c7cccccccccccccccc7ccc77c77ccc77c7cccccccccccccccc17777777
77777771cccccccccccccccc7cc77cc77cc77cc7cccccccccccccccc7cc77cc77cc77cc7cccccccccccccccc7cc77cc77cc77cc7cccccccccccccccc17777777
77777771cccccccccccccccc7777cc777777cc77cccccccccccccccc7777cc777777cc77cccccccccc77cccc7777cc777777cc77cccccccccccccccc17777777
77777771ccccccccccccccccc777777cc777777cccccccccccccccccc777777cc777777cccccccccc77cccccc777777cc777777ccccccccccccccccc17777777
77777771c777777cc777777cc777777cc777777cccccccccccccccccc777777cc777777cccccccccccccccccc777777cc777777cc777777cc777777c17777777
777777717c77ccc77c77ccc77c77ccc77c77ccc7cccccccccccccccc7c77ccc77c77ccc7cccccccccccccccc7c77ccc77c77ccc77c77ccc77c77ccc717777777
77777771777ccc77777ccc77777ccc77777ccc77cccccccccccccccc777ccc77777ccc77cccccccccccccccc777ccc77777ccc77777ccc77777ccc7717777777
7777777177ccc77777ccc77777ccc77777ccc777cccccccccccccccc77ccc77777ccc777cccccccccccccccc77ccc77777ccc77777ccc77777ccc77717777777
777777717ccc77c77ccc77c77ccc77c77ccc77c7cccccccccccccccc7ccc77c77ccc77c7cccccccccccccccc7ccc77c77ccc77c77ccc77c77ccc77c717777777
777777717cc77cc77cc77cc77cc77cc77cc77cc7cccccccccccccccc7cc77cc77cc77cc7cccccccccccccccc7cc77cc77cc77cc77cc77cc77cc77cc717777777
777777717777cc777777cc777777cc777777cc77cccccccccccccccc7777cc777777cc77cccccccccccccccc7777cc777777cc777777cc777777cc7717777777
77777771c777777cc777777cc777777cc777777cccccccccccccccccc777777cc777777cccccccccccccccccc777777cc777777cc777777cc777777c17777777
77777771ccccccccccccccccccccccccccccccccccccccccccccccccc777777cc777777ccccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777761cccccccccccccccccccccccccccccccccccccccccccccccc7c77ccc77c77ccc7cccccccccccccccccccccccccccccccccccccccccccccccc17777767
76677771cccccccccccccccccccccccccccccccccccccccccccccccc777ccc77777ccc77cccccccccccccccccccccccccccccccccccccccccccccccc16677777
77677771cccccccccccccccccccccccccccccccccccccccccccccccc77ccc77777ccc777cccccccccccccccccccccccccccccccccccccccccccccccc17677777
77777671cccccccccccccccccccccccccccccccccccccccccccccccc7ccc77c77ccc77c7cccccccccccccccccccccccccccccccccccccccccccccccc17777677
77777661cccccccccccccccccccccccccccccccccccccccccccccccc7cc77cc77cc77cc7cccccccccccccccccccccccccccccccccccccccccccccccc17777667
76777771cccccccccccccccccccccccccccccccccccccccccccccccc7777cc777777cc77cccccccccccccccccccccccccccccccccccccccccccccccc16777777
77777771ccccccccccccccccccccccccccccccccccccccccccccccccc777777cc777777ccccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccccccccccccccccccccccccccccccccccccccccccc777777cc777777ccccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccccccccccccccccccccccc7ccccccccccccccccc7c77ccc77c77ccc7cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccccccccccccccccccccccc77ccccccccccccccccc777ccc77777ccc77cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccccccccccccccccccccc77cccccccccccccccccc77ccc77777ccc777cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccccccccccccccccccccccccccccccccccccccccc7ccc77c77ccc77c7cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccccccccccccccccccccccccccccccccccccccccc7cc77cc77cc77cc7cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccccccccccccccccccc77cccccccccccccccccccc7777cc777777cc77cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccccccccccccccccccc77cccccccccccccccccccccc777777cc777777ccccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccccccccccc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777ccccccccccccccccc17777777
77777771cccccccccccccccc7c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc7cccccccccccccccc17767777
77777771cccccccccccccccc777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77cccccccccccccccc17667767
77777771cccccccccccccccc77ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc777cccccccccccccccc17777777
77777771cccccccccccccccc7ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c7cccccccccccccccc17777777
77777771cccccccccccccccc7cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc7cccccccccccccccc16776677
77777771cccccccccccccccc7777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc77cccccccccccccccc17776777
77777771ccccccccccccccccc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777ccccccccccccccccc17777777
77777771ccccccccccccccccc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777ccccccccccccccccc17777777
77777771cccccccccccc7ccc7c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc7cccccccccccccccc17777777
77777771cccccccccc7ccccc777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77cccccccccccccccc17777777
77777771ccccccccc77ccccc77ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc77777ccc777cccccccccccccccc17777777
77777771ccccccccc7ccc7cc7ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c77ccc77c7cccccccccccccccc17777777
77777771cccccccccccc77cc7cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc77cc7cccccccccccccccc17777777
77777771ccccccccc7cc7ccc7777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc77cccccccccccccccc17777777
77777771ccccccccccccccccc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777cc777777ccccccccccccccccc17777777
77777771ccccccccccccccccc777777cc777777cccccccccccccccccccccccccccccccccccccccccccccccccc777777cc777777ccccccccccccccccc17777777
77767771cccccccccccccccc7c77ccc77c77ccc7cccccccccccccccccccccccccccccccccccccccccccccccc7c77ccc77c77ccc7cccc7ccccccccccc17777777
77667761cccccccccccccccc777ccc77777ccc77cccccccccccccccccccccccccccccccccccccccccccccccc777ccc77777ccc77cc7ccccccccccccc17777777
77777771cccccccccccccccc77ccc77777ccc777cccccccccccccccccccccccccccccccccccccccccccccccc77ccc77777ccc777c77ccccccccccccc17777777
77777771cccccccccccccccc7ccc77c77ccc77c7cccccccccccccccccccccccccccccccccccccccccccccccc7ccc77c77ccc77c7c7ccc7cccccccccc17777777
76776671cccccccccccccccc7cc77cc77cc77cc7cccccccccccccccccccccccccccccccccccccccccccccccc7cc77cc77cc77cc7cccc77cccccccccc17777777
77776771cccccccccccccccc7777cc777777cc77cccccccccccccccccccccccccccccccccccccccccccccccc7777cc777777cc77c7cc7ccccccccccc17777777
77777771ccccccccccccccccc777777cc777777cccccccccccccccccccccccccccccccccccccccccccccccccc777777cc777777ccccccccccccccccc17777777
77777771ccccccccccccccccc777777cc777777cccccccccccccccccccccccccccccccccccccccccccccccccc777777cc777777ccccccccccccccccc17777777
77777771cccccccccccccccc7c77ccc77c77ccc7cccccccccccccccccccccccccccccccccccccccccccccccc7c77ccc77c77ccc7cccccccccccccccc17777777
77777771cccccccccccccccc777ccc77777ccc77cccccccccccccccccccccccccccccccccccccccccccccccc777ccc77777ccc77ccaaaaaaaccccccc17777777
77777771cccccccccccccccc77ccc77777ccc777cccccccccccccccccccccccccccccccccccccccccccccccc77ccc77777ccc777cca45444aacccccc17777777
77777771cccccccccccccccc7ccc77c77ccc77c7cccccccccccccccccccccccccccccccccccccccccccccccc7ccc77c77ccc77c7cca455444aaccccc17777777
77777771cccccccccccccccc7cc77cc77cc77cc7cccccccccccccccccccccccccccccccccccccccccccccccc7cc77cc77cc77cc7cca7ff7544accccc17777777
77777771cccccccccccccccc7777cc777777cc77cccccccccccccccccccccccccccccccccccccccccccccccc7777cc777777cc77ccacffcf55accccc17777777
77777771ccccccccccccccccc777777cc777777cccccccccccccccccccccccccccccccccccccccccccccccccc777777cc777777cccafffff5aaccccc17777777
77777771ccccccccccccccccccccccccccccccccccccccccccccccccc777777cc777777cccccccccccccccccccccccccccccccccccaa2288aacccccc17777777
77777771cccccccccccccccccccccccccccccccccccccccccccccccc7c77ccc77c77ccc7cccccccccccccccccccccc7cccccccccccca8888accccccc17777767
77777771cccccccccccccccccccccccccccccccccccccccccccccccc777ccc77777ccc77ccccccccccccccccccccc77ccccccccccccadadaaccccccc16677777
77777771cccccccccccccccccccccccccccccccccccccccccccccccc77ccc77777ccc777cccccccccccccccccccc77cccccccccccccaaaaacccccccc17677777
77777771cccccccccccccccccccccccccccccccccccccccccccccccc7ccc77c77ccc77c7cccccccccccccccccccccccccccccccccccc1111cccccccc17777677
77777771cccccccccccccccccccccccccccccccccccccccccccccccc7cc77cc77cc77cc7cccccccccccccccccccccccccccccccccccc1111cccccccc17777667
77777771cccccccccccccccccccccccccccccccccccccccccccccccc7777cc777777cc77cccccccccccccccccc77ccccccccccccccc111111ccccccc16777777
77777771ccccccccccccccccccccccccccccccccccccccccccccccccc777777cc777777cccccccccccccccccc77cccccccccccccccc1111111cccccc17777777
77777771ccccccccccccccccccccccccccccccccccccccccccccccccc777777cc777777cccccccccccccccccccccccccccccccccccc1111111cccccc17777777
77777771cccccccccccccccccccccccccccccccccccccc7ccccccccc7c77ccc77c77ccc7ccccccccccccccccccccccccccccccccccc111111ccccccc17777777
77777771ccccccccccccccccccccccccccccccccccccc77ccccccccc777ccc77777ccc77ccccccccccccccccccccccccccccccccccc11111cccccccc17777777
77777771cccccccccccccccccccccccccccccccccccc77cccccccccc77ccc77777ccc777cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccccccccccccccccccccccccccccccccccccccccc7ccc77c77ccc77c7cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccccccccccccccccccccccccccccccccccccccccc7cc77cc77cc77cc7cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771cccccccccccccccccccccccccccccccccc77cccccccccccc7777cc777777cc77cccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771ccccccccccccccccccccccccccccccccc77cccccccccccccc777777cc777777ccccccccccccccccccccccccccccccccccccccccccccccccc17777777
77777771111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111117777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777111177777777777777777777777771117717771777711777777711177777761777777777777777777777777777777776177616761677777777777777
77777777177771777777777777777777777717771717717777177177777177717777771777777777777777777777777777777777177717771717777777777777
77777777177777771177177171716711777717777717177777177177777177777711771771177171177711777771177171177711177717771777711777777777
777777771d1761717717177171177177177771117711777777711771777711177177171717717117717177177717717117717177177771717617177177777777
7777777717777171771717717177711117777777171717711717717777777771717717177d1171777177d117777d117177717177177771717717177777777777
77777777177771717717177171777177777717771717717777177177777177717177171717717177717177177717717177717177177777177717177177777777
77777777177771771177711171777711d77771117717771777711771777711177711771771117177717711177771117177717711177777177717711777777777
77777777777777717777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
7777777777777771dd17777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777717771777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777717771777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777771117777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777

__gff__
0000000000020200000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0505050505050505050505050505050503030303030303030303030303030303030303030303030303030303030303030505050505050505050505050505050505050505050505050505050505050505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0500000000000005050000000000000503030303030303030303030303030303030314030303030303030303030303030500000505000000000000000000000505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0500000000000005050000000000000503030303030303030303030303030303030303030303030303030303030303030500000505000000000000000000000505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0500000505000005050000050500000503030303030303030303030303030303030303030303030303030403030303030500000505000005050505050500000505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505000005050000050505050503030303030303030303030303030303030303030303030303030303030303030500000505000005050505050500000505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0500000000000005050000000000000503030303030303030303030303030303030303030303030303030303030303030500000000000005050000000000000505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0500000000000005050000000000000503030303030303030303030303030303030303030403030303030303030303030500000000000005050000000000000505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0500000505050505050505050500000503030303030303030303030303030303030303030303030303030303030303030505050505050505050000050505050505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0500000505050505050505050500000503030303030303030303030303030303030314030303030303030303030303030505050505050505050000050505050505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0500000505000000000000050500000503030303030303030303030303030303030303030303030303030303031403030500000000000005050000000000000505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0500000505000000000000050500000503030303030303030303030303030303030303030303030303030303030303030500000000000005050000000000000505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0500000000000005050000000000000503030303030303030303030303030303030303030303030303030304030303030500000505000005050505050500000505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0500000000000005050000000000000503030303030303030303030303030303030303030304030303030303030303030500000505000005050505050500000505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050503030303030303030303030303030303030303030303030303030303030303030500000505000000000000000000000505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050503030303030303030303030303030303030303030303030303030303030303030500000505000000000000000000000505000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050503030303030303030303030303030303030303030303030303030303030303030500000505050505050505050505050505050505050505050505050505000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0606061706070606060606170606060603030303030303030303030303030303030303030303030303030303030303030500000505050505050505050505050505050505050505050505050505000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600000000000000000000000000000603030303030303030303030303030303030303030303030303030303030303030500000000000005050000000000000000000000000000050500000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600000000000000000000000000000603030303030303030303030303030303030303030303030303030303030303030500000000000005050000000000000000000000000000050500000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600000000000000000000000000000603030303030303030303030303030303030303030303030303030303030303030505050505000005050000050505050505050505050000050500000505050505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600000000000000000000000000000603030303030303030303030303030303030303030303030303030303030303030505050505000005050000050505050505050505050000050500000505050505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1700000000000000000000000000001703030303030303030303030303030303030303030303030303030303030303030500000000000005050000000000000505000000000000050500000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600000000000000000000000000000603030303030303030303030303030303030303030303030303030303030303030500000000000005050000000000000505000000000000050500000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600000000000000000000000000000703030303030303030303030303030303030303030303030303030303030303030500000505050505050505050500000505000005050505050505050505000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600000000000000000000000000000603030303030303030303030303030303030303030303030303030303030303030500000505050505050505050500000505000005050505050505050505000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0700000000000000000000000000000603030303030303030303030303030303030303030303030303030303030303030500000505000000000000050500000505000005050000000000000505000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600000000000000000000000000000603030303030303030303030303030303030303030303030303030303030303030500000505000000000000050500000505000005050000000000000505000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600000000000000000000000000001703030303030303030303030303030303030303030303030303030303030303030500000505000005050000050500000505000005050000050500000505000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600000000000000000000000000000603030303030303030303030303030303030303030303030303030303030303030500000505000005050000050500000505000005050000050500000505000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0606060606060606060606060606060603030303030303030303030303030303030303030303030303030303030303030500000000000005050000000000000505000000000000050500000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
062122232425262728292a2b2c2d2e0603030303030303030303030303030303030303030303030303030303030303030500000000000005050000000000000505000000000000050500000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0631320606060606060606060606060603030303030303030303030303030303030303030303030303030303030303030505050505050505050505050505050505050505050505050505050505050505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
