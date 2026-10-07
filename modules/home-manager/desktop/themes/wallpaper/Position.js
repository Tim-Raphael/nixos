function emptyState() {
    return { workspaces: [], windows: {} };
}

function applyEvent(state, event) {
    if (event.WorkspacesChanged) {
        return { workspaces: event.WorkspacesChanged.workspaces, windows: state.windows };
    }
    if (event.WorkspaceActivated) {
        const activated = event.WorkspaceActivated;
        const target = state.workspaces.find(workspace => workspace.id === activated.id);
        if (!target) return state;
        const workspaces = state.workspaces.map(workspace => {
            if (workspace.output !== target.output) return workspace;
            return Object.assign({}, workspace, { is_active: workspace.id === target.id });
        });
        return { workspaces: workspaces, windows: state.windows };
    }
    if (event.WindowsChanged) {
        const windows = {};
        for (const window of event.WindowsChanged.windows) windows[window.id] = window;
        return { workspaces: state.workspaces, windows: windows };
    }
    if (event.WindowOpenedOrChanged || event.WindowClosed || event.WindowLayoutsChanged) {
        const windows = Object.assign({}, state.windows);
        if (event.WindowOpenedOrChanged) {
            const window = event.WindowOpenedOrChanged.window;
            windows[window.id] = window;
        }
        if (event.WindowClosed) delete windows[event.WindowClosed.id];
        if (event.WindowLayoutsChanged) {
            for (const change of event.WindowLayoutsChanged.changes) {
                const id = change[0];
                if (windows[id]) windows[id] = Object.assign({}, windows[id], { layout: change[1] });
            }
        }
        return { workspaces: state.workspaces, windows: windows };
    }
    return state;
}

function offset(state, output, width, height) {
    const workspace = state.workspaces.find(item => item.output === output && item.is_active);
    if (!workspace || width <= 0 || height <= 0) return { x: 0, y: 0 };

    let firstColumn = null;
    for (const id of Object.keys(state.windows)) {
        const window = state.windows[id];
        if (window.workspace_id !== workspace.id || window.is_floating) continue;
        const layout = window.layout;
        if (!layout || !layout.pos_in_scrolling_layout || !layout.tile_pos_in_workspace_view) continue;
        if (!firstColumn || layout.pos_in_scrolling_layout[0] < firstColumn.pos_in_scrolling_layout[0]) {
            firstColumn = layout;
        }
    }

    let scroll = 0;
    if (firstColumn) scroll = -firstColumn.tile_pos_in_workspace_view[0] / width;

    // Bounded offsets keep even very long workspaces inside the overscan.
    return {
        x: -width * 0.04 * Math.tanh(scroll / 4),
        y: -height * 0.04 * Math.tanh((workspace.idx - 1) / 5)
    };
}

if (typeof module !== "undefined") module.exports = { emptyState, applyEvent, offset };
