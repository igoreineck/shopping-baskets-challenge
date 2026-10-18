# shopping-baskets-challenge

This is a small CLI application that represents a simple shopping basket for all kinds of products, with tax calculation applied at the checkout.

The tax calculation follows a few requirements:

- Sales Tax: is a 10% fee applied on all product types except **books**, **foods** and **medications**.
- Import Tax: is a 5% fee applied on all imported products with no exempt.

**Rounding rules**
The rounding rules for sales tax are that for a tax rate of n%, a shelf price of p contains (np/100 rounded up to the nearest 0.05) amount of sales tax.

---

## Technical Decisions

It was built using Ruby version **3.4.11** purely with no external libraries except [pry](https://github.com/pry/pry) used for debugging at runtime and [rspec](https://github.com/rspec/rspec) for writing tests.

Some tools included in the Ruby standard library were used, such as:

- `json`: used to parse and process objects in JSON.
- `optparse`: used to handle command line arguments.

All the other entities, services and helpers are custom made entirely in _PORO_ (Plain Old Ruby Object).

---

## How to execute

To execute you must have Ruby 3.4.11 installed. If not, it can be installed using [asdf](https://asdf-vm.com/) or [rbenv](https://github.com/rbenv/rbenv).

Using **rbenv** it can be easily installed by using:

```bash
rbenv install 3.4.11

# after installing, set local Ruby for this version
rbenv local 3.4.11
```

Then it can be executed with:

```bash
ruby src/main.rb -h
```

This program requires a file in order to work as expected. There are a few files saved at `input_examples/` that can be used to test the application properly. An example of call would be like:

```bash
ruby src/main.rb -f input_examples/case_1.txt
```

After executing, it shows the input entries given and the excepted output with all calculations applied.

```txt
Input
------
2  Book at 12.49
1  music CD at 14.99
1  chocolate bar at 0.85

Output
------
2  Book: 24.98
1  music CD: 16.49
1  chocolate bar: 0.85
Sales Taxes: 1.5
Total: 42.32
```

---

## Tests

This command can be used for test execution:

```bash
# Runs for all spec files
rspec
```

To run the tests for a single file, use:

```bash
rspec <relative_file_path>
# example: rspec spec/entities/shopping_basket_spec.rb
```

To see a different output with formatting options, use:

```bash
rspec --format doc
# or rspec spec/entities/shopping_basket_spec.rb --format doc
```

More formatting options can be found at the RSpec docs.
