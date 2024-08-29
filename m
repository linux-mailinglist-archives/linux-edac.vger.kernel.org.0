Return-Path: <linux-edac+bounces-1749-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBD1965297
	for <lists+linux-edac@lfdr.de>; Fri, 30 Aug 2024 00:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36D71C23469
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 22:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C718DF7A;
	Thu, 29 Aug 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bNEb2kzF"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2048.outbound.protection.outlook.com [40.107.241.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30726296;
	Thu, 29 Aug 2024 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724969002; cv=fail; b=TxbM3I28XdnPTRnhxSBHSXbh09BIpDKHfIRCJq+mW6gboif4k8dn4uInp3ww2qiAPlfP6TTwK3h3IrdtoY+4aWQg7nmBBaN5RQtDTHQGliFwni2hUZDoHguzrA0h1Gi2AVpBVs4G7gn1Xh0TLtHa3OTBOHEbAXgjL8CFgzXy5FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724969002; c=relaxed/simple;
	bh=l6NexzxEsmyncH2xpra3OJNJwZKFN2gjlAocAJg8FkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=raaI2i3wBoVt0eNMTPXhBa8jZY86TH0IwPO8sUP1Z5j0th236kPYRC1gTgHig5phwxQymzc5ZDY7m9McIG3JTOwoksldGuP3LOwhpnuZwffkO18ox2AOEB7mVzNy07ogB5KQPOsn7Z5WlvSkyknax81G7EoO62kdgRlqaB4IakM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bNEb2kzF; arc=fail smtp.client-ip=40.107.241.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyJHx32H+9vTeWNg7UlS9yRA/7FSE0upfZWDz7vDX5Rojn/2pNOi6GRZ1mvxDhPEqSXk8Yzq3P69WIJZchoT2tfKe8svceHnmJmaUWFYwPOwqvMtLIp76CUYEIHp4c1ysP1+ia1Qeq5yzpywOxFXG2DnjvBdB7RK892VpzAPVAWNEBLDdZWhB5DY+4IQ2eO/SCGdLGgZCm6oEQ3S9SbugQFp1lbEOXGMHMxGgj/eK8tWUIrq91Eoz0x1f11T06XviG5HJzFTftgqu9mHZOzT41vpIFRSCx25JYby4KZiYWJRZ4W+DjAXvsAzMeTMo7CKJGefBhJBQVYfK0SQIV27mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVHAKTZmUNUtxUjDc7zW/Ngu7tKDZZXo9KK5fG9eT9A=;
 b=Rt+/v/DSvp6emv8jGAIV2j6CweN9LG0aUmE3FznGxJOgmyt70gD3aljbKMzYGvGdgGcIG0jMZFtiwsl/AdXLXWZ97vOGwlo07aeS/TSp37NXcwlWp49O6L8IqKKaUChUwjFBmi/LYLOaeXhQljHwyJuA1lrm2UZtYXawF0jC1TJ+NJuWrI3vYv0SkRzIQ6icPbbZci3N8OTcUrPG5aXdoHv/37yGz1GhF+HvvZeAz24FGLZQWyNKfzRxYuo6abk1T4QyyTPqaEuOLC1vkMByrS9oV01PM9wvLak9BFCw6YfHS66MEApU/YUeaEKhNw2uapv41wMH/sFANxoQGNE4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVHAKTZmUNUtxUjDc7zW/Ngu7tKDZZXo9KK5fG9eT9A=;
 b=bNEb2kzFOTgq04fNtuij0MbtyMyig9SfeLKd8lGe6COA2gbby14XtxE87CvXOj/EdkaxenWCdGvzt+AWyQgzGU1jSd+Yq3NCwjTMByK4r6zQfShPHx0edIhrAOBWPcY4h0rj1OjC58P8imruFSRTgyQcvFvJAtl9hQt+sCNoiLKa134GC90Q3WuAwV4HpyBEND7UMKWSOajFj7Kl1sU/6/mgypQ4ijOkemsQ6h9MlWGID+9r52Fctdp9czMLa4aF9B6LyFBQE+vwdLjJ95MEW7ciYl/GcOialvtG+JzfPhwFyPmlKBaecRnSPX4VyHTWVhRoqycjidqkzvtHJnOerw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7972.eurprd04.prod.outlook.com (2603:10a6:20b:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Thu, 29 Aug
 2024 22:03:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 22:03:17 +0000
Date: Thu, 29 Aug 2024 18:03:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: York Sun <york.sun@nxp.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] EDAC: fsl_ddr: Pass down fsl_mc_pdata in ddr_in32()
 and ddr_out32()
