const std = @import("std");

pub fn main(init: std.process.Init) !void {
    var buf: [1024]u8 = undefined;
    var stdout_writer = std.Io.File.stdout().writer(init.io, &buf);
    const stdout = &stdout_writer.interface;
    defer stdout.flush() catch {};

    // Copies all arguments into one allocation you own.
    const args = try init.minimal.args.toSlice(init.gpa);
    defer init.gpa.free(args);

    try stdout.print("program: {s}\n", .{args[0]});
    try stdout.print("{d} user arguments\n", .{args.len - 1});

    for (args[1..]) |arg| {
        try stdout.print("{s}\n", .{arg});
    }
}
