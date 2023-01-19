# agile-in-action-minima-docker-image
This is a multi-architecture Docker Image for Jekyll 4.3.1. It was designed to support the Agile in [Action Minima Repo](https://github.com/BillRaymond/agile-in-action-minima), but can be used for any website design.

How to use:

1. Create or clone a Jekyll 4.3.1 repo to your local computer
2. Add a file to the root of the repo and name it `Dockerfile`
3. At minimum, add the following line to the Dockerfile:
```
FROM billraymond/agile-in-action-minima-docker-image:latest
```
4. Add any other RUN, ARG, ENV, etc elements to the file that you may need
5. In Visual Studio Code, install the `Docker` and `Dev Containers` extensions
6. In VSC, run the command "Open folder in container..." and select Dockerfile. Do not select any other options
7. The Docker image will build
8. In the VSC terminal, type:
```
bundle install
bundle update
```
9. Now you can run the Jekyll site with:
```
bundle exec jekyll serve --livereload
```
