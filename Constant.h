//
//  Constant.h
//  LocalTest
//
//  Created by Huahan on 4/18/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#ifndef LocalTest_Constant_h
#define LocalTest_Constant_h

//global settins
#define WC_ENV @"stage"

//debug settings
#define DEBUG_DEVICE_TOKEN @"d6915bfdc113c048a04666f61b733916ec23ef6db0c0b2c1081ec9f721df8c33"


//picker view
#define PICKER_TITLE_SHOWS_UP @"Shows Up"
#define PICKER_TITLE_SHOWS_MORE @"Shows More"
#define PICKER_TITLE_SHOWS_LESS @"Shows Less"
#define PICKER_TITLE_DISAPPEAR @"Disappear"
#define PICKER_NUM_ROWS 4

//local sqlite
#define PLAYER_DOC_NAME @"WWC.sqlite"
#define WCTASK_ENTITY_NAME @"WCTask"
#define WCWEBPAGE_ENTITY_NAME @"WCWebPage"

//Alert
#define PATTERN_FIND_ALERT_TIME_INTERVAL 360
#define SHOW_PATTERN_FOUND_ALERT NO

//Background Image
#define BACKGROUND_IMAGE_POOL_SIZE 1
#define BACKGROUND_COLOR_R 236
#define BACKGROUND_COLOR_G 236
#define BACKGROUND_COLOR_B 236

//Network Setting
#define NW_SERVERHOST @"52.26.203.246"
#define NW_NEW_WCTASK_PATH @"td/index.php/wc/wcctrl/add_new_wc_entry"
#define NW_NEW_WCTASK_HTTP_GET_FORMAT @"http://%@/%@?url=%@&pattern=%@&patternCount=%@&wctype=%@&uuid=%@"
#define NW_DEL_WCTASK_PATH @"td/index.php/wc/wcctrl/delete_wc_entry"
#define NW_DEL_WCTASK_HTTP_GET_FORMAT @"http://%@/%@?url=%@&pattern=%@&wctype=%@&uuid=%@"
#define NW_GET_WCTASK_PATH @"td/index.php/wc/wcctrl/get_wc_tasks"
#define NW_GET_WCTASK_HTTP_GET_FORMAT @"http://%@/%@?uuid=%@"
#define NW_SING_UP_PATH @"td/index.php/wc/userctrl/signup"
#define NW_SING_UP_HTTP_GET_FORMAT @"http://%@/%@?username=%@&pwd=%@"
#define NW_SING_IN_PATH @"td/index.php/wc/userctrl/signin"
#define NW_SING_IN_HTTP_GET_FORMAT @"http://%@/%@?username=%@&pwd=%@"
#endif

//View Shared Settings
#define WINDOW_HERDER_HEIGHT 20

//MainView
#define MAIN_VIEW_SCROLL_VIEW_INIT_HEIGHT 56
#define MAIN_VIEW_TOP_HEIGHT 56

//DetailWebView
#define DETAIL_WEB_VIEW_BOTTOM_BUTTON_HEIGHT 47
