Imports System
Imports System.Data.Entity.Migrations
Imports Microsoft.VisualBasic

Namespace Migrations
    Public Partial Class initial
        Inherits DbMigration
    
        Public Overrides Sub Up()
            AddColumn("dbo.CustomerOrders", "RowVersion", Function(c) c.Binary(nullable := False, fixedLength := true, timestamp := True, storeType := "rowversion"))
        End Sub
        
        Public Overrides Sub Down()
            DropColumn("dbo.CustomerOrders", "RowVersion")
        End Sub
    End Class
End Namespace
