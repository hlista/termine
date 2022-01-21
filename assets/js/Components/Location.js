import React from "react";

function Location(){
  return(
    <div className="text-center px-5">
      <div className="flex h-24 justify-center border-b-4">
        <p className="flex text-4xl items-center">DeadRock Mines</p>
      </div>
      <div className="flex h-12 justify-center border-b-4">
        <p className="flex items-center">Many of the local townsfolk call these mines cursed and the promise of treasure burred deep within a fools quest</p>
      </div>
      <div className="flex h-36 justify-center border-b-4">
        <p className="flex items-center"> 
          You find yourself at the entrance of the cave. You light your torch and slowly make your way into mines. The ground is sticky and the air is damp. You can't see much beyond the light of your torch. You pause for a moment to listen to your surroundings. You hear water dripping in the distance, and then you hear a hiss. You turn in the direction of the hiss and find a human sized spider blocking the path.
        </p>
      </div>
    </div>
  );
}

export default Location;