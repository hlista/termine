import React from "react";
import { StarIcon as StarIconSolid } from '@heroicons/react/solid'
import { StarIcon as StarIconOutline } from '@heroicons/react/outline'

function Minerbar() {
  return (
    <div className="border-l">
      <div className="flex justify-center border-b px-24">
        <p className="text-4xl">Miners</p>
      </div>
      <div className="grid grid-cols-3 items-center gap-2">
          <p>John Piere</p>
          <div className="flex">
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconOutline className="h-5 w-5 text-yellow-500" />
            <StarIconOutline className="h-5 w-5 text-yellow-500" />
          </div>
          <button className="border bg-red-300 rounded-full px-2">Mining...</button>
          <p>Jerry Carey</p>
          <div className="flex">
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconOutline className="h-5 w-5 text-yellow-500" />
            <StarIconOutline className="h-5 w-5 text-yellow-500" />
            <StarIconOutline className="h-5 w-5 text-yellow-500" />
            <StarIconOutline className="h-5 w-5 text-yellow-500" />
          </div>
          <button className="border bg-green-300 rounded-full px-2">Send</button>
          <p>Paul Terror</p>
          <div className="flex">
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
          </div>
          <button className="border bg-red-300 rounded-full px-2">Mining...</button>
          <p>Terry Test</p>
          <div className="flex">
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconOutline className="h-5 w-5 text-yellow-500" />
            <StarIconOutline className="h-5 w-5 text-yellow-500" />
          </div>
          <button className="border bg-green-300 rounded-full px-2">Send</button>
          <p>Mike Rao</p>
          <div className="flex">
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconSolid className="h-5 w-5 text-yellow-500" />
            <StarIconOutline className="h-5 w-5 text-yellow-500" />
          </div>
          <button className="border bg-green-300 rounded-full px-2">Send</button>
      </div>
    </div>
  );
}

export default Minerbar;