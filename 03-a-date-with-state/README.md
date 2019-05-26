## React state

## What is state?

We've seen how to create static templates for rendering HTML, but how do we get anything to change on the page? How do we respond to user events?

We need "state". This is a JavaScript representation of the state your UI is in. E.g. whether a button has been clicked, the JSON you got back from an API, a search term a user has typed in etc.

By rendering our UI based on this state we can tell React how the page should look for any given state and let it worry about keeping the DOM in sync.

## Using state

Imagine we have a counter component. When the button is clicked we want the count to go up one:

```jsx
const Counter = props => {
  const count = 0;
  return <button>Count is {count}</button>;
};
```

We want to be able to change the `count` variable and have the component re-render to match the new value. React provides a way to make this value "stateful": `React.useState()`.

`useState()` takes the initial state value as an argument, and returns an array with two properties: the state value and a function that lets you update the state value.

```jsx
const Counter = props => {
  const countState = React.useState(0);
  const count = countState[0];
  const setCount = countState[1];
  return <button>Count is {count}</button>;
};
```

It's common to use array destructuring to simplify this:

```jsx
const Counter = props => {
  const [count, setCount] = React.useState(0);
  return <button>Count is {count}</button>;
};
```

The updater function (`setCount`) takes a new state value as its argument. E.g. if we wanted to update the `count` to 10 we would call `setCount(10)`.

Whenever the updater function is called the component will re-render with the new value of the state. This will keep your UI in sync with the state.

### Updates based on previous state

Sometimes you need access to the old value of the state in order to update. The state updater functions also accept a _function_ as an argument. React will call this function with the old state value, and whatever you return from it will be set as the new state.

E.g. instead of `setCount(10)` we could do `setCount(oldCount => oldCount + 1)` to update the count by one. You'll see an example of when this is necessary in the next section.

## Event listeners

We have a function that will let us update the state, but how do we attach event listeners to our DOM nodes?

```jsx
const Counter = props => {
  const [count, setCount] = React.useState(0);
  const handleClick = () => setCount(count + 1);
  return <button onClick={handleClick}>Count is {count}</button>;
};
```

You can pass event listener functions in JSX like any other property. They are always formatted as "on" followed by the camelCased event name. So "onClick", "onKeyDown", "onChange" etc.

In this example we are passing a function that calls `setCount` with our new value of `count`.

![counter-example](https://user-images.githubusercontent.com/9408641/57850062-e9281100-77d4-11e9-81cc-befd42f1faf7.gif)

## Workshop Part 2

Time to add some state! Open up `index.2.html` in your editor. You should see the `Counter` component we just created.

Create a new component called `Toggle`. It should render a button that toggles a boolean state value. It should show/hide its children based on this state.

Example usage:

```jsx
const App = () => <Toggle>Toggle me!</Toggle>;
```

![toggle-example](https://user-images.githubusercontent.com/9408641/57849940-98b0b380-77d4-11e9-86ef-315861f60489.gif)

[Next section](/04-perfect-effects)
