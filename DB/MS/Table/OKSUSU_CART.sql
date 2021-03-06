CREATE TABLE [dbo].[OKSUSU_CART](
	[ID] [nvarchar](20) NOT NULL,
	[ITEM_CD] [nvarchar](10) NOT NULL,
	[ITEM_QT] [numeric](18, 0) NULL,
	[INSERT_DT] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[ITEM_CD] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[OKSUSU_CART] ADD  DEFAULT (getdate()) FOR [INSERT_DT]
GO
