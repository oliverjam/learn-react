## React components

React elements aren't very useful on their own. They're just static values assigned to a variable. To build a dynamic interface we need something like functions.

A _React component_ is a function that returns a React element.

```jsx
const Title = () => <h1 className="main-title">Hello world!</h1>;
```

These components are useful because JSX allows us to compose them together just like HTML elements:

```jsx
const Page = () => (
  <div className="page">
    <Title /> // Title component we just made
  </div>
);
```

It's like making your own custom HTML tags.

### Note

**You have to capitalise your component names**. This is how JSX distinguishes between HTML and custom components. E.g. `<img />` will create an HTML image tag, but `<Image />` will call your custom component function named `Image`.

## Dynamic components

Our `Title` component is still not very useful: its className and children are both hard-coded. We want a re-usable and composable component (like an HTML element). Ideally we can use it like this:

```jsx
const Page = () => (
  <div className="page">
    <Title className="whatever-i-want">Hello universe!</Title>
  </div>
);
```

### Props

React will pass any properties you put on your JSX element to your component function. It bundles them all up into an object known as "props".

```jsx
const Title = props => <h1 className={props.className}>{props.children}</h1>;
```

You can imagine your component function is being called with the props object as an argument like this:

```javascript
Title({ className: "whatever-i-want", children: "Hello universe!" });
```

#### Note on children

Anything between two JSX tags (e.g. `<Title>Hello universe!</Title>`) will be passed to the component as `props.children`. Children is the same as any other prop, which means you can pass it like `<Title children="Hello universe!" />` if you like. Putting it between the tags makes it a little closer to HTML.

### Interpolating expressions

We've just introduced another JSX concept—we can put dynamic JS values into our HTML using curly brackets. This is similar to a template literal interpolation or Handlebars embedded expressions.

You can do all kinds of JS stuff inside the curly brackets, like calculations or conditional expressions.

```jsx
const Hello = props => <h1>Hello {props.name || "world"}!</h1>;
<Hello name="mum" />; // <h1>Hello mum!</h1>
<Hello />; // <h1>Hello world!</h1> props.name is undefined so we get "world" instead
```

#### Note on expressions

You can put any valid JS _expression_ inside the curly brackets. An expression must resolve to a value. E.g. `<p>{1 + 1}</p>` will end up as `<p>2</p>`, but `<p>{if (true) 1}</p>` won't work, since `if` blocks are _statements_, not expressions.

## Rendering to the page

You may be wondering how we get these React components to actually show up on the page.

React consists of two libraries—the main `React` library and a specific `ReactDOM` library for rendering to the DOM (since React can also be used to create VR or Native mobile apps).

We use the `ReactDOM.render()` function to put our app in the DOM. It takes an element as the first argument and a DOM node as the second.

```jsx
const App = () => (
  <Page>
    <Title>Hello world!</Title>
    <p>Welcome to my page</p>
  </Page>
);

const rootNode = document.querySelector("#root");
ReactDOM.render(<App />, rootNode);
```

Since your React app is like a tree of objects you only call `ReactDOM.render()` **once**. You give it the very top-level component of your app and it will move down the tree rendering all the children recursively.

<details>
<summary>A bit more detail</summary>

The component functions return React elements, which are objects describing an element, its properties, and its children. These objects form a tree, with a top-level element that renders child elements, that in turn have their own children. A small app might produce a tree like this:

```jsx
const App = () => (
  <Page>
    <Title>Hello world!</Title>
    <p>Welcome to my page</p>
  </Page>
);

// App returns an object roughly like this:
// {
//   type: App,
//   props: {
//     children: [
//       {
//         type: Page,
//         children: [
//           {
//             type: Title,
//             props: {
//               children: "Hello world!",
//             },
//           },
//           {
//             type: "p",
//             props: {
//               children: "Welcome to my page",
//             },
//           },
//         ],
//       },
//     ],
//   },
// };

const rootNode = document.querySelector("#root");
ReactDOM.render(<App />, root);

// will render this HTML to the DOM:
// <div className="page">
//   <h1>Hello world!</h1>
//   <p>Welcome to my page</p>
// </div>
```

</details>

## Workshop Part 1

Time to create some components! Open up `index.1.html` in your editor. You should see the components we created above.

Create a new component called `Card`. It should take 3 props: `title`, `image` and `children`, that render into `h2`, `img` and `p` elements respectively.

Replace the `<p>` in the `App` component with a `<Card />`. Here's an image URL you can use: `https://source.unsplash.com/400x300/?burger`

<img width="489" alt="task example" src="https://user-images.githubusercontent.com/9408641/58386359-a0ebc880-7ff6-11e9-8214-48b9206aa711.png">

[Next section](/03-a-date-with-state)
