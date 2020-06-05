The purpose of this repo is to provide a reproducible example for [#7874](https://github.com/facebook/jest/issues/7874).

# How to run

I ran these tests with the following env:

```
npx envinfo --preset jest

  System:
    OS: macOS 10.15.5
    CPU: (8) x64 Intel(R) Core(TM) i7-8569U CPU @ 2.80GHz
  Binaries:
    Node: 14.3.0 - /usr/local/bin/node
    Yarn: 1.22.4 - ~/.yarn/bin/yarn
    npm: 6.13.7 - ~/.npm-global/bin/npm
  npmPackages:
    jest: ^26.0.1 => 26.0.1
```

To reproduce this issue, clone this repo and run locally or through Docker:

### Local

```
yarn test
```

### Docker

```
yarn docker test
```

```
 PASS  tests/simple23.test.js (300 MB heap size)
 PASS  tests/simple0.test.js (316 MB heap size)
 PASS  tests/simple4.test.js (316 MB heap size)
 PASS  tests/simple10.test.js (333 MB heap size)
 PASS  tests/simple26.test.js (333 MB heap size)
 PASS  tests/simple42.test.js (333 MB heap size)
 PASS  tests/simple15.test.js (348 MB heap size)

Test Suites: 50 passed, 50 total
Tests:       50 passed, 50 total
Snapshots:   0 total
Time:        7.191 s
Ran all test suites.
✨  Done in 8.29s.
```

---

Exposing Node's gc API via the `--expose-gc` flag seems to fix the problem (see [package.json](package.json) for exact script):

### Local

```
yarn test-expose
```

### Docker

```
yarn docker test-expose
```

```
 PASS  tests/simple35.test.js (36 MB heap size)
 PASS  tests/simple29.test.js (36 MB heap size)
 PASS  tests/simple3.test.js (36 MB heap size)
 PASS  tests/simple1.test.js (36 MB heap size)
 PASS  tests/simple34.test.js (36 MB heap size)
 PASS  tests/simple41.test.js (36 MB heap size)
 PASS  tests/simple32.test.js (36 MB heap size)

Test Suites: 50 passed, 50 total
Tests:       50 passed, 50 total
Snapshots:   0 total
Time:        8.144 s
Ran all test suites.
✨  Done in 8.82s.
```
