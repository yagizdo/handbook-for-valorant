## 9. Resource & Memory Management

- Dispose all controllers, focus nodes, subscriptions, timers in `dispose()`.
- Verify lifecycle scope before disposing — don't blindly dispose shared objects.
- `BlocProvider`-managed cubits auto-dispose — never manually close them.
- Cancel `StreamSubscription`s in the cubit's `close()` override.
