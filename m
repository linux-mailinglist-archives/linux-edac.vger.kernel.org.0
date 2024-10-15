Return-Path: <linux-edac+bounces-2086-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F4699F6A2
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 20:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E0E1C23215
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFF81F81BD;
	Tue, 15 Oct 2024 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KYPZfuge"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C1E1CACE5;
	Tue, 15 Oct 2024 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018549; cv=fail; b=f2jNSuXF5sbci+7pfekjGmWsK4vdvIUXR9ZXcUrvP8XZTXTeyaV/G//+6GbheyvrD+asHZdN1q1HIgdSOAMG8uAtzn1UnY/1T+n7yPEczH/K9KqboJ8usNTDJpE9/f6PAjhy35HzsyxCWEd/vmXwq1mh8hGCkV/tMwiIhd+7hMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018549; c=relaxed/simple;
	bh=K9UYbLJTGY5SaADU+2PRNCfswNkN0Os+75miVLSXYDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=InFkaL8wuTTFm5t2KiPUXehgkZFVpFSQYVATTqp4fI9Onyr28xh1c34dZ5+RVlg23qUrR0x1M4ehCe9J6zsEginjsqIg0CNkxQ7rKUNhCFWGGIoBYKrQTONnDkkd+pbI9DlQm+7eOTmf4GejskE6cX8114EKNomN0NrBVzfnZqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KYPZfuge; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7cWTKYJMPo5XtcgrW905NyWm3ZKHyFHj5tMHEnVFBh2ZIs2SPpVEOJnOoB3bzNlaxQocYPt6yZNHYTw+E8tjW1ANoFYsgLDmuqgqoaKElPXVdmGTn2E8zVrGINQuFyMb3goSZ+3vVfoYku7IDW+vuGMsO/t3iev9zpux8kcJIgTtVtVO3f0oj3hpZcl3ML8UCCQIvc6JZhCRD63iq4chBY2rB4L9CET5zTDgL1rjxUSAncW6VJTdUEl2DBNqldGL+DI3nB1R4wRVHZxlqlMmbnveg7+qGcN5CikMLqIcsXFPba0k2A0d7T3Be8Z/v+NiwOdMHs7Xrt+KL56XgshCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRbbPwbnvKdB/Bf2XvCfXupfZBhkFrlmh3R4k4Sxx6M=;
 b=xo7YNeN68BJxqjWh6zyQ2LkAQca2MH/86ijEwFHXCiwP97TpCyXtu2CBmHJsrzSoUJlk1FgCgHFev7bVrq0s/JM3zTaqQltmxCYlQ4Wzg6Gq/QDeDwgqFCk6Z51hMXZtrtPLoYd2Kxr6dmkUzpagvrwNfHa8OTkSHHm+hQnCydR1AZvN51svHPJyYjZT3u6f/qpduLoodmvDIAhoD27B5V79PGcdbgp8WSII7rVCdje2kRQaPynXcJ1hjiTBcKZIpHKEl8sy9JgVNiLF6taLJGuoEEYz3zYZM0PAG96Tw3qvL7lmcESKb1F9YCfPYTtP3TmzxvDfrIAmvRdqqBb9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRbbPwbnvKdB/Bf2XvCfXupfZBhkFrlmh3R4k4Sxx6M=;
 b=KYPZfugenM1W+dGZoMQWAM65HGoJ3BBmiow9lURO8p2XWiWszPvetOvWpKqPvdgitkBiTnNBzXaEDZKCH5d02nRO02SXrRUF1YGSuoD+hIqSAt4IEDBjW7ummYyvaP+ieedRzNUcxwkcfs3b31YboAz7sAie40STH8SEPMC0IhGJlAfTlhqUJzC5gxYA7mJSWvCVfD9XPtG6YTLahclidG2VAYoJWAYWbsuAP4hrxd5/nmMo7hK3a3IKxk6fm8MUYhUW2rZP7ycDm+CePYVx5Bae7Ry+vpXyQwzV5jyX9PcJLToirYK/uDbB1bJuya2DuIV+bhnpIUg29bUhn7CWhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7506.eurprd04.prod.outlook.com (2603:10a6:20b:281::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 18:55:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 18:55:44 +0000
Date: Tue, 15 Oct 2024 14:55:34 -0400
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
Message-ID: <Zw66phYPxM85AfHP@lizhi-Precision-Tower-5810>
References: <20241011-imx95_edac-v2-0-011b68290951@nxp.com>
 <20241011-imx95_edac-v2-3-011b68290951@nxp.com>
 <20241014181647.GQZw1gDwIhBdnFnleH@fat_crate.local>
 <Zw6K3dlsnlhV3F/6@lizhi-Precision-Tower-5810>
 <20241015161139.GEZw6UO2txZVBXffKc@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015161139.GEZw6UO2txZVBXffKc@fat_crate.local>
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 850a0423-b751-42b2-fa36-08dced4af92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dgKjBmD7KS0Ozqy2c+nle+9OZw3RDkgWd5mdTTzJLVhoLL7R23XTW5f3AyzH?=
 =?us-ascii?Q?BUGGhNXXuEf+htfqDxjgr4ymrKEq8tKxXmtD9OJy0wBaS7aOJWyKbpiRuzQn?=
 =?us-ascii?Q?hrgjrozu0j0k65X31QmStDbZ4EHT3WQIdnQbIRuh0v+6lA8KOobhHFYaABMZ?=
 =?us-ascii?Q?T1KQSwz0LS12p0AXUZidcLQzT/7a5p5ivLTtNw+rpBNiqHcT8O7+kvTBjqal?=
 =?us-ascii?Q?w0HM3Agq6hgfnnqs48C/Kr3j/P4eYuPTHEqqJAk1EP12L7cz1zrN9npMeiFN?=
 =?us-ascii?Q?ZeeNaf8wmL57jqQxKmF4gQrgimOJjNGTfcolLIAUhfAKQOwBtnrrt734fMIg?=
 =?us-ascii?Q?BOGAx+niuIkM5VyACDCZ4Y0mwb6VPEhw+DpjhrsDoZVSGJ+EdJfIzh3QsQTu?=
 =?us-ascii?Q?pYDd88XXcGgYzsLEMncHadq7LmmD7KcMtK0HliUPtHMeXbWQw9afuRFBWMzQ?=
 =?us-ascii?Q?akQvKOiaHaA5AaouGDkDUwKXmZTTe3583Pbzd8ymsKGZ20ElGTUnNjqJQnfk?=
 =?us-ascii?Q?GeBfJ4wd7urCPUpRZ0TKDD+z3XpD0coWQQ/pAZ4UC0doUZImC2Z5j0DfX9jL?=
 =?us-ascii?Q?ROMS9W3RnBqK39Sh4GifVz35r+kEj3IdhiWL0weJWdOpuRKrhhqaXn1qYTQ7?=
 =?us-ascii?Q?0F3/kuB3XhEwMlZf664E+sBYVCt/cT97g0qTJ7uX12I92Cf1xCDGn4IXSGve?=
 =?us-ascii?Q?6O1ceAd9SnMY4NXEVUfayD630z83K6/GaAOo6YFkIC66Fn1fQpXpOYQBbIYP?=
 =?us-ascii?Q?r0r8dlNkWfpucELOH3H24SJMMWbV4gH9ywjWIamzX3W06qZvHOxckZuqlUcU?=
 =?us-ascii?Q?K2Djlw3NRwzKivMZe2Pjm67JzUDIQSd/0DDqQOHOqkCLyIACFuNeNs+FFtRx?=
 =?us-ascii?Q?99O5qItb+IrrUb1e9CFDSxZcW0ZSZEwuG0+tJa2Sqz4VwW0xWnA/QfuYOyBs?=
 =?us-ascii?Q?ziaeuagg+5iTKxTlbLVPza9Uhto3OKjPCVMLZ01i5r5eklE0G/plmkek7Tss?=
 =?us-ascii?Q?z7xDNzHgxgvWKHt1kDll8noQRX1OZA8iWzO4NdVcm2/gWCWrvMUUaGvjlr4c?=
 =?us-ascii?Q?uQ/AOOeBLZGTg/7vC4TFHqCSTYkPJoxErR0T264GmkevVY/RN6yrMzQOsMjh?=
 =?us-ascii?Q?wn1MpqyJGQy4ZJrEv4xa7+yBt4ndJjW0hHKzpWKx/tZ/dHlWO/cFQwzzjAQG?=
 =?us-ascii?Q?h/jRccMRoOBEe8eInsVe8ZUzbUPNBi8oKxXLP1mdVSVc+eshDd4Fri62oc73?=
 =?us-ascii?Q?X1S0yzaduy3MIJ2Jv1IBhVpvm5E5Pr59JnRQnoZZp+xMRJ3ifcMb9IBo0Y8g?=
 =?us-ascii?Q?pvHFhctJjfaw/4HbwaVvvJDvCQHshE1OvmfZKb7CweBqhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DKKHIx6SqJD5k4Y0QAdizviQCxcGCjvajiRZ6mgzbhvKs8DBk6ixy9bdpMqo?=
 =?us-ascii?Q?Yuy4vb2WWmYpNGR3Y/fD/KBRhQ1JBijO2yrepsSMjA2ATtyq+7SWN4qbIuEA?=
 =?us-ascii?Q?c+uUJtTIdnKJt5A20Hzl/eoMj47LFnol8+hHK1hTLoHCKPWWSrFwYNP446nu?=
 =?us-ascii?Q?zxh9vX3UVROBw1LxglpTGK70XNfQzwOFG8zvpZ9DJ0kJHCFKOJXvMiN/218v?=
 =?us-ascii?Q?RGTPTPiOkhXAEsBnKXKgFsvx3iGem6iRITHEt5TfQ6RCaWvMFVPTbWF9RrYm?=
 =?us-ascii?Q?dZ7DgJRGk/ZZU/L8iU5QP0GDZVD2PO8/eoqVhqfyBZ8yvBF0c5s99Ppmp95d?=
 =?us-ascii?Q?w8Emwvp5nAS8MHQ+kSspuUFh8XRF9fEjI/lXeEo0mrVm1LIPL9OuVHYY7yxd?=
 =?us-ascii?Q?nI3lckP2MQ+YvIqGR8sSTnrS1/JebacrrEvwHniibeqCffCi7kxsksDkYqur?=
 =?us-ascii?Q?5va412g8wm2qQeKOcZeV3iq3vPu121V3rcu6ayWnfgSsdo7lVS0mp0sVZgUa?=
 =?us-ascii?Q?z3HHIoAEa1egQNT0uhZ9DFzYpaIEzNUsJ+8mhQPKV0DeJSkiO/Nf4mjFH0Fr?=
 =?us-ascii?Q?Me/NVg2ifc117KJ+PCrS8MIcVYQcrepL6+wHQFGJ/G4LQmGXGj7sZUBWYsGT?=
 =?us-ascii?Q?w6SjZHrW34zccb10rl2+gCnGJk6qhCyc0Jd8tgjWSqtpR1l1UdMbxy+1dURq?=
 =?us-ascii?Q?9UzckawlS3WZuOSBFF/uU/izizm0Wng38oHE8qUo4b1is+8ZQrTMNkA4Z/YC?=
 =?us-ascii?Q?+JlmjRtQzuEDBayOcm0d4Fm7IlWgQK7HfVlIBP2Ud+EKW1f94POpV/95wmJr?=
 =?us-ascii?Q?Js9rbvejRZ87ALOrRFlnu8QP+14SPldKWx9YrqDmplIU4PeqthcyU/Mqlrjh?=
 =?us-ascii?Q?FrB/+kItcEAtdilXsZXPEzl7aiPqXCFJysqle+D4285ZM+x8fdxqsFy1tLoF?=
 =?us-ascii?Q?XLAziNHJKifQfYCNXKVd3T+bi4V2Ooh4FBvXvYsh2QBaKrH1PDAY+b1s690z?=
 =?us-ascii?Q?kSUtVr79rubP/DR8fMJU+kzFMdxSA6DunnxAk5yQVTTOJZ0PSpFoV9uhrdz0?=
 =?us-ascii?Q?hr4J+Z/u/mXUBk/r9qP8PE51pNh2MOigtXN5ZbQUHWRV95lJgZPmWDXq/R2D?=
 =?us-ascii?Q?NIDtap455zhfnOkg2pA7mDUlDTR93QhMdpAcq5L998375aj+w6CqGZQFdbVe?=
 =?us-ascii?Q?oCCUeKKXcPaf+KKw7se79qwCgOXJcN6sD1/OmRAqvO1yOXOkpVp4VzzG8neq?=
 =?us-ascii?Q?OtNcjiqYUZSea8S6CzpFVSdpbCC1RHcRqS3t10J3rLJDTW2gdgAhOFI4/HA0?=
 =?us-ascii?Q?NxfEYFIKlPlQdH/BPFMcQEi3fjlFHk1Y2XuR+/Da70y+VV8P/BSx9xfoRFwC?=
 =?us-ascii?Q?ewqR+0v1i0UxcDiD1TDTzEH/t6siFrJ/UGOCUIvgLNEgJdGj/fFVSWdc9fLe?=
 =?us-ascii?Q?3Kz8qpdF+0LWshjar7UtR83G9ZftJrplHbCnheExsLb5p/Nq36lLNwxyU4Pa?=
 =?us-ascii?Q?blmmzQVybBu8PrPysaf9UGhqcFbqAf1x8sJtmhjOZFSjHt3oa9nbeqFW2EUR?=
 =?us-ascii?Q?cbOs42nBtRiN1diEqKe4w+PuIlsY9GP5qtuDMXuL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850a0423-b751-42b2-fa36-08dced4af92a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 18:55:44.4700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htZzNPTmBYr6XvlBVh9LebDlNyhEhaFYoS6UlVDezRoKK5kGIonWdC/hY98paaTq4Z0x/+kOkRbPtQ56Nd5/DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7506

On Tue, Oct 15, 2024 at 06:11:39PM +0200, Borislav Petkov wrote:
> On Tue, Oct 15, 2024 at 11:31:41AM -0400, Frank Li wrote:
> > I don't think it is urgent. In most system the return value is 0. I am not
> > sure who caught it because patch already exist at downstream tree for a
> > whole.
>
> That current patch looks like it needs rethinking and making it sane - see
> below.
>
> > > > diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> > > > index 7a9fb1202f1a0..ccc13c2adfd6f 100644
> > > > --- a/drivers/edac/fsl_ddr_edac.c
> > > > +++ b/drivers/edac/fsl_ddr_edac.c
> > > > @@ -338,11 +338,18 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
> > > >  			fsl_mc_printk(mci, KERN_ERR,
> > > >  				"Faulty ECC bit: %d\n", bad_ecc_bit);
> > > >
> > > > -		fsl_mc_printk(mci, KERN_ERR,
> > > > -			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> > > > -			cap_high ^ (1 << (bad_data_bit - 32)),
> > > > -			cap_low ^ (1 << bad_data_bit),
> > > > -			syndrome ^ (1 << bad_ecc_bit));
> > > > +		if ((bad_data_bit > 0 && bad_data_bit < 32) && bad_ecc_bit > 0) {
> > > > +			fsl_mc_printk(mci, KERN_ERR,
> > > > +				      "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> > > > +				      cap_high, cap_low ^ (1 << bad_data_bit),
> > > > +				      syndrome ^ (1 << bad_ecc_bit));
> > > > +		}
> > > > +		if (bad_data_bit >= 32 && bad_ecc_bit > 0) {
> > > > +			fsl_mc_printk(mci, KERN_ERR,
> > > > +				      "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> > > > +				      cap_high ^ (1 << (bad_data_bit - 32)),
> > > > +				      cap_low, syndrome ^ (1 << bad_ecc_bit));
> > > > +		}
> > >
> > > This is getting unnecessarily clumsy than it should be. Please do the
> > > following:
> > >
> > > 	if (bad_data_bit != 1 && bad_ecc_bit != -1) {
> > >
> > > 		// prep the values you need to print
> > >
> > > 		// do an exactly one fsl_mc_printk() with the prepared values.
> > >
> > > 	}
> > >
> > > Not have 4 fsl_mc_printks with a bunch of silly if-checks in front.
>
> You missed the most important feedback. See above. ^^^^^^^

Sorry, will fix at next version.

Frank
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

