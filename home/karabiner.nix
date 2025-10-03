{ ... }: {
  home.file.".config/karabiner/karabiner.json".text = builtins.toJSON {
    global = {
      check_for_updates_on_startup = true;
      show_in_menu_bar = true;
      show_profile_name_in_menu_bar = false;
    };
    profiles = [
      {
        name = "Default profile";
        parameters = {
          delay_milliseconds_before_open_device = 1000;
        };
        selected = true;
        simple_modifications = [];
        virtual_hid_keyboard = {
          country_code = 0;
          indicate_sticky_modifier_keys_state = true;
          mouse_key_xy_scale = 100;
        };
        complex_modifications = {
          parameters = {
            basic.simultaneous_threshold_milliseconds = 50;
            basic.to_delayed_action_delay_milliseconds = 500;
            basic.to_if_alone_timeout_milliseconds = 1000;
            basic.to_if_held_down_threshold_milliseconds = 500;
            mouse_motion_to_scroll.speed = 100;
          };
          rules = [
            {
              description = "Caps Lock → Control/Escape, Left Control → Hyper";
              manipulators = [
                {
                  type = "basic";
                  from.key_code = "caps_lock";
                  to = [{ key_code = "left_control"; }];
                  to_if_alone = [{ key_code = "escape"; }];
                }
                {
                  type = "basic";
                  from.key_code = "left_control";
                  to = [{ 
                    key_code = "left_shift";
                    modifiers = ["left_command" "left_option" "left_control"];
                  }];
                }
              ];
            }
            {
              description = "Microsoft Keyboard Option ↔ Command Swap";
              manipulators = [
                {
                  type = "basic";
                  from = {
                    key_code = "left_option";
                    modifiers = {
                      mandatory = ["left_command"];
                    };
                  };
                  to = [{ 
                    key_code = "left_option";
                    modifiers = ["left_command"];
                  }];
                  conditions = [{
                    type = "device_if";
                    identifiers = [{ vendor_id = 1118; }];
                  }];
                }
                {
                  type = "basic";
                  from = {
                    key_code = "left_command";
                    modifiers = {
                      mandatory = ["left_option"];
                    };
                  };
                  to = [{ 
                    key_code = "left_command";
                    modifiers = ["left_option"];
                  }];
                  conditions = [{
                    type = "device_if";
                    identifiers = [{ vendor_id = 1118; }];
                  }];
                }
                {
                  type = "basic";
                  from.key_code = "left_option";
                  to = [{ key_code = "left_command"; }];
                  conditions = [{
                    type = "device_if";
                    identifiers = [{ vendor_id = 1118; }];
                  }];
                }
                {
                  type = "basic";
                  from.key_code = "right_option";
                  to = [{ key_code = "right_command"; }];
                  conditions = [{
                    type = "device_if";
                    identifiers = [{ vendor_id = 1118; }];
                  }];
                }
                {
                  type = "basic";
                  from.key_code = "left_command";
                  to = [{ key_code = "left_option"; }];
                  conditions = [{
                    type = "device_if";
                    identifiers = [{ vendor_id = 1118; }];
                  }];
                }
                {
                  type = "basic";
                  from.key_code = "right_command";
                  to = [{ key_code = "right_option"; }];
                  conditions = [{
                    type = "device_if";
                    identifiers = [{ vendor_id = 1118; }];
                  }];
                }
              ];
            }
          ];
        };
        devices = [];
        fn_function_keys = [];
        one_to_many_mappings = {};
      }
    ];
  };

}
