Return-Path: <linux-edac+bounces-1483-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7088292C871
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 04:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214B61F225BF
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 02:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05E0C147;
	Wed, 10 Jul 2024 02:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NYisZ0M0"
X-Original-To: linux-edac@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544C4C6B;
	Wed, 10 Jul 2024 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720578308; cv=fail; b=TdfnNTwFWRUnye1HpntNtgYeqh3H1vps5o0EA9XguhdWNslLeCXUmuzdnPz9i49uCUTW5VZXaITCFzGFR09orUF9MJKy2zTvjmFN7ZlVT+i3dZWlEvzI9oulRdXiV/v5HLaMI/ERUAYncsQu0I/svH4KDIyfEBF3/k1sYa7wVhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720578308; c=relaxed/simple;
	bh=3AMrSb5gRotuRKhLauqtHJvuxDeDCLth+VVQe787tWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hwi25UzT85jJIXajPQ4EKkaWS/Vo0uFLIL0l9l2iXojwphdi9Cpi7Q0UQ7NbHV5A6MCe4Qar9xKkXvrIAg+5tn8VU2j8oFTfl3vTGCE79LCF5t065ugQ3X6ouZTgitFvx2tjoYF7+1eOjWa1dO+IWFav6wFWYI/XqOnlGir+Goc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NYisZ0M0; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwj/V4jVtWQW16sYI7HNU4kj54Gf9/xly+CVaB7L/S/6vy4zLzUR9C/i3QyccrGlF6pnuzc1jjSvJOF40jCCIz1bxz5kGAp/ItoGUmxWbaxBqM5fQmFZsyhX93SpcJ29YU8gWTohDELv/wcX3sWvA39t+ehTXbmybR4FlmTEgaE9ieV7UpdhNVOJfsJcZWeM/3k4A6IO8FaepA5RnHetRZrdtaG16yanJglGE7ReRD0KrNOq6g1rRNEVMOLeh/OioaS9H1yUf2sakpJC8nprXQhf2I1+gznwyOL+RZp+06Nxe3RRNnA4o/6xk08cMHjY3rrKDW30HOt2CeKWPSG22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AMrSb5gRotuRKhLauqtHJvuxDeDCLth+VVQe787tWs=;
 b=BlhK4vM6fraBPVSjcNeoshe/XktgI0yO6ZFTA4eOC3mPDcqvojVxBoEnzAww4itvUhV48Xf9WcJWG8blbiImHQWWFTLigfcO0pv61wog4Hpo51Uhi5wrV16le2aF95f8uKnUa00IWTFW93dgPn2HivbKrS/4SBy4FQPOuPXBUMtkyp9Ehh6B8y+jZX353gUQ3dYFbUyjztK3ctpa/qza4jGagXo6ahxwz54qKTsGuRRQMlDch1XWl3kHkiwk37i2hmHlCCl5pCy7Mg+NjE+FguDj01NuFFLEI1u6w9GJpJeSIL4WXqbR6rb3NE1i1vV8jXMj13bvijCNDkuik8EkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AMrSb5gRotuRKhLauqtHJvuxDeDCLth+VVQe787tWs=;
 b=NYisZ0M0UvGbQoppwiDCWich4otug3rh40kYex/cJ0mFr/V4bWt6449NKpDewFQdHD1zFnfzj/iuMCmN5CQx9DIrNpcvo0+MvzG2gqy2Aobx9lzWoO7wt2cTBfZYo2IzdvONMA9oz1/r+fJgm9UmeNii0mA4j1hu7MxA6JWM6uE=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9069.eurprd04.prod.outlook.com (2603:10a6:150:20::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 02:25:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 02:25:02 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, York Sun <york.sun@nxp.com>, Borislav Petkov
	<bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert
 Richter <rric@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav
 Petkov <bp@suse.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH 6/6] arm64: dts: imx93: add ddr edac support
Thread-Topic: [PATCH 6/6] arm64: dts: imx93: add ddr edac support
Thread-Index: AQHa0j4Uc4waYDkM7kCj6dJi8cylzLHvPBLw
Date: Wed, 10 Jul 2024 02:25:02 +0000
Message-ID:
 <PAXPR04MB8459D5061624A819C70E985188A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
 <20240709-imx95_edac-v1-6-3e9c146c1b01@nxp.com>
