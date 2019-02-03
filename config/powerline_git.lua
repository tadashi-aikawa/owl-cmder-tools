-- Constants
local segmentColors = {
    clean = {
        fill = colorGreen,
        text = colorWhite
    },
    conflict = {
        fill = colorYellow,
        text = colorWhite
    },
    dirtyLocal = {
        fill = colorRed,
        text = colorWhite
    },
    dirtyStaged = {
        fill = colorMagenta,
        text = colorWhite
    },
    dirtyRemote = {
        fill = colorCyan,
        text = colorWhite
    }
}

function get_git_branch(git_dir)
    git_dir = git_dir or get_git_dir()

    -- If git directory not found then we're probably outside of repo
    -- or something went wrong. The same is when head_file is nil
    local head_file = git_dir and io.open(git_dir..'/HEAD')
    if not head_file then return end

    local HEAD = head_file:read()
    head_file:close()

    -- if HEAD matches branch expression, then we're on named branch
    -- otherwise it is a detached commit
    local branch_name = HEAD:match('ref: refs/heads/(.+)')

    return branch_name or 'HEAD detached at '..HEAD:sub(1, 7)
end

function get_git_status()
    local file = io.popen("git --no-optional-locks status --porcelain | cut -c-2 | c:\\tools\\Cmder\\vendor\\git-for-windows\\usr\\bin\\sort | uniq -c 2>nul")
    local add, add_staged, modify, modify_staged, delete, delete_staged, rename, unknown = 0, 0, 0, 0, 0, 0, 0, 0
    for line in file:lines() do
        num, kindStaged, kind = string.match(line, ".+(%d+) (.)(.)")
        if kind == "A" then
          add = add + num
        elseif kind == "M" then
          modify = modify + num
        elseif kind == "D" then
          delete = delete + num
        elseif kind == "?" then
          unknown = unknown + num
        end

        if kindStaged == "A" then
          add_staged = add_staged + num
        elseif kindStaged == "M" then
          modify_staged = modify_staged + num
        elseif kindStaged == "D" then
          delete_staged = delete_staged + num
        elseif kindStaged == "R" then
          rename = rename + num
        end
    end
    file:close()

    return add, add_staged, modify, modify_staged, delete, delete_staged, rename, unknown
end


function git_ahead_behind_module()
    local file = io.popen("git rev-list --count --left-right @{upstream}...HEAD 2>nul")
    local ahead, behind = "0", "0"
    for line in file:lines() do
        ahead, behind = string.match(line, "(%d+).+(%d+)")
    end
    file:close()

    return ahead, behind
end

function get_git_conflict()
    local file = io.popen("git diff --name-only --diff-filter=U 2>nul")
    for line in file:lines() do
        file:close()
        return true;
    end
    file:close()
    return false
end

local segment = {
    isNeeded = false,
    text = "",
    textColor = 0,
    fillColor = 0
}
local segmentStaged = {
    isNeeded = false,
    text = "",
    textColor = 0,
    fillColor = 0
}
local segmentRemote = {
    isNeeded = false,
    text = "",
    textColor = 0,
    fillColor = 0
}

