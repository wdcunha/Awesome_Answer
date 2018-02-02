import React from 'react';

function Field (props) {
  return (
    // <p>
    //   <strong>{props.name}:</strong> {props.value}
    <p className="Field">
      <strong>{props.name}:</strong> <em>{props.value}</em>
    </p>
  );
}



export {Field};
