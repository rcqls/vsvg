module vsvg

import strings
import os

struct Svg {
pub:
	height int
	width int
	buffer strings.Builder = strings.new_builder(32768)
pub mut:
	content &strings.Builder = 0
}

[params]
pub struct SvgParams {
	height int
	width int
}

pub fn svg(p SvgParams) &Svg {
	mut s := &Svg{
		height: p.height
		width: p.width
	}
	s.content = &s.buffer
	return s
}

pub fn(mut s Svg) begin() {
	s.content.write_string("<?xml version='1.0' encoding='utf-8'?>\n<svg width='${s.width}px' height='${s.height}px'  xmlns='http://www.w3.org/2000/svg' version='1.1' xmlns:xlink='http://www.w3.org/1999/xlink'>\n")
}

pub fn(mut s Svg) end() {
	s.content.write_string("</svg>\n")
}

pub fn (mut s Svg) save(filepath string) ? {
	// write it to a file
	os.write_file_array(filepath, *s.content) ?
}

[params]
pub struct Params {
	stroke string = "none"
	strokewidth int
	fill string = "none"
	rx int
	ry int
}

pub fn (mut s Svg) circle(x int, y int, r int, p Params) {
	s.content.write_string("<circle  cy='${y}' cx='${x}' r='${r}'  stroke='${p.stroke}' stroke-width='${p.strokewidth}px' fill='${p.fill}' />\n")
}

pub fn (mut s Svg) line(x1 int, y1 int, x2 int, y2 int, p Params) {
	s.content.write_string("<line x1='${x1}' y1='${y1}' x2='${x2}' y2='${y2}' stroke='${p.stroke}' stroke-width='${p.strokewidth}px' />\n")
}

pub fn (mut s Svg) rectangle(x int, y int, width int, height int, p Params) {
	s.content.write_string("<rect x='${x}' y='${y}' width='${width}' height='${height}' rx='${p.rx}' ry='${p.ry}' fill='${p.fill}' stroke='${p.stroke}' stroke-width='${p.strokewidth}px' />\n")
}

pub fn (mut s Svg) fill(fill string) {
    s.rectangle(0, 0, s.width, s.height, fill: fill)
}

pub fn (mut s Svg) text(x int, y int,  text string, fill string, ts TextStyle) {
	s.content.write_string("<text x='${x}' y='${y}' fill='${fill}' stroke='${vsvg.color(ts.color)}' font-family='${ts.font_name}' font-size='${ts.size}px' dominant-baseline='${ts.vertical_align}' text-anchor='${ts.align}'><![CDATA[${text}]]></text>\n")
}

pub fn (mut s Svg) ellipse(x int, y int, rx int, ry int, p Params) {
	s.content.write_string("<ellipse cx='${x}' cy='${y}' rx='${rx}' ry='${ry}' fill='${p.fill}' stroke='${p.stroke}' stroke-width='${p.strokewidth}px' />\n")
}

pub fn (mut s Svg) polygon(points string, p Params) {
	s.content.write_string("<polygon points='${points}' fill='${p.fill}' stroke='${p.stroke}' stroke-width='${p.strokewidth}px' />\n")
}

pub fn (mut s Svg) polyline(points string, p Params) {
	s.content.write_string("<polyline points='${points}' fill='${p.fill}' stroke='${p.stroke}' stroke-width='${p.strokewidth}px' />\n")
}

pub fn (mut s Svg) image(x int, y int, width int, height int, path string) {
	s.content.write_string("<image xlink:href='${path}' x='${x}' y='${y}' height='${height}' width='${width}' />\n")
}