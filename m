Return-Path: <linux-edac+bounces-2003-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B532998CD0
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 18:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF671C20B5F
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE331CDA23;
	Thu, 10 Oct 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V3UgTxfx"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510791A303E;
	Thu, 10 Oct 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576478; cv=fail; b=aF10r0yeIJcN71K5XcDbauV1gmRcQqu/QoEFHQ5T5jhe/8PDRNkGWltuMNBzuiSaED6VpVCTqXvpbXaDe1zHhaO4OHIrX4lohP3Gwh9Ce3HVY8l13BZdDR2t6J7GLSV6cdrJIT0ZSg7XEsRfMiw9KCxjMbF8cRaJokJJ4zqhl+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576478; c=relaxed/simple;
	bh=eAZK4ZZJ2ab2uHjjJKszA416HXiISRjn1QP8oxjrVc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EDT45jkXSMjYLQM6C5+H96tCSD8Sgm+TwvP1SGRFB01m2y1MDoyCJtXZS+A+9PCjS3f2stkRx8VlFznLzyagzj3UwtV52tXiH8yTUvWwyjy9UK5on2S9rOu7mXOejqM0JwWvl/OqciDLre7oi2dx8qZscleeNWoTCUqNIvbpV5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V3UgTxfx; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0/Uq2qe/4+YwzL57Dr+VgevFHVQ8EoLW+4wISNqtkoKh9ETNh5IGxYbRlTK35V9H3JCTeUHBOg+9igXB8JWacmRM1g43/kjHBlv7iKuO52gI/5Yq5puzxI/gb9NQfVos+Li30i4MUalepMsPY4XO5X+WK5I8EcPZU3tYS3KRGkyibYyH8/1jMgDLM9mkN7p9DhfvQzle2ERWsvU8INbpNgDyDO9s3ZKFQQ6Mc4x/fOQMlNmgA4HAbatAS9N8bqKfV+g9RdFCVgmo9/+CX36GLn/f1n2ujj76l0VyMZj2J5qldP0XmC0mZ3jXQFwCZJzVuglSx5vlqHuDcuBIIuwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wh8qiZ93QAr3rISfZ+MNoeDJTZNlEmC2c1xuQ7p8nWw=;
 b=COZVZQIh69y+iUoDWz1hBx7ZhM6zKRKlnl4+Tus9OflX/pjnznt0iSdoYr+EmMmFMOpSgrMiSX+vycPSMnRZ3PR0tkrBVqaNKbzhGn4StUVliVw+yTl4daKkixnFk08a6vI5F0iDXkUFwR/UovnvT/cg2ba/L/6IkqQYBOOHxwayX1/vI3wevUCWUieIHGvu2R8N6oPkelE3ACTsQ9zrIOUPspZENfkyNliZN2SHvJnBCd6NNDOa/ppM0QEhW6iE4BqNZ0+iQj3qDI/x9hjXQ7TkBqXYlOrMUo2RYvkJJbDrn6Qemm2bX9DOqoa8B6evkZM7qRk60Hytc34hfwf9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh8qiZ93QAr3rISfZ+MNoeDJTZNlEmC2c1xuQ7p8nWw=;
 b=V3UgTxfx+W5Bz51LEC25mq1HuQLBKdjK8rx3bheg2z+i3WF6vJPQgRSqQGJgt/tXuG33XyjY+gT7kCc6V4D/6u0+T6J5eLwa0DyvWeoeoZK2/i4+noljW7iwiJiEQu+GBchM1i5qIY/zvMxYwmxhdiuesurtxjMBClFrXOIEayUKh9SgvRIil2l7g0MgEpH1dSguRUiT+Ge4HGz7X1CdydwY3I28Pm/uGCn9r9l/NnSVqqbm9PuC10upojKfnsmWzZYJ/ENzFD1DkFuDIvjNwx+dR3C8sA2S5X7pB8fLCSUVCtKon1n8O7PbkxT8+FdHoFuG4oVR+8qDZFDo5x4HyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8658.eurprd04.prod.outlook.com (2603:10a6:20b:429::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 16:07:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 16:07:52 +0000
Date: Thu, 10 Oct 2024 12:07:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Borislav Petkov <bp@alien8.de>
Cc: York Sun <york.sun@nxp.com>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] EDAC: fsl_ddr: Pass down fsl_mc_pdata in ddr_in32()
 and ddr_out32()
