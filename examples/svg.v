import vsvg

mut s := vsvg.svg(width: 192, height: 320)

s.begin()
s.fill("#DADAFF")
// s.text(32, 32, "draw all shapes", "#000000", "#000000", font_name: "sans-serif", size: 16)
s.circle(32, 64, 96, stroke: "#000080", strokewidth: 4, fill: "#0000FF")
s.ellipse(64, 160, 32, 16, fill: "#FF0000", stroke: "#800000", strokewidth: 4)
s.line(32, 192, 160, 192, stroke: "#000000", strokewidth: 2)
s.rectangle(64, 64, 32, 224, rx: 4, ry: 4, fill: "#00FF00", stroke: "#008000", strokewidth: 4)
s.end()

s.save("allshapes.svg") ?