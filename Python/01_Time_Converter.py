def convert_minutes(minutes):
    hours = minutes // 60
    remaining = minutes % 60
    return f"{hours} hrs {remaining} minutes"

# Example
print(convert_minutes(130))
