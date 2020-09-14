## React state

Most of an app's UI is static, but some parts need to update in response to things like user actions. For example if a user clicks a button, or the app fetches some JSON from an API server.

In a "traditional" vanilla JS app these stateful values would be stored directly in the DOM. For example a counter might update the text content of a DOM element each time a button is clicked. However this can get quite complex to keep track of as your app grows, since you have to manually update each bit of the DOM when changes occur.

In React all stateful values are stored as JS variables. We can render our UI based on these variables, and let React take care of updating the DOM to match whenever the state changes.

## Using state

Imagine we have a counter component. When the button is clicked we want the count to go up one:

```jsx
function Counter(props) {
  const count = 0;
  return <button>Count is {count}</button>;
}
```

We could write a function that updated the `count` value by one, but for our UI to update we'd need some way to make our `Counter` function run again with the new value.

React provides a way to make this value "stateful", which means React will keep track of the value and re-run our component function any time that value changes.

We use the `React.useState` method for this. It takes the initial state value as an argument, and returns an array. This array contains two things: the state value, and a function that lets you _update_ the state value.

```jsx
function Counter(props) {
  const stateArray = React.useState(0);
  const count = stateArray[0];
  const setCount = stateArray[1];
  return <button>Count is {count}</button>;
}
```

It's common to use array destructuring to simplify this:

```jsx
function Counter(props) {
  const [count, setCount] = React.useState(0);
  return <button>Count is {count}</button>;
}
```

The updater function (that we named `setCount` in this example) lets us update our state value and tells React to re-run this component function with the new value.

The updater function takes a new state value as its argument. E.g. if we wanted to update the `count` to 10 we would call `setCount(10)`. If we wanted to increment `count` by one we would call `setCount(count + 1)`.

Whenever the updater function is called the component will re-render with the new value of the state. This will keep your UI in sync with the state.

**Note**: never _mutate_ a state variable. For example `setCount(count++)` will break React's update in subtle and confusing ways. You should always pass a **totally new variable** to the updater function, and leave the _old_ state variable unchanged.

### Updates based on previous state

Sometimes you need access to the old value of the state in order to update. The state updater functions also accept a _function_ as an argument. React will call this function with the old state value, and whatever you return from it will be set as the new state.

E.g. instead of `setCount(10)` we could do `setCount(oldCount => oldCount + 1)` to update the count by one. You'll see an example of when this is necessary in the next section.

<details>
  <summary>A fake implementation that might help</summary>
  
```js
function useState(initialState) {
  // keep track of a state value
  let state = initialState;
  // create a function that can update the state
  function setState(update) {
    // if the user passed a function we call it with the old state
    // then set the return value of the function as the new state
    if (typeof update === "function") {
      const newState = update(state);
      state = newState;
    } else {
      // otherwise we just directly update the state
      state = update;
    }
    // some magic React internal that will cause your component function to re-run
    // this allows your component to get the updated value
    rerenderTheComponentSomehow();
  }
  // return the state and updater function in an array for convenience
  return [state, setState];
}
```
  
</details>

## Event listeners

We have a function that will let us update the state, but how do we attach event listeners to our DOM nodes?

```jsx
function Counter(props) {
  const [count, setCount] = React.useState(0);
  const increment = () => setCount(count + 1);
  return <button onClick={increment}>Count is {count}</button>;
}
```

You can pass event listener functions in JSX like any other property. They are always formatted as "on" followed by the camelCased event name. So "onClick", "onKeyDown", "onChange" etc.

In this example we are passing a function that calls `setCount` with our new value of `count`.

![counter-example](https://user-images.githubusercontent.com/9408641/57850062-e9281100-77d4-11e9-81cc-befd42f1faf7.gif)

## Workshop Part 2

Time to add some state! Open up `03-a-date-with-state/challenge.html` in your editor. You should see the `Counter` component we just created.

Create a new component called `Toggle`. It should always render a button that toggles a boolean state value when clicked. It should also render a div containing its children, but only when the boolean state value is true.

Example usage:

```jsx
function App() {
  return <Toggle>This text is hidden until the button is clicked</Toggle>;
}
```

![toggle-example](https://user-images.githubusercontent.com/9408641/57849940-98b0b380-77d4-11e9-86ef-315861f60489.gif)

<details>
<summary>Hint</summary>

Remember you can use ternaries to do conditional logic inside JSX. Rendering `null` or an empty string tells React to put nothing on the page. E.g.

```jsx
<h2>{x > 5 ? null : <div>It's less than 5</div>}<h2>
```

</details>

[Next section](/04-perfect-effects)
