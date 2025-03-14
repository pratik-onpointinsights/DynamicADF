/****** Object:  Table [dbo].[Location_Src]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location_Src](
	[location_id] [int] NULL,
	[location_state] [varchar](50) NULL,
	[location_city] [varchar](50) NULL,
	[integration_id] [int] NULL,
	[Created_On] [datetime] NULL,
	[Is_Active] [bit] NULL,
	[Updated_On] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Location_Src] ADD  CONSTRAINT [DF_Location_Src_Created_On]  DEFAULT (getdate()) FOR [Created_On]
GO
ALTER TABLE [dbo].[Location_Src] ADD  CONSTRAINT [DF_Location_Src_is_active]  DEFAULT ((1)) FOR [Is_Active]
GO
