# Be a RDBMS Rockstar

Welcome to my RDBMS learning journey! This repository showcases my understanding of RDBMS(PostgreSQL) concepts through both explanatory content and practical assignments.

## 📚 Blog Content

### What is PostgreSQL?

PostgreSQL is a Relational Database Management Software, RDBMS in short. Currently It is one of the most popular software to manage a relational database. It gives us high-performance solution for managing structured data efficiently.

**Examples:**

```typescript
let age = 25; // TypeScript infers `age` as `number`
let name = "Alice"; // TypeScript infers `name` as `string`
const isActive = true; // TypeScript infers `isActive` as `boolean`
```

Here, TypeScript automatically assigns types to age, name, and isActive without requiring : number, : string, or : boolean.

### Union and Intersection Types

#### Union Types:

Allow a variable to hold one of several possible types.

```typescript
function printId(id: number | string) {
  console.log(`ID: ${id}`);
}
```

#### Intersection Types:

Combine multiple types into one super type.

```typescript
type User = {
  name: string;
  age: number;
};

type Admin = {
  role: "admin";
  permissions: string[];
};

type AdminUser = User & Admin; // Must have ALL properties

const superUser: AdminUser = {
  name: "Alice",
  age: 30,
  role: "admin",
  permissions: ["delete", "ban_users"],
};
```

### 🚀 Try It Yourself!

```typescript
type A = { a: number };
type B = { b: string };
type C = A | B; // Must have `a` OR `b`  [Union]
type D = A & B; // Must have `a` AND `b` [Intersection]
```

## 🚀 Run the Project

### Quick Start (with live reload)

```bash
tsnd --respawn ./src/index.ts
```

## Prerequisites:

### Install TypeScript globally if not already installed:

```bash
npm install -g typescript ts-node ts-node-dev
```