In-Reply-To: <20240709-imx95_edac-v1-6-3e9c146c1b01@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB9069:EE_
x-ms-office365-filtering-correlation-id: b6a069e2-2b1e-4fec-b7c3-08dca0878116
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDdWWXpQVFJlaFUxRS8vRnppZnI1eG5La01Xc1V5aXB6WFNMeHl5QmFhSjZh?=
 =?utf-8?B?SDRua1ZWUWZ4RjduK3JqYmZ2OTFyZ2VULzhoZG01cnZhaXFtb3NOcForOGpn?=
 =?utf-8?B?WGRjZU4wU2dKNGxEb1ZMUlhHWDQyVnBIUVI2eTRkMWEwY0lnQWtRNzcrcjBj?=
 =?utf-8?B?dTJYNk1pcHBoN1UvVnNjYmorVW9FOVhSSXFRMWFBbnRmUDM1M0U4c3FVSUpq?=
 =?utf-8?B?U3dqOEtpS1BkV011UDFJcTBJcWRuSUkzMGR6SXh4eEVUY2l4UGhwdjFCUFlB?=
 =?utf-8?B?Sk9XV2hmdHZQR29iaEtyYno1R2hsenFYMDhCdXJ6UE1vZXhqbTloZkl6UXh5?=
 =?utf-8?B?UjNMYjE1d3V0bnh0MXQyeUtuUXJrdk9ZS1MwVE1ZOTBwQXVoNHlGU1ZweDN4?=
 =?utf-8?B?WXZZMjU4NWtOQlBkMFBMbzE5SFJWdmdoeWF2bmxheSs5WUg3aG9tQ3UrWDIy?=
 =?utf-8?B?U3AzNm43RWdJaW5COUwycitYdUtMQ1RZR0tmTnZwYWxtMUFWRDBCM294d3A0?=
 =?utf-8?B?TzIrbWc3TEJMU1VRem1LWXcycTBpL3pQN25Zc1hLSWgyMmQxclNsL09pYWpj?=
 =?utf-8?B?UVVEdVo3cmptL2hNdklkT2J3Uis5S05JODdvK3plNkdiYjdOd0dXYnlZRmJX?=
 =?utf-8?B?WVpqc1R5ZDQ1NVdIRGtJRU40RjFWRkZSeXNiM3VkaERCZ09tbGpqTURzWGk5?=
 =?utf-8?B?Nm1lcFVhNmxQZ21mRXpjVklRODFEVitLQWxFRDBNaEoxSnBKY2crckV0MUJI?=
 =?utf-8?B?SUN6WEovVFMyckx2aVJ5bi95RkkxYnpUT2dmTXNTaElQREtLaEFhVjlvTVcx?=
 =?utf-8?B?ckdBcVlyc1NsOWozeTE4MXEwclhiSTVqaDR2a0tHNlM4MncyTGNmTUhQSk5S?=
 =?utf-8?B?b3RBSzhObVhkcE03Y09BRlhCYklaYk5jTWxQQ05sVTRBejZtcG1sZDRJZit6?=
 =?utf-8?B?YjJNZGxNMXlqMXZCd0tQZDZtU2tJVlU2d0p2MUhGd1JoeDl4Qi8wckxoL0pP?=
 =?utf-8?B?QnJLazZHdHFxSWc4aS95UTR6alNkWXNPRmN0OEt2WmRCaUJQNmZmZjJuNVpJ?=
 =?utf-8?B?U21mcUpod2VGajJNakhCeDlrWFJyRWFkRFZZWHY3RWhUZFptdUxSQ3U3QkRF?=
 =?utf-8?B?cXp5cWE2YjIyTXBlYkZ5YjZkMG91Uyt5M0dLYVYwbm4yK0FJbkU5NmYyQk1h?=
 =?utf-8?B?WjJmYUFtUytBQjJoWERlRXUycjFZWkYxUnk4bFVSZno0OUtRY2Y1NEptdVI3?=
 =?utf-8?B?VytqRlBiVWJSV2UwZEdyQ3MxRklQZXlYMzlrcU95dXRWMW1sMit5Zm1hQ2Js?=
 =?utf-8?B?aDNlWFFSZUxJNXJLNGtnWDRoU3dOZmcycXZEYTVXNUR4TmVjTDd1OWk5K1Yy?=
 =?utf-8?B?QzlCVEF3aW1PbHNLUjBNRTZ3ZzNZWTJtRVhpa1Q4U3RuUE1tZ2JrbXhaQlBU?=
 =?utf-8?B?UnpXdFlXUmZ2eXhjQlBlejUzdjNOTVZpKzlsVFlUdzJMQzlLTXNLMVErUlpQ?=
 =?utf-8?B?bXpBQVhmQW52dE5ySWdCRXlUc3R4bXlVa1pxUS9nTGp4cVBlWWQra2Z4dHZ6?=
 =?utf-8?B?SVcxZUVRSmtSSkxEaFlrb2dydFhMbWRDMEI1UjZ1cGpyRko4aFNqNGd3aEZB?=
 =?utf-8?B?TW1zQnkzcGdDRUJJQ1g2Ly9GK3Q4NE02T2VEZC9uVEZJanZxY2dvSUNvQjh4?=
 =?utf-8?B?THY4Vy9KVC9KcWlrNFVRKzZkU1BOSVJDQ3g2cG5HczFYSmMvdFRhZDBVTXN3?=
 =?utf-8?B?dDhqYm1kNFJleE5uNm1MTlV1ME11Y3NHNWw4blk0Yk9EL2lsUDNGUEJHdTlM?=
 =?utf-8?B?aU0yckxOQ0lBWE5oSnVJQXZrZWlGWlloUzVscHRYb0NmdHoraysreU1JT2t3?=
 =?utf-8?B?dm1NNzZOSStkMkVScEwzNUo1ZkFrVFpCUG1FY0tuWnVCRzJPWXBDQnRiVWc4?=
 =?utf-8?Q?kwHxUQr87FY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q21VZVozTEo1THdaSFhtRVpiZ2NRdGFIdWNudUZVNmx0d2FZRFg3VGw2b1BY?=
 =?utf-8?B?VkF2aXN2M2lqZVJsVTV2UDBHclBWd1NYeWtRa00xZVQ2K0gyMTJQdE45QVRm?=
 =?utf-8?B?bU1tdHVDbFNEejhTK3EvZ1FZOXMwT3lWU3c4SjhrRjJCV3RRc2lnWnN0TmlI?=
 =?utf-8?B?YkozbXdWRXNxN1F2NjFwY01wSGl6SHQyOHBmOW5SMlYrdWpMTHhMY3dTdTkr?=
 =?utf-8?B?V3Y4dFJyNUNCeXlINFJTVG1RaCtXSmp1S0dDSVhxeG03dy9DUW84RVJUak55?=
 =?utf-8?B?THBSVVA4bStNelovemFxT0JnK3JXd1BDcG5RZ3pUd2R6NldnSkY1Ni8wMllw?=
 =?utf-8?B?d0c5YldNYm56RFBLMWZXd055czZSbEthVWxVR0Q4RklwNmc5NC96SGNlVW1R?=
 =?utf-8?B?SDZBaEsyYmhnZ01CLzRFaU1wOHhRcjBXdmMzL2Z1RElpNktnbmhoZUhoYWlE?=
 =?utf-8?B?ak94cG14aUZFWFUwTU1GdVNpd3lOVG1PV3RDRllKMDh6OWNnbVVUNk5zYVVS?=
 =?utf-8?B?Nzljczg5NklBeWY0dENyNzhRYWNKc2RuL2ZGZzdTbFN6WlVlMERaSXlaM3N5?=
 =?utf-8?B?Yjc1WmdtZ3RTbU92N3B5bmhlclJLTVY5bDFMRVNBT215ZEN1NDZiL215T3E5?=
 =?utf-8?B?V3NaSzBnaGFwcjFmK1U2d3pGcTcvL3kvbzNhNjJ5bFBtRCtiTEZkWm8zbERp?=
 =?utf-8?B?MTc3RGFKTWVVSGxDMjFjR0NRUk1TVXBZU2ZldFJUQklBZ0Zuc1pJQm9qaTBW?=
 =?utf-8?B?UGRNMnIydjVNOGtaUnkzTlNlVWNZRUpTTmMxa2pVdmJZSGcyMUIxVmxETC9v?=
 =?utf-8?B?YnVjQklSTXBST2hTa1VQRERua2p4NDE0SGw0WEdROEV4K0tOWFRpRFBWL1BM?=
 =?utf-8?B?UEJ1M0hLVlUwYnR3Uno0LzFubndKYkUvVzVNS0hTL2JmRFJXWlUvaTVKaDNV?=
 =?utf-8?B?ajVsMWlLRlloVkNwbnprMkg3R1BNSnJ5OTdDNVl1STRQMjFwTmhHUG01eDht?=
 =?utf-8?B?WUN5Z3A5Z1NEdFM3Tjhyb0dPNEF2Q2t2QjJZVjBNNUVMTExJd0oxRjdEVmx0?=
 =?utf-8?B?Ujl0blA4ZkEyd3RGTml6c3NPbVkvbloxbHJVSTZaenQxbEJja0dCWGRmMGlR?=
 =?utf-8?B?a0g5NWFWOU5pcEp2ODJUd2pheUthL0lYOGtRMWhHQS9ydDFQRlVFTVQxcUJ6?=
 =?utf-8?B?RC9qelpwVVJxaWVrUWEydnE5elRDU05ib01KWlZtSUxLRWE1OC9ZdytRM1BG?=
 =?utf-8?B?NGMreTRhR0FuWW5yZW1tUUVHREhoTDZWRjhzVDd5REJxMkV6eVQ0c1drcDds?=
 =?utf-8?B?aE9BNVJiNkhTdGhieFkrSWtGcUtMUE1FZERWUk1nMG82MmxsdGNpakU1RU9J?=
 =?utf-8?B?Q1NWcjFWeGJ1ZzUyQ0dZS0theDB4dTM3QjFTNGpCc21NTDBsNEdIODAvWnRr?=
 =?utf-8?B?SG8ySE9ua0tlSmFlWFNJNHNJL2srUGtZNHppTzhENi9ZbUJjYkdiZEpZNTJj?=
 =?utf-8?B?NXVsREd1Lzl6cmpPNGdFdml4MERIOFl0VnBUOUtzY1JySGNQQWVOWXk2aTNR?=
 =?utf-8?B?Wm95RXBPVGtQL0pObDlVeUpBSU9iTnkwRGZVdFpXRGJzK0VKUWVLSjVNQ2Zy?=
 =?utf-8?B?WlhwYUdKV0RIdUNFYkpWOEZUdFJYUmtSS3ROSUszZmlMV09Tc1hWemV3dnl0?=
 =?utf-8?B?SysyZmpxUHFMSHc2MzZIcmNISkpvbmlYZFBQTDlCam5qa0hzNS9HRHhqNmkr?=
 =?utf-8?B?MWpVOEwwMWFXcThjTEFnQzhZUTQ3RVhZTkhRa1p5a0JKOFdpYW9adFVJenBK?=
 =?utf-8?B?QUFDM3Q1OGI4UTZCRmFXeW0vQ3IyZU1YQlJtTG13QS9kUThya3pGUWhKeGxG?=
 =?utf-8?B?Y0syV2lQRUpDdlBDbS9XSFU5b1ZYWk1VUEpsVFVzektwem1scEhvRkZ6WUU2?=
 =?utf-8?B?RnlJcjlvRXhqUjNWcUpXa1Frc3VvRzE1ampBc25qeGI3T2Q0bGlVMzRyQjgz?=
 =?utf-8?B?ZnJTcVcydXcwMVN6QUsvZmlVQnAvL0Q3RnRzR2lzcmxvWnovSWtVeVVNMW5X?=
 =?utf-8?B?aFlSQTlYTGVaNXAxRjd2dk1jSDFORXpwd2M1ZVlJV1pRRWhLTEdiY2NPcU8x?=
 =?utf-8?Q?bD9c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a069e2-2b1e-4fec-b7c3-08dca0878116
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 02:25:02.6358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6RrB+hkvuMk7zSLC1Gw6dKDgv5SkYkPqt0gGYGCcOCJWJOoQ+RLtq+hSYAgdP0pKHC5t0OqL1PKljoTVV+d9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9069

