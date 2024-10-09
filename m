Return-Path: <linux-edac+bounces-1989-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602679974EB
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 20:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B141F23DF4
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2EA1E049A;
	Wed,  9 Oct 2024 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f1iZnrLR"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2049.outbound.protection.outlook.com [40.107.247.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34A52F9E;
	Wed,  9 Oct 2024 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498686; cv=fail; b=UdIKVnCSpRwoToazIHGY5s/ErW60gBO6AEeVRYQ+avuJrt91vsjiQR6I4Tksz3w/TgP5yth4iUUAGTLfQ+VdAbpffL0AXRJE+0kAa3c1T+RqXozqKRdrOPocwpirK58Vs8bd2rv1nmQKeJfI8JGtMpcoaQQk/M+obIdWAmy9xyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498686; c=relaxed/simple;
	bh=JkxzG5DKrVT++Wj8EVJFfs0vuD9A85zGejCjFI6zwJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kmzWPjeVJZy/L9eGLqAlUvs0Rk1RxsVqX8JKtfAtWmoyvNDMLbiLOIUGkkbeOFJ3tB6yEDDgyEQ283x1LN4JkG7NeyhyJeSSkdOPDj8G+ejAQ0WhDCQEeofN65UWw+Uj7EKqa9m5Lno0YsgN5Sg4W3bdJ91v9WvDFilMqZ9dEhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f1iZnrLR; arc=fail smtp.client-ip=40.107.247.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VERS9tEWpDvswY0a0OHGvGeyp+o3gaCp1St8PUh2C8TenY0bwBKW3HFBhyvWF0E+lMq2BdNLppEk2HRIPXVZzgCfIs+i1y5yzxMPo2mEOkUscDOCjM5qi0L+pyPykPxJmTXEapqUHzjt9RYJt8bs/yXhXV+3/5bo0FcfNDFBYKGxSzmYkv7XCKilJuUZ/twhJirHytp6qDOea4mwf55iEotSRduavmmmbpKClC7zh8+Igmt73Zc5pdDVuBx8RRuuF78WZu9F1HeV6FucxcJj5b0hKHtTUro4VTmIjtEBscAA0mFTSbiYlGTAmB2+fn7qHVvucAVsE3SPyDwPKY+/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fa1DOxbN0j+qUzbGKHQhuk+JMIvo/iX4rkICwsrc6k=;
 b=Y5+7bp7JLLKG+n5vY8JL776E5A5QVrqpTwX1+ak2CwM6NLmW8Zg37fBmgk+LkARPdhcLDU1cH0dHRMnlzM0xgZRS0uhxEiQViOXTM97I4m/qz+JwmuOJHQJKHpuYlPxNVB9YaRdNsDaT3LiS6yPxSKyRfB77qZaQqszAS7311IBqS2wmDdNYVwzPJx/V0CUO3Ebejx42h5yrkuICBCiqdhKUMh4y3yojI1/WozR5Qv8MgZ/XYkajaXCnpoSLRAgqdNFG+iHejh5TGGwqwB/vav1sYYNhmAAqhGcUupqJ0hqSjofN8UObe4J67k4DmLm+ToF0gWu8fr7XBCYrWkQ4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fa1DOxbN0j+qUzbGKHQhuk+JMIvo/iX4rkICwsrc6k=;
 b=f1iZnrLR8rcSqXZ1bSGES6z3yU0v3PGgsto8L5t7ejfhud/BkCB7iIlIfscJOsSjZTlBZfYJ8Wmg8KTWWnzOgSgfuzE3SsklRAXOEzk53jU0fStfs5Mr8OwEeAdjlp34VApsjnRp0OvL1RzpWBm09iE6gUASCIFN2p/fXug+4Z8Qt2+65WvmD7E9cUpaXMZ/IXzDEGLLI72Iu3yqfnnp2FaOZv4bguCKBabGwkcO1ViEVaBQPA4qezV/N/KSyUQrBFBwM8qBf0FHTDj7C/63B1nbrje3CAOfHEvN9WsnxiwzJBltxDakOADoOZFBQ+6DJph9nYrJlgMY9nijAzejfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8117.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 18:31:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 18:31:21 +0000
Date: Wed, 9 Oct 2024 14:31:10 -0400
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
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Priyanka Singh <priyanka.singh@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/6] EDAC: fsl-ddr, add imx9 support
Message-ID: <ZwbL7iM2SV5cMb3d@lizhi-Precision-Tower-5810>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
 <ZvsNJrxF6TpUC6ws@lizhi-Precision-Tower-5810>
 <20241002090834.GAZv0Nkp5YKcy86UmZ@fat_crate.local>
 <ZwalsAJdaHjtD1/E@lizhi-Precision-Tower-5810>
 <20241009162038.GNZwatVpTr9rOEyfQs@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009162038.GNZwatVpTr9rOEyfQs@fat_crate.local>
