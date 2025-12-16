# Monorepo & Melos Rules

These rules govern how to interact with the monorepo structure and the `melos` tooling.

### 1. Code Generation (Build Runner)

When code generation is required for packages (e.g., for `freezed`, `json_serializable`, etc.), you **must not** run `build_runner` directly.

Instead, you **must** run the following command from the project root:

```sh
melos run build-files --no-select
```

This ensures that the build command is run consistently across all relevant packages in the workspace.

### 2. Adding a New Package/App

When creating a new package or application within the `packages/` or `apps/` directories, a two-step process is required for it to be correctly integrated into the monorepo:

1.  **Update Workspace:** Add the relative path to your new package to the `workspace:` list in the root `pubspec.yaml` file.
2.  **Bootstrap:** After updating the `pubspec.yaml`, run the `melos bootstrap` command from the project root. This will link all local packages together and install their dependencies.

    ```sh
    melos bootstrap
    ```

    (You can use the shorthand `melos bs` as well).
