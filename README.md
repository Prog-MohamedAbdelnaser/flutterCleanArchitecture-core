# softcore

A thin, predictable state layer on top of [flutter_bloc](https://pub.dev/packages/flutter_bloc).

Most screens do the same few things: load data, show a spinner, show an error
with a retry button, run an action with a progress dialog, and show a message
when it fails. softcore gives you those once, with defaults you can override,
so each screen only describes its data.

- **Typed states**: `DataLoading`, `DataSuccess<T>`, `DataFailed`, plus
  one-shot `ActionLoading` / `ActionSuccess` / `ActionFailed`.
- **`BaseCubit`**: `load` for screen data, `runAction` for user actions,
  caching, and independent sections with `observe`.
- **Widgets** that render every state and handle actions for you.
- **Your own states**: extend the built-in states and emit them, or set any
  state by hand.
- Only depends on `flutter_bloc`, and works on mobile, web and desktop.

## Install

```yaml
dependencies:
  flutter_bloc: ^9.1.0
  softcore: ^1.0.0
```

## Quick start

```dart
class UsersCubit extends BaseCubit<List<User>> {
  UsersCubit(this.api);
  final Api api;

  Future<void> loadUsers() => load(api.getUsers);

  Future<void> addUser(String name) => runAction(
        () => api.addUser(name),
        onSuccess: (user) => updateData((users) => [...users, user]),
      );
}
```

```dart
BlocProvider(
  create: (_) => UsersCubit(api)..loadUsers(),
  child: SoftBlocConsumer<UsersCubit, List<User>>(
    onRetry: () => context.read<UsersCubit>().loadUsers(),
    builder: (context, users) => UsersList(users),
  ),
)
```

That's the whole screen. `SoftBlocConsumer` shows a spinner while
loading, an error view with **Retry** on failure, and your list on success.
When `addUser` runs, a progress dialog appears, the list stays on screen,
and a failure shows a snackbar.

## The two kinds of state

| Screen states (`BuildState`) | Action states (`ActionState`) |
| --- | --- |
| What the screen shows | One-shot events for a user action |
| `DataInitial`, `DataLoading`, `DataSuccess(data)`, `DataFailed(error)` | `ActionLoading`, `ActionSuccess(result)`, `ActionFailed(error)` |
| Widgets **rebuild** | Widgets **listen** (progress, messages, navigation) |

Because actions never rebuild the screen, the data stays visible while you
save, delete or submit. `cubit.buildState` and `cubit.data` always give you
what the screen is showing.

## BaseCubit

```dart
// Screen data. Only the latest call's result is shown.
load(request);
load(request, cacheKey: 'users', cacheTtl: Duration(minutes: 5));
load(request, cacheKey: 'users', forceRefresh: true, keepDataWhileLoading: true);

// One-shot actions. They never throw, and return an ActionResult.
final result = await runAction(() => api.save(form));
if (result.isSuccess) print(result.value);

// Manage the state yourself.
emitLoading();
emitData(users);
emitError(SoftException('Offline'));
updateData((users) => users.where((u) => u.active).toList());
emitState(const CartEmpty()); // your own state

// Independent sections of one screen.
observe<Profile>('profile', api.getProfile);
observer<Profile>('profile'); // the same observer, to render
```

Every error from `load` and `runAction` goes through `onError`, so override
it to log or report errors. Nothing is emitted after `close()`.

## Widgets

### SoftBlocConsumer

Renders a `DataState` bloc and handles its actions.

```dart
SoftBlocConsumer<UsersCubit, List<User>>(
  builder: (context, users) => UsersList(users),
  onRetry: cubit.loadUsers,
  onActionSuccess: (context, result) => Navigator.pop(context),
  onActionError: (context, error) => showMyDialog(error.message), // replaces the snackbar
  listener: (context, state) {},   // runs after the defaults, never instead of them
  stateBuilder: (context, state) => state is CartEmpty ? EmptyCart() : null,
  loadingBuilder: (context) => Shimmer(),
  showProgress: false,             // use your own inline indicator
)
```

### SoftBlocListener

Handles actions only, for forms and buttons.

```dart
SoftBlocListener<LoginCubit, void>(
  onActionSuccess: (context, _) => context.go('/home'),
  child: LoginForm(),
)
```

### SoftBlocPage

A whole screen in one class. It creates the cubit, loads once, renders every
state, provides the cubit to children, and closes it.

```dart
class UsersPage extends SoftBlocPage<UsersCubit, List<User>> {
  const UsersPage({super.key});

  @override
  UsersCubit createBloc(BuildContext context) => UsersCubit(api);

  @override
  void onInit(UsersCubit bloc) => bloc.loadUsers(); // also used by Retry

  @override
  String? title(BuildContext context) => 'Users';

  @override
  Widget buildData(BuildContext context, UsersCubit bloc, List<User> users) =>
      UsersList(users);
}
```

If you get the cubit from a service locator, override
`closeBlocOnDispose => false` when the page does not own it.

### DataObserverBuilder

Renders one `DataObserver` with its own loading, error and retry.

```dart
DataObserverBuilder<List<Notice>>(
  observer: cubit.observer('notices'),
  onRetry: cubit.loadNotices,
  builder: (context, notices) => NoticesList(notices),
)
```

### DataStateView

Renders any `DataState` you hold, with no bloc needed.

```dart
DataStateView<User>(state: state, builder: (context, user) => UserCard(user))
```

## Your own states

Both state families are open, so make your own by extending them and emit
them with `emitState`. No mapping or registration needed:

```dart
class CartEmpty extends BuildState<List<Item>> {
  const CartEmpty();
}

class CouponApplied extends ActionState<List<Item>> {
  const CouponApplied(this.discount);
  final int discount;
}

class CartCubit extends BaseCubit<List<Item>> {
  void clear() => emitState(const CartEmpty());
  void applyCoupon(int discount) => emitState(CouponApplied(discount));
}
```

Screen states you add are drawn by `stateBuilder`; action states you add go
to `listener`:

```dart
SoftBlocConsumer<CartCubit, List<Item>>(
  stateBuilder: (context, state) => state is CartEmpty ? const EmptyCart() : null,
  listener: (context, state) {
    if (state is CouponApplied) showToast('${state.discount}% off');
  },
  builder: (context, items) => ItemsList(items),
)
```

## Configure once

```dart
MaterialApp(
  builder: (context, child) => SoftCore(
    config: SoftCoreConfig(
      errorMapper: mapErrors,
      loadingBuilder: (context) => const MyLoader(),
      errorBuilder: (context, error, onRetry) => MyErrorView(error, onRetry),
      initialBuilder: (context) => const SizedBox(),
      progressBuilder: (context) => const MyProgressCard(),
      errorMessenger: (context, error) => showMyToast(error.message),
      retryLabel: 'Try again',
    ),
    child: child!,
  ),
)
```

Wrapping inside `MaterialApp.builder` covers dialogs and pushed pages too.
Any widget can still override a single builder for itself.

## Errors

Throw a `SoftException` when you already know what to tell the user, or a
`LocalizedException` for several languages. The message for the app's
current locale is shown:

```dart
throw const SoftException('Out of stock', code: 'stock');
throw LocalizedException({'en': 'Out of stock', 'ar': 'نفدت الكمية'});
```

Turn any other error (Dio, HTTP, your API's errors) into a message with an
`ErrorMapper`:

```dart
SoftError mapErrors(BuildContext context, Object error) {
  if (error is DioException) {
    return const SoftError(message: 'Check your internet connection.');
  }
  return defaultErrorMapper(context, error);
}
```

## Clean architecture

`UseCase<T, Params>` and `NoParams` are included for the domain layer:

```dart
class GetUsers implements UseCase<List<User>, NoParams> {
  GetUsers(this.repository);
  final UserRepository repository;

  @override
  Future<List<User>> call(NoParams params) => repository.getUsers();
}
```

## Example

The [example app](example/lib/main.dart) has a runnable screen for every
component: loading, actions, caching, observers, pages, listeners, your own
states, configuration and `DataStateView`.

```bash
cd example && flutter run
```

## Migrating from 0.x

See the [changelog](CHANGELOG.md#breaking-changes) for the renamed states and
methods.
