function love.load()
  screen_width = 500
  screen_height = 300

  background_color = {39, 77, 126}

  initialize_paddle_1()
  initialize_paddle_2()
  initialize_ball()
  initialize_score()

  state = 'play'

  left_score = 0
  right_score = 0

  love.window.setTitle('PONG!')
  love.window.setMode(screen_width, screen_height)
end

function love.update(dt)
  if state ~= 'play' then
    return
  end

  update_paddle_1(dt)
  --update_paddle_2(dt)
  ai_paddle_2(dt)
  bounce_ball_if_it_hits_top_of_screen()
  bounce_ball_if_it_hits_bottom_of_screen()
  bounce_ball_if_it_hits_paddle_1()
  bounce_ball_if_it_hits_paddle_2()
  reset_ball_if_offscreen()
  update_ball(dt)
end

function love.draw()
  set_background()
  draw_paddle_1()
  draw_paddle_2()
  draw_ball()
  draw_score()
  if state == 'pause' then
    draw_pause_overlay()
  end
end

function love.keypressed(key)
  if key == 'q' or key == 'escape' then
    love.event.quit()
  end

  if key == 'p' then
    if state == 'play' then
      state = 'pause'
    else
      state = 'play'
    end
  end
end

function draw_score()
  love.graphics.print( left_score .. ':' .. right_score, 210, 10 )
end

function initialize_score()
  font = love.graphics.newFont(48)
  love.graphics.setFont(font)
end

function initialize_paddle_1()
  paddle_1_width = 20
  paddle_1_height = 70
  paddle_1_x = 0
  paddle_1_y = (screen_height / 2) -  (paddle_1_height / 2)
  paddle_1_speed = 400
  paddle_1_color = {240, 125, 64}
end

function initialize_paddle_2()
  paddle_2_width = 20
  paddle_2_height = 70
  paddle_2_x = screen_width - paddle_2_width
  paddle_2_y = (screen_height / 2) -  (paddle_2_height / 2)
  paddle_2_speed = 120
  paddle_2_color = {240, 125, 64}
end

function initialize_ball()
  ball_width = 20
  ball_height = 20
  ball_x = (screen_width / 2) - (ball_width / 2)
  ball_y = (screen_height / 2) - (ball_height / 2)
  ball_speed_x = -200
  ball_speed_y = 200
  ball_color = {240, 204, 64}
end

function update_paddle_1(dt)
  if love.keyboard.isDown('w') then
    paddle_1_y = paddle_1_y - (paddle_1_speed * dt)
  end
  if love.keyboard.isDown('s') then
    paddle_1_y = paddle_1_y + (paddle_1_speed * dt)
  end

  if paddle_1_y < 0 then
    paddle_1_y = 0
  elseif (paddle_1_y + paddle_1_height) > screen_height then
    paddle_1_y = screen_height - paddle_1_height
  end
end

function ai_paddle_2(dt)
  if ball_y < paddle_2_y then
    paddle_2_y = paddle_2_y - (paddle_2_speed * dt)
  end
  if ball_speed_y > paddle_2_y then
    paddle_2_y = paddle_2_y + (paddle_2_speed * dt)
  end

  if paddle_2_y < 0 then
    paddle_2_y = 0
  elseif (paddle_2_y + paddle_2_height) > screen_height then
    paddle_2_y = screen_height - paddle_2_height
  end
end

function update_paddle_2(dt)
  if love.keyboard.isDown('up') then
    paddle_2_y = paddle_2_y - (paddle_2_speed * dt)
  end
  if love.keyboard.isDown('down') then
    paddle_2_y = paddle_2_y + (paddle_2_speed * dt)
  end

  if paddle_2_y < 0 then
    paddle_2_y = 0
  elseif (paddle_2_y + paddle_2_height) > screen_height then
    paddle_2_y = screen_height - paddle_2_height
  end
end

function bounce_ball_if_it_hits_top_of_screen()
  if ball_y < 0 then
    ball_speed_y = math.abs(ball_speed_y)
  end
end

function bounce_ball_if_it_hits_bottom_of_screen()
  if (ball_y + ball_height) > screen_height  then
    ball_speed_y = -math.abs(ball_speed_y)
  end
end

function bounce_ball_if_it_hits_paddle_1()
  if ball_x <= paddle_1_width and
    (ball_y + ball_height) >= paddle_1_y and
    ball_y < (paddle_1_y + paddle_1_height)
  then
    ball_speed_x = math.abs(ball_speed_x)
  end
end

function bounce_ball_if_it_hits_paddle_2()
  if (ball_x + ball_width) >= (screen_width - paddle_2_width) and
    (ball_y + ball_height) >= paddle_2_y and
    ball_y < (paddle_2_y + paddle_2_height)
  then
    ball_speed_x = -math.abs(ball_speed_x)
  end
end

function reset_ball_if_offscreen()
  if ball_x + ball_width < 0 then
    right_score = right_score + 1
    initialize_ball()
  elseif ball_x > screen_width then
    left_score = left_score + 1
    initialize_ball()
  end

end

function update_ball(dt)
  ball_x = ball_x + (ball_speed_x * dt)
  ball_y = ball_y + (ball_speed_y * dt)
end

function set_background()
  love.graphics.setBackgroundColor(background_color)
end

function draw_paddle_1()
  love.graphics.setColor(paddle_1_color)
  love.graphics.rectangle('fill', paddle_1_x, paddle_1_y, paddle_1_width, paddle_1_height)
end

function draw_paddle_2()
  love.graphics.setColor(paddle_2_color)
  love.graphics.rectangle('fill', paddle_2_x, paddle_2_y, paddle_2_width, paddle_2_height)
end

function draw_ball()
  love.graphics.setColor(ball_color)
  love.graphics.rectangle('fill', ball_x, ball_y, ball_width, ball_height)
end

function draw_pause_overlay()
  love.graphics.setColor(0, 0, 0, 100)
  love.graphics.rectangle('fill', 0, 0, screen_width, screen_height)
end