Message-ID: <ZtDwG2xFGaUssJVN@lizhi-Precision-Tower-5810>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
 <20240709-imx95_edac-v1-1-3e9c146c1b01@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709-imx95_edac-v1-1-3e9c146c1b01@nxp.com>
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: b26b370b-99e2-4ccd-c4a4-08dcc87662f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AI5M7AsRf9JY1wUWafbfyr8ByYYNk+vzmDhHLIzsuqIpRWEhUsIiVcEhQpXa?=
 =?us-ascii?Q?OWe1zOVwQX6XKqBsMZxFgutQKHBnJ8assW2822KQGixxvqhPRtRmorcXhIvQ?=
 =?us-ascii?Q?BVs+1JgDGP5KurFH5jKz6ubTX/LGpsPJrj42BqEtItPZ9xtP7e7cVu3XWQCc?=
 =?us-ascii?Q?9HvoDC65CQo6zSYO6LTwEQCjHwp5TmDbHwYOGXXIdpYYVrU0wkdnR/ujQVac?=
 =?us-ascii?Q?YVBzPGXddSPbYWtG83TPV1CZDgFQlSgGmXTOBho3OhTE7zKhGXVOIB1fLp/D?=
 =?us-ascii?Q?6TvTuyYLQ+DZl5DwIvXEXHzwJUGZ2j0sAjxK09Uy+ndv4zha26icGMg5nAhv?=
 =?us-ascii?Q?dDRMWowy6yeHpiuC98vaQV3evxPP5y815vc5037NUWFe990cS7Xy/jCfGAb9?=
 =?us-ascii?Q?dxGhUsfi9H+kXksA07xMhMYOzE7c1/9T46mtcf1Y18bfsQE+xPiNrP2Yg2ZG?=
 =?us-ascii?Q?n2cbVvf8Xtq5YSAzYyEahZwkoHcR4o6Yo2VgoBYEwlfvLpD8Gj0pdaw/f9Jt?=
 =?us-ascii?Q?O83odb8Qp/PoIAE2EhLQEPD44mAzHcp/lm0WacjszOZ0V/CcMKQseVJz4iAG?=
 =?us-ascii?Q?0FB0hGrPAfkFM7Ctf2GsevWnLQ3RmN6UZemhy+v2VLyhkOwISIyEkNGljXLD?=
 =?us-ascii?Q?PAJPEDxvZIjW/Gf6Ac67+oE5D0Z+hSvNzP1YIvZOQe3w6AAAn/+S+YQWYEnJ?=
 =?us-ascii?Q?Its5TMllarn8AmftJIH+mzavVLUNYduHEhGErEpC2gMBDkD1PQ5Q22ogY/wk?=
 =?us-ascii?Q?ODcPvk3jngoDOUQ+mamBlCGE6aUBiJ2tBtujHwPaoKkmOb3PtsouZC84J/Et?=
 =?us-ascii?Q?IWHkgAAFfQ3mWmuHerMHfQBoaGPjFT2jFpCuuzgQLck+lkCFikofTJgTrNFw?=
 =?us-ascii?Q?RmV579EyqRjD693UJf0pv9ZYPFqykDPO1gtgm53fL6g7ATf0lZ3dWjc1PzHT?=
 =?us-ascii?Q?JDzeKPaobVKISHXbyI42jvYY5E09fKm7Hkss1+VYtOkpZFfSTVbcQ2JxvsQc?=
 =?us-ascii?Q?JLAIti1FnsCOGUaehpT6/5UkO7ydIThpCjVs0jejyOTicRwPHNsa+jsU48p5?=
 =?us-ascii?Q?7SiFBvep5SAX6U3S44ihIjKJCmq2KlqYRsSRfMtsVw2FvKoMbGQ7qjB9LZJY?=
 =?us-ascii?Q?6jVeoR5KHDFwD9PO0rxtwRCs7ZlqnGYKq9/crpezHLAZoi1IoTFaQyZJLFVO?=
 =?us-ascii?Q?6RJeX5+QQwMppn/RZRjMhbCJ/TCyIugr7mMJl8e/4V0C9rK+qGKfCwnN6COu?=
 =?us-ascii?Q?u3TQVZFco0HZko0kTB+GyArfUdSeXoObaooJffhC6i992ae7Wa8dPlJ8B1tD?=
 =?us-ascii?Q?XkNmpR/GH4CXv2uoDN5HEG/wvapV9uDtOFUSqi0KUavB3osB0xOJNqUU3S0V?=
 =?us-ascii?Q?I2qmTnlHlBv4MpzmLXYxjyObm5UC74uW/Bpzer/7+sKh4kR4hpEjS2s1mLqF?=
 =?us-ascii?Q?F9Pmtt4/heU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?scVcYzhGTcMVgU3U5AXtqNU9FJ+k4mwJQ7+vsQ6NX+XYdNBLU55LB1VFdQNK?=
 =?us-ascii?Q?obuIXQnK5BSV/emi31juvUBtZ+SLGrSLGjdsaoiYbiSLpPrstHOR+Ak8DNYD?=
 =?us-ascii?Q?8dXbEf8h8qkKaJXMTgq7B5uu8LRkc48IUBm869YINLDu7guXLyDmvz3zalh8?=
 =?us-ascii?Q?GDxdNOzhSvsr+1JZByhiiCYE5QeivfhpSRMe3gerfOf5C9bLrJDn1BqtvApu?=
 =?us-ascii?Q?fHgobyqLnItZlW3ldjMD06ShQQytw8GGg7JOtjL9SWW/zL2KJ1co3DchdGP8?=
 =?us-ascii?Q?8YCqmmDICozI3ez4JOUJPTCuYGj4SuxfN3XmaRRWaG2Xg5a1s6SghEmMgUJE?=
 =?us-ascii?Q?MPiixX91SfbFBtN8BUBIby4m9KieC48TTRnVoAM8W6jWMfZ+hteGzjylFxCq?=
 =?us-ascii?Q?yMY7nAzFsXUzVm9CruqdVrNKyjPki7kZqHB4vo9T9doaIObkazw6QlhICejc?=
 =?us-ascii?Q?5+CJfd24c2TO/qu45IOSvt+vs7Sge59AOeq8yqH4cCmNaOWfgDDv8NEYmY21?=
 =?us-ascii?Q?TeyRXeulKNmIvjONUCagPPW1ylTuLpF4gVKFMr/K9PhSESnXYhIg3oxoEh9l?=
 =?us-ascii?Q?J0yYvmh0KhWxZNtJd8ys/NZuxfDaS7w240MmLpKNNwByw6pWACd8j5hPoIhj?=
 =?us-ascii?Q?ZT6omQhw11oyyhc2EUgg1wWnb4b0d+pbgNvhpUlLem/zJJYmj+z01AAEVgdC?=
 =?us-ascii?Q?Fg01kidEPQjFJ5f71UaSAcGVKh9PIagLQfTenfZbH+kFBNpiAndbCGdDMRNk?=
 =?us-ascii?Q?Z9Fys1MfaNM/iVRlQXV8W4dUgjf9uqh8T4c/P5Kmzwlj3lhgzGY9rj70yV5K?=
 =?us-ascii?Q?Fo2oXEOi85x6QuvOzZNqR63nOk/UumQNmitP3c2XYopfbr72hnn3PrV0+mcG?=
 =?us-ascii?Q?HprbeHCYpUPTcCFnFJTfahLyBELz0tfNwl7nto9BsG4o8LOK6zxDpc/0OU2H?=
 =?us-ascii?Q?04S8dMUogLD9arfZOwk4A/fmwIylf4GtgSWVbuoswYD7kKmDaw46UFnRlb46?=
 =?us-ascii?Q?dVgYXNbqJmqz5KoZMRLJbJ9m2RhP+sUDsKoryiXkqKAFZoj7MQQRsbXISHXW?=
 =?us-ascii?Q?FLjqCgT1zIW9nDzLhnUaLT/BM4StniktazhR3cf10agyHXmA/yF/tt9EjAVd?=
 =?us-ascii?Q?eeRkszwafMzSwydof7m16ELrS97icU/+XIvriyU12z+jDc7oK61oy3QcFs7G?=
 =?us-ascii?Q?BPg14R/5izID9uC13VMyResB9L3lMsszKev524n2BKtz1PiBgph6yIYrMUVL?=
 =?us-ascii?Q?IJ0CXY/jvV72HS5KxjOW5cL5do9db2K3+lQXALuaxSg43Le063u/ZLgjS0SZ?=
 =?us-ascii?Q?quE1MT9jdy7L0IfhWe+DtT3GuZKycDmRoWy94EqsaTykWifMVPymSjxEj69Y?=
 =?us-ascii?Q?slX9sLt8PK4PhSTD9+kcDrZZMX2ko32h2r6vb17U65X16Zk+2edCENex/tqU?=
 =?us-ascii?Q?2vPiwq8gw5xGH4JgncXdexzSlPxe4xPntB3A6m7AzgDzZ2cvi7YHG7w4t9Cm?=
 =?us-ascii?Q?sRzexf+K/pzP5xbhsdgM30Gn9VXkpm96u3qQ73A3oP0nLsYkQgrY8j2ZrXfw?=
 =?us-ascii?Q?eH+Tec+HfiBp1sVXrh8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26b370b-99e2-4ccd-c4a4-08dcc87662f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:03:17.2753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RqXNOXN4DeTwf8S0ouZnR5gukt4BPY4M5RI7VebwtOC7I48qbjwrb0jbqyKsdsCcvauQK2cPeQ7B/sXehKDlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7972

