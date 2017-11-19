function State.get_current()
  local state = state_stack:peek()
  if state == nil then
    love.event.quit(0)
    return State{}
  end
  return state
end

function State.push(state)
  assert(
    type(state) == 'table'
    and state.__class
    and state.__class <= State,
    'Attempting to push a non-state object onto the state stack'
  )
  state_stack:push(state)
end

function State.pop()
  local top = state_stack:pop()

  State.get_current():restore(top)

  return top
end
