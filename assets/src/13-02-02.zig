const std = @import("std");

pub fn main(init: std.process.Init) !void {
    var iter = init.minimal.args.iterate();
    defer iter.deinit();

    _ = iter.skip(); // skip the program name

    while (iter.next()) |arg| {
        if (std.mem.eql(u8, arg, "--count")) {
            // --count consumes the next argument as its value.
            const value = iter.next() orelse {
                std.debug.print("error: --count needs a number\n", .{});
                return error.MissingValue;
            };
            const count = try std.fmt.parseInt(u32, value, 10);
            std.debug.print("counting to {d}\n", .{count});
        } else {
            std.debug.print("You passed {s}\n", .{arg});
        }
    }
}
