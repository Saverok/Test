using System;
using Transport.Enums;

namespace Transport.Classes
{
    public abstract class Vehicle
    {
        private const int DistanceRatio = 100;
        public VehicleType Type { get; init; }
        public float AverageFuelConsumption { get; set; }
        public float Fuel { get; set; }
        public int Speed { get; set; }
        public float MaxumimTankVolume { get; init; }

        public float GetAverageDistance(bool isMaxumimTankVolume)
        {
            var result = isMaxumimTankVolume ? (MaxumimTankVolume * DistanceRatio) / AverageFuelConsumption
                : GetMovementReserve();
            return result;
        }

        public abstract float GetMovementReserveWhithCargo();

        public float GetMovementTimeInHours(float distance)
        {
            if (distance > GetMovementReserve())
            {
                throw new ArgumentException("Not enough fuel");
            }
            return distance / Speed;
        }

        protected float GetMovementReserve()
        {
            return (Fuel * DistanceRatio) / AverageFuelConsumption;
        }
    }
}
