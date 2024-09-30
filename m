Return-Path: <linux-edac+bounces-1941-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710DA98AE9A
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 22:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915651C2141D
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 20:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866F91A0AFA;
	Mon, 30 Sep 2024 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LnBbxoy6"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3B2C190;
	Mon, 30 Sep 2024 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728955; cv=fail; b=VnYpPKO+wOS8tvSjYwlcP4067mZYggdWyXXWTtb8XGsDe2Tkg8S83dZVR/176GB9exOnokEV6g08+8QeMJhJcj4cl7sBVhhXo4ERQ8lVE1w+Jupq7VQ1u1p4HR57VrKgQVyzCfS0rkV3ZQ82mO5MiidO8mI0+JYMjZYc17BW8DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728955; c=relaxed/simple;
	bh=NQHaf+kzm9tnxMtVbiU93PXjRT1OMmTPplrXgIf1crA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P7z0czy9rvW+g04EfBDRBAketNy6JRHYHxEt0T7HklX2IykF4c6WxNmo+XMiVScQ1XqSsmryZF/7l3CTGGm8j5OxxUYCZ/4LyQkr6SBqzyxLUnwJTCArHFQ17IH1VX/638GircUKGZ3DPXuYbVgiDTHd/MGDc2uYSWhvtEfcusg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LnBbxoy6; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noy9GX7RP1TZR0fSHXeNuLMr7Gtb6Egi0wOdGQmJbWMuujdcqWu9cgmZo13JH3FAUcmUB5m9BA+hQOn1S/5lbjx2um154b6x0m5XSwSp5tGpHvbk16a6d4tVAGiHU6h/zLSVJMU8mCvrJI2+UTV4ugtpyeEcNa6cOumxkmATATHnHhuPWS0fwmMV58AB9x/0WomHr18UXGZEGmw3frcmsizK7gC8Qyv5r2kTFx1khNBXDTpZV/Fi9wrWnCjPzd10dHzKeKcwH/wLX/YgH6Dm8sphSPv5LCDl9x1pzOtcH/MHsHUbfq7i1sEqOh+D5/eDaq6YjXB2hGCycYxntqse2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv3mNP3syXC00fZLOhD3wgOrLoqAvzwe7JsgPKG8g30=;
 b=o8hsux8GBEVH7MkkTXfm70+BBMd5ePuf7mrmeAmVyHXzpdqf+htQGsK7QvXFG6/cBSyzL1mfdneOWLEf+qiQQe/2DpFYp35qNZIQsHiyfb5VPDz2bYHPV9cnmZUBaMJEH/NWApSSzLU5R8FVXdJWg4mB/JVSAW+hD/gxv+wHM5YKDWeaXeRJ0bM1oOr3iujK6EqhmNdV8IM2eczSGE/dawtXCeOP0DPVHl3gIIH7BqsfJQibKOwVhDZhpRQmzdO3Tl9HRC2kf7pWv+EcoKtcXiwzxWxTwB/MDxYdrHsgIrjeDtN/ijhF5o3SEpFQUbJlhzYBQWvar7kUb8OijGAxFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv3mNP3syXC00fZLOhD3wgOrLoqAvzwe7JsgPKG8g30=;
 b=LnBbxoy6GhYGikPZHzzQIGJbAuD5NNboBhAEJiT27mnxzc69uhHrQSyS1JB8ycN0cX0mvLDhhtLly778dB3DirpdA0PLBc40hs0aANHuPFvbPLauyYbW5AMr/0cPMMKV9HFG+6/f8HRxPkLpvlY6AMXPwQ+L5oe7phLHu59N/7PTo4bn5+6SXVnqulZWS2SdaIOfATbWYqJ8KqabVCYjGXkpc6gMDp/Q9DpnulvbgJ9lLQRmV+zvM2rc3mQpnF7WY5r81OnCKecm4+epgaiw0IjUc5H2wyyab2PyQaQOCMPQ9Opsi1VD+kqM4Kr+Niubnq9tt6iQlQ1EGuHIMlGpcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6912.eurprd04.prod.outlook.com (2603:10a6:803:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 20:42:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 20:42:25 +0000
Date: Mon, 30 Sep 2024 16:42:14 -0400
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
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Priyanka Singh <priyanka.singh@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/6] EDAC: fsl-ddr, add imx9 support
Message-ID: <ZvsNJrxF6TpUC6ws@lizhi-Precision-Tower-5810>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 5452d78d-ea3e-49ed-245a-08dce1906446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b2RRJcOjA4Bf+HwcehWjGVBIfuF3ExgB44s6gmvVOfLT4ydfMBXdXJ6TY6U+?=
 =?us-ascii?Q?O5nETi782vu+5NGSwIQVO21D8yXKAEMUOv7Lmx9kqtdSEPIVP0F48jFoeTxo?=
 =?us-ascii?Q?wXxVZ2ndorA/8SRAQvK5RIT99N+7yWpkwOWA1XbEO+QR3mWuk6yrxltLC2Wv?=
 =?us-ascii?Q?G6Cp85lvk5bA5vDeYdH6zcBbCjwlUtIg5FLnkbwfAyLY8fU6sHSTpqxrAYnt?=
 =?us-ascii?Q?LSigMhQgAX3Ql0aAqzR3j9D8FggS9S5plyRJ5+jz+i7PPlNzO09jzAFRGob/?=
 =?us-ascii?Q?M/e1csXhEjLrUYG3wa1CFm/WH/1FJy3ttf5CYj7QgS8Rtq+B7IRnqj/Ou7tl?=
 =?us-ascii?Q?mt02ui7UZCLp8EMYpYMq+iu5nyqry/0fxsc6Gd1FPujA7Dy6Ff2fH8zNv2OR?=
 =?us-ascii?Q?98Q2pSG/EuwqDh3lxYw+FbOzDzcRCaqYdT0I+fIw7HZ9VBINAXSR1gPKUbSD?=
 =?us-ascii?Q?6+Qiq8KXCk8+uZ1JN1z1dOTWmUVwetVUScHQ7XqaAUbsl5nVPCqm3iL2AOd5?=
 =?us-ascii?Q?Rnpg+lrConFsbpjI5Jf4hrbOymCnWbmPIyn0zSmbbo1v6WP8TBBQb6Dncy4Y?=
 =?us-ascii?Q?eYtPsJ+IK2WGa+Kf0A99HCtoJroUNGqhOQO5wPydSSOc6bz+jQugH6dcIdep?=
 =?us-ascii?Q?XMN72US0HARELe7SF0QcgzThqvqdMc6O9tjxF7H4+9tY0gp3I0LpD80Ka7Vq?=
 =?us-ascii?Q?LB53s6gUtEKZtqRszSLcONQ+43sRnDW9y6YEaY9e7K+40fF5cGEyjf34x/58?=
 =?us-ascii?Q?vq5sBQURQCZQuW4JWLIpYm7EzieMqmqogLpNd3bwtciowAeh6eo919OS0DLq?=
 =?us-ascii?Q?aOUns7s1tPWJ2quhuDxyAoYvtfbQSvZqKc9oI+L1mB/PA7Gp/RJ6YZpRQ0UO?=
 =?us-ascii?Q?HpHYNqjxbRDNUw85c3vRlBfvO8g2ohr9Or1OSL/KNGwdbYIgOPIYfZX/zL2s?=
 =?us-ascii?Q?zNTmeHJBA/cjGmdQein1C31k/m/Dxsq3pJqZ3FQo+kdMeKEjYE2AEe+ALQb6?=
 =?us-ascii?Q?JHrdUi2u+iSFwbpWumT7ovUatKDWao1Wic6mCQi41YlY5ShNpzCafudVs/LC?=
 =?us-ascii?Q?8KKo3EeHtBTX0ut7SpyO9/se6infAkejYSyUJzgDoiwJNYiCBgQohhFx8TSx?=
 =?us-ascii?Q?tLEuK1uMxdfyB+sTLqBsfFUn43abVrw47g3ZQwjQIx2sFWbhOLobXy3GGE5k?=
 =?us-ascii?Q?IjFADrvs0TQ8dtCGmzSSjrObdwbMLWRpS/3g2QHriwEaet6C0gs0Y88Wn9F5?=
 =?us-ascii?Q?Lnuk410D4VsuZBeU5Vc14am93axfRzaZhbQf7WwVrTSJ/dwmAkUOy/Xbux0k?=
 =?us-ascii?Q?uWO91SRt31Gt5qzCRrNlW1Nk1+83nh3du/40VSHkeW3jqY9Yka7308r2A6SY?=
 =?us-ascii?Q?X6ufU+vaCj2hZ6/XxlsHbrHYWg4Er57wykwB0X91JNNB8l+My61QvfzmEhfm?=
 =?us-ascii?Q?f8X5TQ36oZU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BkaHWe66GxUK6W2sttxTyyCZCTJMKcwR0fKLvK4L6HGbDJUW9ANRQ4bSAc4v?=
 =?us-ascii?Q?xlg8/lTJ7e9d+UfsUhJjG8kMaIbO0hqZ01uAREU2dGphGkSIOSlUx2qc6JSA?=
 =?us-ascii?Q?FuGMwm2r8Kneat4h6yLzzT9L6hFSAOU1MWDCMETP7rP/CzVy6A8y0OJRzs3T?=
 =?us-ascii?Q?SCxZyssTZw4BzIZeu7nwShgrYoMMB5ZxaozFA5C01KjXHdkU6K7yujzdJHrC?=
 =?us-ascii?Q?rqA/Y5NT9dIkulGUSRwjUbzlc83OdzdaOav2wVClLDP1pNxDbPtAfCVyN0L2?=
 =?us-ascii?Q?CGIjVA7jr3+mj8IiHDX1ov3FWhXZPUTI2LFaCaUnWWxbq17p7OfJ/aTkbSIW?=
 =?us-ascii?Q?Wc8bGOGQAbp+UTyeVALIbPzJ6QjY1biYqYfrcFWuPfQgs3LCo1auEdMgQO9P?=
 =?us-ascii?Q?KaF1flfVIVbFBAagSsbWv2TLxWRvfEDu/iIbndIZXSnV/ne2W34+arcjNLvV?=
 =?us-ascii?Q?VBjeuX8267aOgy6Nh9+gKKgkhf3hbVggAmXK0tS47VaXs/OMa0XrEXSTVcT+?=
 =?us-ascii?Q?M+RjHWZA9PkeUZFBL7U9fpPHKAsLQoShPvLHWuwVFGU8pSz54B4bd2u++ckM?=
 =?us-ascii?Q?Eb4AkVe6V0QgfrNvLOyKIezp2pAxzUO3oK95lkzedRn2Aw1xeFWyszkB6xpj?=
 =?us-ascii?Q?Ks7aITsvIkQLGO0zxCTRvatRfDUEebjFXTuHduXcTw1hoSmhpUzVYqjGiHEu?=
 =?us-ascii?Q?nagGu3O9W/+Rr6l+ONZhMJG+cTTdJa5D7DVgSVf0rJpqNY3hwUZsInkuxLq3?=
 =?us-ascii?Q?efoxZoVfMoTSKAfijXDLqqIXRfyLVVdoz0ly8BgusmjAKlxpSaJVZGeq2jaK?=
 =?us-ascii?Q?QrkQgLr2KgXNaZRiBlhzHHlMHzLUdzGtOriPrXRbDazlYOsLvaV2pVvIncqr?=
 =?us-ascii?Q?Y7X8AnAC68+mxDwXkjiDUutIOHzASz2RD/EVPzU/bgxDmWoRTynkzaKgBEjt?=
 =?us-ascii?Q?WhFYclLin4GPBu6ifUhaP7ju7Aa3d49RndMPVQXI2K/zfIuScks8vq9mWhlB?=
 =?us-ascii?Q?Nx2pjuv5LJvP7X9X+beEpnafeh4oTEHbZ3OnJIh0InANuzyS3o2CqyTeMDtT?=
 =?us-ascii?Q?lMxuiFMDUjrpkaShUW64MGg5G+xuC/EFThQgdTEPxytLU4E9PPJVilwtHqZQ?=
 =?us-ascii?Q?1mImNnieYBTYfMeBca4NdBSU36HoNL2hwwYTVbBBwSFjdoojbmQs/sYNRrFZ?=
 =?us-ascii?Q?9wn/MdefGF1SfEQGROAUCuJ+EhGV2sV1YHEwJxKv80N3akSAyPOT4sYt9SU1?=
 =?us-ascii?Q?ocwaunCQOcV2NCKXpunBehKe1gkamZGJMRFarsoB8ilvf6Y+yJu3cktnIq6O?=
 =?us-ascii?Q?d+pCcGaSbRw69654dEmqttRswaOJq58WAvS6qGMLc1VfzbXRYVOXSE8q5cfQ?=
 =?us-ascii?Q?yXnpnvtNYzo3wIwQ8pavKR4o33+hiihJ+mp+qZdxwqwSAAnhTCbY3mtI4W34?=
 =?us-ascii?Q?H7b3wwPquhPPBqrvkETr2r1TMfoCchQIkXgZpdUpkX89629DRF5gYqG/z1pB?=
 =?us-ascii?Q?EdrYhGybzvxkr8ZG68yod4Y8Nm2gxuScaDKrLyz2oiHT4yo/VIWBfHRr/8Xd?=
 =?us-ascii?Q?MlIVsyMIG5IC27Z4/LMJ5dGkRGt6cDw/dsBDhrzn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5452d78d-ea3e-49ed-245a-08dce1906446
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 20:42:25.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxUPtdY4+6lWh4iIYSSnMNk8Unl3BVtzVqwgCxVuiID0FIiveWbwPDJ0eB2dbMSpEqELpFhOGIAgKGHsva4nxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6912

