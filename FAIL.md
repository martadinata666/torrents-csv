## Some log of fail build
```
#19 4817.6    Compiling perseus-axum v0.4.0
#19 4817.6    Compiling human_bytes v0.4.1
#19 4817.6    Compiling torrents-csv-ui-perseus v0.1.0 (/app)
#19 4817.6     Finished release [optimized] target(s) in 74m 10s
#19 4817.6      Running `dist/target_engine/release/torrents-csv-ui-perseus`
#19 4817.6 Error: template 'search' can't be exported because it depends on strategies that can't be run at build-time (only build state and build paths can be used in exportable templates)
#19 ERROR: process "/bin/sh -c perseus deploy -e --no-system-tools-cache --no-minify-js --verbose" did not complete successfully: exit code: 1
------
 > [builder 4/4] RUN perseus deploy -e --no-system-tools-cache --no-minify-js --verbose:
#19 4817.6    Compiling base64 v0.21.0
#19 4817.6    Compiling ipnet v2.7.2
#19 4817.6    Compiling reqwest v0.11.17
#19 4817.6    Compiling format_num v0.1.0
#19 4817.6    Compiling perseus-axum v0.4.0
#19 4817.6    Compiling human_bytes v0.4.1
#19 4817.6    Compiling torrents-csv-ui-perseus v0.1.0 (/app)
#19 4817.6     Finished release [optimized] target(s) in 74m 10s
#19 4817.6      Running `dist/target_engine/release/torrents-csv-ui-perseus`
#19 4817.6 Error: template 'search' can't be exported because it depends on strategies that can't be run at build-time (only build state and build paths can be used in exportable templates)
------
Dockerfile.test:28
--------------------
  26 |     #   && perseus deploy --no-system-tools-cache --cargo-engine-args="--target=$CARGO_BUILD_TARGET" --verbose --no-minify-js
  27 |     #ARG CARGO_BUILD_TARGET=aarch64-unknown-linux-gnu
  28 | >>> RUN perseus deploy -e --no-system-tools-cache --no-minify-js --verbose
  29 |     # The alpine runner
  30 |     FROM 192.168.0.2:5050/dedyms/python-http-server:latest as runner
--------------------
ERROR: failed to solve: process "/bin/sh -c perseus deploy -e --no-system-tools-cache --no-minify-js --verbose" did not complete successfully: exit code: 1

```

```
#24 [linux/amd64 builder 4/4] RUN perseus deploy --no-system-tools-cache --no-minify-js --verbose
#24 5644.4     Blocking waiting for file lock on package cache
#24 5644.4     Blocking waiting for file lock on package cache
#24 5644.4     Blocking waiting for file lock on package cache
#24 5644.4     Blocking waiting for file lock on package cache
#24 5644.4     Blocking waiting for file lock on build directory
#24 5644.4     Finished release [optimized] target(s) in 94m 01s
#24 5644.4      Running `dist/target_engine/aarch64-unknown-linux-gnu/release/torrents-csv-ui-perseus`
#24 5644.4 qemu-aarch64: Could not open '/lib/ld-linux-aarch64.so.1': No such file or directory
#24 ERROR: process "/bin/sh -c perseus deploy --no-system-tools-cache --no-minify-js --verbose" did not complete successfully: exit code: 1

#22 [linux/amd64->arm64 builder 4/4] RUN perseus deploy --no-system-tools-cache --no-minify-js --verbose
#22 CANCELED
------
 > [linux/amd64 builder 4/4] RUN perseus deploy --no-system-tools-cache --no-minify-js --verbose:
#24 248.3 warning: `torrents-csv-ui-perseus` (bin "torrents-csv-ui-perseus") generated 4 warnings (run `cargo fix --bin "torrents-csv-ui-perseus"` to apply 2 suggestions)
#24 248.3     Finished release [optimized] target(s) in 4m 05s
#24 5644.4     Blocking waiting for file lock on package cache
#24 5644.4     Blocking waiting for file lock on package cache
#24 5644.4     Blocking waiting for file lock on package cache
#24 5644.4     Blocking waiting for file lock on package cache
#24 5644.4     Blocking waiting for file lock on build directory
#24 5644.4     Finished release [optimized] target(s) in 94m 01s
#24 5644.4      Running `dist/target_engine/aarch64-unknown-linux-gnu/release/torrents-csv-ui-perseus`
#24 5644.4 qemu-aarch64: Could not open '/lib/ld-linux-aarch64.so.1': No such file or directory
------
Dockerfile:28
```
* it detect libc6:arm64 not the cross libc6-arm64-cross https://packages.debian.org/search?searchon=contents&keywords=%2Flib%2Fld-linux-aarch64.so.1&mode=path&suite=stable&arch=any

