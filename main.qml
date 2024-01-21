//Switch to 2.3 for Dash use... 6.2 is for preview in designer.
import QtQuick 2.3

//import Qt3D 1.0
//import QtGraphicalEffects 1.0

import QtGraphicalEffects 1.12
import FileIO 1.0
Item {


    /*#########################################################################
      #############################################################################
      Imported Values From GAWR inits
      #############################################################################
      #############################################################################
     */
    id: root
    property int myyposition: 0
    property int udp_message: rpmtest.udp_packetdata

    // onUdp_messageChanged: console.log(" UDP is "+udp_message)
    property bool udp_up: udp_message & 0x01
    property bool udp_down: udp_message & 0x02
    property bool udp_left: udp_message & 0x04
    property bool udp_right: udp_message & 0x08

    property int membank2_byte7: rpmtest.can203data[10]
    property int inputs: rpmtest.inputsdata

    //Inputs//31 max!!
    property bool ignition: inputs & 0x01
    property bool battery: inputs & 0x02
    property bool lapmarker: inputs & 0x04
    property bool rearfog: inputs & 0x08
    property bool mainbeam: inputs & 0x10
    property bool up_joystick: inputs & 0x20 || root.udp_up
    property bool leftindicator: inputs & 0x40
    property bool rightindicator: inputs & 0x80
    property bool brake: inputs & 0x100
    property bool oil: inputs & 0x200
    property bool seatbelt: inputs & 0x400
    property bool sidelight: inputs & 0x800
    property bool tripresetswitch: inputs & 0x1000
    property bool down_joystick: inputs & 0x2000 || root.udp_down
    property bool doorswitch: inputs & 0x4000
    property bool airbag: inputs & 0x8000
    property bool tc: inputs & 0x10000
    property bool abs: inputs & 0x20000
    property bool mil: inputs & 0x40000
    property bool shift1_id: inputs & 0x80000
    property bool shift2_id: inputs & 0x100000
    property bool shift3_id: inputs & 0x200000
    property bool service_id: inputs & 0x400000
    property bool race_id: inputs & 0x800000
    property bool sport_id: inputs & 0x1000000
    property bool cruise_id: inputs & 0x2000000
    property bool reverse: inputs & 0x4000000
    property bool handbrake: inputs & 0x8000000
    property bool tc_off: inputs & 0x10000000
    property bool left_joystick: inputs & 0x20000000 || root.udp_left
    property bool right_joystick: inputs & 0x40000000 || root.udp_right

    property int odometer: rpmtest.odometer0data / 10
                           * 0.62 //Need to div by 10 to get 6 digits with leading 0
    property int tripmeter: rpmtest.tripmileage0data * 0.62
    property real value: 0
    property real shiftvalue: 0

    property real rpm: rpmtest.rpmdata
    property real rpmlimit: 8000 //Originally was 7k, switched to 8000 -t
    property real rpmdamping: 5
    //property real rpmscaling:0
    property real speed: rpmtest.speeddata
    property int speedunits: 2

    property real watertemp: rpmtest.watertempdata
    property real waterhigh: 100
    property real waterlow: 80
    property real waterunits: 1

    property real fuel: rpmtest.fueldata
    property real fuelhigh: 0
    property real fuellow: 0
    property real fuelunits
    property real fueldamping

    property real o2: rpmtest.o2data
    property real map: rpmtest.mapdata
    property real maf: rpmtest.mafdata

    property real oilpressure: rpmtest.oilpressuredata
    property real oilpressurehigh: 0
    property real oilpressurelow: 0
    property real oilpressureunits: 0

    property real oiltemp: rpmtest.oiltempdata
    property real oiltemphigh: 90
    property real oiltemplow: 90
    property real oiltempunits: 1

    property real batteryvoltage: rpmtest.batteryvoltagedata

    property int mph: (speed * 0.62)

    property int gearpos: rpmtest.geardata

    property real masterbrightness: 1
    property real colourbrightness: 0.5

    property string colorscheme: "green"
    property int red: 0
    property int green: 0
    property int blue: 0
    property string red_value: if (red < 16)
                                   "0" + red.toString(16)
                               else
                                   red.toString(16)
    property string green_value: if (green < 16)
                                     "0" + green.toString(16)
                                 else
                                     green.toString(16)
    property string blue_value: if (blue < 16)
                                    "0" + blue.toString(16)
                                else
                                    blue.toString(16)
    //  onColorschemeChanged: console.log("color scheme is "+colorscheme)
    //property real masterbrightness:fuel/100

    //  onRed_valueChanged: console.log("red_value hex "+red_value)
    // onGreen_valueChanged: console.log("green_value hex "+green_value)
    // onBlue_valueChanged: console.log("blue_value hex "+blue_value)
    width: 800
    height: 480
    clip: true
    z: 0

    property real speed_spring: 1
    property real speed_damping: 1

    property real rpm_needle_spring: 3.0 //if(rpm<1000)0.6 ;else 3.0
    property real rpm_needle_damping: 0.2 //if(rpm<1000).15; else 0.2

    property bool changing_page: rpmtest.changing_pagedata
    //Commenting out this for possible future usage rather than deleting. -Tristan
    onChanging_pageChanged: if (changing_page) {

                                //                                temp_slider_colour_overlay.visible = false
                                //                                gauge_back4.visible = false
                                //                                oilp_slider_colour_overlay.visible = false
                                //                                gauge_back3.visible = false
                                //                                fuel_slider_colour_overlay.visible = false
                                //                                gauge_back.visible = false
                                //                                oilt_slider_colour_overlay.visible = false
                                //                                gauge_back2.visible = false
                            }
    //See Above reason for commenting out
    Component.onCompleted: delay_on_timer.start()
    Timer {
        id: delay_on_timer //this delay on timer is to delay the visibility of certain items , this gives a nice effect and stops opacity fade in of the screen looking crap
        interval: 500
        onTriggered: {

            //            temp_slider_colour_overlay.visible = true
            //            gauge_back4.visible = true
            //            oilp_slider_colour_overlay.visible = true
            //            gauge_back3.visible = true
            //            fuel_slider_colour_overlay.visible = true
            //            gauge_back.visible = true
            //            oilt_slider_colour_overlay.visible = true
            //            gauge_back2.visible = true
        }
    }

    //Tristan Generated Code Here:
    property string white_color: "#FFFFFF"
    property string primary_color: "#FFFFFF" //#FFBF00 for amber
    property string daylight_lcd_color: "#000000" //Daylight LCD should be black (tbd)
    property string night_light_color: "#CDFFBE" //Pale Green for LCD
    property string sweetspot_color: "#FFA500" //Cam Changeover Rev colpr
    property string warning_red: "#FF0000" //Redline/Warning colors
    property string engine_warmup_color: "#eb7500"
    property string background_color: "#000000"
    x: 0
    y: 0

    //Fonts
    FontLoader {
        id: digital7monoitalic
        source: "./fonts/digital7monoitalic.ttf"
    }

    /* ########################################################################## */
    /* Main Layout items */
    /* ########################################################################## */
    Rectangle {
        id: background_rect
        y: 0
        width: 800
        height: 480
        color: root.background_color
        border.width: 0
        z: 0
        Text{
            z: 8
            
            color: '#FFFFFF'
        }
    }
    Item {
        id: background_gradient
        z: 0
        x: 0
        y: 0
        Image {
            source: './img/bkg.png'
            width: 800
            height: 480
        }
    }
    Item {
        id: side_items
        y: 266.7
        x: 544
        z: 1
        Image {
            source: './img/RightDashOutside.png'
            width: 250
            height: 208
        }
    }
    Item{
        id: side_lcd
        y: 277
        x: 560.7
        z: 2
        Image {
            source: if(!root.sidelight) './img/LightFurtherInfo.png'; else './img/DarkFurtherInfo.png'
            width: 222.1
            height: 182
        }
    }

    Item {
        id: centerpiece
        y: 245.5
        x: 245
        z: 3
        Image {
            source: './img/CenterPiece.png'
            width: 313
            height: 230
        }
    }

    Item {
        id: warning_lights
        x: 635
        y: 40
        Image {
            source: './img/warninglightholster.png'
            width: 152
            height: 208
            z: 1
        }
        Image{
            source: './img/door_warning.png'
            width: 67
            height: 32
            z:2
            x: 5
            y: 5
            visible: root.doorswitch
        }
        Image{
            source: './img/ebrake_warning.png'
            width: 67
            height: 32
            z:2
            x: 80
            y: 5
            visible: root.brake
        }
        Image{
            source: './img/seatbelt_warning.png'
            width: 67
            height: 32
            z:2
            x: 5
            y: 42
            visible: root.seatbelt
        }
        Image{
            source: './img/abs_warning.png'
            width: 67
            height: 32
            z:2
            x: 80
            y: 42
            visible: root.abs
        }
        Image{
            source: './img/battery_warning.png'
            width: 67
            height: 32
            z:2
            x: 5
            y: 79
            visible: root.battery
        }
        // TPS??
        // Image{
        //     source: './img/tps_warning.png'
        //     width: 67
        //     height: 32
        //     z:2
        //     x: 80
        //     y: 79
        //     visible: root.tps
        // }
        Image{
            source: './img/oil_warning.png'
            width: 67
            height: 32
            z:2
            x: 5
            y: 116
            visible: root.oil
        }
        Image{
            source: './img/engine_warning.png'
            width: 67
            height: 32
            z:2
            x: 80
            y: 116
            visible: root.mil
        }
        Image{
            source: './img/oil_warning.png'
            width: 67
            height: 32
            z:2
            x: 5
            y: 116
            visible: root.oil
        }
        Image{
            source: './img/engine_warning.png'
            width: 67
            height: 32
            z:2
            x: 80
            y: 116
            visible: root.mil
        }
    }

    Item{
        id: mph_display
        y: 371
        x: 261.6
        z: 4
        Image { 
            source: if(!root.sidelight) './img/LightMPHDisplay.png'; else './img/DarkMPHDisplay.png'
        }
    }

    Text {
        id: speed_display_val
        font.pixelSize: 90
        horizontalAlignment: Text.AlignRight
        font.family: digital7monoitalic.name
        font.pointSize: 90
        x: 328
        y: 370
        width: 134
        height: 75.7
        z: 8
        color: if (!root.sidelight)
                   root.daylight_lcd_color
               else
                   root.night_light_color
        text: if (root.speedunits === 0) {
                  root.speed.toFixed(0) //"0"   // Alec added speed
              } else {
                  root.mph.toFixed(0)
              }
    }
    DropShadow{
        z:7
       anchors.fill: speed_display_val
        source:speed_display_val
       verticalOffset: 3
       radius: 3.0
       samples: 9
       color: '#44000000'
    }
    Image{
        id: mph_label
        z: 7
        width: 47
        height: 21
        x: 481
        y: 428
        source: if(!root.sidelight) './img/Lite_mph.png'; else './img/Dark_mph.png'
        visible: root.speedunits === 1 
    }
    Image{
        id: kmh_label
        z: 7
        width: 47
        height: 21
        x: 481
        y: 428
        source: if(!root.sidelight) './img/Lite_kmh.png'; else './img/Dark_kmh.png'
        visible: root.speedunits === 0
    }
     Text {
        id: odometer_display_val
        text: if (root.speedunits === 0)
                  root.odometer 
              else if (root.speedunits === 1)
                  root.odometer
              else
                  root.odometer
        font.pixelSize: 18
        horizontalAlignment: Text.AlignRight
        font.pointSize: 18
        font.family: digital7monoitalic.name
        x: 463
        y: 384 //480 - 16 - 12
        z: 8
        width: 62
        color: if (!root.sidelight)
                   root.daylight_lcd_color
               else
                   root.night_light_color
    }
    Item {
        id: watertemp_bezel
        x: 30
        y: 288
        z: 1
        Image{
            source: './img/WaterTempRingBack.png'
            height: 187
            width: 187
        }
    }

    Item { 
        id: watertemp_gaugeface
        x: 42
        y: 299
        z: 2
        Image{
            height: 161
            width: 161
            source: if(!root.sidelight) './img/LightWaterTempFace.png'; else './img/DarkWaterTempFace.png'
        }
    }
    Item {
        id: watertemp_needle
        z: 4
        x: 49
        y: 373
        Image{
            height: 12
            width: 85
            source: './img/WaterTempNeedle'
            transform:
                Rotation {
                    id: watertemp_rotate
                    origin.y: 6
                    origin.x: 76
                     //Minimum angle on horizontal needlie is negative 90 for straight down, water temp needs offset of 60 degrees, 
                     //270/60 = 4.5 for angle ratio, max rotation for that horizontal pointing left arrow is 180
                    angle:Math.min(Math.max(-90, ((root.watertemp - 60) * 4.5) - 90), 180)
                    } 
                }
        }
    Item{
        id: watertemp_warning
        z: 4
        x: 145
        y: 400
        Image{
            height: 28
            width: 28
            source: if(root.watertemp < root.waterhigh) './img/warninglightdim.png'; else './img/warninglightlit.png'
        }
    }
    Item {
        id: tachometer_back
        z: 2
        x: 171.4
        y: 12
        Image{
            height: 456
            width: 457
            source: if(!root.sidelight) './img/LightTachFace.png'; else './img/DarkTachFace.png'
        }
    }
    Item{
        id: tachometer_needle
        z: 4
        x: 194
        y: 236
        Image{
            height: 14
            width: 239
            source: './img/TachNeedle.png'
            transform:
                Rotation {
                    id: tachneedle_rotate
                    origin.y: 6
                    origin.x: 205
                    angle: Math.min(Math.max(-28.5, Math.round((root.rpm/1000)*24) - 30), 212.5)                
                }
        }
    }
    
    Item{
        id: shift_lights_dim
        z: 3
        x: 326
        y: 170
        width: 140
        height: 19
        Image{
            x: 0
            y: 0
            height: 19
            width: 46
            source:'./img/ShiftLightDimmed.png'
        }
        Image{
            x: 51
            y: 0
            height: 19
            width: 46
            source: './img/ShiftLightDimmed.png'
        }
        Image{
            x: 102
            y: 0
            height: 19
            width: 46
            source: './img/ShiftLightDimmed.png'
        }
    }
    Item{
        id: shift_lights
        z: 3
        x: 326
        y: 170
        width: 140
        height: 19
        Image{
            x: 0
            y: 0
            height: 19
            width: 46
            source:'./img/ShiftLightLit.png'
            visible: if(root.rpm > 7500) true; else false
            opacity: if(root.rpm < 8200) 100
        }
        Image{
            x: 51
            y: 0
            height: 19
            width: 46
            source:'./img/ShiftLightLit.png'
            visible: if(root.rpm > 7750) true; else false
            opacity: if(root.rpm < 8200) 100

        }
        Image{
            x: 102
            y: 0
            height: 19
            width: 46
            source:'./img/ShiftLightLit.png'
            visible: if(root.rpm > 8000) true; else false
            opacity: if(root.rpm < 8200) 100

        }
        Timer{
            id: rpm_shift_blink
            running: if(root.rpm >= 8200)
                        true
                    else
                        false
            interval: 60
            repeat: true
            onTriggered: if(parent.opacity === 0){
                parent.opacity = 100
            }
            else{
                parent.opacity = 0
            } 
        }
    }
    Text {
        id: oiltemp_display_val
        font.pixelSize: 32
        font.pointSize: 32
        font.family: digital7monoitalic.name
        width: 110
        height: 36
        x: 626.3
        y: 334
        z: 2
        color: if (!root.sidelight)
                   root.daylight_lcd_color
               else
                   root.night_light_color
        text: root.oiltemp.toFixed(0) + "C" // "100C"
        horizontalAlignment: Text.AlignRight

        // visible: if (root.oiltemphigh === 0)
        //              false
        //          else
        //              true
    }
    DropShadow{
        z:2
       anchors.fill: oiltemp_display_val
        source: oiltemp_display_val
       verticalOffset: 3
       radius: 3.0
       samples: 9
       color: '#44000000'
    }
    Text {
        id: oilpressure_display_val
        text: root.oilpressure.toFixed(1)
        font.pixelSize: 36
        font.pointSize: 36
        font.family: digital7monoitalic.name
        horizontalAlignment: Text.AlignRight
        width: 110
        height: 36
        x: 626.3
        y: 285
        z: 2
        color: if (!root.sidelight)
                   root.daylight_lcd_color
               else
                   root.night_light_color
        // visible: if (root.oilpressurehigh === 0)
        //              false
        //          else
        //              true
    }
    DropShadow{
        z:2
       anchors.fill: oilpressure_display_val
        source: oilpressure_display_val
       verticalOffset: 3
       radius: 3.0
       samples: 9
       color: '#44000000'
    }
    Image{
        id: oilpressure_label
        x: 738
        y: 290
        z:3
        width: 45
        height: 32
        source: if(!root.sidelight) './img/LightOilPressure.png';else './img/DarkOilPressure.png'
    }
    Image{
        id: oiltemp_label
        x: 738
        y: 339
        z:3
        width: 42
        height: 34
        source: if(!root.sidelight) './img/LightOilTemp.png';else './img/DarkOilTemp.png'
    }
    Image{
        id: volts_label
        x: 738
        y: 395
        z:3
        width: 39
        height: 17
        source: if(!root.sidelight) './img/LightVolts.png';else './img/DarkVolts.png'
    }
    // Need TPS value for this to be enabled
    // Image{
    //     id: tps_label
    //     x: 680
    //     y:395
    //     source: if(!root.sidelight) './img/lite_tps.png';else './img/dark_tps.png'
    // }
    Image{
        id: gas_label
        x: 745
        y: 423
        z:3
        width: 35
        height: 32
        source: if(!root.sidelight) './img/LightGasIcon.png';else './img/DarkGasIcon.png'
    }
    Text {
        id: battery_display_val
        text: root.batteryvoltage.toFixed(1)
        font.pixelSize: 36
        font.pointSize: 36
        font.family: digital7monoitalic.name
        horizontalAlignment: Text.AlignRight
        width: 110
        height: 36
        x: 626.3
        y: 377
        z: 2
        color: if (!root.sidelight)
                   root.daylight_lcd_color
               else
                   root.night_light_color
        // visible: if (root.oilpressurehigh === 0)
        //              false
        //          else
        //              true
    }
    Text{
        id: tps_display_val
        text: root.
    }
    DropShadow{
        z:2
        anchors.fill: battery_display_val
        source: battery_display_val
        verticalOffset: 3
        radius: 3.0
        samples: 9
        color: '#44000000'
    }
    Text {
        id: fuel_label
        x: 321
        y: 431
        width: 128
        color: if (root.fuel > root.fuellow)
                   if (!root.sidelight)
                       root.primary_color
                   else
                       root.night_light_color
               else
                   root.warning_red
        text: if (root.fuel > root.fuellow)
                  root.fuel + " %"
              else
                  "LOW FUEL!!"
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
        font.family: digital7monoitalic.name
    }

    Item {
        id: fueling_system
        x: 336
        y: 402
        width: 128
        height: 32
        Row {
            id: gasgauge
            x: 0
            y: -8
            width: 128
            height: 32
            antialiasing: true
            z: 3
            Repeater {
                model: 10
                //  required
                property int index
                Row {
                    Rectangle {
                        width: 11
                        height: 32
                        color: if (Math.floor(root.fuel / 10) > index) {
                                   if (root.fuel > 30)
                                       if (!root.sidelight)
                                           root.primary_color
                                       else
                                           root.night_light_color
                                   else
                                       root.warning_red
                               } else
                                   "#0A0A0A"
                        radius: 2
                        border.width: if (Math.floor(root.fuel / 10) > index) {
                                          0
                                      } else
                                          1
                        border.color: if (!root.sidelight)
                                          root.primary_color
                                      else
                                          root.night_light_color
                        z: 1
                    }
                    Rectangle {
                        width: 2
                        height: 32
                        color: root.background_color
                        z: 1
                    }
                }
            }
        }
    }
   
        Image {
            id: left_blinker
            x: 341
            y: 295
            source: "./img/left_blinker.png"
            visible: root.leftindicator
        }
        Image {
            id: right_blinker
            x: 432
            y: 295
            source: "./img/right_blinker.png"
            visible: root.rightindicator
        }
    
} //End Init Item



