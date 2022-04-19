# devenv start up

## python environment

### pyenv install & setup

``` sh
brew install pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```

### python install

``` sh
# Latest stable version as of 2022/04/17
pyenv install 3.9.7
```

## poetry install & setup

``` sh
brew install poetry

# Set the version of python to use for this project
pyenv local 3.9.7

# "pyenv local" command can be used to set it to 3.9.7
# pyenv local 3.9.7

# "pyenv install" command can be install and configure the version of python you have set up for this project
# pyenv install
```

## create project

``` sh
mkdir <project-name>
cd <project-name>

poetry init

# Create venv to current directry setting
poetry config virtualenvs.in-project true --local
# To set global settings ↓
# poetry config virtualenvs.in-project true

# Create in venv with local Python version
python -m venv .venv
```

### flask install

``` sh
poetry add flask
```

### usage of poetry
https://cocoatomo.github.io/poetry-ja/cli/


# Switch python virtual env

## venv activate
``` sh
. .venv/bin/activate
```

### venv deactivate
``` sh
deactivate
```

# Install database driver

## Intstall required package to HostOS

```sh
# postgresql and openssl is required on the host OS to use psycopg2
brew install postgresql
brew install openssl
```

## Install flask×postgressql packages

``` sh
poetry add flask-sqlalchemy flask-migrate psycopg2
```

