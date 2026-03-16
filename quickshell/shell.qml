import Quickshell
import Quickshell.Io
import QtQuick

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  height: 48
  property int widgetHeight: 32
  color: "#161816"

  property int batteryPct: 0
  property bool batteryCharging: false
  property int volumePct: 0
  property int brightnessPct: 0

  function volumeIcon(pct) {
    if (pct == 0) return "󰝟"
    if (pct < 33)  return "󰕿"
    if (pct < 66)  return "󰖀"
    return "󰕾"
  }

  function batteryIcon(pct, charging) {
    if (charging) {
      if (pct >= 100) return "󰂅"
      if (pct >= 90)  return "󰂋"
      if (pct >= 80)  return "󰂊"
      if (pct >= 70)  return "󰢞"
      if (pct >= 60)  return "󰂉"
      if (pct >= 50)  return "󰢝"
      if (pct >= 40)  return "󰂈"
      if (pct >= 30)  return "󰂇"
      if (pct >= 20)  return "󰂆"
      if (pct >= 10)  return "󰢜"
      return "󰢟"
    }
    if (pct >= 100) return "󰁹"
    if (pct >= 90)  return "󰂂"
    if (pct >= 80)  return "󰂁"
    if (pct >= 70)  return "󰂀"
    if (pct >= 60)  return "󰁿"
    if (pct >= 50)  return "󰁾"
    if (pct >= 40)  return "󰁽"
    if (pct >= 30)  return "󰁼"
    if (pct >= 20)  return "󰁻"
    if (pct >= 10)  return "󰁺"
    return "󰂃"
  }

  function brightnessIcon(pct) {
    if (pct < 33) return "󰃞"
    if (pct < 66) return "󰃟"
    return "󰃠"
  }

  ListModel {
    id: workspaceModel
  }

  Process {
    id: workspaceProcess
    command: ["sh", "-c", "niri msg -j workspaces | tr -d '\\n'"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        try {
          var ws = JSON.parse(data.trim())
          workspaceModel.clear()
          ws.sort((a, b) => a.idx - b.idx).forEach(w => workspaceModel.append({ idx: w.idx, focused: w.is_focused }))
        } catch(e) {}
      }
    }
  }

  Timer {
    interval: 500
    running: true
    repeat: true
    onTriggered: {
      workspaceProcess.running = false
      workspaceProcess.running = true
    }
  }

  Process {
    id: networkProcess
    command: ["sh", "-c", "nmcli -t -f TYPE,STATE,CONNECTION dev 2>/dev/null | awk -F: '$2==\"connected\"{type=$1; name=$3; exit} END{if(type==\"wifi\") print \"wifi \"name; else if(type==\"ethernet\") print \"eth \"name; else print \"none\"}'"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        var parts = data.trim().split(" ")
        var type = parts[0]
        var name = parts.slice(1).join(" ")
        if (type === "wifi") networkLabel.text = "󰤨 " + name
        else if (type === "eth") networkLabel.text = "󰈀 " + name
        else networkLabel.text = "󰤭"
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: {
      networkProcess.running = false
      networkProcess.running = true
    }
  }

  Process {
    id: cpuProcess
    command: ["sh", "-c", "awk 'NR==1{u1=$2+$4;t1=$2+$3+$4+$5} NR==2{u2=$2+$4;t2=$2+$3+$4+$5; printf \"%d\",((u2-u1)*100/(t2-t1))}' <(grep '^cpu ' /proc/stat) <(sleep 0.2; grep '^cpu ' /proc/stat)"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        cpuLabel.text = "󰻠 " + data.trim() + "%"
      }
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: {
      cpuProcess.running = false
      cpuProcess.running = true
    }
  }

  Process {
    id: memoryProcess
    command: ["sh", "-c", "free | awk '/^Mem:/{printf \"%d\", $3/$2*100}'"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        memoryLabel.text = "󰍛 " + data.trim() + "%"
      }
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: {
      memoryProcess.running = false
      memoryProcess.running = true
    }
  }

  Process {
    id: brightnessProcess
    command: ["sh", "-c", "brightnessctl -m | awk -F, '{print $4}' | tr -d '%'"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        brightnessPct = parseInt(data.trim())
        brightnessLabel.text = brightnessIcon(brightnessPct) + " " + data.trim() + "%"
      }
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: {
      brightnessProcess.running = false
      brightnessProcess.running = true
    }
  }

  Process {
    id: volumeProcess
    command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d\", $2 * 100}'"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        volumePct = parseInt(data.trim())
        volumeLabel.text = volumeIcon(volumePct) + " " + data.trim() + "%"
      }
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: {
      volumeProcess.running = false
      volumeProcess.running = true
    }
  }

  Process {
    id: batteryProcess
    command: ["sh", "-c", "upower -i $(upower -e | grep BAT) | awk '/state/{s=$2} /percentage/{p=$2} END{print s, p}'"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        var parts = data.trim().split(" ")
        var state = parts[0]
        var pctStr = parts[1] || "0%"
        batteryCharging = (state === "charging" || state === "fully-charged")
        batteryPct = parseInt(pctStr)
        batteryLabel.text = batteryIcon(batteryPct, batteryCharging) + " " + pctStr
      }
    }
  }

  Timer {
    interval: 30000
    running: true
    repeat: true
    onTriggered: {
      batteryProcess.running = false
      batteryProcess.running = true
    }
  }

  Rectangle {
    id: networkRect
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.rightMargin: 16
    anchors.topMargin: 16
    color: "transparent"
    border.color: "#3a3f3a"
    border.width: 2
    width: networkLabel.implicitWidth + 16
    height: widgetHeight

    Text {
      id: networkLabel
      anchors.centerIn: parent
      text: "..."
      color: "#3a3f3a"
      font.pixelSize: 18
    }
  }

  Rectangle {
    id: cpuRect
    anchors.right: memoryRect.left
    anchors.top: parent.top
    anchors.rightMargin: 16
    anchors.topMargin: 16
    color: "transparent"
    border.color: "#3a3f3a"
    border.width: 2
    width: cpuLabel.implicitWidth + 16
    height: widgetHeight

    Text {
      id: cpuLabel
      anchors.centerIn: parent
      text: "..."
      color: "#3a3f3a"
      font.pixelSize: 18
    }
  }

  Rectangle {
    id: memoryRect
    anchors.right: brightnessRect.left
    anchors.top: parent.top
    anchors.rightMargin: 16
    anchors.topMargin: 16
    color: "transparent"
    border.color: "#3a3f3a"
    border.width: 2
    width: memoryLabel.implicitWidth + 16
    height: widgetHeight

    Text {
      id: memoryLabel
      anchors.centerIn: parent
      text: "..."
      color: "#3a3f3a"
      font.pixelSize: 18
    }
  }

  Rectangle {
    id: brightnessRect
    anchors.right: volumeRect.left
    anchors.top: parent.top
    anchors.rightMargin: 16
    anchors.topMargin: 16
    color: "transparent"
    border.color: "#3a3f3a"
    border.width: 2
    width: brightnessLabel.implicitWidth + 16
    height: widgetHeight

    Text {
      id: brightnessLabel
      anchors.centerIn: parent
      text: "..."
      color: "#3a3f3a"
      font.pixelSize: 18
    }
  }

  Rectangle {
    id: volumeRect
    anchors.right: batteryRect.left
    anchors.top: parent.top
    anchors.rightMargin: 16
    anchors.topMargin: 16
    color: "transparent"
    border.color: "#3a3f3a"
    border.width: 2
    width: volumeLabel.implicitWidth + 16
    height: widgetHeight

    Text {
      id: volumeLabel
      anchors.centerIn: parent
      text: "..."
      color: "#3a3f3a"
      font.pixelSize: 18
    }
  }

  Rectangle {
    id: batteryRect
    anchors.right: networkRect.left
    anchors.top: parent.top
    anchors.rightMargin: 16
    anchors.topMargin: 16
    color: "transparent"
    border.color: "#3a3f3a"
    border.width: 2
    width: batteryLabel.implicitWidth + 16
    height: widgetHeight

    Text {
      id: batteryLabel
      anchors.centerIn: parent
      text: "..."
      color: "#3a3f3a"
      font.pixelSize: 18
    }
  }

  Row {
    id: workspaceRow
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.leftMargin: 16
    anchors.topMargin: 16
    spacing: 8

    Repeater {
      model: workspaceModel
      delegate: Rectangle {
        color: "transparent"
        border.color: model.focused ? "#3a3f3a" : "#222222"
        border.width: 2
        height: widgetHeight
        width: widgetHeight

        Text {
          id: wsLabel
          anchors.centerIn: parent
          text: model.idx
          color: "#3a3f3a"
          font.pixelSize: 18
        }
      }
    }
  }

  Rectangle {
    id: clockRect
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 16
    color: "transparent"
    border.color: "#3a3f3a"
    border.width: 2
    width: label.implicitWidth + 16
    height: widgetHeight

    Text {
      id: label
      anchors.centerIn: parent
      text: Qt.formatDateTime(new Date(), "dd HH:mm")
      color: "#3a3f3a"
      font.pixelSize: 18
    }

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: label.text = Qt.formatDateTime(new Date(), "dd HH:mm")
    }
  }
}
