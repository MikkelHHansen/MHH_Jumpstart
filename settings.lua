data:extend{
  {
    name = 'mhh-jumpstart-preset',
    type = 'string-setting',
    setting_type = 'startup',
    default_value = 'cheaty',
    allowed_values = { 'balanced', 'advanced', 'overpowered', 'cheaty' },
    order = 'a'
  },
  {
    name = 'mhh-jumpstart-quality',
    type = 'string-setting',
    setting_type = 'startup',
    default_value = 'normal',
    allowed_values = { 'normal', 'uncommon', 'rare', 'epic', 'legendary' },
    order = 'b'
  },
  {
    name = 'mhh-jumpstart-starter-items',
    type = 'string-setting',
    setting_type = 'startup',
    default_value = 'none',
    allowed_values = { 'none', 'balanced', 'advanced', 'overpowered', 'cheaty' },
    order = 'c'
  },
}
