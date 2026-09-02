const std = @import("std");

pub fn main(init: std.process.Init) !void {
    // Arena from Init reclaims all allocations at process exit — no manual free needed.
    const args = try init.minimal.args.toSlice(init.arena.allocator());

    std.debug.print("program: {s}\n", .{args[0]});
    std.debug.print("{d} user arguments\n", .{args.len - 1});

    for (args[1..]) |arg| {
        std.debug.print("{s}\n", .{arg});
    }
}
