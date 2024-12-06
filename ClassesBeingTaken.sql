ClassesBeingTaken

create table classesBeingTaken (
    StuID INT,
    Cid INT,
    Sid INT,
    PRIMARY KEY (StuID, Cid, Sid),
    FOREIGN KEY (StuID) REFERENCES students(StuID),
    FOREIGN KEY (Cid) REFERENCES classes(Cid),
    FOREIGN KEY (Sid) REFERENCES semesters(Sid)
)