PiBTdWJqZWN0OiBbUEFUQ0ggNi82XSBhcm02NDogZHRzOiBpbXg5MzogYWRkIGRkciBlZGFjIHN1
cHBvcnQNCj4gDQo+IEFkZCBkZHIgZWRhYyBzdXBwb3J0IGZvciBpbXg5My4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiAtLS0NCj4gIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLmR0c2kgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OTMuZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDkzLmR0c2kNCj4gaW5kZXggNGEzZjQyMzU1Y2I4Zi4uNmZhYmE4NDhmZTI4NiAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMuZHRzaQ0K
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5My5kdHNpDQo+IEBAIC0x
Mjc5LDYgKzEyNzksMTQgQEAgdXNibWlzYzI6IHVzYm1pc2NANGMyMDAyMDAgew0KPiAgCQkJI2lu
ZGV4LWNlbGxzID0gPDE+Ow0KPiAgCQl9Ow0KPiANCj4gKwkJbWVtb3J5LWNvbnRyb2xsZXJANGUz
MDAwMDAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJueHAsaW14OS1tZW1vcnktY29udHJvbGxlciI7
DQo+ICsJCQlyZWcgPSA8MHg0ZTMwMDAwMCAweDgwMD4sIDwweDRlMzAxMDAwDQo+IDB4MTAwMD47
DQo+ICsJCQlyZWctbmFtZXMgPSAiY3RybCIsICJpbmplY3QiOw0KPiArCQkJaW50ZXJydXB0cyA9
IDxHSUNfU1BJIDkxDQo+IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArCQkJbGl0dGxlLWVuZGlh
bjsNCj4gKwkJfTsNCj4gKw0KPiAgCQlkZHItcG11QDRlMzAwZGMwIHsNCg0KU2hvdWxkIHRoZSBk
ZHItcG11IGJlIHBhcnQgb2YgbWVtb3J5IGNvbnRyb2xsZXI/DQoNClJlZ2FyZHMsDQpQZW5nLg0K
DQo+ICAJCQljb21wYXRpYmxlID0gImZzbCxpbXg5My1kZHItcG11IjsNCj4gIAkJCXJlZyA9IDww
eDRlMzAwZGMwIDB4MjAwPjsNCj4gDQo+IC0tDQo+IDIuMzQuMQ0KPiANCg0K

