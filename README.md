# Headless Google Chrome
This docker image uses the Google Chrome stable channel that introduced headless execution with version 59.

There are currently two feasible options to run Chrome inside Docker:
* Specify a Docker security profile that allows the Chrome sandbox (`docker run --security-opt seccomp=chrome.json`)
  * Jess Frazelle (@jessfraz) has created such a profile for Chrome
* Disable the Chrome sandbox (`google-chrome --no-sandbox`)
  * This lowers the security of Chrome and is not recommended when browsing untrusted web content

## Examples

### Security Profile
Download @jessfraz Docker security profile for Chrome:
```
wget https://raw.githubusercontent.com/jessfraz/dotfiles/master/etc/docker/seccomp/chrome.json
```
Browse to Google and save a screenshot to the current directory:
```
docker run --rm --security-opt seccomp=chrome.json -v $PWD:/data armbues/chrome-headless --screenshot http://www.google.com
```
Start Chrome with the remote debugging port running on 9222 and map it to the host:
```
docker run --rm -d --security-opt seccomp=chrome.json -p 9222:9222 armbues/chrome-headless --remote-debugging-address=0.0.0.0 --remote-debugging-port=9222
```
### Disabled Chrome sandbox
Browse to Google and save a screenshot to the current directory:
```
docker run --rm -v $PWD:/data armbues/chrome-headless --no-sandbox --screenshot http://www.google.com
```
Start Chrome with the remote debugging port running on 9222 and map it to the host:
```
docker run --rm -d -p 9222:9222 armbues/chrome-headless --no-sandbox --remote-debugging-address=0.0.0.0 --remote-debugging-port=9222
```
