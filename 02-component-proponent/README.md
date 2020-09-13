## React components

React elements aren't very useful on their own. They're just static values assigned to a variable. To build a dynamic interface we need something reusable and dynamic, like functions.

A _React component_ is a function that returns a React element.

```jsx
function Title() {
  return <h1 className="title">Hello world!</h1>;
}
```

### Valid elements

A React element can be a JSX element, or a string, number, boolean or array of JSX elements. Returning `null`, `undefined`, `false` or `""` (empty string) will cause your component to render nothing.

## Composing components

Components are useful because JSX allows us to compose them together just like HTML elements:

```jsx
function Title() {
  return <h1 className="title">Hello world!</h1>;
}

function Page() {
  return (
    <div className="page">
      <Title />
    </div>
  );
}
```

We can use our `Title` component as JSX within another component. It's like making your own custom HTML tags.

### Always capitalise components

**You have to capitalise your component names**. This is how JSX distinguishes between HTML and custom components. E.g. `<img />` will create an HTML image tag, but `<Img />` will look for a component function named `Img`.

## Customising components

A component where everything is hard-coded isn't very useful. It will always return the exact same thing, so there's almost no point being a function. Functions are most useful when they take _arguments_. Passing different arguments lets us change what the function returns each time we call it.

JSX supports passing arguments to your components. It does this using the same syntax as HTML:

```jsx
<Title name="oli" />
```

React component functions only ever receive _one_ argument: an object containing all of the arguments passed to it. React will gather up any `key="value` arguments from the JSX and create this object.

This object is commonly named "props" (short for properties). Using an object like this means you don't have to worry the order of arguments. So in this case our `Title` function will receive a single argument: an object with a "name" property.

```jsx
function Title(props) {
  console.log(props); // { name: "oli" } (assuming <Title name="oli" /> was used)
  return <div className="title">Hello world</div>;
}
```

You can use these props within your components to customise them. For example we can interpolate them into our JSX to change the rendered HTML:

```jsx
function Title(props) {
  return <div className="title">Hello {props.name}</div>;
}
```

Now we can re-use our `Title` component to render different DOM elements:

```jsx
function Page() {
  return (
    <div className="page">
      <Title name="oli" />
      <Title name="sam" />
    </div>
  );
}
// <div class="page"><h1 class="title">Hello oli</h1><h1 class="title">Hello sam</h1></div>
```

### Non-string props

Since JSX is JavaScript it supports passing _any_ valid JS expression to your components, not just strings. To pass JS values as props you use **curly brackets**, just like interpolating expressions inside tags.

```jsx
function Page() {
  const customName = "oliver" + " phillips";
  return (
    <div className="page">
      <Title name={customName} />
      <Title name={5 * 5} />
    </div>
  );
}
// <div class="page"><h1 class="title">Hello oliver phillips</h1><h1 class="title">Hello 25</h1></div>
```

### Children

It would be nice if we could nest our components just like HTML. Right now this won't work, since we hard-coded the text inside our `<h1>`:

```jsx
<Title>Hello oli</Title>
```

JSX supports a special prop to achieve this: `children`. Whatever value you put _between_ JSX tags will be passed to the component as a prop named `children`. You can then access and use it exactly like any other prop.

```jsx
function Title(props) {
  return <div className="title">{props.children}</div>;
}
```

Now this JSX will work as we expect:

```jsx
<Title>Hello oli</Title>
// <h1 class="title">Hello oli</h1>
```

This is quite powerful, as you can now nest your components to build up more complex DOM elements.

```jsx
// pretend we have defined Image and BigText components above
<Title>
  <Image src="hand-wave.svg" />
  <BigText>Hello oli</BigText>
</Title>
```

## Rendering to the page

You may be wondering how we get these React components to actually show up on the page.

React consists of two libraries—the main `React` library and a specific `ReactDOM` library for rendering to the DOM (since React can also be used to create VR or Native mobile apps).

We use the `ReactDOM.render()` function to put our app in the DOM. It takes an element as the first argument and a DOM node as the second.

```jsx
function App() {
  return (
    <Page>
      <Title>Hello world!</Title>
      <p>Welcome to my page</p>
    </Page>
  );
}

const rootNode = document.querySelector("#root");
ReactDOM.render(<App />, rootNode);
```

Since your React app is like a tree of objects you only call `ReactDOM.render()` **once**. You give it the very top-level component of your app and it will move down the tree rendering all the children recursively.

<details>
<summary>A bit more detail (that you don't need to understand)</summary>

The component functions return React elements, which are objects describing an element, its properties, and its children. These objects form a tree, with a top-level element that renders child elements, that in turn have their own children. Here is a small React component that renders a couple more:

```jsx
function App() {
  return (
    <Page>
      <Title>Hello world!</Title>
      <p>Welcome to my page</p>
    </Page>
  );
}

const rootNode = document.querySelector("#root");
ReactDOM.render(<App />, root);
```

`<App />` tells React to call the `App` function (with an empty props object, since we didn't pass any props). This returns an object roughly like this:

```js
// React's actual internal representation is a bit more complex
{
  type: function Page,
  children: [
    {
      type: function Title,
      props: {
        children: "Hello world!",
      },
    },
    {
      type: "p",
      props: {
        children: "Welcome to my page",
      },
    },
  ],
}
```

This object is passed to `ReactDOM.render`, which will loop through every property. If it finds a string type (e.g. "p") it'll create a DOM node. If it finds a function type it'll call the function with the right props to get the elements that component returns. It keeps doing this until it runs out of elements to render.

This is the final DOM created for this app:

```html
<div class="page">
  <h1>Hello world!</h1>
  <p>Welcome to my page</p>
</div>
```

</details>

## Workshop Part 1

Time to create some components! Open up `02-component-proponent/challenge.html` in your editor. You should see the components we created above.

Create a new component called `Card`. It should take 3 props: `title`, `image` and `children`, that render into `h2`, `img` and `p` elements respectively.

Replace the `p` in the `App` component with a `Card`. Pass whatever you like as the 3 props (although here's an image URL you can use: `https://source.unsplash.com/400x300/?burger`).

<img width="489" alt="task example" src="https://user-images.githubusercontent.com/9408641/58386359-a0ebc880-7ff6-11e9-8214-48b9206aa711.png">

<details>
<summary>Hint</summary>

This is what your `App` should return:

```jsx
<Page>
  <Title>Hello world!</Title>
  <Card
    title="Tasty burger"
    image="https://source.unsplash.com/400x300/?burger"
  >
    That is a good burger
  </Card>
</Page>
```

</details>

[Next section](/03-a-date-with-state)