On Tue, Jul 09, 2024 at 04:23:02PM -0400, Frank Li wrote:
> Pass down fsl_mc_data in help function ddr_in32() and ddr_out32() to
> prepare add iMX9 support. iMX9 have a little difference register layout.
>
> No functional change.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Ping?

Frank

>  drivers/edac/fsl_ddr_edac.c | 62 ++++++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> index d148d262d0d4d..a7982370e2381 100644
> --- a/drivers/edac/fsl_ddr_edac.c
> +++ b/drivers/edac/fsl_ddr_edac.c
> @@ -35,13 +35,17 @@ static u32 orig_ddr_err_disable;
>  static u32 orig_ddr_err_sbe;
>  static bool little_endian;
>
> -static inline u32 ddr_in32(void __iomem *addr)
> +static inline u32 ddr_in32(struct fsl_mc_pdata *pdata, unsigned int off)
>  {
> +	void __iomem *addr = pdata->mc_vbase + off;
> +
>  	return little_endian ? ioread32(addr) : ioread32be(addr);
>  }
>
> -static inline void ddr_out32(void __iomem *addr, u32 value)
> +static inline void ddr_out32(struct fsl_mc_pdata *pdata, unsigned int off, u32 value)
>  {
> +	void __iomem *addr = pdata->mc_vbase + off;
> +
>  	if (little_endian)
>  		iowrite32(value, addr);
>  	else
> @@ -60,7 +64,7 @@ static ssize_t fsl_mc_inject_data_hi_show(struct device *dev,
>  	struct mem_ctl_info *mci = to_mci(dev);
>  	struct fsl_mc_pdata *pdata = mci->pvt_info;
>  	return sprintf(data, "0x%08x",
> -		       ddr_in32(pdata->mc_vbase + FSL_MC_DATA_ERR_INJECT_HI));
> +		       ddr_in32(pdata, FSL_MC_DATA_ERR_INJECT_HI));
>  }
>
>  static ssize_t fsl_mc_inject_data_lo_show(struct device *dev,
> @@ -70,7 +74,7 @@ static ssize_t fsl_mc_inject_data_lo_show(struct device *dev,
>  	struct mem_ctl_info *mci = to_mci(dev);
>  	struct fsl_mc_pdata *pdata = mci->pvt_info;
>  	return sprintf(data, "0x%08x",
> -		       ddr_in32(pdata->mc_vbase + FSL_MC_DATA_ERR_INJECT_LO));
> +		       ddr_in32(pdata, FSL_MC_DATA_ERR_INJECT_LO));
>  }
>
>  static ssize_t fsl_mc_inject_ctrl_show(struct device *dev,
> @@ -80,7 +84,7 @@ static ssize_t fsl_mc_inject_ctrl_show(struct device *dev,
>  	struct mem_ctl_info *mci = to_mci(dev);
>  	struct fsl_mc_pdata *pdata = mci->pvt_info;
>  	return sprintf(data, "0x%08x",
> -		       ddr_in32(pdata->mc_vbase + FSL_MC_ECC_ERR_INJECT));
> +		       ddr_in32(pdata, FSL_MC_ECC_ERR_INJECT));
>  }
>
>  static ssize_t fsl_mc_inject_data_hi_store(struct device *dev,
> @@ -97,7 +101,7 @@ static ssize_t fsl_mc_inject_data_hi_store(struct device *dev,
>  		if (rc)
>  			return rc;
>
> -		ddr_out32(pdata->mc_vbase + FSL_MC_DATA_ERR_INJECT_HI, val);
> +		ddr_out32(pdata, FSL_MC_DATA_ERR_INJECT_HI, val);
>  		return count;
>  	}
>  	return 0;
> @@ -117,7 +121,7 @@ static ssize_t fsl_mc_inject_data_lo_store(struct device *dev,
>  		if (rc)
>  			return rc;
>
> -		ddr_out32(pdata->mc_vbase + FSL_MC_DATA_ERR_INJECT_LO, val);
> +		ddr_out32(pdata, FSL_MC_DATA_ERR_INJECT_LO, val);
>  		return count;
>  	}
>  	return 0;
> @@ -137,7 +141,7 @@ static ssize_t fsl_mc_inject_ctrl_store(struct device *dev,
>  		if (rc)
>  			return rc;
>
> -		ddr_out32(pdata->mc_vbase + FSL_MC_ECC_ERR_INJECT, val);
> +		ddr_out32(pdata, FSL_MC_ECC_ERR_INJECT, val);
>  		return count;
>  	}
>  	return 0;
> @@ -286,7 +290,7 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
>  	int bad_data_bit;
>  	int bad_ecc_bit;
>
> -	err_detect = ddr_in32(pdata->mc_vbase + FSL_MC_ERR_DETECT);
> +	err_detect = ddr_in32(pdata, FSL_MC_ERR_DETECT);
>  	if (!err_detect)
>  		return;
>
> @@ -295,14 +299,14 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
>
>  	/* no more processing if not ECC bit errors */
>  	if (!(err_detect & (DDR_EDE_SBE | DDR_EDE_MBE))) {
> -		ddr_out32(pdata->mc_vbase + FSL_MC_ERR_DETECT, err_detect);
> +		ddr_out32(pdata, FSL_MC_ERR_DETECT, err_detect);
>  		return;
>  	}
>
> -	syndrome = ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_ECC);
> +	syndrome = ddr_in32(pdata, FSL_MC_CAPTURE_ECC);
>
>  	/* Mask off appropriate bits of syndrome based on bus width */
> -	bus_width = (ddr_in32(pdata->mc_vbase + FSL_MC_DDR_SDRAM_CFG) &
> +	bus_width = (ddr_in32(pdata, FSL_MC_DDR_SDRAM_CFG) &
>  		     DSC_DBW_MASK) ? 32 : 64;
>  	if (bus_width == 64)
>  		syndrome &= 0xff;
> @@ -310,8 +314,8 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
>  		syndrome &= 0xffff;
>
>  	err_addr = make64(
> -		ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_EXT_ADDRESS),
> -		ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_ADDRESS));
> +		ddr_in32(pdata, FSL_MC_CAPTURE_EXT_ADDRESS),
> +		ddr_in32(pdata, FSL_MC_CAPTURE_ADDRESS));
>  	pfn = err_addr >> PAGE_SHIFT;
>
>  	for (row_index = 0; row_index < mci->nr_csrows; row_index++) {
> @@ -320,8 +324,8 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
>  			break;
>  	}
>
> -	cap_high = ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_DATA_HI);
> -	cap_low = ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_DATA_LO);
> +	cap_high = ddr_in32(pdata, FSL_MC_CAPTURE_DATA_HI);
> +	cap_low = ddr_in32(pdata, FSL_MC_CAPTURE_DATA_LO);
>
>  	/*
>  	 * Analyze single-bit errors on 64-bit wide buses
> @@ -367,7 +371,7 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
>  				     row_index, 0, -1,
>  				     mci->ctl_name, "");
>
> -	ddr_out32(pdata->mc_vbase + FSL_MC_ERR_DETECT, err_detect);
> +	ddr_out32(pdata, FSL_MC_ERR_DETECT, err_detect);
>  }
>
>  static irqreturn_t fsl_mc_isr(int irq, void *dev_id)
> @@ -376,7 +380,7 @@ static irqreturn_t fsl_mc_isr(int irq, void *dev_id)
>  	struct fsl_mc_pdata *pdata = mci->pvt_info;
>  	u32 err_detect;
>
> -	err_detect = ddr_in32(pdata->mc_vbase + FSL_MC_ERR_DETECT);
> +	err_detect = ddr_in32(pdata, FSL_MC_ERR_DETECT);
>  	if (!err_detect)
>  		return IRQ_NONE;
>
> @@ -396,7 +400,7 @@ static void fsl_ddr_init_csrows(struct mem_ctl_info *mci)
>  	u32 cs_bnds;
>  	int index;
>
> -	sdram_ctl = ddr_in32(pdata->mc_vbase + FSL_MC_DDR_SDRAM_CFG);
> +	sdram_ctl = ddr_in32(pdata, FSL_MC_DDR_SDRAM_CFG);
>
>  	sdtype = sdram_ctl & DSC_SDTYPE_MASK;
>  	if (sdram_ctl & DSC_RD_EN) {
> @@ -444,7 +448,7 @@ static void fsl_ddr_init_csrows(struct mem_ctl_info *mci)
>  		csrow = mci->csrows[index];
>  		dimm = csrow->channels[0]->dimm;
>
> -		cs_bnds = ddr_in32(pdata->mc_vbase + FSL_MC_CS_BNDS_0 +
> +		cs_bnds = ddr_in32(pdata, FSL_MC_CS_BNDS_0 +
>  				   (index * FSL_MC_CS_BNDS_OFS));
>
>  		start = (cs_bnds & 0xffff0000) >> 16;
> @@ -558,11 +562,11 @@ int fsl_mc_err_probe(struct platform_device *op)
>  	fsl_ddr_init_csrows(mci);
>
>  	/* store the original error disable bits */
> -	orig_ddr_err_disable = ddr_in32(pdata->mc_vbase + FSL_MC_ERR_DISABLE);
> -	ddr_out32(pdata->mc_vbase + FSL_MC_ERR_DISABLE, 0);
> +	orig_ddr_err_disable = ddr_in32(pdata, FSL_MC_ERR_DISABLE);
> +	ddr_out32(pdata, FSL_MC_ERR_DISABLE, 0);
>
>  	/* clear all error bits */
> -	ddr_out32(pdata->mc_vbase + FSL_MC_ERR_DETECT, ~0);
> +	ddr_out32(pdata, FSL_MC_ERR_DETECT, ~0);
>
>  	res = edac_mc_add_mc_with_groups(mci, fsl_ddr_dev_groups);
>  	if (res) {
> @@ -571,15 +575,15 @@ int fsl_mc_err_probe(struct platform_device *op)
>  	}
>
>  	if (edac_op_state == EDAC_OPSTATE_INT) {
> -		ddr_out32(pdata->mc_vbase + FSL_MC_ERR_INT_EN,
> +		ddr_out32(pdata, FSL_MC_ERR_INT_EN,
>  			  DDR_EIE_MBEE | DDR_EIE_SBEE);
>
>  		/* store the original error management threshold */
> -		orig_ddr_err_sbe = ddr_in32(pdata->mc_vbase +
> +		orig_ddr_err_sbe = ddr_in32(pdata,
>  					    FSL_MC_ERR_SBE) & 0xff0000;
>
>  		/* set threshold to 1 error per interrupt */
> -		ddr_out32(pdata->mc_vbase + FSL_MC_ERR_SBE, 0x10000);
> +		ddr_out32(pdata, FSL_MC_ERR_SBE, 0x10000);
>
>  		/* register interrupts */
>  		pdata->irq = platform_get_irq(op, 0);
> @@ -620,12 +624,12 @@ void fsl_mc_err_remove(struct platform_device *op)
>  	edac_dbg(0, "\n");
>
>  	if (edac_op_state == EDAC_OPSTATE_INT) {
> -		ddr_out32(pdata->mc_vbase + FSL_MC_ERR_INT_EN, 0);
> +		ddr_out32(pdata, FSL_MC_ERR_INT_EN, 0);
>  	}
>
> -	ddr_out32(pdata->mc_vbase + FSL_MC_ERR_DISABLE,
> +	ddr_out32(pdata, FSL_MC_ERR_DISABLE,
>  		  orig_ddr_err_disable);
> -	ddr_out32(pdata->mc_vbase + FSL_MC_ERR_SBE, orig_ddr_err_sbe);
> +	ddr_out32(pdata, FSL_MC_ERR_SBE, orig_ddr_err_sbe);
>
>  	edac_mc_del_mc(&op->dev);
>  	edac_mc_free(mci);
>
> --
> 2.34.1
>

