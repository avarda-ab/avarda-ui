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
4. Commit changes
5. Create PR in DevOps
6. Squash and merge to `master`
7. Create a git tag in DevOps with name of the new version from `elm bump` you ran earlier
8. Pull from DevOps master (`git pull {devops_origin} master`)
9. Push to Github master, including tags (`git push --tags {github_origin} master`)
10. Run `elm publish`

## Quick Tip

In order to expose anything from the package, you have to reference it in `elm.json` under `"exposed-modules"`. If you do so, then every exposed function from that module has to be documented. If it isn't, Elm will not let you publish the package, therefore you will have to go through another round of creating a PR and syncing repos.

You can follow [this official article](https://package.elm-lang.org/help/documentation-format) on how to correctly document everything.
