###
# Copyright (C) 2014 Andrey Antukh <niwi@niwi.be>
# Copyright (C) 2014 Jesús Espino Garcia <jespinog@gmail.com>
# Copyright (C) 2014 David Barragán Merino <bameda@dbarragan.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: modules/resources/projects.coffee
###


taiga = @.taiga

resourceProvider = ($repo, $http, $urls) ->
    service = {}

    service.get = (projectId) ->
        return $repo.queryOne("projects", projectId)

    service.getBySlug = (projectSlug) ->
        return $repo.queryOne("projects", "by_slug?slug=#{projectSlug}")

    service.list = ->
        return $repo.queryMany("projects")

    service.templates = ->
        return $repo.queryMany("project-templates")

    service.usersList = (projectId) ->
        params = {"project": projectId}
        return $repo.queryMany("users", params)

    service.rolesList = (projectId) ->
        params = {"project": projectId}
        return $repo.queryMany("roles", params)

    service.stats = (projectId) ->
        return $repo.queryOneRaw("projects", "#{projectId}/stats")

    service.leave = (projectId) ->
        url = "#{$urls.resolve("projects")}/#{projectId}/leave"
        return $http.post(url)

    service.memberStats = (projectId) ->
        return $repo.queryOneRaw("projects", "#{projectId}/member_stats")

    service.tagsColors = (projectId) ->
        return $repo.queryOne("projects", "#{projectId}/tags_colors")

    service.export = (projectId) ->
        url = "#{$urls.resolve("exporter")}/#{projectId}"
        return $http.get(url)

    return (instance) ->
        instance.projects = service


module = angular.module("taigaResources")
module.factory("$tgProjectsResourcesProvider", ["$tgRepo", "$tgHttp", "$tgUrls", resourceProvider])
