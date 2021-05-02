# Strava access token generator

Generate Strava API OAuth2 access token for testing purposes.

Used in pet projects:
- [**stra-bash**](https://github.com/mgryszko/stra-bash) - Strava batch CLI tool written in bash language 
- [**kstrava**](https://github.com/mgryszko/kstrava) -  Strava batch CLI tool written in functional Kotlin using [Arrow](https://arrow-kt.io/)

## Installation

### Prerequisites

Ruby executable. Tested on macOS with Homebrew Ruby environment managed by `rbenv`.

### Homebrew

```shell script
brew tap mgryszko/strava
brew install strava-access-token
```

## Usage

```shell script
strava-access-token <client_id> <client_secret>
```

If you don't have a client id/secret, register your app following the official [Strava documentation](https://developers.strava.com/docs/getting-started/#account).

The script starts a local server (acting as an OAuth2 client) listening on port 8080.

Open your http://localhost:8080/ in your browser and authenticate against Strava. Access token will be displayed in the browser and downloaded to the current working directory as `.access-token` .

## Developer setup

Pre-requisite: install [`rbenv` (Ruby environment)](https://github.com/rbenv/rbenv), then:

```shell script
# Replace '<ruby_version>' with latest 2.7 [Ruby release](https://www.ruby-lang.org/en/downloads/).
rbenv install <ruby_version>
rbenv local <ruby_version>
```

### Run

```shell script
rbenv exec ruby strava-access-token <client_id> <client_secret>
```
