# BlogApp

BlogApp is a simple blogging platform built with Ruby on Rails. It allows users to create, edit, delete, and view blog posts. Users can also register, log in, and manage their posts.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Running the Application](#running-the-application)
- [Running Tests](#running-tests)

## Features

- User authentication (Sign up, Log in, Log out) using Devise
- CRUD operations for blog posts
- Pagination using Kaminari
- Simple and responsive user interface with Tailwind CSS
- User-friendly error messages and form validations

## Getting Started

These instructions will guide you through setting up the project on your local machine for development and testing purposes.

### Prerequisites

- **Ruby**: Version 3.0.0 or later
- **Rails**: Version 7.0 or later
- **PostgreSQL**: Ensure PostgreSQL is installed and running
- **Node.js**: Version 12 or later
- **Yarn**: Version 1.22 or later
- **Bundler**: Version 2.2 or later

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/blog_app.git
   cd blog_app
   ```

2. **Install dependencies:**

   Install the required Ruby gems:

   ```bash
   bundle install
   ```

   Install JavaScript dependencies:

   ```bash
   yarn install
   ```

3. **Database setup:**

   Create and migrate the database:

   ```bash
   rails db:create
   rails db:migrate
   ```

### Running the Application

1. **Start the Rails server:**

   ```bash
   rails server
   ```

2. **Visit the application:**

   Open your web browser and visit `http://localhost:3000`.

### Running Tests

This project uses RSpec for testing.

1. **Run the test suite:**

   ```bash
   bundle exec rspec
   ```

2. **Run specific tests:**

   To run a specific test file, use:

   ```bash
   bundle exec rspec spec/path_to_your_spec.rb
   ```
