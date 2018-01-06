-- Generated with Love Project Builder
-- https://github.com/ediiknorand/love-project-builder

local Class = {}

local meta_events = {
  __index = true,
  __newindex = true,
  __mode = true,
  __call = true,
  __metatable = true,
  __tostring = true,
  __len = true,
  __pairs = true,
  __ipairs = true,
  __gc = true,
  __unm = true,
  __add = true,
  __sub = true,
  __mul = true,
  __div = true,
  __mod = true,
  __pow = true,
  __concat = true,
  __eq = true,
  __lt = true,
  __le = true,
}

local class_mt = {
  __newindex = function(class, key, value)

    assert(
      key ~= '__super',
      'Attempting to overwrite superclass'
    )

    if key == '__index' then
      assert(
        type(value) == 'table' or type(value) == 'function',
        'Attempting to assign a non-table/function value to __index'
      )
      rawset(
        class.__objmt,
        key,
        function(object, k)
          local result

          if type(value) == 'function' then
            result = value(object, k)
          elseif type(value) == 'table' then
            result = value[k]
          end

          if result == nil then
            result = rawget(class, k)
          end

          return result
        end
      )
    elseif meta_events[key] then
      rawset(class.__objmt, key, value)
    else
      rawset(class, key, value)
    end

  end,

  __call = function(class, ...)
    local object

    if class.__new then
      object = class.__new(...)
    else
      object = {...}
    end

    object.__class = class
    setmetatable(object, class.__objmt)

    return object
  end,

  __le = function(left, right)
    local class = left

    while class do
      if class == right then
        return true
      end
      class = class.__super
    end

    return false
  end,

  __lt = function(left, right)
    local class = left.__super

    while class do
      if class == right then
        return true
      end
      class = class.__super
    end

    return false
  end
}

local function new_class(_, base_class)
  local class = {}
  class.__objmt = {__index = class}

  assert(
    base_class == nil
    or type(base_class) == 'table'
    and base_class.__objmt,
    'Bad argument #1: Class expected'
  )

  if base_class then
    for k,v in pairs(base_class) do
      if k == '__objmt' then

        for mt_k,mt_v in pairs(v) do
          if mt_k ~= '__index' and mt_k ~= '__newindex' then
            class.__objmt[mt_k] = mt_v
          end
        end

      else
        class[k] = v
      end
    end
    class.__super = base_class
  end

  setmetatable(class, class_mt)

  return class
end

setmetatable(Class, {__call=new_class})

return Class
