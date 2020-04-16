import QtQuick 2.6
import QtQuick.Controls 2.2

import QtPositioning 5.3
import QtLocation 5.0
import "../assets"

Page {
    padding: -3
    font.pointSize: 9
    title: qsTr("Map")

    NmeaPositionSource { id: positionSource }
    Map {
        id: map
        anchors.fill: parent
        plugin: Plugin {
            allowExperimental: true
            name: "osm"
            required.mapping: Plugin.AnyMappingFeatures
            required.geocoding: Plugin.AnyGeocodingFeatures
        }
        onZoomLevelChanged: zoomLevel.value = zoomLevel
        // ToDo: enable gesture recognition
        // ToDo: bind zoomLevel property to slider value

        // ToDo: add binding of the map center to the position coordinate

        // ToDo: create MouseArea to handle clicks and holds

        Component.onCompleted: center = QtPositioning.coordinate(55.751244, 37.618423)
        MouseArea{
            anchors.fill: parent
        //    onClicked: {
        //        var circle = Qt.createQmlObject(
        //         "import QtLocation 5.0; MapCircle {}",
        //         map
        //        );
        //        circle.center = positionSource.position.coordinate;
        //        circle.radius = 1000000.0;
        //        circle.color = "red";
        //        circle.border.width = 3;
        //        circle.center = map.toCoordinate(Qt.point(mouse.x, mouse.y))
        //        map.addMapItem(circle);
        //    }
            onClicked: {
                var circle = mapQuickCircleComponent.createObject(map);
                circle.radius = 8.0;
                circle.color = "green";
                circle.coordinate = map.toCoordinate(Qt.point(mouse.x, mouse.y))
                map.addMapItem(circle);
            }
        }
    }
    // ToDo: add a slider to control zoom leve


    // ToDo: add a component corresponding to MapQuickCircle

    // ToDo: add item at the current position
    Footprints {
        id: footprints
        coordinate: positionSource.position.coordinate
        diameter: Math.min(map.width, map.height) / 8
    }

    Binding {
     target: map
     property: "center"
     value: positionSource.position.coordinate
     when: false//positionSource.position.coordinate.isValid
    }
Component.onCompleted: {
    map.addMapItem(footprints)
}

Component {
 id: mapQuickCircleComponent
 MapQuickCircle { }
}

Slider {
    id: zoomLevelSlider
    font.pointSize: 6
    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
 from: map.minimumZoomLevel
 to: map.maximumZoomLevel
 value: map.zoomLevel
 onValueChanged: map.zoomLevel = value
}
}





/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
