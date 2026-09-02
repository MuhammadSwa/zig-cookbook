const std = @import("std");

pub fn main(init: std.process.Init) !void {
    var buf: [1024]u8 = undefined;
    var stdout_writer = std.Io.File.stdout().writer(init.io, &buf);
    const stdout = &stdout_writer.interface;
    defer stdout.flush() catch {};

    // The raw argv: entries are null-terminated pointers ([*:0]const u8),
    // so convert them to slices with std.mem.span.
    const args = init.minimal.args.vector;

    for (args[1..]) |arg| { // args[0] is the program name
        const s = std.mem.span(arg);
        try stdout.print("{s} (len={d})\n", .{ s, s.len });
    }
}