---
-- Sets the properties of the Segment object, and prepares for a segment to be added
---
local function init()
    segment.isNeeded = get_git_dir()
    segmentStaged.isNeeded = false
    segmentRemote.isNeeded = false

    if not segment.isNeeded then
        return
    end

    local branch = get_git_branch(git_dir)
    if not branch then
        return
    end

    local add, add_staged, modify, modify_staged, delete, delete_staged, rename, unknown = get_git_status()
    local ahead, behind = git_ahead_behind_module()
    local gitConflict = get_git_conflict()

    -- Local
    segment.text = " "..plc_git_branchSymbol.." "..branch.." "
    segment.textColor = segmentColors.clean.text
    segment.fillColor = segmentColors.clean.fill

    if gitConflict then
        segment.textColor = segmentColors.conflict.text
        segment.fillColor = segmentColors.conflict.fill
        if plc_git_conflictSymbol then
            segment.text = segment.text..plc_git_conflictSymbol
        end
        return
    end
    if add ~= 0 then
        segment.textColor = segmentColors.dirtyLocal.text
        segment.fillColor = segmentColors.dirtyLocal.fill
        segment.text = segment.text.."+"..add.." "
    end
    if modify ~= 0 then
        segment.textColor = segmentColors.dirtyLocal.text
        segment.fillColor = segmentColors.dirtyLocal.fill
        segment.text = segment.text.."*"..modify.." "
    end
    if delete ~= 0 then
        segment.textColor = segmentColors.dirtyLocal.text
        segment.fillColor = segmentColors.dirtyLocal.fill
        segment.text = segment.text.."-"..delete.." "
    end
    if unknown ~= 0 then
        segment.textColor = segmentColors.dirtyLocal.text
        segment.fillColor = segmentColors.dirtyLocal.fill
        segment.text = segment.text.."?"..unknown.." "
    end

    segmentStaged.isNeeded = add_staged ~= 0 or modify_staged ~= 0 or delete_staged ~= 0 or rename ~= 0
    if segmentStaged.isNeeded then
        -- Staged
        segmentStaged.text = " ↗ "
        segmentStaged.textColor = segmentColors.clean.text
        segmentStaged.fillColor = segmentColors.clean.fill
        if add_staged ~= 0 then
            segmentStaged.textColor = segmentColors.dirtyStaged.text
            segmentStaged.fillColor = segmentColors.dirtyStaged.fill
            segmentStaged.text = segmentStaged.text.."+"..add_staged.." "
        end
        if modify_staged ~= 0 then
            segmentStaged.textColor = segmentColors.dirtyStaged.text
            segmentStaged.fillColor = segmentColors.dirtyStaged.fill
            segmentStaged.text = segmentStaged.text.."*"..modify_staged.." "
        end
        if delete_staged ~= 0 then
            segmentStaged.textColor = segmentColors.dirtyStaged.text
            segmentStaged.fillColor = segmentColors.dirtyStaged.fill
            segmentStaged.text = segmentStaged.text.."-"..delete_staged.." "
        end
        if rename ~= 0 then
            segmentStaged.textColor = segmentColors.dirtyStaged.text
            segmentStaged.fillColor = segmentColors.dirtyStaged.fill
            segmentStaged.text = segmentStaged.text.."🎃"..rename.." "
        end
    end

    -- Remote
    segmentRemote.isNeeded = ahead ~= "0" or behind ~= "0"
    if segmentRemote.isNeeded then
        segmentRemote.text = " ☁ "
        segmentRemote.textColor = segmentColors.clean.text
        segmentRemote.fillColor = segmentColors.clean.fill
        if ahead ~= "0" then
            segmentRemote.textColor = segmentColors.dirtyRemote.text
            segmentRemote.fillColor = segmentColors.dirtyRemote.fill
            segmentRemote.text = segmentRemote.text.."↓"..ahead.." "
        end
        if behind ~= "0" then
            segmentRemote.textColor = segmentColors.dirtyRemote.text
            segmentRemote.fillColor = segmentColors.dirtyRemote.fill
            segmentRemote.text = segmentRemote.text.."↑"..behind.." "
        end
    end
end

---
-- Uses the segment properties to add a new segment to the prompt
---
local function addAddonSegment()
    init()
    if segment.isNeeded then
        addSegment(segment.text, segment.textColor, segment.fillColor)
    end
    if segmentStaged.isNeeded then
        addSegment(segmentStaged.text, segmentStaged.textColor, segmentStaged.fillColor)
    end
    if segmentRemote.isNeeded then
        addSegment(segmentRemote.text, segmentRemote.textColor, segmentRemote.fillColor)
    end
end

clink.prompt.register_filter(addAddonSegment, 61)
