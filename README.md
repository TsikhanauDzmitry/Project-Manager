# Project Manager

A single-page Rails 7 app powered by Turbo (Hotwire) to manage **Projects** and their hierarchical **Tasks**.  
Tasks automatically expire 6 months after creation and can be created, edited, and deleted without a full page reload.

---

## Table of Contents

- [Tech Stack](#tech-stack)
- [Features](#features)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
    - [Database Setup](#database-setup)
    - [Seeding Data](#seeding-data)
- [Running the App](#running-the-app)
- [Running Tests](#running-tests)
- [Linting & Formatting](#linting--formatting)

---

## Tech Stack

- **Ruby** 3.3.4
- **Rails** 7.2.2.1
- **SQLite3** (development & test)
- **Hotwire** (Turbo & Stimulus)
- **Bootstrap** 5 (UI)
- **RSpec** & FactoryBot (testing)

---

## Features

- **Projects**
    - List all projects
    - Delete a project via Turbo Stream
    - Count of expired tasks

- **Tasks**
    - Nested (parent/subtask) relationships
    - Inline deletion via Turbo Frames
    - Automatic 6-month expiry
    - Inline editing (bonus)

- **Performance Optimizations**
    - Single aggregated query for expired-task counts
    - Eager loading of tasks & subtasks
    - QueryObject pattern for index

---

## Getting Started

### Prerequisites

- **Ruby** ≥ 3.3.4
- **Bundler** (`gem install bundler`)
- **Node.js** & **Yarn** (for Webpacker)

### Installation

```bash
# Clone
git clone git@github.com:TsikhanauDzmitry/Project-Manager.git
cd project_manager

# Install gems
bundle install
```

### Database Setup
```bash
rails db:create
rails db:migrate
```

### Seeding Data
```bash
rails db:seed
```

## Running the App
```bash
# start Rails server
rails server
# Visit http://localhost:3000
```

## Running Tests
```bash
bundle exec rspec
```
•	Routing specs (spec/routing)	
•	Model specs (spec/models)	
•	Controller specs (spec/controllers)

