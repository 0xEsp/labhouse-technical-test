<p align="center">
  <h1 align="center">Labhouse App</h1>
</p>

#### AI-powered ranking app built with Flutter

<img width="1024" alt="github-banner" src="https://framerusercontent.com/images/36qyACq2D9HaLA5biRBqQadLHR0.png">

<!-- ![GitHub Release](https://img.shields.io/github/v/release/NyxellApp/https%3A%2F%2Fgithub.com%2FNyxellApp%2FNyxellFlutterApp?display_name=release&style=flat-square)
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
[![GitHub Workflow Status (with branch)](https://img.shields.io/github/actions/workflow/status/ManuEspeso/delocals-app/CI-pre-release.yml?style=flat-square)](https://github.com/ManuEspeso/delocals-app/actions/workflows/CI-pre-release.yml) -->

## Table of Contents

- [Contributors](#contributors)
- [Run project](#steps-to-run-project)
- [Commands](#useful-commands)

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/0xEsp"><img src="https://avatars.githubusercontent.com/u/44836587?v=4?s=100" width="100px;" alt="Manu Espeso"/><br /><sub><b>Manu Espeso</b></sub></a><br /><a href="https://github.com/0xEsp" title="Code">💻</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

## Steps to run project

> 1. Install Ruby as specified in `.ruby-version` (recommended: use rbenv) and run `bundle install`.
> 2. Install [FVM](https://fvm.app) and run `fvm install` in the project root to install the correct Flutter version.
> 3. Install dependencies:
>    ```bash
>    fvm flutter pub get
>    ```
> 4. Generate localization files:
>    ```bash
>    fvm flutter gen-l10n
>    ```
> 5. Generate code for `@JsonSerializable` models:
>    ```bash
>    fvm dart run build_runner build --delete-conflicting-outputs
>    ```
> 6. Create `.env/secrets.json` and add your OpenAI API key:
>    ```json
>    {
>      "OPENAI_API_KEY": "sk-..."
>    }
>    ```
> 7. Select an iPhone simulator or Android emulator in your IDE.
> 8. In VS Code, open the **Run and Debug** panel (`⇧⌘D`) and launch the **`labhouse-debug`** configuration.

## Useful commands

> - `flutter gen-l10n` -> Create require localization files
> - `dart run build_runner build` -> Generate .g files for JsonSerializable models
