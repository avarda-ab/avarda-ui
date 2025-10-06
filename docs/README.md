# Elm Design System

This is our Elm design system repo including both the elm package code and a storybook.

## Requirements

`pnpm install`

## Run storybook

`pnpm storybook`

Deployed storybook can be found [here](https://elm-ui.test.avarda.com/).

## Workflow

Currently there are two origins:

- https://github.com/avarda-ab/avarda-ui
- Azure DevOps (**ElmDesignSystem** repository)

In order for these repos to stay in sync, this following flow is in place:

1. Create branch from master
2. Make some changes
3. Run `elm bump`
4. After running `elm bump`, it always removes `"source-directories"` from `elm.json` which breaks the further development process (linting, formatting, hot-reload). Add it back.

```json
"source-directories": [
    "src"
]
```

5. Commit changes
6. Create PR in DevOps
7. Squash and merge to `master`
8. Create a git tag in DevOps with name of the new version from your updated `elm.json`
9. Pull from DevOps master (`git pull --tags {devops_origin} master`)
10. Push to Github master, including tags (`git push --tags {github_origin} master`)
11. Run `elm publish`

## Quick Tip

In order to expose anything from the package, you have to reference it in `elm.json` under `"exposed-modules"`. If you do so, then every exposed function from that module has to be documented. If it isn't, Elm will not let you publish the package, therefore you will have to go through another round of creating a PR and syncing repos.

You can follow [this official article](https://package.elm-lang.org/help/documentation-format) on how to correctly document everything.

## Problem with documentation after publish

If it happens that after running `elm-publish` you get `Problem with documentation` kind of error, you will have to fix it in another PR, follow these steps:

1. Remove the tag you created in Azure DevOps and Github
2. Remove the tag locally by running `git tag -d {your_tag}`
3. Create a new branch as you would do normally and do your changes
4. Commit changes without running `elm-bump`
5. Follow the same instructions in [Workflow](#workflow) from step `6.` till the end
