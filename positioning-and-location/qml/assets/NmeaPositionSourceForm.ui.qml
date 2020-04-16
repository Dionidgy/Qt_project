import QtPositioning 5.3

PositionSource {
 updateInterval: 1000
 nmeaSource: "/usr/share/%1/nmea/path.nmea"
 .arg(Qt.application.name)
 active: true
}
