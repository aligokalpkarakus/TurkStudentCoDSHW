-- Members tablosu
CREATE TABLE members (
    member_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Categories tablosu
CREATE TABLE categories (
    category_id SMALLINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Courses tablosu
CREATE TABLE courses (
    course_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    instructor VARCHAR(100) NOT NULL,
    category_id SMALLINT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

-- Enrollments tablosu
CREATE TABLE enrollments (
    enrollment_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    member_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    enrollment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    UNIQUE (member_id, course_id)  -- Bir üye aynı kursa bir kez kayıt olabilir
);

-- Certificates tablosu
CREATE TABLE certificates (
    certificate_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    certificate_code VARCHAR(100) NOT NULL UNIQUE,
    issue_date DATE NOT NULL,
    course_id BIGINT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- CertificateAssignments tablosu
CREATE TABLE certificate_assignments (
    assignment_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    member_id BIGINT NOT NULL,
    certificate_id BIGINT NOT NULL,
    assignment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (certificate_id) REFERENCES certificates(certificate_id) ON DELETE CASCADE,
    UNIQUE (member_id, certificate_id)  -- Bir üye aynı sertifikayı bir kez alabilir
);

-- BlogPosts tablosu
CREATE TABLE blog_posts (
    post_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    publish_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    author_id BIGINT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES members(member_id) ON DELETE CASCADE
);