Message-ID: <Zwf7zkAIIEr/QxHg@lizhi-Precision-Tower-5810>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
 <20240709-imx95_edac-v1-1-3e9c146c1b01@nxp.com>
 <20241010153320.GPZwfzwGeFF1cz4arw@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010153320.GPZwfzwGeFF1cz4arw@fat_crate.local>
X-ClientProxiedBy: BY3PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:217::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: e62d2ed5-eb68-44e9-7bb9-08dce945b18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zPfLUTNNt4rUKFGya+vdQ7Gf0Eb4SC/jCbSYRjKb78h1cXTxrf8qDqLhcde5?=
 =?us-ascii?Q?jw/jVDNCLL0wqxQUGu9ZzYmXIYEcLuRpcDymL4Wl4VE6batDvwc0rayt6dzq?=
 =?us-ascii?Q?IQg29MRyvMUVQHOSwRcXs6q2sIp5u+06/P2rQ3ioskRUfa8udgHGpfVC+dI6?=
 =?us-ascii?Q?la/0yfYPhpcT6DT0Q7tDPlLoLWysnbH0aokvVrwHdmaV8PIygFdNeiyg+vAA?=
 =?us-ascii?Q?S0MGiVswXnV2ge1WRLz2e+f/Y8RUGLfl1MpX3CuEUrx0qwI/CAPwNNzXDxl9?=
 =?us-ascii?Q?UFXpLTxm0phVivWoojw42wc03L0goKrqGVdDgRUs0EDVGQqJGlC/wBMQsqmI?=
 =?us-ascii?Q?hVlp0qNuwmkIWQ6ESya2/IiDJwMJeboZSjDYpbQGvV7+MdCLQU/9quksNaVb?=
 =?us-ascii?Q?ENeK57dACNGFCLuJD5aQK5nf7QPF8tlG+iRjUb+lc5+hOpxgGyaSmjDwvWQu?=
 =?us-ascii?Q?xjyBWnRGYn3WxVFCWpRFIMvDGAHnuCgQmMutAoAXjR0CpsTPyb4mmWsaqenV?=
 =?us-ascii?Q?Jyhu6CeoSNTHcwWa4teh21wYd9MFx9+D8SdLRaC3wTT2IlLva1h1OqkGocvl?=
 =?us-ascii?Q?R7dnst7LXyLcScfZ4uAlk5s9aAeEenoYuFV77JUk4R1QklF7p22PonMXM4aF?=
 =?us-ascii?Q?i/JQPc7GY8zGcCiqlsqqQ8ctxQrSUh/nD9ZFdiKOiZPfEzl4AVsel6GsScFb?=
 =?us-ascii?Q?5HonYDi5tUskXq3/aGdEfzTUSl0rRYnsYTxdiZE/DnaAL0qBDqGKphQErKtw?=
 =?us-ascii?Q?BWo7XxCJspCG3mrUGiDqNvgYJZ9d0AkyDCKnRopJu7nD/fUA2Ace+1a04Q4+?=
 =?us-ascii?Q?gxy4tELHzFD94iLJZBA9P6oT92VPBcdMCqEkTz1iVwMEoWN8DoQWlXw5p+CQ?=
 =?us-ascii?Q?dpmwOE+NOmsD/m2OIh0soXy50MLWoWJNhlRfA8b2Z5fYnXL5jjxbaY9buInC?=
 =?us-ascii?Q?o2ukUH6ZyNqRpUyJv1c24xkkHZWr/nVTDPXiZEI0fBWWAcmCdJAH7o3oZ5iH?=
 =?us-ascii?Q?eSc5ALo9h2GDcjxhJG+a5sfscs0nwXlfNNfwo9ZD1f4yZ+r4sfSWfz6s3T7p?=
 =?us-ascii?Q?TYWt1j98SwDvDzZ5pqBHUGmeCePqhcUb6udYbc1konP7kj9CwF2P/zHeMvDo?=
 =?us-ascii?Q?R0z9d6PMlzUliJgwRre9OfUkKHYbtJpYFHqWCwf9rOKhDv90o9TXB+tGTI5b?=
 =?us-ascii?Q?Z+4p6q2U40VCQCnj/zk/N+KW2Xuxotdgz6UOQohCc7Sz3QrL+OTCDMDFF0o9?=
 =?us-ascii?Q?qrmHfn/2EARel+OxUF7CKLXBGQBaHRVy9kFENSbZIJEdGqqx194LwGkcR6HR?=
 =?us-ascii?Q?+5bbzPeGJh6mgCFSlb5VL+u4SVZIwwTNV5jq7+N1GFtd6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s1pbGEZquTRrMg799EZoeRq5+0sMKUS4mc/BISdzEjBlBBRShbi5uE5gqavA?=
 =?us-ascii?Q?m9iqejXslAmGauBV1IG0T47VCSz+B36pFqcQS/7S4AzAdmlI9dhsJzvVGvTR?=
 =?us-ascii?Q?D/hqMfBUZDyjvX+pLZKvUouz4MFeYRs6crMi06x0XlMohthNGhhKrDWj/g82?=
 =?us-ascii?Q?o/yRIGKLHiOshN+uviuf2jhZ7RVZmoXTaxOxJd6OvUpNKJ0qi4AAbDYIflYL?=
 =?us-ascii?Q?bDCPU28zA3Ourm0Sdsc0QCpinCmB955ur2TcnCFqrhfsn2J5y+j4ngDfNyLZ?=
 =?us-ascii?Q?H5w0HVaop85c9hoiKhSTIDqnR4MdJag3+lI+k0t/ARJ2cdgVCavjoXWutoxv?=
 =?us-ascii?Q?NdgbaoZ/fYAAor1IIefczFZI0dUBXSvxS2c7xqZTVCGwu99rpvibG/4Y4NRi?=
 =?us-ascii?Q?cBVisNeR0uiIsHMKEBo8sL7c2ZMNy4XKomVzXpoRZ+nYBIpY98b6Kb2nQx1D?=
 =?us-ascii?Q?HGdFobw53f578cTFSc3D5QxRihYtWq+u3lB2FoxsHxh0l1ur8iEMfYsV0nsY?=
 =?us-ascii?Q?b7zLOV8BrXDguGh5oKuxr95AfQT2dHeOWARsWyVnSRJxXj1DSNMiVHa3kdWa?=
 =?us-ascii?Q?VIqkgwW4XECHuWGuhJgtj2dgtq4t4KZouxhRkbYi+rsoA2nILcwQAJglngak?=
 =?us-ascii?Q?LUg0996ruUIx6xcK0x3lwibN05gxVHcfQBfmVMbwVGDg2bQ69dr0KJAsfu+a?=
 =?us-ascii?Q?nLYfBTtq3uD2KR4RLQaX/gd0CoTBQ7wPJ3gqQAAFC3/eJNGFy07mVmFZ7iyA?=
 =?us-ascii?Q?iajsgP7U1WOsaOaon9H69ORa6DndkAk+y0DsYpBrkIt/KkBS1WO0ZGMQjKu6?=
 =?us-ascii?Q?q3RxXY7uKbVeFy1/YKDHJ01lnQNhEHDYXn6OtpHye+zEfjFtOl2dymJU1hsm?=
 =?us-ascii?Q?NlQiIa8gGyKA6l8omyJtVMsFZImYKMZJREQ3tkcDBB8lfrkGg0VYONgsdb0G?=
 =?us-ascii?Q?A4U1/uscN8Ia/GarGv2OzjWSLjSJZYQgT02l6hoi3ziChpkXUPFZ5LOEf3wJ?=
 =?us-ascii?Q?+NHwim4Hj0CfseAMFc0fJUoL5pcdv/2J/EU/B6O7BEMU8RQTrBpLMt1mTp2/?=
 =?us-ascii?Q?Mlnv0Jut2HrW6imyidHhaxxfYbh9NiGQGBvg5+Ga1KzFCTT7EFN1+M6OogWf?=
 =?us-ascii?Q?SlGV2Lgm+Nf1z+RRQcolAj5R1AedNNdSgAr2CZmrQedHlfBIQiW08QC99Y9e?=
 =?us-ascii?Q?QxBORmkpr5dJlW0NsK8eg6sCGW1+tF4Ut62mIWQiyEcLRJbPdHsIrdFX8fMn?=
 =?us-ascii?Q?Jau2gJAG09+IYRXuyi4peAaM1pzrT7xIx7+eQrke//O5i5f/OroCVDMgYZsj?=
 =?us-ascii?Q?/7RxtYGATI56ZlZoAw49nP1Uz+dmBlKbX9qBo4mdCOqIJckV6IDNl9kDjR2O?=
 =?us-ascii?Q?4Mc+Jlv3oDsnr9NlR3d6qs5Ys1EkNs5Rx4XeiS5eZ4yRYCM4UVB2NPtYI55E?=
 =?us-ascii?Q?H4/UwPjdctyaj10wLe5rJ5zgMmQHZ8FutTW/XtminWMzHAgOoNcp8saosUQ3?=
 =?us-ascii?Q?YuW3DCtH7VcZ313ZcM2mp2pxf/j3cbpRa1qC7OKQlZu6uDi2lGF+Tv02vmUc?=
 =?us-ascii?Q?v76sIifXvRepK2t6laE2U6IgdDh7CRmXxYIBd6It?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62d2ed5-eb68-44e9-7bb9-08dce945b18e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 16:07:52.2094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbYRGd/0J5M3TRLAsccoeElmaY7PUU/hxZgwVXZXB08R58N5GAAFwoCZ4QJaNdkMh/dUYNjRyrM4/71TcK9roA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8658