```
   Compiling format_num v0.1.0
   Compiling human_bytes v0.4.1
   Compiling torrents-csv-ui-perseus v0.1.0 (/home/debian/tcui)
    Finished release [optimized] target(s) in 75m 20s
```

# Building persesuse expected slow, on 8400T result ~90mnts, disable optimization                                                                                                                                                                                   0.1s
# => [builder 4/4] RUN perseus deploy --no-system-tools-cache --no-minify-js --verbose                                    4870.6s
## 17 97.11    Compiling human_bytes v0.4.1
# 17 99.41    Compiling torrents-csv-ui-perseus v0.1.0 (/app)
# 17 107.2     Finished release [unoptimized] target(s) in                                                                 1m 47s
#

Static build fail
```
23 92.59    Compiling time v0.1.45
#23 93.54    Compiling fmterr v0.1.1
#23 93.72    Compiling iana-time-zone v0.1.56
#23 94.24    Compiling chrono v0.4.24
#23 94.98    Compiling perseus v0.4.0
#23 95.47 error[E0432]: unresolved import `crate::web_log`
#23 95.47    --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/lib.rs:152:13
#23 95.47     |
#23 95.47 152 |     pub use crate::web_log;
#23 95.47     |             ^^^^^^^^^^^^^^ no `web_log` in the root
#23 95.47 
#23 95.47 error[E0432]: unresolved imports `crate::PerseusNodeType`, `crate::Request`
#23 95.47    --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/lib.rs:155:21
#23 95.47     |
#23 95.47 155 |     pub use crate::{PerseusNodeType, Request};
#23 95.47     |                     ^^^^^^^^^^^^^^^  ^^^^^^^ no `Request` in the root
#23 95.47     |                     |
#23 95.47     |                     no `PerseusNodeType` in the root
#23 95.47 
#23 95.47 error[E0432]: unresolved import `crate::utils::PerseusDuration`
#23 95.47  --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/template/core/setters.rs:2:5
#23 95.47   |
#23 95.47 2 | use crate::utils::PerseusDuration;
#23 95.47   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ no `PerseusDuration` in `utils`
#23 95.47 
#23 95.47 error[E0432]: unresolved imports `decode_time_str::ComputedDuration`, `decode_time_str::PerseusDuration`
#23 95.47   --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/utils/mod.rs:25:27
#23 95.47    |
#23 95.47 25 | pub use decode_time_str::{ComputedDuration, InvalidDuration, PerseusDuration}; /* These have dummy equivalents for the browser */
#23 95.47    |                           ^^^^^^^^^^^^^^^^                   ^^^^^^^^^^^^^^^ no `PerseusDuration` in `utils::decode_time_str`
#23 95.47    |                           |
#23 95.47    |                           no `ComputedDuration` in `utils::decode_time_str`
#23 95.47 
#23 95.79 error[E0392]: parameter `M` is never used
#23 95.79    --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/init.rs:111:36
#23 95.79     |
#23 95.79 111 | pub struct PerseusAppBase<G: Html, M: MutableStore, T: TranslationsManager> {
#23 95.79     |                                    ^ unused parameter
#23 95.79     |
#23 95.79     = help: consider removing `M`, referring to it in a field, or using a marker such as `PhantomData`
#23 95.79 
#23 95.79 error[E0392]: parameter `T` is never used
#23 95.79    --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/init.rs:111:53
#23 95.79     |
#23 95.79 111 | pub struct PerseusAppBase<G: Html, M: MutableStore, T: TranslationsManager> {
#23 95.79     |                                                     ^ unused parameter
#23 95.79     |
#23 95.79     = help: consider removing `T`, referring to it in a field, or using a marker such as `PhantomData`
#23 95.79 
#23 95.79 error[E0392]: parameter `G` is never used
#23 95.79   --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/reactor/mod.rs:71:20
#23 95.79    |
#23 95.79 71 | pub struct Reactor<G: Html> {
#23 95.79    |                    ^ unused parameter
#23 95.79    |
#23 95.79    = help: consider removing `G`, referring to it in a field, or using a marker such as `PhantomData`
#23 95.79 
#23 95.83 Some errors have detailed explanations: E0392, E0432.
#23 95.83 For more information about an error, try `rustc --explain E0392`.
#23 95.83 error: could not compile `perseus` due to 7 previous errors
#23 95.83 warning: build failed, waiting for other jobs to finish...
#23 ERROR: process "/bin/sh -c case ${TARGETPLATFORM} in          \"linux/amd64\")  CARGO_BUILD_TARGET=x86_64-unknown-linux-gnu  ;;          \"linux/arm64\")  CARGO_BUILD_TARGET=aarch64-unknown-linux-gnu  ;;     esac     && cargo build --release --target=$CARGO_BUILD_TARGET &&     ls target &&     mkdir ./pkg &&     cp target/$CARGO_BUILD_TARGET/release/torrents-csv-ui-perseus ./pkg/server;" did not complete successfully: exit code: 101

#24 [linux/amd64->arm64 builder 6/6] RUN case linux/arm64 in          "linux/amd64")  CARGO_BUILD_TARGET=x86_64-unknown-linux-gnu  ;;          "linux/arm64")  CARGO_BUILD_TARGET=aarch64-unknown-linux-gnu  ;;     esac     && cargo build --release --target=$CARGO_BUILD_TARGET &&     ls target &&     mkdir ./pkg &&     cp target/$CARGO_BUILD_TARGET/release/torrents-csv-ui-perseus ./pkg/server;
#24 93.49    Compiling fmterr v0.1.1
#24 93.70    Compiling iana-time-zone v0.1.56
#24 94.13    Compiling chrono v0.4.24
#24 94.86    Compiling perseus v0.4.0
#24 95.22 error[E0432]: unresolved import `crate::web_log`
#24 95.22    --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/lib.rs:152:13
#24 95.22     |
#24 95.22 152 |     pub use crate::web_log;
#24 95.22     |             ^^^^^^^^^^^^^^ no `web_log` in the root
#24 95.22 
#24 95.22 error[E0432]: unresolved imports `crate::PerseusNodeType`, `crate::Request`
#24 95.22    --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/lib.rs:155:21
#24 95.22     |
#24 95.22 155 |     pub use crate::{PerseusNodeType, Request};
#24 95.22     |                     ^^^^^^^^^^^^^^^  ^^^^^^^ no `Request` in the root
#24 95.22     |                     |
#24 95.22     |                     no `PerseusNodeType` in the root
#24 95.22 
#24 95.22 error[E0432]: unresolved import `crate::utils::PerseusDuration`
#24 95.22  --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/template/core/setters.rs:2:5
#24 95.22   |
#24 95.22 2 | use crate::utils::PerseusDuration;
#24 95.22   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ no `PerseusDuration` in `utils`
#24 95.22 
#24 95.23 error[E0432]: unresolved imports `decode_time_str::ComputedDuration`, `decode_time_str::PerseusDuration`
#24 95.23   --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/utils/mod.rs:25:27
#24 95.23    |
#24 95.23 25 | pub use decode_time_str::{ComputedDuration, InvalidDuration, PerseusDuration}; /* These have dummy equivalents for the browser */
#24 95.23    |                           ^^^^^^^^^^^^^^^^                   ^^^^^^^^^^^^^^^ no `PerseusDuration` in `utils::decode_time_str`
#24 95.23    |                           |
#24 95.23    |                           no `ComputedDuration` in `utils::decode_time_str`
#24 95.23 
#24 95.55 error[E0392]: parameter `M` is never used
#24 95.55    --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/init.rs:111:36
#24 95.55     |
#24 95.55 111 | pub struct PerseusAppBase<G: Html, M: MutableStore, T: TranslationsManager> {
#24 95.55     |                                    ^ unused parameter
#24 95.55     |
#24 95.55     = help: consider removing `M`, referring to it in a field, or using a marker such as `PhantomData`
#24 95.55 
#24 95.56 error[E0392]: parameter `T` is never used
#24 95.56    --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/init.rs:111:53
#24 95.56     |
#24 95.56 111 | pub struct PerseusAppBase<G: Html, M: MutableStore, T: TranslationsManager> {
#24 95.56     |                                                     ^ unused parameter
#24 95.56     |
#24 95.56     = help: consider removing `T`, referring to it in a field, or using a marker such as `PhantomData`
#24 95.56 
#24 95.56 error[E0392]: parameter `G` is never used
#24 95.56   --> /home/debian/cargo/registry/src/index.crates.io-6f17d22bba15001f/perseus-0.4.0/src/reactor/mod.rs:71:20
#24 95.56    |
#24 95.56 71 | pub struct Reactor<G: Html> {
#24 95.56    |                    ^ unused parameter
#24 95.56    |
#24 95.56    = help: consider removing `G`, referring to it in a field, or using a marker such as `PhantomData`
#24 95.56 
#24 95.58 Some errors have detailed explanations: E0392, E0432.
#24 95.58 For more information about an error, try `rustc --explain E0392`.
#24 95.58 error: could not compile `perseus` due to 7 previous errors
#24 95.58 warning: build failed, waiting for other jobs to finish...
#24 ERROR: process "/bin/sh -c case ${TARGETPLATFORM} in          \"linux/amd64\")  CARGO_BUILD_TARGET=x86_64-unknown-linux-gnu  ;;          \"linux/arm64\")  CARGO_BUILD_TARGET=aarch64-unknown-linux-gnu  ;;     esac     && cargo build --release --target=$CARGO_BUILD_TARGET &&     ls target &&     mkdir ./pkg &&     cp target/$CARGO_BUILD_TARGET/release/torrents-csv-ui-perseus ./pkg/server;" did not complete successfully: exit code: 101
------
 > [linux/amd64->arm64 builder 6/6] RUN case linux/arm64 in          "linux/amd64")  CARGO_BUILD_TARGET=x86_64-unknown-linux-gnu  ;;          "linux/arm64")  CARGO_BUILD_TARGET=aarch64-unknown-linux-gnu  ;;     esac     && cargo build --release --target=$CARGO_BUILD_TARGET &&     ls target &&     mkdir ./pkg &&     cp target/$CARGO_BUILD_TARGET/release/torrents-csv-ui-perseus ./pkg/server;:
#24 95.56    |
#24 95.56 71 | pub struct Reactor<G: Html> {
#24 95.56    |                    ^ unused parameter
#24 95.56    |
#24 95.56    = help: consider removing `G`, referring to it in a field, or using a marker such as `PhantomData`
#24 95.56 
#24 95.58 Some errors have detailed explanations: E0392, E0432.
#24 95.58 For more information about an error, try `rustc --explain E0392`.
#24 95.58 error: could not compile `perseus` due to 7 previous errors
#24 95.58 warning: build failed, waiting for other jobs to finish...
------

```