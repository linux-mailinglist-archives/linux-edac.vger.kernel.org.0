Return-Path: <linux-edac+bounces-2192-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7F49AB731
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 21:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC51E28567E
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 19:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A721CC16E;
	Tue, 22 Oct 2024 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QD1ze/Nt"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2068.outbound.protection.outlook.com [40.107.103.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF914A08E;
	Tue, 22 Oct 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626782; cv=fail; b=pM9YuJb54VJN29jUMlPUc+n85orvHneYJSgMkFsWIHNly5IV0pYKt/AazAtaalfS9SlMAv770Dqa0WgwXrx2FKRH7s7V3yuDn6ecZ7Dr1RmKr9yNgdafFpjBx+6S0bJ3E4f/g/4fSN7Z4tNDk5oyLLE3KkwTCW7yXffSxH3TZeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626782; c=relaxed/simple;
	bh=Lz1RvAREQ+JC805+PV+r2KBzVyqF7y+magYPyMmEj5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q3QQQxnsEH5T9b56zqCvgdj9Qm/uYFGduESQuPZpCExRQ3pqD+DThDyOa0oMftXrm2SOSR41ihnwVPZjlAhcAE0rRx5mKzubOteJzM25E1HJ2yXAVi8KtbDfDcziI9uzyMDIutkUdqODwOEORxQBS0IpvJlwa1ub1z8tvNKGflw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QD1ze/Nt; arc=fail smtp.client-ip=40.107.103.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySbDq5xdTND23d8gJAAxvPqqDXPxYNX6stG6wSHx5NQrXyJLlDlGOEpvXdzGtjKEkwAbB86NrndehIYGHf/xgVlLfUSsqNT9J97uJBi+ZQJFciDUYGNr6hXenHRGBXstRID2Tlxsy5K7OYcoBhIpdS91HoB/UZpV5YY+s88StlYrUhOoLG3AMFMP93HjC5f4lS8qUCY223xNfZ7N0AoK4wP/O78pppxyZVwdRCZ8wdd505mp+2jtvF/6E4MoBJPMA26FkNvhwcY47EMetbC3SZfgKZgd3SftQo9fe/mqxowTccanCl3B8FNwweWWDlp9c8fhu41ia96lfjqAz9Uv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNR7WnWn5dV0RYlNtIvp54N2a7IZ5Oiw0DLpsTHSUuQ=;
 b=ClvJBxIWoBuXyFp/mvOBu/nAFd3IuaBWfshxQpelDAJGKgepPRDde6e4Cd5v2SqtryeZkRsOEUkk2Z7F1pq7JzXV7viA+Mq3sVtKn9IU138wGtU1jgfUidHcWSzzm7LuBCK0mtpIvvmHX947AreYvZJbIqM0NtoebNArW/OvdIy0G9Ijak8M0oxPmRwTCM9M6SMzqrZ8X25ll65i+K33j2W5/8JwDq5U+l0bBFR8tVloONqBDv7HmOljqqprklA7Ui773eGLvkf5Tt0/vElnaQaD1Sh22dQ8fXereutN6J/404m4iMtAp66EVzJWm0TNLo5E7NhEmKudFeR5YCMq1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNR7WnWn5dV0RYlNtIvp54N2a7IZ5Oiw0DLpsTHSUuQ=;
 b=QD1ze/Ntb1fMnMBItVkpSiCi9AgDPrEx/nGFqi0crFUl64NFZ+DkjqI7MHDMl9CaMWQ3jlBuWHYCVooWEpZaBIkJ1VW0pK0+hYTETjDk+WQLvOYMf4sAIEhuev8q+aoK5x38Vc4w8zDbyriNVegSb0Jy9sTxZoTeJPGbg/z/5FOqqJGEzQwdn9XyPte0Dleo5oyapRxJRKVjwHbMgrt5wzzK5s+INlIrWJlThRu6x5u+AcfXKm7II+o3FEKP21kpk7T0oyP0dQR6aNvTIbYIW1N24YxPdaoleT9lcmd8qM6oG0jwAyIb4iv76Rd1uXRLm/6xjIH6F2i9EpGhfng/uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10998.eurprd04.prod.outlook.com (2603:10a6:800:262::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 19:52:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 19:52:56 +0000
Date: Tue, 22 Oct 2024 15:52:46 -0400
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
	Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v3 3/6] EDAC/fsl_ddr: Fix bad bit shift operations
