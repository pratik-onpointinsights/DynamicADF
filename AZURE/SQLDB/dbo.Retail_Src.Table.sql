/****** Object:  Table [dbo].[Retail_Src]    Script Date: 08-04-2024 11:08:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Retail_Src](
	[integration_id] [int] NULL,
	[transaction_date] [date] NULL,
	[transaction_hour] [time](7) NULL,
	[location_id] [int] NULL,
	[location_state] [varchar](50) NULL,
	[location_city] [varchar](50) NULL,
	[rewards_number] [varchar](50) NULL,
	[rewards_member] [varchar](50) NULL,
	[num_of_items] [int] NULL,
	[coupon_flag] [varchar](50) NULL,
	[discount_amt] [varchar](50) NULL,
	[order_amt] [float] NULL,
	[created_on] [datetime] NULL,
	[is_active] [bit] NULL,
	[updated_on] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Retail_Src] ADD  CONSTRAINT [DF_Retail_Src_Created_On]  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[Retail_Src] ADD  CONSTRAINT [DF_Retail_Src_is_active]  DEFAULT ((1)) FOR [is_active]
GO
