local BLOCKS = {
    --Motion
    motion_movesteps = {},
    motion_turnright = {},
    motion_turnleft = {},
    motion_pointindirection = {},
    motion_pointtowards = {},
    motion_gotoxy = {},
    motion_goto = {},
    motion_glidesecstoxy = {},
    motion_glideto = {},
    motion_changexby = {},
    motion_setx = {},
    motion_changeyby = {},
    motion_sety = {},
    motion_ifonedgebounce = {},
    motion_setrotationstyle = {},
    motion_scroll_right = {},
    motion_scroll_up = {},
    motion_align_scene = {},
    --Sound
    sound_play = {},
    sound_playuntildone = {},
    sound_stopallsounds = {},
    sound_seteffectto = {},
    sound_changeeffectby = {},
    sound_cleareffects = {},
    sound_changevolumeby = {},
    sound_setvolumeto = {},
    --Control
    control_wait = {},
    control_wait_until = {},
    control_create_clone_of = {},
    control_incr_counter = {},
    control_clear_counter = {},
    --Sensing
    sensing_askandwait = {},
    sensing_setdragmode = {},
    sensing_resettimer = {},
    --Operators
    operator_lt = {},
    operator_equals = {},
    operator_gt = {},
    operator_and = {},
    operator_or = {},
    operator_not = {},
    operator_contains = {},
    --Data (Variables+List)
    data_setvariableto = {},
    data_changevariableby = {},
    data_showvariable = {},
    data_hidevariable = {},
    data_addtolist = {},
    data_deleteoflist = {},
    data_deletealloflist = {},
    data_insertatlist = {},
    data_replaceitemoflist = {},
    data_showlist = {},
    data_hidelist = {},
    --------------
    --Extensions--
    --------------
    --Pen
    extension_pen_down = {},
    --Music
    extension_music_drum = {},
    extension_music_play_note = {},
    --Microbit
    extension_microbit_display = {},
    --WeDo
    extension_wedo_motor = {},
}

local REPORTERS = {
    --Shadows
    argument_reporter_string_number = {},
    argument_editor_string_number = {},
    math_number = {},
    math_integer = {},
    math_whole_number = {},
    math_positive_number = {},
    math_angle = {},
    matrix = {},
    colour_picker = {},
    text = {},
    note = {},
    --Motion
    motion_xposition = {},
    motion_yposition = {},
    motion_direction = {},
    motion_xscroll = {},
    motion_yscroll = {},
    --Sound
    sound_volume = {},
    --Control
    control_get_counter = {},
    --Sensing
    sensing_distanceto = {},
    sensing_answer = {},
    sensing_mousex = {},
    sensing_mousey = {},
    sensing_loudness = {},
    sensing_timer = {},
    sensing_of = {},
    sensing_current = {},
    sensing_dayssince2000 = {},
    sensing_username = {},
    sensing_userid = {},
    --Operators
    operator_add = {},
    operator_subtract = {},
    operator_multiply = {},
    operator_divide = {},
    operator_random = {},
    operator_join = {},
    operator_letter_of = {},
    operator_length = {},
    operator_mod = {},
    operator_round = {},
    operator_mathop = {},
    --Data (Variables+List)
    data_variable = {},
    data_listcontents = {},
    data_itemoflist = {},
    data_itemnumoflist = {},
    data_lengthoflist = {},
    --------------
    --Extensions--
    --------------
    --Music
    extension_music_reporter = {},
    --WeDo
    extension_wedo_tilt_reporter = {},
}

local BOOLEANS = {
    --Shadows
    argument_reporter_boolean = {},
    argument_editor_boolean = {},
    --Sensing
    sensing_touchingobject = {},
    sensing_touchingcolor = {},
    sensing_coloristouchingcolor = {},
    sensing_keypressed = {},
    sensing_mousedown = {},
    sensing_loud = {},
    --Data (Variables+List)
    data_listcontainsitem = {},
    --------------
    --Extensions--
    --------------
    --Wedo
    extension_wedo_boolean = {},
}

local HATS = {
    --Control
    control_start_as_clone = {},
    --Events
    event_whentouchingobject = {},
    event_whenflagclicked = {},
    event_whenthisspriteclicked = {},
    event_whenstageclicked = {},
    event_whenbroadcastreceived = {},
    event_whenbackdropswitchesto = {},
    event_whengreaterthan = {},
    event_broadcast = {},
    event_broadcastandwait = {},
    event_whenkeypressed = {},
    --------------
    --Extensions--
    --------------
    --Wedo
    extension_wedo_hat = {},

}

local CAPS = {
    --Control
    control_delete_this_clone = {},
}

local CBLOCKS = {
    --Control
    control_repeat = {},
    control_if = {},
    control_repeat_until = {},
    control_while = {},
    control_for_each = {},
    control_all_at_once = {},
}
local DOUBLE_CBLOCKS = {
    --Control
    control_if_else = {},
}

local SPECIAL = {
    --Control
    control_forever = {},
    control_stop = {},
}

local MENUS = {
    --Motion
    motion_pointtowards_menu = {},
    motion_goto_menu = {},
    motion_glideto_menu = {},
    --Sound
    sound_sounds_menu = {},
    --Control
    control_create_clone_of_menu = {},
    --Events
    event_touchingobjectmenu = {},
    event_broadcast_menu = {},
    --Sensing
    sensing_touchingobjectmenu = {},
    sensing_distancetomenu = {},
    sensing_keyoptions = {},
    sensing_of_object_menu = {},
    --Data (Variables+List)
    data_listindexall = {},
    data_listindexrandom = {},
    --------------
    --Extensions--
    --------------
    --Wedo
    extension_wedo_tilt_menu = {},
}

local OTHER = {
    --Data (Variables+List)
    CUSTOM_CONTEXT_MENU_GET_VARIABLE_MIXIN = {},
    CUSTOM_CONTEXT_MENU_GET_LIST_MIXIN = {},
    VARIABLE_OPTION_CALLBACK_FACTORY = {},
    RENAME_OPTION_CALLBACK_FACTORY = {},
    DELETE_OPTION_CALLBACK_FACTORY = {},
    -- Custom/Procedure/Mutations
    procedures_definition = {},
    procedures_call = {},
    procedures_prototype = {},
    procedures_declaration
}