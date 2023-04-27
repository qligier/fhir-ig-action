# fhir-ig-action

This action provides the following functionality for [GitHub Actions](actions) users:

- Build a FHIR IG with the [IG Publisher](igpublisher)
- Use the set versions of the [IG Publisher](igpublisher) and [SUSHI](sushi) (if needed)

## Usage

### Simple IG

```yaml
name: Build the IG
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: qligier/fhir-ig-action@v1
        with:
          ig-publisher: "latest"
```

## License

This project is released under the [MIT License](https://github.com/qligier/fhir-ig-action/blob/main/LICENSE.txt).

[igpublisher]: https://github.com/HL7/fhir-ig-publisher/
[sushi]: https://github.com/FHIR/sushi
[actions]: https://docs.github.com/en/actions
