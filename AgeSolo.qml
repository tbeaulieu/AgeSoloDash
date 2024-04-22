import QtQuick 2.3
import QtGraphicalEffects 1.0
import "img"

Item {
    /*#########################################################################
      #############################################################################
      Imported Values From GAWR inits
      #############################################################################
      #############################################################################
     */
    id: root
    ////////// IC7 LCD RESOLUTION ////////////////////////////////////////////
    width: 800
    height: 480
    
    z: 0
    
    property int myyposition: 0
    property int udp_message: rpmtest.udp_packetdata

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

    property int odometer: rpmtest.odometer0data/10*0.62 //Need to div by 10 to get 6 digits with leading 0
    property int tripmeter: rpmtest.tripmileage0data*0.62
    property real value: 0
    property real shiftvalue: 0

    property real rpm: rpmtest.rpmdata
    property real rpmlimit: 8000 //Originally was 7k, switched to 8000 -t
    property real rpmdamping: 5
    property real speed: rpmtest.speeddata
    property int speedunits: 2

    property real watertemp: rpmtest.watertempdata
    property real waterhigh: 0
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

    property real speed_spring: 1
    property real speed_damping: 1

    property real rpm_needle_spring: 3.0 //if(rpm<1000)0.6 ;else 3.0
    property real rpm_needle_damping: 0.2 //if(rpm<1000).15; else 0.2

    property bool changing_page: rpmtest.changing_pagedata


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
        x: 0
        y: 0
        width: 800
        height: 480
        color: root.background_color
        border.width: 0
        z: 0
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
            source: './img/brights_on.png'
            width: 67
            height: 32
            z:2
            x: 5
            y: 156
            visible: root.mainbeam
        }
        Image{
            source: './img/airbag_warning.png'
            width: 67
            height: 32
            z:2
            x: 80
            y: 156
            visible: root.airbag
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
        y: 407
        source: if(!root.sidelight) './img/lite_mph.png'; else './img/Dark_mph.png'
        visible: root.speedunits === 1 
    }
    // Image{
    //     id: mi_label
    //     z: 7
    //     x: 481
    //     y: 407
    //     width: 24
    //     height: 18
    //     source: if(!root.sidelight) './img/lite_mi.png'; else './img/dark_mi.png'
    //     visible: root.speedunits === 1 
    // }
    Image{
        id: kmh_label
        z: 7
        width: 47
        height: 21
        x: 481
        y: 428
        source: if(!root.sidelight) './img/lite_kmh.png'; else './img/Dark_kmh.png'
        visible: root.speedunits === 0
    }    
     Text {
        id: odometer_display_val
        text: if (root.speedunits === 0)
                  (root.odometer/.62).toFixed(0)
              else if (root.speedunits === 1)
                  root.odometer.toFixed(0)
              else
                  root.odometer.toFixed(0)
        font.pixelSize: 18
        horizontalAlignment: Text.AlignRight
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
            id: watertemp_needle_image
            height: 12
            width: 85
            source: './img/WaterTempNeedle.png'
            }
            DropShadow{
                anchors.fill: watertemp_needle_image
                horizontalOffset: 1
                verticalOffset: 1
                radius: 8.0
                samples: 17
                color: "#80000000"
                source: watertemp_needle_image
            }
            transform:[
                Rotation {
                    id: watertemp_rotate
                    origin.y: 6
                    origin.x: 76
                     //Minimum angle on horizontal needlie is negative 90 for straight down, water temp needs offset of 60 degrees, 
                     //270/60 = 4.5 for angle ratio, max rotation for that horizontal pointing left arrow is 180
                    angle:Math.min(Math.max(-90, ((root.watertemp - 60) * 4.5) - 90), 180)
                    }
            ]
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
            id: tachometer_needle_image
            height: 14
            width: 239
            source: './img/TachNeedle.png'
            antialiasing: true 
        }
        transform:[
                Rotation {
                    id: tachneedle_rotate
                    origin.y: 6
                    origin.x: 205
                    angle: Math.min(Math.max(-28.5, Math.round((root.rpm/1000)*24) - 30), 212.5)                
                   //Match for Elise S2 spring update
                    Behavior on angle{
                        SpringAnimation {
                            spring: 1.2
                            damping:.16
                        }
                    }
                }
            ]
            DropShadow{
                anchors.fill: tachometer_needle_image
                horizontalOffset: 1
                verticalOffset: 1
                radius: 8.0
                samples: 17
                color: "#80000000"
                source: tachometer_needle_image
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
            opacity: if(root.rpm > root.rpmlimit-1000 && root.rpm < root.rpmlimit + 200) 1; else 0
        }
        Image{
            x: 51
            y: 0
            height: 19
            width: 46
            source:'./img/ShiftLightLit.png'
            opacity: if(root.rpm > root.rpmlimit-500 && root.rpm < root.rpmlimit + 200) 1; else 0
        }
        Image{
            x: 102
            y: 0
            height: 19
            width: 46
            source:'./img/ShiftLightLit.png'
            opacity: if(root.rpm > root.rpmlimit-250 && root.rpm < root.rpmlimit + 200) 1; else 0
        }
    }

    Item{
        id: shift_lights_blinking
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
            visible: if(root.rpm < root.rpmlimit + 200) false; else true
        }
        Image{
            x: 51
            y: 0
            height: 19
            width: 46
            source:'./img/ShiftLightLit.png'
            visible: if(root.rpm < root.rpmlimit + 200) false; else true

        }
        Image{
            x: 102
            y: 0
            height: 19
            width: 46
            source:'./img/ShiftLightLit.png'
            visible: if(root.rpm < root.rpmlimit + 200) false; else true
        }
        Timer{
            id: rpm_shift_blink
            running: if(root.rpm >= root.rpmlimit + 200)
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
        text: if(root.oiltempunits !== 0)((((root.oiltemp.toFixed(0))*9)/5)+32).toFixed(0)+"F"; else root.oiltemp.toFixed(0) + "C"
        horizontalAlignment: Text.AlignRight
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
        visible: if (root.oilpressurehigh === 0)
                     false
                 else
                     true
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
        z: 3
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

    Item{
        id: fueling_lcd
        z:3
        width: 162
        height: 26
        y: 424
        x: 580
        Item{
            id: actual_bars
            width: 162*(root.fuel/100)
            height: 26
            z: 4
            clip: true
            Image{
                source: if(!root.sidelight) "./img/lit_fuelbars.png"; else "./img/dark_fuelbars.png"
            }
        }
        Image{
            z: 3
            source: './img/fuel_lcd_bkg.png'
        }
    }
    
    Item{
        id: fuel_icon
        opacity: 100
        z:3
        Image{
            id: gas_label
            x: 745
            y: 423
            width: 35
            height: 32
            source: if(!root.sidelight) './img/LightGasIcon.png';else './img/DarkGasIcon.png'
            opacity: 100
        }
        Timer{
                id: gas_animate
                running: if(root.fuel <= root.fuellow)
                            true
                        else
                            false
                interval: 500
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
        id: battery_display_val
        text: root.batteryvoltage.toFixed(1)
        font.pixelSize: 36
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
        visible: if (root.oilpressurehigh === 0)
                     false
                 else
                     true
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
    Image {
        id: left_blinker
        x: 341
        y: 295
        z: 8
        source: if(!root.leftindicator) "./img/dim_blinker.png";else "./img/lit_blinker.png"
    }
    Image {
        id: right_blinker
        x: 442
        y: 295
        z: 8
        source: if(!root.rightindicator) "./img/dim_blinker.png";else "./img/lit_blinker.png"
    }
    
} //End AgeSolo Item



