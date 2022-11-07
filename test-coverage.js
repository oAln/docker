const { readFileSync, promises: fsPromises } = require('fs');

// ✅ read file SYNCHRONOUSLY
function syncReadFile(filename) {
  const contents = readFileSync(filename, 'utf-8');

  const arr = contents.split(/\r?\n/);
  const thresold = process.env.TEST_COVERAGE_THRESOLD || 60;
  let testCoverage = 0;

    console.log(arr); // 👉️ ['One', 'Two', 'Three', 'Four']

  if (arr.length > 4 && arr[4].includes('Functions')) {
    const getTestCoverage = arr[4].substring(
      arr[4].indexOf(":") + 1,
      arr[4].lastIndexOf("%")
    )
    testCoverage = parseInt(getTestCoverage);
  } else {
    console.log('Coverage undefind');
  }

  if (testCoverage >= thresold) {
    console.log('thresold reached');
  } else {
    console.log(`Coverage for functions ${testCoverage} does not meet global threshold ${thresold}`);
  }
  console.log(testCoverage);

  return arr;
}

syncReadFile('./unit-test-report.txt');