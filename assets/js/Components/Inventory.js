import React from "react";

function Inventory(){
  return(
    <div className="border-r px-4">
      <div className="flex justify-center border-b">
        <p className="text-4xl">Inventory</p>
      </div>
      <div className="grid grid-cols-2 gap-2">
        <p>30</p>
        <p>Iron</p>
        <p>240</p>
        <p>Copper</p>
        <p>245</p>
        <p>Mithiril</p>
        <p>1512</p>
        <p>Spider Silk</p>
        <p>235</p>
        <p>Hide</p>
      </div>
    </div>
  );
}

export default Inventory;