CREATE TABLE [dbo].[OKSUSU_ORDER](
	[ID] [nvarchar](20) NOT NULL,
	[ORDER_NB] [nvarchar](12) NOT NULL,
	[ITEM_CD] [nvarchar](1000) NOT NULL,
	[ITEM_NM] [nvarchar](1000) NOT NULL,
	[ITEM_QT] [numeric](18, 0) NULL,
	[ITEM_AM] [numeric](18, 0) NULL,
	[NAME] [nvarchar](100) NOT NULL,
	[PHONE] [nvarchar](20) NULL,
	[ZIP] [nvarchar](10) NULL,
	[ADDR] [nvarchar](300) NULL,
	[INSERT_DT] [datetime] NOT NULL,
	[ORDER_FG] [nvarchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[ORDER_NB] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[OKSUSU_ORDER] ADD  DEFAULT (getdate()) FOR [INSERT_DT]
GO