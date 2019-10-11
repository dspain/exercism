defmodule RobotSimulator do
  defstruct position: {0, 0}, direction: :north
  @directions [:north, :east, :south, :west]

  defguard is_invalid_position(p) when not is_tuple(p) or is_nil(p) or tuple_size(p) != 2
  defguard is_invalid_position(x, y) when not (is_integer(x) and is_integer(y))
  defguard is_invalid_direction(d) when d not in @directions

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ nil, position \\ nil)
  def create(nil, nil), do: %RobotSimulator{}

  def create(direction, _position) when is_invalid_direction(direction),
    do: {:error, "invalid direction"}

  def create(_direction, position) when is_invalid_position(position),
    do: {:error, "invalid position"}

  def create(_direction, {x, y}) when is_invalid_position(x, y), do: {:error, "invalid position"}
  def create(direction, position), do: %RobotSimulator{direction: direction, position: position}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, ""), do: robot

  def simulate(robot, instructions) do
    instruction_list =
      instructions
      |> String.graphemes()

    instruction = List.first(instruction_list)

    robot =
      cond do
        instruction not in ~w(R L A) -> {:error, "invalid instruction"}
        instruction in ~w(R L) -> rotate(robot, instruction)
        true -> advance(robot)
      end

    case robot do
      {:error, message} -> {:error, message}
      _ -> simulate(robot, Enum.join(Enum.slice(instruction_list, 1..-1)))
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%{direction: dir}), do: dir

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%{position: pos}), do: pos

  defp rotate(robot, direction) do
    index = Enum.find_index(@directions, fn x -> x == robot.direction end)

    case direction do
      "R" -> %{robot | direction: Enum.at(@directions, rem(index + 1, 4))}
      "L" -> %{robot | direction: Enum.at(@directions, rem(index - 1, 4))}
      true -> {:error, "invalid direction"}
    end
  end

  defp advance(robot) do
    position = robot.position

    case robot.direction do
      :north -> %{robot | position: {elem(position, 0), elem(position, 1) + 1}}
      :east -> %{robot | position: {elem(position, 0) + 1, elem(position, 1)}}
      :south -> %{robot | position: {elem(position, 0), elem(position, 1) - 1}}
      :west -> %{robot | position: {elem(position, 0) - 1, elem(position, 1)}}
      true -> {:error, "invalid direction (somehow!)"}
    end
  end
end