Message-ID: <ZxgCjuxbeaMe8WpT@lizhi-Precision-Tower-5810>
References: <20241016-imx95_edac-v3-0-86ae6fc2756a@nxp.com>
 <20241016-imx95_edac-v3-3-86ae6fc2756a@nxp.com>
 <20241022094429.GFZxdz_QNHHr_DCPp3@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022094429.GFZxdz_QNHHr_DCPp3@fat_crate.local>
X-ClientProxiedBy: BYAPR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:a03:54::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10998:EE_
X-MS-Office365-Filtering-Correlation-Id: 6334b3c5-0ea8-4841-4a3d-08dcf2d31f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?itXQ+YR4c5SSpNdE6Jer/m2PxxGZKFHFSTGIPjPogs8tGRYg9kylTdbikkwl?=
 =?us-ascii?Q?8yE1b5YRx5WUrRz8bY1Q6hCf/I6FjmvZTHlyJZWqoi6NNXkZsbbzyTdGa/6K?=
 =?us-ascii?Q?08Uw6eSZF7Iy4rehZA6VxahHMK8FolPTxO5W3PU2j4nFRX144NACiyQ6zITj?=
 =?us-ascii?Q?UE/5t+6HDSbCc1oozohDhwYSyRXYrP4T0oQlalCkeIj9Z/TrdF2NORu+FW9A?=
 =?us-ascii?Q?PjRC6XJ+4lipfEbO/Rtr4mydptTspytsQh7FkW4K0du7+CnOET9jcmB3OnAV?=
 =?us-ascii?Q?IwLPIxnRgHOAkhRFlhsKueXBFYXc5NFfMkzEzVXLP4UEozHY7n/CfVtwZ5Zv?=
 =?us-ascii?Q?l1jKBM6zRlzv4+Me1jhswQZo4hJIElsbCUg/M5kRtOWsUzPRubconcWLuTTV?=
 =?us-ascii?Q?Z2LLMpbJxP6NNiN7xMrhlhtcsiiC9KLQXdYN5V3KozerMfNwmmMgsc+NkmCB?=
 =?us-ascii?Q?x9v7c/tHTAc7ED7XuFGdC4WpIAQIt1GSgFTZ2ezvBB2LH0pvfSAqKzHBKk3o?=
 =?us-ascii?Q?IGSbbyZxqaL4QtMMxQAtlMi1gpuYY+Pxcab8gGjmLTSUyZNHWDLV4UQLJOJF?=
 =?us-ascii?Q?DZUqfqsw2YBb5eJS+J1yTNC5vUR4q9GvkE9iIxWgXs8y47qQri47d3F4H3V1?=
 =?us-ascii?Q?H685XPTKGpcQapG6Nfy4sKSWeG8lOZCfUBEru3w/vIPPGJv/0yyQ5JFIHU6a?=
 =?us-ascii?Q?l8sqom21DwzPofMWXCG7v9BBv4vKmyHVTNqEgEGAqyki1Ma55ysDVSOGJndC?=
 =?us-ascii?Q?g2EcQcMJ7wrEBW7gkI/GXx+rn4rkfEPCkHUNAJ+CCuXZcuox2QgV0HPBk01c?=
 =?us-ascii?Q?uJUlwCOGLjOlF1gwYY4CJMtM6PLxqMy2mZvXAfognUpnJwcNY/cIDNhgm6Bx?=
 =?us-ascii?Q?3QnRXpLiN7FVY8DdIaDKemm1aG1b1CfDIVlCOXNgqqkIwe/ytUjQFK00qIgM?=
 =?us-ascii?Q?q1cT4l2mn0E9RHY0gtGQzUc4yM2z27y8vsIJyJyAI6l1Exrg45/WfxRSXoy3?=
 =?us-ascii?Q?bu7bwxYnoRTEEYCc1KO0U2rAUAD3tMocvwW0MVn9wkdS0b/fz1GB/D9sLfcp?=
 =?us-ascii?Q?Sik94N5gjI1/1rVGH0USLuoFw/0DBLjXx58yZ6/bwRGruTFKx1HqCJN1ZUzU?=
 =?us-ascii?Q?DdzI13DMOrZT+YEbY4Un9oI6inPZKtkAip1M0joAoxbelK2LBJ5HbZd5Tocn?=
 =?us-ascii?Q?/phkXMh0aE2P1A+jpAROlMrBiElnPu4dMAvkgpiO5gJvMzh2Brvzz9xnmkh9?=
 =?us-ascii?Q?sKU1pK0mDOePSxjYc8Hl/uzGJwurLAkcPPV8QElMBJcE7NkIb2vtoVkLyTA4?=
 =?us-ascii?Q?EM6iVE5Wh8WmoOy+X+Dcb7Ya5G19wnwgfzgw+BOniVEnTu40DP7uHJK3ngry?=
 =?us-ascii?Q?b2dZKUl1JK3VjtMZr2pEOuxM5eQN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dF084j94R48AtqcWfH5okLWPbYDjNvTnGml5XXnyMaP6OUrZvwPefeHNwXOj?=
 =?us-ascii?Q?M/ryGzEssn4O2U/yfTES9IJKDJ4AL9vsAEUX23eaelpn9A+PHg3XDGkOAVA/?=
 =?us-ascii?Q?3pwlS0GMth394PP7sY0f1RZcWpXPjvgl4B2cAJyKrbT26C/fTJ/D8TFRcl9z?=
 =?us-ascii?Q?gRG2d2Jof+rxiIZcJvXkTYx/aAG3Oevvoj1dhYk2mHdoOgtgiA/rXE2ekikf?=
 =?us-ascii?Q?HezEAUdfGZITz2dgclV8dO3CQ+YizCMZu+31PlDaASniuzqcTMeNVsjwmAgo?=
 =?us-ascii?Q?J+CHOETFusEIYIy7f38gTY8SJE85pKP8t0Cfo/jXwkWknCZ6zPxSbQ2flEHx?=
 =?us-ascii?Q?nQ/3c/Ya08b7zIHWQ/L4UuFyFAkeow5TrrXT5Ttspeyd32PHDcQP/FUTVZHl?=
 =?us-ascii?Q?jdl+xIm8S3npEBpmzOG5gUC2F9buGCc8ml9s45KvQMre4ZRNHwQeFeQP5737?=
 =?us-ascii?Q?QMEQGBxuei6Bhq7ICS5WOx6Wgn1D6pS8ZaQscfZ7xie2hCdSkKuzeUIbf4mQ?=
 =?us-ascii?Q?z5MXO9OaZPNFgJFm2zTW6jxmWW31uS7PGnMjZswTiXtgULmjsakkS7O82j16?=
 =?us-ascii?Q?4cnFcJWs+a4W5WRGQvmGKFI0Bp+Q6MphSGdt4haadz7FJ0VwlgxREnephobM?=
 =?us-ascii?Q?UwD+qagrm8/acdc8A8hQJ2PvHcYdZl2DjPAW5J5EEmR1TvNwd/UEXb3oS9Tv?=
 =?us-ascii?Q?11HVMWBSXoq1RsAUSjta1mC0u0Z7RHE3yHlY86yFXNKD4i5lE1HbqTtTJalA?=
 =?us-ascii?Q?Gnkv0Hhx2slLkR3o1mnVLe446R0ZeDIQ7Rga+lcYHFvPWYdAgsa3EIY4X9Yj?=
 =?us-ascii?Q?X8tZYmyBJADNZ3LtHziJI4pjDX/GH62MuMggMIlvk1n4esPNgzF9/2ufyXqk?=
 =?us-ascii?Q?ukfyytEecFlvQXKgItwbCcuwB1D0bviF0ie54l2VErB2zgR8bWqnvVYOrF6W?=
 =?us-ascii?Q?krgr/m6kcwEdgepML8J7xwqUt0ZhEma1xf0QspVZX44MjloynERfjtQfJjr1?=
 =?us-ascii?Q?siSjYAQIAr66DvJKKABi+VIyhvO2hLthGmkENKz3N6cdONpJ71S/E87ROuia?=
 =?us-ascii?Q?T05n6CHAkJ2RYm56WOOgfS5w8HKI/mh7e/9OthxScBabntNKnzD0JX5WxmPT?=
 =?us-ascii?Q?Mmaz+3JbNhm5czGsPOT4QREIyNTFKq33qDaLZY0R+UQNIRVs80xE+Zomc0Ax?=
 =?us-ascii?Q?xt+BXDZr+TjzbxVdkJNboo68ze58aGL72WDbJEpqclhBhANVef5IxLf+1xxe?=
 =?us-ascii?Q?RQZ4BKQi4p/dAeKvPQShqsfGTXQAg8e8gYiRbQoP8OZe2zRURVKn/rTG1nJk?=
 =?us-ascii?Q?IYXZvr1zhSvSSjEJ7mSMdkPPjmCUyu/0//HsH3mCm6T4fPxANWv/4cYaFRlW?=
 =?us-ascii?Q?t9TePg84az49dwFpdxpvRzjvQDrq0yIKYha1mI88Kx27MZjG9W4KpBU/PbKl?=
 =?us-ascii?Q?eRAKkpmOdKVyUvxjnFX5f3hyzAIVlCLjsICK2iN68ljYqQ2BsZ0eT+UcUcPk?=
 =?us-ascii?Q?6G2mzmeEMrBl+MOoT0xbFQDOgft7fs6Xn85DfixpxStl5n4LyFXVBPwAhJVr?=
 =?us-ascii?Q?/1FI2tX+Bs0JWe+FlU68jvO3pCj6wv3Tv04lZ4im?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6334b3c5-0ea8-4841-4a3d-08dcf2d31f5b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:52:56.0065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2j/XaRQnrJm/Zr5/cNMjjZtPUwMwJyT1Kc4i0dngiMOKCnF0ji6pPHujgAgOXJkVAvWNvyjH/gxUi4cBzcZ8Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10998

