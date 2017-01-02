CREATE TABLE [dbo].[OKSUSU_BOARD](
	[IDX] [int] IDENTITY(1,1) NOT NULL,
	[PARENT_IDX] [int] NULL,
	[TITLE] [nvarchar](100) NOT NULL,
	[CONTENTS] [nvarchar](4000) NOT NULL,
	[HIT_CNT] [int] NOT NULL,
	[DEL_GB] [nvarchar](1) NOT NULL,
	[CREA_DTM] [datetime] NOT NULL,
	[CREA_ID] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDX] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[OKSUSU_BOARD] ADD  DEFAULT ('N') FOR [DEL_GB]
GO

ALTER TABLE [dbo].[OKSUSU_BOARD] ADD  DEFAULT (getdate()) FOR [CREA_DTM]
GO


