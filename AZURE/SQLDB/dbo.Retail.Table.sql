/****** Object:  Table [dbo].[Retail]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Retail](
	[transaction_key] [int] IDENTITY(1,1) NOT NULL,
	[transaction_date] [date] NULL,
	[transaction_hour] [varchar](50) NULL,
	[location_state] [varchar](50) NULL,
	[location_city] [varchar](50) NULL,
	[rewards_number] [varchar](50) NULL,
	[rewards_member] [varchar](50) NULL,
	[num_of_items] [int] NULL,
	[coupon_flag] [varchar](50) NULL,
	[discount_amt] [float] NULL,
	[order_amt] [float] NULL,
	[Inserted_On] [datetime] NULL,
	[Is_Active] [bit] NULL,
	[Updated_On] [datetime] NULL,
	[Updated_By] [varchar](50) NULL,
	[location_key] [int] NULL,
	[location_id] [int] NULL,
	[integration_id] [int] NULL,
 CONSTRAINT [PK_Retail] PRIMARY KEY CLUSTERED 
(
	[transaction_key] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Retail] ADD  CONSTRAINT [DF_Retail_inserted_at]  DEFAULT (getdate()) FOR [Inserted_On]
GO
ALTER TABLE [dbo].[Retail] ADD  CONSTRAINT [DF_Retail_is_active]  DEFAULT ((1)) FOR [Is_Active]
GO
