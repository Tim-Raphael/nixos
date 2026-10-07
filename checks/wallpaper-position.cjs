const assert = require("node:assert/strict");
const position = require(process.argv[2]);

let state = position.emptyState();
function emit(event) {
    state = position.applyEvent(state, event);
}
function layout(x, column = 1) {
    return { pos_in_scrolling_layout: [column, 1], tile_pos_in_workspace_view: [x, 0] };
}

assert.deepEqual(position.offset(state, "DP-1", 3840, 2160), { x: 0, y: 0 });
emit({ WorkspacesChanged: { workspaces: [
    { id: 1, idx: 1, output: "DP-1", is_active: true },
    { id: 2, idx: 2, output: "DP-1", is_active: false },
    { id: 3, idx: 1, output: "DP-2", is_active: true }
] } });
emit({ WindowsChanged: { windows: [
    { id: 10, workspace_id: 1, layout: layout(0) },
    { id: 20, workspace_id: 2, layout: layout(-1920) }
] } });
const initial = position.offset(state, "DP-1", 3840, 2160);
emit({ WindowLayoutsChanged: { changes: [[10, layout(-3840)]] } });
const scrolled = position.offset(state, "DP-1", 3840, 2160);
assert(scrolled.x < initial.x);
assert.equal(scrolled.y, initial.y);
emit({ WindowLayoutsChanged: { changes: [[10, layout(-1000)]] } });
assert(position.offset(state, "DP-1", 3840, 2160).x > scrolled.x);

emit({ WorkspaceActivated: { id: 2, focused: true } });
const switched = position.offset(state, "DP-1", 3840, 2160);
assert(switched.y < initial.y);
assert.deepEqual(position.offset(state, "DP-2", 3840, 2160), { x: -0, y: -0 });
emit({ WindowOpenedOrChanged: { window: {
    id: 30, workspace_id: 2, is_floating: true, layout: layout(-99999)
} } });
assert.deepEqual(position.offset(state, "DP-1", 3840, 2160), switched);

emit({ WindowLayoutsChanged: { changes: [[20, layout(-1e9)], [999, layout(0)]] } });
const extreme = position.offset(state, "DP-1", 3840, 2160);
assert(Math.abs(extreme.x) <= 3840 * 0.04);
assert(Math.abs(extreme.y) <= 2160 * 0.04);
emit({ WindowClosed: { id: 20 } });
assert.equal(position.offset(state, "DP-1", 3840, 2160).x, -0);
emit({ WorkspacesChanged: { workspaces: [] } });
assert.deepEqual(position.offset(state, "DP-1", 3840, 2160), { x: 0, y: 0 });
console.log("Wallpaper offsets passed scroll, centering, workspace, output, bounds, and removal checks.");
