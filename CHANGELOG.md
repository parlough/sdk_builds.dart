## 0.3.0

* **Breaking:** Changes the name of multiple methods to match effective dart standards
  * `DartDownloads#getDownloadLink` is now `DartDownloads#createDownloadLink`
  * `DartDownloads#getVersions` is now `DartDownloads#fetchVersions`
  * `DartDownloads#getVersionPaths` is now `DartDownloads#fetchVersionPaths`
  * `DartDownloads#getVersion` is now `DartDownloads#fetchVersion`
* Update to support null safety
* Update dependencies
* Fix various lints

## 0.1.0

* Added `VersionInfo`

* `DartDownloads`
  * `getVersion` now returns `VersionInfo`
  * Added `getVersions`
  * Removed `getVersionMap`

## 0.0.1

* Just getting started.
