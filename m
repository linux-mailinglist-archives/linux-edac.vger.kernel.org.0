Return-Path: <linux-edac+bounces-2180-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6629AB20C
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 17:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6F61F253BE
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4681A38EC;
	Tue, 22 Oct 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LCQDaeIv"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072.outbound.protection.outlook.com [40.107.247.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4413B2A4;
	Tue, 22 Oct 2024 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610959; cv=fail; b=VEiD6U80CleP5zgftgI8Y2qAN8pW1ZmuIad9FQLyqbTfVPD3w5HL2CB6FnQOs6dy7knziYF72QqERJHsCayG7MBdg2ztEYBqylxly1p/ugY3HQ02Oslb57+NRzAbHac0HH5t11T9hGoS9SQfl6Zxglxm4pw8ekk8ZQv6KMfRxaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610959; c=relaxed/simple;
	bh=imtxbc5fVFSkmWu4RQ9+ccXMQB2+QYfzmMagW/rA/M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NV8Et7yAXKHO/HlPoTYeMHnJdoMSS6Pd6lF13rKnkrwemsesLocSfR6IAR5QXGF0e97Nblri8T4eX7DM1gT5CsQaFFXZoybS9d6GNUB36l/9dYR2WBhd7JdSgTTYC+7Hvs3520TQEgBQf4INavKthvz92lYMRjxUAjs+af+JBPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LCQDaeIv; arc=fail smtp.client-ip=40.107.247.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fW2bhrfAJAgI97rFFldrifMWaubK51mHnz0SnTf8CrtqIcMxAieJi+RW0CIPGwhmyFjD5nCr/TE2p8MneGaZXbZNwRQ+GJdTmGjk0CIp40Ph7VJ9DvLjBBe00ixPUj/go4kq4kv87HTTRNZTpS9khP2VhsHkLY1Ia8EhYDICn+V1gWC7FO8CGmuKlUXluUIscBixrzzvBJIh8InErd/Tofnh4OMkMsj1l/vqivSTZanA1w8Dz12Yak1rxqIehkhyQ2L4TMzhnil7IFvypBJvywuVbPjr1uvKZFQ8+cRgNPAGyghRwcshWmEbP+MVQRYxDnZ+Y2YSDHV9M4O9Krzr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtdvelxfG9kLytdRHIJf3+DjsKfgRCLy1bO0ked5bnA=;
 b=KUgJZvISTDJg3Ky25f81XK7jyzj6g0BZoMEwo4Ht7qAspBzgFm1PlsWYHKdl2yes/t/PDPAzKMlKW4a/IL+gPZEsoO1vGA4YMG9ARBXEcOYF+15Mx733RqkA/YnC3C4UwaxIWrfrEVk396++JuJ2XqcGxqauSoKLFyducpjY1oa+AffdpJ50D7ZCCcU/RmAer39t+xvtUMfuwFTdjSJAgMA2n8imbtUKx64foIr4jZ9XbFwgqPUHArfIKPxjFvl3znpc5nWTh/QqN4Hi3exWU0UnXwZguvy4+cwau0F19Lk9+qK3DNbxKY272Ks7u9eUv/vf85xIyZ2pmj4o1Uy8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtdvelxfG9kLytdRHIJf3+DjsKfgRCLy1bO0ked5bnA=;
 b=LCQDaeIvLc7atTVXv8LTTqs3jIVOYYoCyXf0FF3o8MGZw8pQVITteB3p4SRtjH33uspR06yenni+er+B9F3KhS7h5soR/8iHBIJLVolwz/TMTBVxrY2K1OFhcSFmVSzr2Yi0nEiQySovm0gWzNUOSwiY2IO2qFK14V1nRWld0cFv0TwT+I0hYqlT6/GitCLoIUt84SUOc85oQlnqHHBRoQwGdbYOaRcqkSVyJPcfiETMI47xQg+CD8OrWVNf6DJerd/GGYRc54oWQ2omM4pSC3GJHGYVYnTa9MRaHFlLBzjoojS1yR92bcn8HN4X5/v1hm5D7MU2AR6lSWNva5SiHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8808.eurprd04.prod.outlook.com (2603:10a6:10:2e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 15:29:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 15:29:13 +0000
Date: Tue, 22 Oct 2024 11:29:03 -0400
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
Message-ID: <ZxfEvxA+0iMKBZh4@lizhi-Precision-Tower-5810>
References: <20241016-imx95_edac-v3-0-86ae6fc2756a@nxp.com>
 <20241016-imx95_edac-v3-3-86ae6fc2756a@nxp.com>
 <20241022094429.GFZxdz_QNHHr_DCPp3@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022094429.GFZxdz_QNHHr_DCPp3@fat_crate.local>
X-ClientProxiedBy: SJ0PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 0622c39c-ac23-47d7-9e36-08dcf2ae4867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gsSsCAaNDoRPOdhAOBfuwJq1janP13sbbviCqGZ7Z4Gtn/hNGa2lyhfnTlC/?=
 =?us-ascii?Q?8NCybOzIaBXt3bTuU/gw8ke+tWHvYrBkQLM8HKHL4gP4LOBULDFvZKnHy3jD?=
 =?us-ascii?Q?Fm5iKjTPNHfxhCe5+7lnp3JKp5dup/S7sQqOeLJF7qUD/rlu5orSkCpZO3Kt?=
 =?us-ascii?Q?e3ut9RSg8TXTjExcFoys4tX9TXrbjlf2gGtZkyj6rTHZcFFjyVFVZiIdrWbB?=
 =?us-ascii?Q?GSkPGddkHEsspKTxtQWZzE8QMSkBaQd1dUJD1stuB84Ta25zHkED/D07uVYM?=
 =?us-ascii?Q?KmP7cYNVGvG1PUdtm42tj9sucjZPQ7mjxoG1sr4ZUJ7oZRAY575mk4sd/Zfo?=
 =?us-ascii?Q?nyYoJuYhcaU4nMqU/XcFog6zFgeqmSF/3LUYWjqph+nhbCa42phV/UtPGbhi?=
 =?us-ascii?Q?kM8ejLGzgaicPtoptvQynGiHle0LF9ERIob9J0u0dHNXY3qp6OlyxmlAvRcN?=
 =?us-ascii?Q?JqODrYEDtaO5UmjE0dZEpUzM/R2Cr3/0TBQirAf+USKxj3DaSViiGR1Gcd7d?=
 =?us-ascii?Q?xxfpve6bzob3xYLTqEDlaP4ohk63IJRBEbTXwyk7aIIviEroBlazYrAY+RZh?=
 =?us-ascii?Q?W4x8pxbsBVGESh48shG8ZnhHXo256JKm6u1CN7kVuRPcYvJqMdmyeHcXSGKL?=
 =?us-ascii?Q?Co8heOlbQlKnJpsv8c0M/86xK+uSGBJa1U+tfkSlHP8pbiCl/XPXW1pEruyi?=
 =?us-ascii?Q?zlsN4D9O4cliR4AgTk3cv60ClNgqwI4hBqRvD9gfgyCK3o81LSB3N68AeHsT?=
 =?us-ascii?Q?G+SazSsNoJUk9N405OaODCt0E5PcIYGFtmHMzIEUBWRSvok/FjQ1IjYXMXLt?=
 =?us-ascii?Q?eIKNik1kJZDKx8h0byHqNCg8T/LzTZnmUG+jFPcfK766zokiu+VsAMJ/mKJW?=
 =?us-ascii?Q?WbihfkLhz5pfaVrRwPpsd3mQ4zSEp6Gbm6xX4JuAJGiawgYBJKmRK+vmPSl3?=
 =?us-ascii?Q?ot/jbSfopydR1KMrdZRvhF4eK0NFiPHS8bedLL6136WdE8S+I8SwCXXWn2Qk?=
 =?us-ascii?Q?zqP1nMS5a1ioacRH4mSNZWmJIlOeJO/vg7I6vKGykD5IcehraPe5tbbMea31?=
 =?us-ascii?Q?PAi7RLnyfBp1qSWI1PCmBrwBttSGKXBo804jbZ1Byyxif7Ji+TMMNhDc1cZG?=
 =?us-ascii?Q?iEj51SFbWLisMDppw9AES6QqS429qQjy2WfrTDuXotoYtYT25dTpR/C1+jEf?=
 =?us-ascii?Q?UPiuzOkKfOaxD62YyxjDKw4W05P7Fm5l8lECNEW4a9Z7eoRmuQ1EjXCE9Qmg?=
 =?us-ascii?Q?s41GPCqixRsdoClNN2sLqE/SfIWZiou/ubVMoLPmybcoQr97MJbpDIdkuiIg?=
 =?us-ascii?Q?tigLr1J6YMbx9kg8e0tGd39zYSMISE/dAGABBqXelGk3m7fR3vEvKZ1ijpp7?=
 =?us-ascii?Q?V2HgyU3Gvn2OHI4vckwf0yv2umhL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1sl0pdvUSEKseJFx+pBurEHL7jEXF3qtAb/1eW5ZNJpA22JIKwx1LK4f9w7y?=
 =?us-ascii?Q?bGWA9fU+j9hGg25t9FLl/icnxDoWw1r3rxWIZMfqZx4ajUyPRw2DUcWtG+w4?=
 =?us-ascii?Q?PQdt4leJrlU+IwmYd4pn2aqzIlQB6QcZCV200V0YclgcisHYNiwQrgJ5DamR?=
 =?us-ascii?Q?2PBP95rKEPDszkBLAu2kCtFQuQsJmJhqqxKcnQSWkqwIvINiUiRlRfNMHxYJ?=
 =?us-ascii?Q?WHytiNbXgzxeEsScOgpmd+dw28Qut3tm2l0lyTtjmkXn44B+YXJ/U483KO0e?=
 =?us-ascii?Q?aHPth1+VdbL5U5cv/QB2+QlWspUJhkJDWCVJDw1IAcVuHFsxwwyTtTNuy9TF?=
 =?us-ascii?Q?LzTtXrgFCJ8n6LBCsR+2lnCeyEvItJ/84Y9fq4BAMPRNTJMVrR+nzQfKi9Jc?=
 =?us-ascii?Q?j8BRyrjKY7uABv3G+95vKDK69hVnhfrnxcUiPjNFoSiADy9iHlFn91XAfRMf?=
 =?us-ascii?Q?mhdVTOdD97w9bs2PfuVe6JuPEsbMUtKZ+Xl/OXd9RpMI9x6b5rpg6vWbJtQ/?=
 =?us-ascii?Q?yyPh0uetMv795iUG1rpkf8uFodhYUWErvu7ZZdsRxTktjuLLLrFr3FJA6x49?=
 =?us-ascii?Q?0EIT9X6ZRRXofDGakhxf22ewT8VIaufGN1KBUIOopPGeBAPKJSnLcpkPx1EO?=
 =?us-ascii?Q?a9kwadMtwABpFXpSP568P6yGTnKEv8I5Yd2cwu0lXzzL8vCo/gZJaSozNtiT?=
 =?us-ascii?Q?qKgt+hb7zz6/8iJmrNoR6X5190p1yU42bjGjiDPJD1Qh3HzYC5F2OuP53p2i?=
 =?us-ascii?Q?ALjV/dDKp2NBPyiAuLDsbWSXPQL1mVgqhmmOQBOKA3T8sDbO+4TzKMX1WVbg?=
 =?us-ascii?Q?jOsHpwUutzK5ySUIhzc0Ij3XwG9rUGiW/6hfAK9VrdEV7R4Sz+ygERSuCCkQ?=
 =?us-ascii?Q?ZB7DI6kjMCKgaCjcXDUlvNInjSkK7BHZ1RlhMc56Z0+tsEDhBtRSaTxWyiUH?=
 =?us-ascii?Q?bDFQ7jTrAvl5Gplm22QHrpKnKZ4UWnijQCAYq+V4vxnh0uwZYFLydKLo3G4L?=
 =?us-ascii?Q?Yr1kenJSVwUZknexUQI8idIgFy+w+yJriZJupvZYIoreeSODDGY2r3I3QEg8?=
 =?us-ascii?Q?56xQkUlg6XVixSUjm9UgbSw2oHBGfH6tX2M1A7ro82BcQugptLPDUNlbeU4d?=
 =?us-ascii?Q?lficJCu1Ail2Ht4IlPhZSfCGjNjFjgn8BteNDfHeLUr0F9yq5yY2t96Lv20J?=
 =?us-ascii?Q?2/Wvb3/I4NquJ4fX8S6aiTof2Ew2c1UoIvtQJf/9ozx2ax1/Ly90oC2201sQ?=
 =?us-ascii?Q?JX/tQA7BgI8Yr0KPTlZyqmZO9uVH2BebYb3efWxUVWRc/VsB3mnpQF5CtV/7?=
 =?us-ascii?Q?qeSGx6sDhpUMnR1hBtl6ItN2OS0asp6S65YJUvrqX9lWnr6Rhs2krDCr61yE?=
 =?us-ascii?Q?OvZ40FN5w0ZbmOh1qBA1yHBMp9drmuv80p00g4EGfMHL5W5En9wheFzfirZa?=
 =?us-ascii?Q?Q3nZQKpH/O3JkB191Npfha1Y/gsiL4d4EMmLzWnEtnzKcsb2YvYLihzcYN2v?=
 =?us-ascii?Q?5dSrbDycEzAjaEz48LCiXEmTKQElTO2zM1NQES+iIQXEfpavrbPo6IyfpKR0?=
 =?us-ascii?Q?bg8grlOoTEZTUno8c92AhR1Bq95FQkH9UaODSNwW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0622c39c-ac23-47d7-9e36-08dcf2ae4867
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 15:29:13.5424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rg1JbYpvNCHl2bG/wZGvdeedIQgd3NSSNA4Sq3uvRPtcbVh9n1761rJfl3Y+wocdOLYKjaG1YQ1Xwd46cy0rvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8808

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

Sorry, I omitted it since it is nxp internal reviewer. Do I need repost
it?

>
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
>
> What does that SOB tag mean?

It is original nxp layerscape platform maintainer. He leave NXP recently
and some item in MAINTANERS already been removed. It intents to fix
layerscape platform problem at beginning. And orginal patch have his SOB.
So I kept as original one.

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

