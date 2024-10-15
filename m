Return-Path: <linux-edac+bounces-2080-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E77099F142
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 17:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A081C210A0
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 15:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032B81B395C;
	Tue, 15 Oct 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="igx6CX1K"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2045.outbound.protection.outlook.com [40.107.241.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1CE147C91;
	Tue, 15 Oct 2024 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006318; cv=fail; b=uA7AOVlgYgsGw+fmWX1aRatOTfXpoXIV0pPQEf1BNwI+Xedt4x6k8NZ22G+Y5+M8cDA5SdLxTo+tdtZ9g0mznR6KmWOEgceCAOVAnEBAmY30UNPs6vQ2BlrZpA4gcGhhTy8aKu/akannzF4zetIovBWV/LSE9hfso3LJ3AG3D/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006318; c=relaxed/simple;
	bh=aou9NJ0cbX7tMiyW2h/oxp6yIREO4/WT1dfu21iG2LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gl4jZFGjZ5N5zcowA0cELewEKwLPzhG59cB1MIdJkVXbK0Xc+STe1hN8UAhAdyLAx4vAS1mAtrP0s2auhkTpbPr0UOCwJaBYdH3BABfMtypgZl/Q6W3Ff/QvyLNeDaqE8XLZBcTmDBqJeY2+fwd96LOUDgoGGjZ2sBQQNRHXBiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=igx6CX1K; arc=fail smtp.client-ip=40.107.241.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfBqmJq/tBdDwKaXi0s/L2XsQYroMBt+BcOLEAHJa6fkh2B7KpuaOLfmvARxwVCngRTZ290YeDvPFu9xpD3jWiAzUaT50aATUIjL/G0pCMFml8+nnWweBAEw2giSKP13XhNKmZgrgDxpDzd6NQ+vXJ0yvIJLh31MQkexfAuZanRniQRHfNk4mzM7KBdTz9p9sfQaotNTi8bF4wHQgFqb4cEA/px9Gid8ew+4UQkPbhG1XvBGFSA7J2ia5MoKGvSLofKN0MaTDlH5CVEFYR+uOymGCpVjM5aiyKSNUb1DuPj1SU1uu6DCYUUkyj6qRUlPlJGhzw28m7nZYB+H9r7pRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acKWBDq/Md6ZFSu5o4+goBL/kekpkbKGXDJFsbVyt1Q=;
 b=fCrsmrdXYme4IEZcqAkOHYWL9lUFrVHHEWGnz1if+6dSl/USxiVfJyj/32XY435iEuGKZTeD9xIGY8xf33OOY097rafcevToW2djJSa6r0W0bgcsu6ELEOZR9svbMbMiMagJa4RFyAv/6mwjgOLDcEuDidXWvtwKFjynzMxUcUrsiVUmD3F5gBxikn/l5sStpZAMoMY6T6aZdfMpSTrMyohhYlNmDSnDMkPXh1qR/xp84yQCs94CAxK9leExnKMc9ZT5Y4rWRSthwIMVguxs+n6hrmy+MuUR30ZwJINbcGJl/QnRACD5kCmyv5B9zhyCwzJRjIWnaKSkUPej0LIxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acKWBDq/Md6ZFSu5o4+goBL/kekpkbKGXDJFsbVyt1Q=;
 b=igx6CX1KxJC7e2Ts5+knJKGR58mBfwR8cVr5r+1oypHyaaZZrFzCgr3eFM1H+PQxoLYM7omey8I3cQr8+XCtBfviGeiPIR9B5q2HL1m1HYSevq7kDQfhD6j7JPbKN1jq2hs3BxUrs05giPNknUfVG91ae1I6q7VRzQKUH4RxUg55zw12LuYVkgsFIhykG/hzXg1f4QiViy0wU+nLbo/tJ4kqBPYQFZKUJMvrQGpUPFNfTMUZTrHG1OSPR/RlYgtCT+aTRJjbXkvyNs9zbm5ZjZikR0AJh7EtdRkclkbA0oKFMqNyLgdlW9x9mCcABf0BYuY7qwIGnttobA7jlsJeAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6793.eurprd04.prod.outlook.com (2603:10a6:10:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 15:31:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 15:31:52 +0000
Date: Tue, 15 Oct 2024 11:31:41 -0400
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
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Priyanka Singh <priyanka.singh@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 3/6] EDAC/fsl_ddr: Fix bad bit shift operations
Message-ID: <Zw6K3dlsnlhV3F/6@lizhi-Precision-Tower-5810>
References: <20241011-imx95_edac-v2-0-011b68290951@nxp.com>
 <20241011-imx95_edac-v2-3-011b68290951@nxp.com>
 <20241014181647.GQZw1gDwIhBdnFnleH@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014181647.GQZw1gDwIhBdnFnleH@fat_crate.local>
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 05cd5fec-e903-4c4e-a294-08dced2e7e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SWtfAcgUJ93XENjic/NqEHbH3aoXUQ6SQaCobJbSSVefjRN6aY1n2w1da3SB?=
 =?us-ascii?Q?MF26bkqEOz8iEab3Ypk/kglYTq8hLHe0JN5IrstqTfla5pwIJVt8ElhTaeg1?=
 =?us-ascii?Q?KhUWRnmNAFbltQCy7MU2xv3pz1rdaPHs32AuffarPcsCPBHRM9OzJ0oraegi?=
 =?us-ascii?Q?cg6iiKVCDNkWO06wkQx39wMM2xA5/h7V9ZrDhHYjKyMN9b4puNVf8GnR1DAY?=
 =?us-ascii?Q?4uAd9sBm/8usc/t6S4jMm/yeTcuq2Em44inYOzdleLUftiAxYcogqPDsM2fR?=
 =?us-ascii?Q?+ytjd0gnSIraRJSb9M5YsSMrdyEH39dusmvtOI1EQqDP7PNe6YVzghCGepym?=
 =?us-ascii?Q?m6kUws3iFVTVspMZbcssqYdx7fTVY9x0MEHeoIrMcJ9Rh1ghbExdDH/EPyIo?=
 =?us-ascii?Q?GoKRqREKJ0CGgDN9x8K2jqNShL/5F9+6Xc9Ao6RU26i4TcBeYcA1NcXwlfpF?=
 =?us-ascii?Q?cYrSvC3hV0/PhlgoH4fM30l3h+ff60SHMLNcxIuiz53+CjCUDFacdFs7Tzzq?=
 =?us-ascii?Q?QQHxjkOI/XS/ENdifI4T3eWgTgPBgjy0bUWx0g00PTZjhrFM2h5Y4Z6zKFdq?=
 =?us-ascii?Q?916sPkOykSLvMvavMSIVSzoiC0Oa2oEJZxMU3GhXcBBu3UAt7nwrVt9Jah7/?=
 =?us-ascii?Q?WuLQP37bBfBn6B3JC/yj17nRwzfIIc/EvwRtB3TtwKcwHCc8gNEabEAm3uji?=
 =?us-ascii?Q?R1nU5l4DMFI97hRAXxIkyepDw64NmfL3D/AX9groxjhSDwAPHI00Umlalv5J?=
 =?us-ascii?Q?AjX/U5JgBp/qHK/DPJhmtW3hGE+7Ry3gUJeDOBiQjhEtoNZ+8v/k6Y/THI/M?=
 =?us-ascii?Q?D5659e5s8lRZe5mVXGXyTBv18OaTUhuHJYIA36HOe+XkE69XEbs+NwkiIKvD?=
 =?us-ascii?Q?9bVXfAvGHYTlUMjw5mHxe7bReFPBAnzK15+iwOvAMQXSd2s4InQ6T1YvXFKV?=
 =?us-ascii?Q?3Ox0DWCjmapyxF2AWrIXq4GnrTvLmUOPgGd+3YeHsm49pfiDvx8QNx4UsWT6?=
 =?us-ascii?Q?+VXpHttG+cKBbBoaEel7CcVpfDdm/lMz0d+knucR/i35Su/c2fRYtPoLWAoa?=
 =?us-ascii?Q?L0ntxg16ytwebNcB34MoG8PaEuMAkiPRpqjow8xHVg4pr3WzfMcdAanD/pYg?=
 =?us-ascii?Q?1CjxH57iPcwaC3rUE3Xz/xD2NLM/211g0i1YMk1rGhlIGFhDQulawawoFegQ?=
 =?us-ascii?Q?puUPsfLz7PZJrYvqbh5ffptUMfMKBr5LjP+6eL4EOtqGR0in+Zd/5Y+9gc0b?=
 =?us-ascii?Q?A8LMkV2ymORpQFpAhZ1XFqFrcsYJVhpUrCL1n57SZijLZJ+xUNfwbRjS2x4C?=
 =?us-ascii?Q?ULtrT7llAfc4jxuo6xjd0ghaPneF8N4Kx2Hugsai48hIBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fF7kTR2L0LbDGud35iGdYm1Znh2BKyuPe+Wwvl3MNmwnuQOnc6YK3sN6J92G?=
 =?us-ascii?Q?hLjpSgM8XJDgZsOdaWrk8yg2LoXuRe2yzG+0aLUyzw9/LBOQm2ReVvivsFZo?=
 =?us-ascii?Q?VCvIXZA5HR74Wm+EvULSZWEpoKajevoyhmH2BfR40/sR0VeYjZSrrhoIcXpR?=
 =?us-ascii?Q?C8GWS6YzomEVPLfFGbeaCN+UdCLaPcOxMiK9j0ic4ienAsTclB3+rCbtiiol?=
 =?us-ascii?Q?n0fHw9cM7Um9R13d1DkOn3LOfPkPnrMMo23uZ7QyfFvX9qyyG5RbOb66VRqD?=
 =?us-ascii?Q?6Rh4etypyzS7mc2Hmmgo7qtLCGX4963CBTGCdRJl4dUCz2wGSStonFjJXwly?=
 =?us-ascii?Q?FO73DqbTLEl02jKYlohEHVw7qy1QLwS8qv3Yl1KOOq3yW+IP5G9yvJfcdqoD?=
 =?us-ascii?Q?DdzgFazF7FnbKpBB+mTgsTNIcdNYbAHqM6T0EGh9bs9t6mwHmOcl1OsJjwkL?=
 =?us-ascii?Q?fRc3vYYgQ6p4ogUNOsOs+jW9++GWnewHopnvAwxcUdAQL6O4LHmkJ5J3bqII?=
 =?us-ascii?Q?51GSR0/RlV4bEK2if2UAjtCE56jN142pnvy2NftCnzLpN+g5RbT9Ut6Bhe/2?=
 =?us-ascii?Q?tDgB7BI84shhdwH7YufVb4SN8ywpp0nvK79troNkqVSgUq4DG8GC0PTJU6Zt?=
 =?us-ascii?Q?QnWIwQD+I1pG4UBQhphvYd2GE2ULY1EEZNQ6TUVAVZEJV3msVtVOaiBRQK0y?=
 =?us-ascii?Q?kvKcnt6vojZ90qc/xWZMQCrSR08FuPE+CVlxZCAAB6iT/p3FwLhq/jEE5kJ6?=
 =?us-ascii?Q?ZulpJ7aRCm+TIomT3gRGiv90RDMj2Ggv7nvluQyrmwBkF6dj5pofK1KujrWT?=
 =?us-ascii?Q?omm2UyZcZ+ymmNGBcHvMi690yt68PWcx+SYH8REIAHQCwTQv/vWWcaYnAjPj?=
 =?us-ascii?Q?LVkQoA3dWyP0rMl1ymh6NDsNQ5RU6ibw64H2hOAgigw3QLHN7TP6gXcNUieb?=
 =?us-ascii?Q?RVE1+WCtfAKdIZIGm7w4F8a1N12T2SNRAp1h96herhMcl8boRgeGB64PWQNj?=
 =?us-ascii?Q?N08kRmP3G1h0KOA5LtWyWqCRP8RMttfl+uPV1cJsulKZN1IZkGRGUntLIIs1?=
 =?us-ascii?Q?wWToR4ST/niCppMdtyJT3fpR3c52GTabYuBXaq2aGgCXKol9HKPR34peJsU1?=
 =?us-ascii?Q?rnYL/zoDpPe5evV3HLy+rWd+fNo2AjXMWjLdTWl8vrh3FET7hoVb/fv0cdAP?=
 =?us-ascii?Q?rRRBiYRj90Jld7PoI+4gqpiPwbx0Wc2+LT10VZMA+mzt93apqB1ldGZo4UQ0?=
 =?us-ascii?Q?w58igt5SlzvSauKIzyXWuVnuV9VzwHDOxonHSZeDO5l8F4SFvcUNj0/S5Rp4?=
 =?us-ascii?Q?iRHCPVzyBjJm2MXLxsXeDrPl6BlfjpOvld6xU8KWBFfPI1fqF8hFmdM1+Z7Q?=
 =?us-ascii?Q?PlVBdYE+OhhXPF8EPkQzG2zoNYzQu7WQTCb9Y2r1C5JLDmSvh8mqUvd7GpS5?=
 =?us-ascii?Q?44znyuwZBMtNAuyjh41kR1du3do8aUgVlZF1StnV/+iE9Jze9DTmBKNtZrwY?=
 =?us-ascii?Q?NDSd/tZTOM+CSNlaExdPmjKQpN39Ewcsiay/6wSEBH+aaCNkbSzpEO9nvfFw?=
 =?us-ascii?Q?iTP1wJTfLGRWMNSu8HgO0SHNK37ZzWoHZhBG6b70?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cd5fec-e903-4c4e-a294-08dced2e7e79
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 15:31:52.7089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPRWoPmw+ojmoiaGtLrbIbf61X6OAnxi2xvFBmMLLb476uBa5oW6hsXe0hSDCodAxBmi6bzBGTsUXN153n9kRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6793

On Mon, Oct 14, 2024 at 08:16:47PM +0200, Borislav Petkov wrote:
> On Fri, Oct 11, 2024 at 11:31:31AM -0400, Frank Li wrote:
> > From: Priyanka Singh <priyanka.singh@nxp.com>
> >
> > Fix undefined behavior caused by left-shifting a negative value in the
> > expression:
> >
> >     cap_high ^ (1 << (bad_data_bit - 32))
> >
> > The variable `bad_data_bit` ranges from 0 to 63. When `bad_data_bit` is
> > less than 32, `bad_data_bit - 32` becomes negative, and left-shifting by a
> > negative value in C is undefined behavior.
> >
> > Fix this by checking the range of `bad_data_bit` before performing the
> > shift.
> >
> > Fixes: ea2eb9a8b620 ("EDAC, fsl-ddr: Separate FSL DDR driver from MPC85xx")
>
> Is this an urgent fix which needs to go to stable or someone just caught it
> from code review?

I don't think it is urgent. In most system the return value is 0. I am not
sure who caught it because patch already exist at downstream tree for a
whole.

>
> Does it trigger in real life, IOW?

The problem is triggered. But the output result is correct at our hardware.
The result may change depend on compiler and cpu version.

Frank
>
> > Signed-off-by: Priyanka Singh <priyanka.singh@nxp.com>
> > Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/edac/fsl_ddr_edac.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> > index 7a9fb1202f1a0..ccc13c2adfd6f 100644
> > --- a/drivers/edac/fsl_ddr_edac.c
> > +++ b/drivers/edac/fsl_ddr_edac.c
> > @@ -338,11 +338,18 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
> >  			fsl_mc_printk(mci, KERN_ERR,
> >  				"Faulty ECC bit: %d\n", bad_ecc_bit);
> >
> > -		fsl_mc_printk(mci, KERN_ERR,
> > -			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> > -			cap_high ^ (1 << (bad_data_bit - 32)),
> > -			cap_low ^ (1 << bad_data_bit),
> > -			syndrome ^ (1 << bad_ecc_bit));
> > +		if ((bad_data_bit > 0 && bad_data_bit < 32) && bad_ecc_bit > 0) {
> > +			fsl_mc_printk(mci, KERN_ERR,
> > +				      "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> > +				      cap_high, cap_low ^ (1 << bad_data_bit),
> > +				      syndrome ^ (1 << bad_ecc_bit));
> > +		}
> > +		if (bad_data_bit >= 32 && bad_ecc_bit > 0) {
> > +			fsl_mc_printk(mci, KERN_ERR,
> > +				      "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> > +				      cap_high ^ (1 << (bad_data_bit - 32)),
> > +				      cap_low, syndrome ^ (1 << bad_ecc_bit));
> > +		}
>
> This is getting unnecessarily clumsy than it should be. Please do the
> following:
>
> 	if (bad_data_bit != 1 && bad_ecc_bit != -1) {
>
> 		// prep the values you need to print
>
> 		// do an exactly one fsl_mc_printk() with the prepared values.
>
> 	}
>
> Not have 4 fsl_mc_printks with a bunch of silly if-checks in front.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

