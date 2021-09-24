hs.alert.show('hammerspoon reload!');

hs.hotkey.bind({'option', 'cmd'}, 'r', function() hs.reload() end) -- reload 해주기

hs.hotkey.bind({'shift', 'option'}, 'N', function() -- note 앱 켜기
    hs.application.launchOrFocus('Notes')
end)

local function move_win_to_left()
    local win = hs.window.focusedWindow()   -- 현재 활성화된 앱의 윈도우
    local frame = win:frame()
    local screen = win:screen():frame()     -- 현재 화면
    frame.x = screen.x
    frame.y = screen.y
    frame.w = screen.w / 2      -- width를 화면의 1/2 로 조정
    frame.h = screen.h
    win:setFrame(frame)
end

local function move_win_to_right()
    local win = hs.window.focusedWindow()
    local frame = win:frame()
    local screen = win:screen():frame()
    frame.x = screen.x + (screen.w / 2) -- 윈도우의 x 좌표를 화면 width의 1/2 로 조정
    frame.y = screen.y
    frame.w = screen.w / 2      -- width를 화면의 1/2 로 조정
    frame.h = screen.h
    win:setFrame(frame)
end

local function move_win_to_top()
    local win = hs.window.focusedWindow()
    local frame = win:frame()
    local screen = win:screen():frame()
    frame.x = screen.x
    frame.y = screen.y
    frame.w = screen.w
    frame.h = screen.h
    win:setFrame(frame)
end

hs.hotkey.bind({'option', 'control', 'shift'}, 'left', move_win_to_left)
hs.hotkey.bind({'option', 'control', 'shift'}, 'right', move_win_to_right)
hs.hotkey.bind({'option', 'control', 'shift'}, 'up', move_win_to_top)

local inputEnglish = "com.apple.keylayout.ABC"

do
    local inputSource = {
        english = "com.apple.keylayout.ABC",
        korean = "com.apple.inputmethod.Korean.2SetKorean",
    }

    local changeInput = function()

        local current = hs.keycodes.currentSourceID()
        local nextInput = nil

        if current == inputSource.english then
            nextInput = inputSource.korean
        else
            nextInput = inputSource.english
        end
        hs.keycodes.currentSourceID(nextInput)
    end
    hs.hotkey.bind({'shift'}, 'space', changeInput)
end

function escapeForVim() 
    local input_source = hs.keycodes.currentSourceID()
    if not (input_source == inputEnglish) then
        hs.eventtap.keyStroke({}, 'right')
        hs.keycodes.currentSourceID(inputEnglish)
    end
    hs.eventtap.keyStroke({''}, 'escape')
end

-- hs.hotkey.bind({'control'}, 'c', escapeForVim)