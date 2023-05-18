# fhir-ig-action

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/qligier/fhir-ig-action)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/qligier/fhir-ig-action/verify.yml)
![GitHub last commit](https://img.shields.io/github/last-commit/qligier/fhir-ig-action)
![GitHub](https://img.shields.io/github/license/qligier/fhir-ig-action)
[![CHANGELOG](https://img.shields.io/badge/-CHANGELOG-blue)](https://github.com/qligier/fhir-ig-action/blob/main/CHANGELOG.md)

This action provides the following functionality for [GitHub Actions](https://docs.github.com/en/actions) users:

- Build a FHIR IG with the [IG Publisher](https://github.com/HL7/fhir-ig-publisher/)
- Use the set versions of the [IG Publisher](https://github.com/HL7/fhir-ig-publisher/) and
  [SUSHI](https://github.com/FHIR/sushi) (if needed)
- Matches IG Publisher and Sushi errors in GitHub

## Usage

The action can be configured with the following inputs:

<dl>
<dt>ig-publisher</dt>
<dd>The version of the IG Publisher to use. The value can be a full version (i.e. <em>x.y.z</em>) or the keyword 
'<strong>latest</strong>'. The default value is '<em>latest</em>'.</dd>

<dt>sushi</dt>
<dd>The version of SUSHI to use. The value can be a partial or full version (i.e. <em>x</em>, <em>x.y</em> or 
<em>x.y.z</em>), the keyword '<strong>latest</strong>', or the keyword '<strong>false</strong>' to disable SUSHI. The 
default value is '<strong>false</strong>'.</dd>
</dl>

### Examples

The following example will build an IG with the latest version of the IG Publisher, without SUSHI. The _ig.ini_ file is
expected in the top directory of the project.

```yaml
name: Build the IG
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: qligier/fhir-ig-action@v0.2.0
```

Another example for a SUSHI IG, with specific versions:

```yaml
name: Build the IG
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: qligier/fhir-ig-action@v0.2.0
        with:
          ig-publisher: "1.3.5"
          sushi: "2.10"
```

To build an IG in another directory, you should use the
[working-directory](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsrun)
configuration:

```yaml
name: Build the IG
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: qligier/fhir-ig-action@v0.2.0
        working-directory: ./folder/my-ig # This will use ./folder/my-ig/ig.ini
```

## License

This project is released under the [MIT License](https://github.com/qligier/fhir-ig-action/blob/main/LICENSE.txt).

## Development

Issues and pull requests are very welcome :blue_heart:

Code contributions must pass the code checks: [shfmt](https://github.com/patrickvane/shfmt),
[shellcheck](https://www.shellcheck.net) and [Prettier](https://prettier.io). See the
[GitHub Action file](https://github.com/qligier/fhir-ig-action/blob/main/.github/workflows/verify.yml) for details.

![Alt](https://repobeats.axiom.co/api/embed/606c44316ea2a19b24c7fd98f732796195955edc.svg "Repobeats analytics image")