On Tue, Oct 22, 2024 at 11:44:29AM +0200, Borislav Petkov wrote:
> On Wed, Oct 16, 2024 at 04:31:11PM -0400, Frank Li wrote:
> > From: Priyanka Singh <priyanka.singh@nxp.com>
> >
> > Fix undefined behavior caused by left-shifting a negative value in the
> > expression:
> >
> >     cap_high ^ (1 << (bad_data_bit - 32))
> >
> > The variable 'bad_data_bit' ranges from 0 to 63. When 'bad_data_bit' is
> > less than 32, 'bad_data_bit - 32' becomes negative, and left-shifting by a
> > negative value in C is undefined behavior.
> >
> > Fix this by combining 'cap_high' and 'cap_low' into a 64-bit variable.
> >
> > Fixes: ea2eb9a8b620 ("EDAC, fsl-ddr: Separate FSL DDR driver from MPC85xx")
> > Signed-off-by: Priyanka Singh <priyanka.singh@nxp.com>
> > Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
>
> You can't keep Reviewed-by tags when you change a patch considerably: Documentation/process/submitting-patches.rst
>
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
>
> What does that SOB tag mean?
>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/edac/fsl_ddr_edac.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> > index 7a9fb1202f1a0..846a4ba25342a 100644
> > --- a/drivers/edac/fsl_ddr_edac.c
> > +++ b/drivers/edac/fsl_ddr_edac.c
> > @@ -328,6 +328,9 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
> >  	 * TODO: Add support for 32-bit wide buses
> >  	 */
> >  	if ((err_detect & DDR_EDE_SBE) && (bus_width == 64)) {
> > +		u64 cap = (u64)cap_high << 32 | (u64)cap_low;
> > +		u32 s = syndrome;
> > +
> >  		sbe_ecc_decode(cap_high, cap_low, syndrome,
> >  				&bad_data_bit, &bad_ecc_bit);
> >
> > @@ -338,11 +341,15 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
> >  			fsl_mc_printk(mci, KERN_ERR,
> >  				"Faulty ECC bit: %d\n", bad_ecc_bit);
> >
> > +		if (bad_data_bit >= 0)
>
> >= 0 implies != -1, right?
>
> IOW?

Yes, Your code is better.

>
> diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> index 846a4ba25342..fe822cb9b562 100644
> --- a/drivers/edac/fsl_ddr_edac.c
> +++ b/drivers/edac/fsl_ddr_edac.c
> @@ -328,24 +328,21 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
>  	 * TODO: Add support for 32-bit wide buses
>  	 */
>  	if ((err_detect & DDR_EDE_SBE) && (bus_width == 64)) {
> -		u64 cap = (u64)cap_high << 32 | (u64)cap_low;
> +		u64 cap = (u64)cap_high << 32 | cap_low;
>  		u32 s = syndrome;
>
>  		sbe_ecc_decode(cap_high, cap_low, syndrome,
>  				&bad_data_bit, &bad_ecc_bit);
>
> -		if (bad_data_bit != -1)
> -			fsl_mc_printk(mci, KERN_ERR,
> -				"Faulty Data bit: %d\n", bad_data_bit);
> -		if (bad_ecc_bit != -1)
> -			fsl_mc_printk(mci, KERN_ERR,
> -				"Faulty ECC bit: %d\n", bad_ecc_bit);
> -
> -		if (bad_data_bit >= 0)
> +		if (bad_data_bit >= 0) {
> +			fsl_mc_printk(mci, KERN_ERR, "Faulty Data bit: %d\n", bad_data_bit);
>  			cap ^= 1ULL << bad_data_bit;
> +		}
>
> -		if (bad_ecc_bit >= 0)
> +		if (bad_ecc_bit >= 0) {
> +			fsl_mc_printk(mci, KERN_ERR, "Faulty ECC bit: %d\n", bad_ecc_bit);
>  			s ^= 1 << bad_ecc_bit;
> +		}
>
>  		fsl_mc_printk(mci, KERN_ERR,
>  			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

