module TeamsHelper



  def find_past_teams(person)
    @past_teams_as_member = Team.find_by_sql(["SELECT t.* FROM  teams t INNER JOIN teams_people tp ON ( t.id = tp.team_id) INNER JOIN users u ON (tp.person_id = u.id) INNER JOIN courses c ON (t.course_id = c.id) WHERE u.id = ? AND (c.semester <> ? OR c.year <> ?)", person.id, AcademicCalendar.current_semester(), Date.today.year])

    teams_list = ""
    count = 0
    @past_teams_as_member.each do |team|
      if count == 0
        teams_list = team.name
      else
        teams_list = teams_list.concat(", " + team.name)
      end
      count += 1
    end
    return teams_list
  end

end
