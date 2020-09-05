Imports System
Imports System.Data.Entity
Imports System.Data.Entity.Migrations
Imports System.Data.Entity.SqlServer
Imports System.Linq
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Namespace Migrations

    Friend NotInheritable Class Configuration
        Inherits DbMigrationsConfiguration(Of ApplicationDbContext)

        Public Sub New()
            AutomaticMigrationsEnabled = False
            ContextKey = "Shotori.ApplicationDbContext"
        End Sub

        Protected Overrides Sub Seed(context As ApplicationDbContext)
            '  This method will be called after migrating to the latest version.

            '  You can use the DbSet(Of T).AddOrUpdate() helper extension method 
            '  to avoid creating duplicate seed data.

            If Not context.Roles.Any(Function(r) r.Name = "Administrator") Then
                Dim store = New RoleStore(Of ApplicationRole)(context)
                Dim manager = New RoleManager(Of ApplicationRole)(store)
                Dim role = New ApplicationRole() With {
                   .Name = "Administrator", .RoleDescription = "Admin Role"
                }

                manager.Create(role)
            End If

            If Not context.Roles.Any(Function(r) r.Name = "Customer") Then
                Dim store = New RoleStore(Of ApplicationRole)(context)
                Dim manager = New RoleManager(Of ApplicationRole)(store)
                Dim role = New ApplicationRole() With {
                   .Name = "Customer", .RoleDescription = "Customer Role"
                }

                manager.Create(role)
            End If

            If Not context.Users.Any(Function(u) u.UserName = "admin@utar.edu.my") Then

                Dim store = New UserStore(Of ApplicationUser)(context)
                Dim manager = New UserManager(Of ApplicationUser)(store)
                Dim user = New ApplicationUser() With {
                    .UserName = "admin@utar.edu.my",
                    .Email = "admin@utar.edu.my"
                }

                manager.Create(user, "admin123")
                manager.AddToRole(user.Id, "Administrator")

                Dim tempUser As UserInfo = New UserInfo()
                tempUser.UserId = user.Id
                tempUser.Email = user.Email
                context.UserInfo.AddOrUpdate(tempUser)
            End If

            Dim state = New List(Of CountryState) From {
                New CountryState With {
                    .Name = "Johor"
                },
                 New CountryState With {
                    .Name = "Kedah"
                },
                 New CountryState With {
                    .Name = "Kelantan"
                },
                 New CountryState With {
                    .Name = "Malacca"
                },
                 New CountryState With {
                    .Name = "Negeri Sembilan"
                },
                 New CountryState With {
                    .Name = "Pahang"
                },
                 New CountryState With {
                    .Name = "Penang"
                },
                 New CountryState With {
                    .Name = "Perak"
                },
                 New CountryState With {
                    .Name = "Perlis"
                },
                 New CountryState With {
                    .Name = "Selangor"
                },
                 New CountryState With {
                    .Name = "Terengganu"
                },
                 New CountryState With {
                    .Name = "Sabah"
                },
                 New CountryState With {
                    .Name = "Sarawak"
                },
                 New CountryState With {
                    .Name = "Kuala Lumpur"
                }
            }

            state.ForEach(Sub(g)
                              If Not context.CountryState.Any(Function(r) r.Name = g.Name) Then
                                  context.CountryState.AddOrUpdate(g)
                              End If
                          End Sub)


        End Sub

    End Class

End Namespace
