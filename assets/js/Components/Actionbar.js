import React from "react";

function Actionbar(){
  return (
    <div className="flex justify-center">
      <button className="items-center border p-2">
        Inventory
      </button>
      <button className="items-center border p-2">
        Mine
      </button>
      <button className="items-center border p-2">
        Travel
      </button>
    </div>
  );
}

export default Actionbar;