On Thu, Oct 10, 2024 at 05:33:20PM +0200, Borislav Petkov wrote:
> On Tue, Jul 09, 2024 at 04:23:02PM -0400, Frank Li wrote:
> Subject: Re: [PATCH 1/6] EDAC: fsl_ddr: Pass down fsl_mc_pdata in ddr_in32() and ddr_out32()
>
> The subject prefixes in the EDAC subsystem have the following format:
>
> "EDAC/driver: <Sentence starting with a capital letter"
>
> > Pass down fsl_mc_data in help function ddr_in32() and ddr_out32() to
> > prepare add iMX9 support. iMX9 have a little difference register layout.
>
> Since everyone is using AI nowadays, you could have it verify your commit
> messages. I did this:
>
> | ChatGPT, Please verify and correct the grammar in this english text: "Pass
> | down fsl_mc_data in help function ddr_in32() and ddr_out32() to prepare add
> | iMX9 support. iMX9 have a little difference register layout."
>
> It replied with:
>
> | "Pass down fsl_mc_data in the helper functions ddr_in32() and ddr_out32() to
> | prepare for adding iMX9 support. The iMX9 has a slightly different register
> | layout."
> |
> | Changes made:
> | 1. "help function" changed to "helper functions" for clarity.
> |
> | 2. "prepare add iMX9 support" changed to "prepare for adding iMX9 support" for
> |    grammatical correctness.
> |
> | 3. "iMX9 have a little difference register layout" changed to "The iMX9 has
> |    a slightly different register layout" for subject-verb agreement and
> |    smoother phrasing.
>
> And this all looks good to me.
>
> With all the cringe we all get from AI, I think it is very useful for
> verifying commit messages.
>
> Do that for all your commit messages pls.
>
> Thx.
>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/edac/fsl_ddr_edac.c | 62 ++++++++++++++++++++++++---------------------
> >  1 file changed, 33 insertions(+), 29 deletions(-)
>
> How did you test these patches of yours?
>
> They don't even build!
>
> drivers/edac/fsl_ddr_edac.c: In function 'fsl_mc_err_probe':
> drivers/edac/fsl_ddr_edac.c:538:21: error: too few arguments to function 'ddr_in32'
>   538 |         sdram_ctl = ddr_in32(pdata->mc_vbase + FSL_MC_DDR_SDRAM_CFG);
>       |                     ^~~~~~~~
> drivers/edac/fsl_ddr_edac.c:38:19: note: declared here
>    38 | static inline u32 ddr_in32(struct fsl_mc_pdata *pdata, unsigned int off)
>       |                   ^~~~~~~~
> make[4]: *** [scripts/Makefile.build:229: drivers/edac/fsl_ddr_edac.o] Error 1
> make[3]: *** [scripts/Makefile.build:478: drivers/edac] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:478: drivers] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1936: .] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
>
> Before you submit next time, build-test *every* *single* patch of yours and
> test the driver with all of them.
>
> This should not ever happen in submission.

Really sorry about this. I need debug why my check script have not found
this problem.

Frank

>
> Stopping review here.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

