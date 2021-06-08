defmodule Calorie.Models.Bmr do

  def bmr_for_user(pp) do
      case pp.sex do
        "Female" -> (9.99 * pp.weight + 6.25 * pp.height - 4.92 * pp.age) - 161
        "Male" -> (9.99 * pp.weight + 6.25 * pp.height - 4.92 * pp.age) + 5
      end
  end

  def cpm_for_user(pp, user_bmr) do
      case pp.physical_activity do
        "1" -> user_bmr * 1.2
        "2" -> user_bmr * 1.3
        "3" -> user_bmr * 1.5
        "4" -> user_bmr * 1.7
        "5" -> user_bmr * 1.9
      end
  end

end
