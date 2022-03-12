using System;

namespace Transport.Classes.Vehicles
{
    public class Car: Vehicle
    {
        private const float PassengerСoefficient = 0.06F;
        public int MaximumPassengersCount { get; init; }
        private byte passengersCount;
        public byte PassengersCount 
        {
            get 
            { 
                if (passengersCount > MaximumPassengersCount)
                {
                    throw new ArgumentException("Passenger limit exceeded");
                }
                return passengersCount;
            }
            set 
            { 
                passengersCount = value;
            } 
        }

        public override float GetMovementReserveWhithCargo()
        {
            var movementReserve = GetMovementReserve();
            return movementReserve - (movementReserve * PassengerСoefficient * PassengersCount);
        }
    }
}
