const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const args = init.minimal.args.vector;

    for (args[1..]) |arg| { // args[0] is the program name
        const s = std.mem.span(arg);
        std.debug.print("{s} (len={d})\n", .{ s, s.len });
    }
}
