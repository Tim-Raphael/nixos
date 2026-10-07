const assert = require("node:assert/strict");
const contrast = require(process.argv[2]);

function pixel(value) {
    return [value, value, value, 255];
}

assert.equal(contrast.modeForPixels(pixel(255)), "light");
assert.equal(contrast.modeForPixels(pixel(0)), "dark");
assert.equal(contrast.modeForPixels(pixel(255), "dark"), "light");
assert.equal(contrast.modeForPixels(pixel(0), "light"), "dark");
assert.equal(contrast.modeForPixels(pixel(120), "light"), "light");
assert.equal(contrast.modeForPixels(pixel(120), "dark"), "dark");
assert.equal(contrast.modeForPixels([], "dark"), "dark");
assert.equal(contrast.modeForPixels([]), "light");
assert.equal(contrast.modeForPixels([0, 255, 0, 255]), "light");
assert.equal(contrast.modeForPixels([0, 0, 255, 255]), "dark");
assert.equal(contrast.modeForPixels([...pixel(0), ...pixel(255)]), "light");

const css = contrast.stylesheet({ "DP-1": "dark", "eDP-1": "light" });
assert(css.includes("window#waybar.\\44 \\50 \\2d \\31  { color: #f8f8f8; }"));
assert(css.includes("window#waybar.\\65 \\44 \\50 \\2d \\31  { color: #181818; }"));
assert(css.includes("#workspaces button.urgent { color: #ffb3bd; }"));
assert(css.includes("#workspaces button.urgent { color: #9c1830; }"));
assert(!contrast.stylesheet({ "screen.name": "light" }).includes("screen.name"));
assert.equal(contrast.stylesheet({}), "\n");
console.log("Wallpaper contrast passed brightness, color, hysteresis, and output checks.");
