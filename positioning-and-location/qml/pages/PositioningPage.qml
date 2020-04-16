import QtQuick 2.6
import QtQuick.Controls 2.2

import QtPositioning 5.3
import "../assets"

Page {
    id: page

    title: qsTr("PositionSource")

    PositionSource {
        id: positionSource
        updateInterval: 1000
        // ToDo: set nmea source to path.nmea file
        active: activeSwitch.checked
    }
    // ToDo: make component NmeaPositionSource in assets directory
    Column {
        anchors.centerIn: parent
        width: parent.width
        spacing: page.height / 20

        ValueDisplay {
            label: qsTr("Timestamp")
            value: positionSource.position.timestamp
            valid: positionSource.position.coordinate.isValid
            notValidText: qsTr("No timestamp data")
            width: parent.width
        }
        ValueDisplay {
            label: qsTr("Coordinate")
            value: positionSource.position.coordinate
            valid: positionSource.position.coordinate.isValid
            notValidText: qsTr("No coordinate data")
            width: parent.width
        }
        ValueDisplay {
            label: qsTr("Latitude")
            value: positionSource.position.coordinate.latitude.toFixed(6)
            valid: positionSource.position.latitudeValid
            notValidText: qsTr("No latitude data")
            width: parent.width
        }
        ValueDisplay {
            label: qsTr("Longitude")
            value: positionSource.position.coordinate.longitude.toFixed(6)
            valid: positionSource.position.longitudeValid
            notValidText: qsTr("No longitude data")
            width: parent.width
        }
        ValueDisplay {
            label: qsTr("Altitude")
            value: positionSource.position.coordinate.altitude.toFixed(6)
            valid: positionSource.position.altitudeValid
            notValidText: qsTr("No altitude data")
            width: parent.width
        }
        ValueDisplay {
            label: qsTr("Speed")
            value: qsTr("%1 meters / second").arg(positionSource.position.speed)
            valid: positionSource.position.speedValid
            notValidText: qsTr("No speed data")
            width: parent.width
        }
        Switch {
            id: activeSwitch
            anchors.horizontalCenter: parent.horizontalCenter
            checked: true
        }
    }
}
