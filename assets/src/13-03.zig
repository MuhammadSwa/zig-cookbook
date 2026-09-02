const std = @import("std");

pub fn main(init: std.process.Init) !void {
    // The raw argv: on POSIX entries are null-terminated pointers ([*:0]const u8),
    // so convert them to slices with std.mem.span. (On Windows/WASI without libc
    // the vector has different semantics — use iterate for portable code.)
    const args = init.minimal.args.vector;

    for (args[1..]) |arg| { // args[0] is the program name
        const s = std.mem.span(arg);
        std.debug.print("{s} (len={d})\n", .{ s, s.len });
    }
}
