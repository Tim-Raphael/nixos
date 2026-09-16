# Code
- Always structure your code in an easy-to-read sequential order instead of
  finding a clever, concise solution
- Keep your comments short
- Never use comments to explain what your code does
- Use comments to explain why your code does something if additional
  context is required to understand it
- Always think about how to verify the changes you are planning to
  make, e.g., do we have tests for the code path I'm touching
- Separate I/O-bound paths of your code from the rest
  implementations for your tests
- Provide mock implementations for I/O bound logic which should be
  utilized during test (using crates like faux and httpmock)
- Only use traits if multiple real implementations are expected
- Do not program to an interface

# Writing
- Never use ":" or "—" in a sentence
- Every sentence that you write should contain information
- Always adhere to technical writing best-practices
