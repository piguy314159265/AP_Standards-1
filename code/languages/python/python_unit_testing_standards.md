# AP Python Unit Testing Standards

We will use the `unittest` python unit testing framework: https://docs.python.org/3/library/unittest.html.

## Writing tests
Tests take the form of methods inside of classes which inherit from `unittest.TestCase`:

```
import unittest

class SimpleTests(unittest.TestCase):
    # This method tests that 0 == 0 returns True
    def testTrue(self):
        self.assertTrue(0 == 0)
    
    # This method tests that 0 == 1 returns False
    def testFalse(self):
        self.assertFalse(0 == 1)

# include at bottom of file to run when calling file
if __name__ == '__main__':
    unittest.main()
```

### Test Set-up, Tear-down
Use `setUp` and `tearDown` methods to build and destroy fixtures needed for tests:
```
import unittest

class SimpleVarTests(unittest.TestCase):
    def setUp(self):
        self.x = True

    def tearDown(self):
        del self.x

    def testTrue(self):
        self.assertTrue(self.x)

if __name__ == '__main__':
    unittest.main()
```

Regardless of whether the test passes, if `setUp` is successful, `tearDown` will be run.

### Skipping tests
```
class MyTestCase(unittest.TestCase):

    @unittest.skip("demonstrating skipping")
    def test_nothing(self):
        self.fail("shouldn't happen")

    @unittest.skipIf(mylib.__version__ < (1, 3),
                     "not supported in this library version")
    def test_format(self):
        # Tests that work for only a certain version of the library.
        pass

    @unittest.skipUnless(sys.platform.startswith("win"), "requires Windows")
    def test_windows_support(self):
        # windows specific testing code
        pass
```

## Running tests
In order to be compatible with test discovery, all test files must be modules or packages importable from the top-level directory of the project.

Tests can be run (if discoverable) via the command line with
```
cd project_directory
python -m unittest
```
Also see `unittest discover` for sub-commands.

## Test Results
There are 3 potential results of tests:
1. `ok`: The test passes
2. `FAIL`: The assertion fails (i.e. raises an `AssertionError` exception)
3. `ERROR`: The rest of the method fails (i.e. raises an error that is not an `AssertionError`)