X-ClientProxiedBy: BY5PR16CA0035.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::48) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: f16848c2-2159-4b47-aa2b-08dce890927e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9wNyMjkp1xA0OqGV4IYLA1/0APZkRUSllMcPk2BDqTLvqNB5XvspQOxDUWXU?=
 =?us-ascii?Q?4mYbpqNHmJOpMULoWfbbF2Uq0A69nuHd0jCxB8VSjYD/wtVL9C12ifrwPb/j?=
 =?us-ascii?Q?RVrgDr5XxwMVYiHtaxfG8ukvpf7BCac4tmCth6bAkNUp2Bkk7Ig/eThGvwUj?=
 =?us-ascii?Q?t5hPSuUV+7p5I4yOTELAQ0ts/Y388rnk6QYojBxqlC1weNjz7UQ3renF9N1y?=
 =?us-ascii?Q?8qmhRI8ftBi1hCU4GIXrYJuXmmqsEiaBCgoGtvHffL4TsS5jVGIZ0Vm+eUQl?=
 =?us-ascii?Q?UyWQufCI2FcJeoEGScceoddQKQc4jeezUmBJAHct0GoIiz6NHW9Jbk/C7hmt?=
 =?us-ascii?Q?MLqz97QYRN/nFmSPDFkpuWBTj39YYsj9W2IlyQAFPrsqW2K7P3hQRsjkLHjm?=
 =?us-ascii?Q?smIL8SbY8VV4spCiLofcXSltl831n9YGrJ9etTrKAXIPCfe9JrmTex80+jeu?=
 =?us-ascii?Q?P6a/Z1VJpHnlD4t4Zy9G2YC03XYT0s1G2+RZwwMMBasrBuWPoqfgwXf+kLPi?=
 =?us-ascii?Q?1Ca8XvPRZGI+CFtmgz+zTuAK4+55EqcwI8+n5rk5GX/ezRNTXmcUUKWgG4I4?=
 =?us-ascii?Q?noS9+OLl5MyQDTU69olp2BirBhmYYs/zgSjNECOqML8da2k1rrzDHVIWEf2s?=
 =?us-ascii?Q?EFUaYxE9pUey3myDpTQaAzvUifzVOiTr8+tFBBc1kjHx443GYhz66ceFgwhE?=
 =?us-ascii?Q?OEEwZCy+Reve70eKJwNWXHu7Wr1jQBPVHpLjtsbgO2y1t5ckG33Pj6TfIJmy?=
 =?us-ascii?Q?Ii9CpRbSyAQSdotzd+UkJASxWEarLN9NH5qWhtUtIQp8kEuiyzKVNVeNIOE8?=
 =?us-ascii?Q?bQ6XnYZTWD5WAb0XCNZQVy9klc5CUY7z4wy4Bsz9w69B6PcAs9BUDSMoMUTW?=
 =?us-ascii?Q?w68yU0gN9Ts+mbldZBaxhpGyeFEhk9ZrnJHmJMlhQkJYZ4L3/CNHDsx+onV3?=
 =?us-ascii?Q?hlHui5l2HM+fI8+31jX4kriE5uhZ34RrbBhU2+hH3N+R4hzvI/b+kGxAvF+V?=
 =?us-ascii?Q?PlYa8J8TDTRNwkEpqq26bi3kMD/cskkUdwejoUP6HHsf50qKccqXvxH0j3y7?=
 =?us-ascii?Q?IRP1dJ03tDhyxxwAlqtEo9xnGRZjJB6EnTjM0XKRggwMNaEDH6Q+yF4F3NKK?=
 =?us-ascii?Q?XMjSRcTyiCNvXS6Ac5ZeRzaanrpCog+peXA6Vu451HkTNpRn6wWgvTGLV/k0?=
 =?us-ascii?Q?NjJAON263vfraW0PCj/wiVOTl9mlqKNHER/pQwtN/h69LDuqhLaHduh9nYIr?=
 =?us-ascii?Q?cb8LFyWgxRAnV+9vAYr/rvCJIqgWRaAPG+NhbhVlE8lxcMUORMdxgY7VI53s?=
 =?us-ascii?Q?rpSYDdp04YgKGq1DOb4N6WTOi9cT1mJe5PYMtC9mSy+mSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nVKII3DoOBux2gXTH9AWapBjETo/Evu2VO9qvT/9MNNrt7sId25mztcRq2xE?=
 =?us-ascii?Q?BRY9OyAr3jaEFh+w5nqcK627cXsPUkD9FzFx3krRbLGI2kKte0SToZXnhe42?=
 =?us-ascii?Q?UyIImRp9WFxJf4kUzYUaXheB5k+Gg350CG8DPvUkl4KbHbsH+Ir1ZbHUlEXr?=
 =?us-ascii?Q?uYUFUG277BXsw56MWLbr6AhF68zl+RuMBhpY/l+oLcaKsvwxYGvqPjOn/mTM?=
 =?us-ascii?Q?h/vXU7S0i7z45DWgbTXubEZjcqXrTzFXFS/Xt3Z09d+ORHvXCmxYD/ZJlpQo?=
 =?us-ascii?Q?2sOBptiPL5JpkSGPl9Kq+onJpvtvjl8SRL47K9md2+XrYE2Njtqx5R5dlMt3?=
 =?us-ascii?Q?DFp5ABlTt9IohuoiyyrGpFaKwr4F5v3BDVGKj8bXiXm3ziYEGDPMQ/1Bb7hM?=
 =?us-ascii?Q?lOUJVE1II9NU43hUiuW5n/WT5PonoIgdy4F2GFUY2hxpilu5bJu6qPND5kwv?=
 =?us-ascii?Q?jjWo1fwnrH/biTRwkxu0OxgjWZwghfL9vZwRREKa3lLAUhxdG2EeL3lWAC99?=
 =?us-ascii?Q?rzsz2fO0WWm15T9y+vO4rUNlcZ1KRQ5JKHCy/Z++R3khczoKUs/9AKP8gbnS?=
 =?us-ascii?Q?1Zzp4N2XD2uBo1KSQygBrSym+CObvdxM4YqZGxTWdIKQKQ7qhlHQIc7ro2+X?=
 =?us-ascii?Q?8qYqaBCdGrTgk9oydMPV7G5txnRmHvzCYD9m5/hCTAtNEmiksUd1wm0WGBEp?=
 =?us-ascii?Q?diQdLM9nYLZyGyyBT1CDl4YJr47uvLJJnLDEbp8INYnP/WowUsMPn5dFt/77?=
 =?us-ascii?Q?uFND+F4t/wwB/P4YUq94wPoiRBqjTby8inWye6iRxhM0O8E3ajTp4juxmWYm?=
 =?us-ascii?Q?OwC4Wao4tZcMfwY1xmqubrp+ePlSoD8KtjiFWFqXFocGYFWZh51Ya42OdQaV?=
 =?us-ascii?Q?qcVyRy1qSFWdO+jcoSgQNpEdSRNTD+3k2WgR1OHAGgpJQGVmzt6NZyitTs2T?=
 =?us-ascii?Q?ebWo47B68z2LViFH+UqFUCPJRBZ10utCDvEyvHZj6XMmUv4iBOgjNiDcFZtd?=
 =?us-ascii?Q?LVGFrVGBpKp3vn4JKLXyB4HEjo5d4tUM32h2+Av+R8hfuhvmoB5z+wNSzXqE?=
 =?us-ascii?Q?vDJ6kI3Z8L9EfTZwgccmJaMC1pyZ323GPYWMUfv119kQJCw/Ukpq9Pqx6RCV?=
 =?us-ascii?Q?BXgU5FVA0aItg19DrYyRSPDOaB16gmfKoRqdvUbURdI706QfIB5hkrZCVHDu?=
 =?us-ascii?Q?pxo2lfCKKL75yeFdYQvf9xiIcWeXfMWy3KscMmyefV39jyLWq66jaL1/BG7i?=
 =?us-ascii?Q?czVnHwY8Jk0y2AqEDkWvz5XtLIg7YOYKb2bg7AlB7KyrHuLz7J6bB6NgYXV4?=
 =?us-ascii?Q?XnEmgeWHmB89frtzpffcEnl9YFQMi0lXn1uZEX3svwAkCnClFOYgLAzRPBXc?=
 =?us-ascii?Q?gA8t7ygUSAsDG1VkZtNKPMHruhQTpgfOZTFte+x6jPY5xPya81PjR29ICCLK?=
 =?us-ascii?Q?yqHv4XdbUUucL28GeB5bANNoVITrWt2V0VgyL/NKGFd7LgcpmewPiPZeLYlq?=
 =?us-ascii?Q?lVY8hFJQ5qkBL+yHA6uJFGaJYTlwMcRSYTgxHrl1E1YWMhtCPczxSdO5HXB5?=
 =?us-ascii?Q?q5w1jpwbcN3RoTmQYLE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16848c2-2159-4b47-aa2b-08dce890927e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 18:31:21.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOeLtrEea3gdYpjH8cELyvgfQFpSqye+auZf9RgdWinOSgArAOVto1ei81sOwIttH/oD6AY3HBj/2o9jlbmhLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8117

On Wed, Oct 09, 2024 at 06:20:38PM +0200, Borislav Petkov wrote:
> Frank,
>
> On Wed, Oct 09, 2024 at 11:48:00AM -0400, Frank Li wrote:
> > Krzy already sent patch remove him from MAINTANINERS.
> >
> > Do you have any more concerns about this patch series?
>
> What are you actually asking?

I ask if there are any other things to prevent this moving foreward.

>
> Whether I should drop everything I'm doing and review your patches?
>
> Do you need to read about the kernel development process and when new stuff
> gets queued for the next merge window?

I think I understood the process since
git log --oneline --author='Frank Li' v6.10..v6.11 | wc
87

It is first time to work with EDAC. The difference maintainer has differece
method to collect new stuff.

>
> Let's cut to the chase and you explain to me what the reason is for you not
> waiting patiently for your turn to come but keep pinging.
>
> So, which is it?

Generally, 7-10 days is reasonable frequent to ask. Contributor also takes
their time and efforts to make kernel better. Why they have to endure a
questioning or accusatory tone!

These patches was already takes more than 3 months. I ask just because
avoid to hold for the another 3 months just because some none technical
reason.

Frank
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