On Tue, Jul 09, 2024 at 04:23:01PM -0400, Frank Li wrote:
> Add imx9 support for fsl-ddr.
>
> Patch 1-2 is prepare patch, no function chagne
> Patch 3 is small fix for bit shift
> Patch 4 is dt binding patch.
> Patch 5 is driver change to support imx9
> Patch 6 is imx93 dts change
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Borislav Petkov:

	More than 2 monthes. I ping at Thu, 29 Aug
https://lore.kernel.org/imx/ZtDwG2xFGaUssJVN@lizhi-Precision-Tower-5810/

	Any reason why not pick these EDAC patches?  Or do you have
additional comment to improve patches?

Frank


> Frank Li (4):
>       EDAC: fsl_ddr: Pass down fsl_mc_pdata in ddr_in32() and ddr_out32()
>       EDAC, fsl_ddr: Move global variable into struct fsl_mc_pdata
>       dt-bindings: memory: fsl: Add compatible string nxp,imx9-memory-controller
>       arm64: dts: imx93: add ddr edac support
>
> Priyanka Singh (1):
>       EDAC: fsl: Fix bad bit shift operations
>
> Ye Li (1):
>       EDAC: fsl_ddr: Add support for i.MX9 DDR controller
>
>  .../bindings/memory-controllers/fsl/fsl,ddr.yaml   |  31 ++++-
>  arch/arm64/boot/dts/freescale/imx93.dtsi           |   8 ++
>  drivers/edac/fsl_ddr_edac.c                        | 134 ++++++++++++++-------
>  drivers/edac/fsl_ddr_edac.h                        |  13 ++
>  drivers/edac/layerscape_edac.c                     |   1 +
>  5 files changed, 141 insertions(+), 46 deletions(-)
> ---
> base-commit: 82d01fe6ee52086035b201cfa1410a3b04384257
> change-id: 20240704-imx95_edac-209cec208446
>
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
>

