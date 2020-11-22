local bufferline = require("bufferline")

bufferline.setup {
  options = {
    view = "multiwindow",
    numbers = "none",
    number_style = "superscript",
    mappings = true,
    buffer_close_icon= '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    tab_size = 18,
    show_buffer_close_icons = false,
    separator_style = "slant",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = "relative_directory"
  }
}
