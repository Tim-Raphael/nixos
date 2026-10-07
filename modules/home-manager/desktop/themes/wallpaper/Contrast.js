function linearChannel(value) {
    const channel = value / 255;
    if (channel <= 0.04045) return channel / 12.92;
    return Math.pow((channel + 0.055) / 1.055, 2.4);
}

function modeForPixels(pixels, previous) {
    if (pixels.length === 0) return previous || "light";

    let luminance = 0;
    for (let index = 0; index < pixels.length; index += 4) {
        luminance += 0.2126 * linearChannel(pixels[index])
            + 0.7152 * linearChannel(pixels[index + 1])
            + 0.0722 * linearChannel(pixels[index + 2]);
    }
    luminance /= pixels.length / 4;

    const darkTextContrast = (luminance + 0.05) / (linearChannel(24) + 0.05);
    const lightTextContrast = (linearChannel(248) + 0.05) / (luminance + 0.05);

    // Hysteresis prevents flicker near the contrast crossover.
    if (previous === "light" && lightTextContrast < darkTextContrast * 1.15) return previous;
    if (previous === "dark" && darkTextContrast < lightTextContrast * 1.15) return previous;
    return darkTextContrast >= lightTextContrast ? "light" : "dark";
}

function stylesheet(modes) {
    const rules = [];
    for (const output of Object.keys(modes).sort()) {
        const escaped = Array.from(output, character => "\\" + character.codePointAt(0).toString(16) + " ").join("");
        const selector = "window#waybar." + escaped;
        const light = modes[output] === "light";
        const foreground = light ? "#181818" : "#f8f8f8";
        const shadow = light ? "rgba(255, 255, 255, 0.35)" : "rgba(0, 0, 0, 0.45)";
        const warning = light ? "#704900" : "#ffe08a";
        const critical = light ? "#9c1830" : "#ffb3bd";
        rules.push(selector + " { color: " + foreground + "; }");
        rules.push(selector + " label { text-shadow: 0 1px 4px " + shadow + "; }");
        rules.push(["#battery.warning", "#memory.warning", "#idle_inhibitor.activated"]
            .map(module => selector + " " + module).join(", ") + " { color: " + warning + "; }");
        rules.push(["#battery.critical", "#memory.critical", "#temperature.critical", "#pulseaudio.muted",
            "#network.disconnected", "#bluetooth.disabled", "#workspaces button.urgent"]
            .map(module => selector + " " + module).join(", ") + " { color: " + critical + "; }");
    }
    return rules.join("\n") + "\n";
}

if (typeof module !== "undefined") module.exports = { modeForPixels, stylesheet };
