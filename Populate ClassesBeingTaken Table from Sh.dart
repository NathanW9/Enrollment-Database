Populate ClassesBeingTaken Table from Sheet Script

function generateSQLStatements() {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  Logger.log("Sheet fetched successfully");
  var dataRange = sheet.getDataRange();
  Logger.log("Data range fetched: " + dataRange.getA1Notation());
  var data = dataRange.getValues();
  Logger.log("Data fetched successfully");

  var tableName = "classesBeingTaken";
  var columnNames = ["StuID", "Cid", "Sid"]; // Columns: Student ID, Class ID, Semester ID

  var studentID = sheet.getRange("B31").getValue(); // Get the student ID from a specific cell

  // Data structure to store class names and their corresponding IDs
  var classMapping = {
    "COMP 115 (Discrete Structures for Computer Science)": 0,
    "COMP 171 (Principles of Computing Science I)": 1,
    "COMP 172 (Principles of Computer Science II)": 2,
    "COMP 210 (Introduction to Computer Organization and Systems)": 3,
    "COMP 220 (Introduction to Data Structures)": 4,
    "COMP 311 (Algorithms and Data Structures)": 5,
    "COMP 345 (Introduction to Software Engineering)": 6,
    "COMP elective at level 1, 2, 3, or 4": 7,
    "COMP elective at level 2, 3, or 4": 8,
    "COMP elective at level 2, 3, or 4": 9,
    "COMP elective at level 3, or 4": 10,
    "MATH 111 (Calculus I)": 11,
    "MATH 187 (Introduction to Applied Linear Algebra), or MATH 231 (Linear Algebra)": 12,
    "MATH 144 (Stats for BEM), or MATH 145 (Stats for HLSS), or MATH 216 (Statistical Analysis)": 13
  };

  // Data structure to store Semesters and their corresponding IDs (columns in the sheet)
  var semesterMapping = {
    "Fall 2024": 1,
    "Spring 2024": 2,
    "Fall 2025": 3,
    "Spring 2025": 4,
    "Fall 2026": 5,
    "Spring 2026": 6,
    "Fall 2027": 7,
    "Spring 2027": 8,
    "Fall 2028": 9,
    "Spring 2028": 11,
    "W": 12,
    "Summer": 13
  };

  // Get the column headers (semesters) from the first row
  var semesters = data[0];

  var sqlStatements = [];

  // Iterate over rows (classes) starting from the second row
  for (var row = 1; row < data.length; row++) {
    var className = data[row][0]; // Class name in the first column

    // Check if the class name exists in the mapping
    if (classMapping.hasOwnProperty(className)) {
      var classID = classMapping[className]; // Get class ID

      // Iterate over columns (semesters) starting from the second column
      for (var col = 1; col < data[row].length; col++) {
        if (data[row][col] === "x") { // If an "X" is found, generate an INSERT statement
          var semesterName = semesters[col]; // Get semester from the column header
          
          // Check if the semester name exists in the mapping
          if (semesterMapping.hasOwnProperty(semesterName)) {
            var semesterID = semesterMapping[semesterName]; // Get semester ID

            // Generate the SQL INSERT statement
            var sql = "INSERT INTO " + tableName + " (" + columnNames.join(", ") + ") VALUES ('" + studentID + "', '" + classID + "', '" + semesterID + "');";
            sqlStatements.push(sql);
          }
        }
      }
    }
  }

  // Output the SQL statements to the log
  Logger.log(sqlStatements.join("\n"));

  // Optionally write the SQL statements to another sheet
  var outputSheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("SQL_Statements");
  if (!outputSheet) {
    outputSheet = SpreadsheetApp.getActiveSpreadsheet().insertSheet("SQL_Statements");
  }
  outputSheet.clear();

  for (var i = 0; i < sqlStatements.length; i++) {
    outputSheet.getRange(i + 1, 1).setValue(sqlStatements[i]);
  }

  // Display a message when done
  SpreadsheetApp.getUi().alert(sqlStatements.length + " SQL insert statements generated.");
}