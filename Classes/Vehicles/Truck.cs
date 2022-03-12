using System;

namespace Transport.Classes.Vehicles
{
    public class Truck: Vehicle
    {
        private const float CarryingСoefficient = 0.06F;
        private const int CarryingСoefficientWeight = 200;
        public int MaximumСarrying { get; init; }
        private int cargoWeight;
        public int CargoWeight
        {
            get
            {
                if (cargoWeight > MaximumСarrying)
                {
                    throw new ArgumentException("Cargo weight limit exceeded");
                }
                return cargoWeight;
            }
            set
            {
                cargoWeight = value;
            }
        }

        public override float GetMovementReserveWhithCargo()
        {
            var movementReserve = GetMovementReserve();
            var result = movementReserve 
                - (movementReserve * CarryingСoefficient * (CargoWeight / CarryingСoefficientWeight));
            return result;
        }
    }
}
