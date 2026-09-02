const std = @import("std");

pub fn main(init: std.process.Init) !void {
    var buf: [1024]u8 = undefined;
    var stdout_writer = std.Io.File.stdout().writer(init.io, &buf);
    const stdout = &stdout_writer.interface;
    defer stdout.flush() catch {};

    var iter = init.minimal.args.iterate();
    defer iter.deinit();

    _ = iter.next(); // skip the program name

    while (iter.next()) |arg| {
        if (std.mem.eql(u8, arg, "--count")) {
            // --count consumes the next argument as its value.
            const value = iter.next() orelse return error.MissingValue;
            const count = try std.fmt.parseInt(u32, value, 10);
            try stdout.print("counting to {d}\n", .{count});
        } else {
            try stdout.print("You passed {s}\n", .{arg});
        }
    }
}
