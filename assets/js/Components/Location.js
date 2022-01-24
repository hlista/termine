import React from "react";

function Location(){
  return(
    <div className="flex-grow">
      <div className="pb-6 text-center">
        <div className="flex py-5 px-5 justify-center">
          <p className="flex text-4xl items-center">DeadRock Mines</p>
        </div>
        <div className="flex py-2 px-5 justify-center border-b-4">
          <p className="flex items-center">Many of the local townsfolk call these mines cursed and the promise of treasure burred deep within a fools quest</p>
        </div>
        <div className="flex py-5 px-5 justify-center border-b-2">
          <p className="flex items-center"> 
            You find yourself at the entrance of the cave. You light your torch and slowly make your way into mines. The ground is sticky and the air is damp. You can't see much beyond the light of your torch. You pause for a moment to listen to your surroundings. You hear water dripping in the distance, and then you hear a hiss. You turn in the direction of the hiss and find a human sized spider blocking the path.
          </p>
        </div>
        <div className="flex py-2 px-5 justify-center">
          <p className="flex items-center italic font-light">
            There are 230 miners attacking Giant Spider with 20,000 health left
          </p>
        </div>
      </div>
      <div>
        <p>Nearby</p>
        <div className="grid grid-cols-4 gap-4 items-center text-center">
          <p className="text-xl">The Meadows</p>
          <p className="flex items-center italic font-light">Lush green rolling hills for as far as the eye can see</p>
          <p>Blocking</p>
          <button className="border bg-green-300 rounded-full px-2">Travel</button>
          <p className="text-xl">The Quary</p>
          <p className="flex items-center italic font-light">A stone quary that the locals have used for hundreds of years</p>
          <p>Mineable</p>
          <button className="border bg-green-300 rounded-full px-2">Travel</button>
        </div>
      </div>
    </div>
  );
}

export default Location;