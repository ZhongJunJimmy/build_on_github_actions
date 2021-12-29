# Github Actions
Hey Guys, I want to make a sample that auto completion your workflow by github actions. It will generate a MAC OS 11(or the other OS) environment, install Node.js in the environment and build executable file by [pkg](https://www.npmjs.com/package/pkg).

##  Creating your workflow
1. Creating a `.github/workflows` directory in your repository if this directory does not already exist.
2. In the `.github/workflows` directory, creating a file named `github-actions-demo.yml` or any file name you want to named. But the extension name must be `.yml`.
3. Edit you workflow step. For example in this repository:
    ``` 
    name: github-actions-demo
    on: [push]
    jobs:
        github-actions-demo:
            runs-on: macos-11
            steps:
            - name: Check out repository code
                uses: actions/checkout@v2
            - name: List files in the repository
                run: |
                ls ${{ github.workspace }}
            - uses: actions/setup-node@v2
                with:
                node-version: '14'
            - name: build pkg
                working-directory: ./koa_project
                run: |
                npm install
                npm install -g pkg
                pkg app.js
            - uses: actions/upload-artifact@v2
                with:
                name: Executable file for MAC OS
                path: ./koa_project/app-macos
            - uses: actions/upload-artifact@v2
                with:
                name: Executable file for Windows
                path: ./koa_project/app-win.exe
            - uses: actions/upload-artifact@v2
                with:
                name: Executable file for Linux
                path: ./koa_project/app-linux
    ```
4. Committing the workflow file to a branch in your repository triggers the push event and runs your workflow.

## What did we do
That review the workflow script in the `Creating your workflow` step 4:
- **name**: This workflow's name.
- **on**: The workflow triger condition. You can got some hints form [there](https://docs.github.com/en/actions/learn-github-actions/events-that-trigger-workflows). In this sample that trigger the workflow when the push event.
- **jobs**: Designing your workflow job. You can create more `job` under a `jobs` and more `step` under a `job`. The following string `github-actions-demo` after `jobs` is job's name in sample workflow script. So maybe you will design a `jobs` like this:
    ```
    jobs:
        job_1:
            ...
        job_2:
            needs: job_1
            ...
        job_3:
            needs: [job_1, job_2]
            ...
        ...
    ```

#### To be continue...













# Reference: 
- [Github Actions](https://docs.github.com/en/actions)
