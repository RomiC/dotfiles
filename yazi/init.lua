-- Remove the percentage segment from the right side
Status:children_remove(5, Status.RIGHT)

-- Add modified + created dates for files (not dirs) on the right side
local function fmt_date(ts)
	local t      = math.floor(ts)
	local ft     = os.date("*t", t)
	local now    = os.date("*t")
	local months = { "Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec" }
	local time   = string.format("%02d:%02d:%02d", ft.hour, ft.min, ft.sec)

	if ft.year == now.year and ft.month == now.month and ft.day == now.day then
		return time
	elseif ft.year == now.year then
		return ft.day .. " " .. months[ft.month] .. ", " .. time
	else
		return ft.day .. " " .. months[ft.month] .. " " .. ft.year .. ", " .. time
	end
end

Status:children_add(function(self)
	local h = self._current.hovered
	if not h or h.cha.is_dir then
		return ui.Line {}
	end

	local spans = { ui.Span("  ") }  -- margin from permissions

	if h.cha.btime then
		spans[#spans + 1] = ui.Span(" c: " .. fmt_date(h.cha.btime) .. " "):style(ui.Style():fg("#2e2e2e"):bg("#d0d0ff"))
	end
	if h.cha.mtime then
		spans[#spans + 1] = ui.Span(" m: " .. fmt_date(h.cha.mtime) .. " "):style(ui.Style():fg("#2e2e2e"):bg("#b4c973"))
	end

	return ui.Line(spans)
end, 1500, Status.RIGHT)

-- Shorten mode name: NOR → N, SEL → S, UNS → U
function Status:mode()
	local mode = tostring(self._tab.mode):sub(1, 1):upper()

	local style = self:style()
	return ui.Line {
		ui.Span(th.status.sep_left.open):fg(style.main:bg()):bg("reset"),
		ui.Span(" " .. mode .. " "):style(style.main),
		ui.Span(th.status.sep_left.close):fg(style.main:bg()):bg(style.alt:bg()),
	}
end

-- Only show file size for files, not directories
function Status:length()
	local h = self._current.hovered
	if not h or h.cha.is_dir then
		return ""
	end

	local style = self:style()
	return ui.Line {
		ui.Span(" " .. ya.readable_size(h.cha.len) .. " "):style(style.alt),
		ui.Span(th.status.sep_left.close):fg(style.alt:bg()),
	}
end
