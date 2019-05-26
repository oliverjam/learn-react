# Forms and inputs

Form elements are sort of unique in HTML because they are stateful. A user can check an `<input type="checkbox">` and the DOM will keep track of that "checked" state.

Since React has its own way of keeping track of UI state it's often annoying to keep input state in the DOM and the rest of your state in React/JS. It's common to move input state entirely into React; this is called _controlling_ a component.

## Controlled components

A controlled component is one whose internal state is managed in another place (usually a parent component).

### `value`

We can "control" the value of an input by passing it a `value` prop.

```jsx
const Form = () => {
  return <input value="Hello" />;
};
```

This isn't very useful as the value is now hard-coded. This value needs to be _stateful_, so we should move it into React state.

```jsx
const Form = () => {
  const [message] = React.useState("Hello");
  return <input value={message} />;
};
```

However we still have no way to update the value—if the user types into the input nothing will happen.

### `onChange`

To control an input you also need an `onChange` event handler. This will update the state (and therefore the input's `value`) whenever the value of the input changes (i.e. when the user types into it).

```jsx
const Form = () => {
  const [message, setMessage] = React.useState("Hello");
  return (
    <input value={message} onChange={event => setMessage(event.target.value)} />
  );
};
```

## How is this useful

This seems like a lot of ceremony just to make an input work the same way it did without React, but there are advantages.

We can now have as many sources of input value as we like—we aren't limited to the user typing. For example we might want to pre-fill the input based on some other data we have:

```jsx
const Form = props => {
  const [email, setEmail] = React.useState(props.user.email);
  return (
    <input
      type="email"
      value={email}
      onChange={event => setEmail(event.target.value)}
    />
  );
};
```

## Other input types

React tries to normalise all the different HTML inputs. In React text inputs, `select`s and `textarea`s all work the same way: you pass `value` and `onChange` props.

```jsx
const Form = () => {
  const [fruit, setFruit] = React.useState("apple");
  return (
    <select value={fruit} onChange={event => setFruit(event.target.value)}>
      <option value="apple">Apple</option>
      <option value="orange">Orange</option>
      <option value="banana">Banana</option>
    </select>
  );
};
```

An `option` is selected when its `value` matches the `value` of the parent select.

### Checkboxes and radios

Checkboxes are slightly different—they take a `checked` prop instead of a `value`.

```jsx
const Form = () => {
  const [checked, setChecked] = React.useState(false);
  return (
    <input
      type="checkbox"
      checked={checked}
      onChange={event => setChecked(event.target.value)}
    />
  );
};
```

Radio buttons are a combination of both: they take a `checked` _and_ a `value` prop. If you have a radio group all using the same value you need to set their `checked` prop conditionally based on their value:

```jsx
const Form = () => {
  const [fruit, setFruit] = React.useState("apple");
  const handleChange = event => setFruit(event.target.value);
  return (
    <form>
      <input
        type="radio"
        name="fruit" // name groups the inputs
        value="apple"
        checked={fruit === "apple"}
        onChange={handleChange}
      />
      <input
        type="radio"
        name="fruit"
        value="orange"
        checked={fruit === "orange"}
        onChange={handleChange}
      />
      <input
        type="radio"
        name="fruit"
        value="banana"
        checked={fruit === "banana"}
        onChange={handleChange}
      />
    </form>
  );
};
```

## Workshop Part 4
