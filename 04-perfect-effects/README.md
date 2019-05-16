# Side effects

React is designed to make it easy to keep the state of your application in sync with your UI. We've seen how JSX and props/state help keep what you're rendering up-to-date, but what about side-effects?

There are lots of things in this category: setting up intervals or global event listeners, fetching data from an API, manually focusing DOM elements (for accessibility), etc.

Ideally we want a way to ensure our effects reflect changes in state just like our UI does.

## Using effects

React provides another "hook" like `useState()` for running side-effects after your component renders.

It's called `useEffect()`. It takes a function as an argument, which will be run after every render (by default).

Let's say we want our counter component to also update the page title (so the count shows in the browser tab):

```jsx
const Counter = props => {
  const [count, setCount] = React.useState(0);

  React.useEffect(() => {
    document.title = `Count: ${count}`;
  });

  return <button onClick={() => setCount(count + 1)}>Count is {count}</button>;
};
```

![effect-example](https://user-images.githubusercontent.com/9408641/57864430-c9ecac00-77f3-11e9-8811-1242688c3e7d.gif)

React will run the arrow function we passed to `useEffect()` every time this component renders. Since calling `setCount` will trigger a re-render (as the state is updated) the page title will stay in sync with our state as the button is clicked.

## Skipping effects

By default all the effects in a component will re-run after every render of that component. If your effect does something expensive like hitting an API (or your component re-renders due to unrelated changes a lot) then this could be a problem.

`useEffect()` takes a second argument to optimise when it re-runs: an array of dependencies for the effect. Any variable used inside your effect function should go into this array:

```jsx
const Counter = props => {
  const [count, setCount] = React.useState(0);

  React.useEffect(() => {
    document.title = `Count: ${count}`;
  }, [count]);

  return <button onClick={() => setCount(count + 1)}>Count is {count}</button>;
};
```

Now our effect will only re-run if the `count` changes.

### Running once

Sometimes your effect will not be dependent on _any_ props or state, and you only want it to run once (after the component renders the first time). In this case you can pass an empty array as the second argument to `useEffect()`, to signify that the effect has no dependencies and never needs to re-run.

For example if we wanted our counter to be controlled by the "up" arrow key instead:

```jsx
const Counter = props => {
  const [count, setCount] = React.useState(0);

  React.useEffect(() => {
    const handleKeyDown = event => {
      if (event.key === "ArrowUp") setCount(prevCount => prevCount + 1);
    };
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, []);

  return <div>Count is {count}</div>;
};
```

We add an event listener to the `window`, and pass an empty array to `useEffect()`. This will keep us from adding new event listeners every time `count` updates and triggers a re-render.

#### Note

It's important to note that we're passing a function to `setCount` here. This will ensure we always have the up-to-date current value of `count` when we update it. If we just referenced `count` directly (`setCount(count + 1)`) the value would always be `0`, since that's what it was when we created the event listener. So the count would update to `1`, then never change.

## Cleaning up effects

Some effects need to be cleaned up. For example intervals need to be cancelled and global event listeners need to be removed when the component is no longer on the page (called "unmounting" in React).

If you return a function from your effect React will run it to clean up.

React performs this cleanup when the component unmounts. However, effects usually run after every render. This means React will _also_ clean up effects from the previous render before running the next effects.

```jsx
const Counter = props => {
  const [count, setCount] = React.useState(0);

  React.useEffect(() => {
    const handleKeyDown = event => {
      if (event.key === "ArrowUp") setCount(prevCount => prevCount + 1);
    };
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, []);

  return <div>Count is {count}</div>;
};
```

The arrow function we return will be called if the component unmounts (is removed from the page). That will ensure we don't keep running an unnecessary event listener and trying to update state that doesn't exist anymore.

## Workshop Part 3

TBC
