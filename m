Return-Path: <linux-edac+bounces-2079-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008FD99F0E3
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 17:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245101C2156F
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2E14A4DF;
	Tue, 15 Oct 2024 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RhVSZS5M"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896371CBA11;
	Tue, 15 Oct 2024 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005599; cv=fail; b=G2/qS3u+RtX8FcnRxhkmuxfKDCHXbSFHvBMHoBOSvWygVX/CO79ba9keJDgEscQPWMuyWM8K2VobOgklLe47BX7lLAxCYwNwOIQfqdawT5zZui8xD73L9jCsg5KaO9etr6+2KEXWFfYch2CxTqJoHoaeeUoCEUje5KQP10n/ynM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005599; c=relaxed/simple;
	bh=dFXy6AIeCZuK01bTygdFXZ8MtUpRAi+RRkxI/oOnRHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M+AGxroDXc9ajGl0TljBxbOKJsr2FjwJGvOh+7lr8kDQjadHJP/oNhB+Ad8iDCxI3MhqGO/ciy7ro3yBHAA6qZ/Kdwg1RB3ofp6/czZDREB4kDqkVItKkTNh0km9qMwwt60L+GC+ssEA8D9vMURQIdZHHpvPrQ7zmbAFrqHcYto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RhVSZS5M; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWg+dlFxMHiDPuy3bYiAWY6/pKqKG3veC1Kj5+9yGzfS7uPEExlBzKIrnirFXaDGnNnZY6jLRZ53pFZxmIPSlH3+caHdZEP0wRyIbd0ZX1Ag3iMyVRhFeNh3c/lMLNBBjImYe/4Gv4CGOJaQbtvGFaAiDnq5OwRZTrVFOBlQPtPjiA/DH66ex2MrTqtp3OuwEf6eVU/oMo1hdjdFdgz8bT3cufyj35KzG18SuMFXNtZ0Gsoe0LiagtKL9r/E06tsMIWFgNrLaZ1q/PS33Azw5miRIY5cFycMOzdMCJZT9zQkztnm7Tmz9FTbK3FbtewWdvG6dqR8q6/eEaLif+AmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ru4C+LgdIQjs19HWUggwkKKM6gRA5GEWFi/DqCoACA=;
 b=n7+SiBP+XObVuho0MsIMpTs0lhyCKJVhPKvtEMubbI+W0FCyPiMTBxeMUf/9YuBNLVACK+YRmiqAAv+dQxbCcqS5t7MyXjod/KSlR30HH5yGykZUPMlA3OSQ/Q8pQqO7Nf8MQCCAlXfQxFBRXdl1ErVyjics9D4lUh0bfCUV5S+iV4dIZ2K1zpyaCcvRqE3k9rEXpK1PZx+W3oHT508ZkrKJKdV64ygbNfmlbxFpUqm1kM/621+9ph5KmuIUbKVxbMAbFzwX+uZXY1CR1lK+ysT5d6bO1yaFc+Effw96DoxtQI7taHQibgJZbloRm+GHtS1WVjgU81A8YGPREvaPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ru4C+LgdIQjs19HWUggwkKKM6gRA5GEWFi/DqCoACA=;
 b=RhVSZS5MFAwOLicQrvVuy0oAw+inbgWc5928/zmXqOpTAu0DAOf5xHPkJlCyhXUbqX9mm/Q+/52/oiXErGy+miIvZ+03uHf1m4FiRZEfLyW6c4SpgTfxxR4vliLjab9xO4nwDRVIJK6ITNuqFH22le7naCbvhDJglusSHuX0f8NkzrIvY0bA7D3+jsY4LQXKzg10HqxgSO94o7lVD42PHoZ4XF+arcfmN+ITUzsA9qyl31wCr+k48FK8kvkOc3KliDLqwiyAxM86nwDR6z7Q8frJ7blRs4AoRCUxHZFtvdGo1XJqgQXDWXeBAMC01C4JF6MvGEwoTR0pc/28XVmNTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7841.eurprd04.prod.outlook.com (2603:10a6:20b:244::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 15 Oct
 2024 15:19:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 15:19:53 +0000
Date: Tue, 15 Oct 2024 11:19:42 -0400
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
	linux-arm-kernel@lists.infradead.org, Ye Li <ye.li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 5/6] EDAC/fsl_ddr: Add support for i.MX9 DDR controller
Message-ID: <Zw6IDnkVbN6aErTc@lizhi-Precision-Tower-5810>
References: <20241011-imx95_edac-v2-0-011b68290951@nxp.com>
 <20241011-imx95_edac-v2-5-011b68290951@nxp.com>
 <20241015145234.GRZw6BsqnIbaGWMzG_@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015145234.GRZw6BsqnIbaGWMzG_@fat_crate.local>
X-ClientProxiedBy: BYAPR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fbd8cc-9d24-4c6f-7ad6-08dced2cd19b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LlcIgahlQGyNyJ8Y6NFVunYAJspVsivDQKEejNTaoGJwa0HMfOG7CAwNeuLU?=
 =?us-ascii?Q?w90bbui0M7Df/NZ+TW9b7UTQ2fJzzcB9/XTckVaAgLYjS6qjnIG86XKVWogM?=
 =?us-ascii?Q?ouc/hv1Tgdo4dJ5fD3WSFQn8DdXZ8TDDOvIxas1qVtKF26hKxc76arXwFy7q?=
 =?us-ascii?Q?hDBTYmhG3XEIEDilT1EgKIUxsn8PUBO39mNxbjQVgIdA6UEdiYm3TQlPT1yD?=
 =?us-ascii?Q?UQ5XQzB7BUtku1tBiaqOHlmtw5fE1dn+Z6BZpsj4gquw6JdbzkRs28GuTwf6?=
 =?us-ascii?Q?ZeWQJPntf0/gz5fC2wpvdWr7ZW+WT53DpIm3BUXdaXAbQmfvzDjBUcq5MfC6?=
 =?us-ascii?Q?Vq5cTByBD91ZVlZeWqJqcajN89VEsF7bBzK2pb+xNYmX16Le6+oqr4eYtCYY?=
 =?us-ascii?Q?r/pEj/FkQvxAJKoEjrY8NhF+zKmUFKPfyw/i4zFu4AZcaKeZhpbccyUfBzez?=
 =?us-ascii?Q?S96NB5nZGU1bCgZrixJwPPdZR7jixEPyVQPJBR7vOJNw6L2p6UAIVrqjnNyn?=
 =?us-ascii?Q?U4/VhHJ+Waw3G2ByOcmINeUnSK/DlqVpNzp64d4ktGPgS/YFGjN6VFLGtcER?=
 =?us-ascii?Q?o5LcqsyqXwL7fgXB491j0aSf0oRhQJd6qIKiaIl5n3QCmHyPZhiSKhVlZ4Kf?=
 =?us-ascii?Q?8gxY7Q0DQ3RVbBAhMdPUDsn1+bVbBckTwdBzSBY6nttDnF/y9GXY3RfVUmXd?=
 =?us-ascii?Q?1/jQ+WS0mmkqgoim7T4LMZN19t3bZRGv9ZO1q5KDpHFRbS7HIFmdgnWJ65by?=
 =?us-ascii?Q?kB2tSCUWHC87vDKe0woiouYFTcGWIxHw7ksNw1YecOgeVEgKpCs+PeT5dj0d?=
 =?us-ascii?Q?4YAXVJyhJpL9dzkjAaXJDcFBqyamuUzcwp9DHSghW6EDoAPXv3s5fmC3HXY1?=
 =?us-ascii?Q?qhajqNu9oKRKQzPB1nSpUmYTXphC0yXgepuPid4WduRztG5HXlOVaGfgHNan?=
 =?us-ascii?Q?XDKgp/9LfG/kQgY5oLFXODZn+FlO/RjYbOHFcwcQgVr59ASdshg0wP0R3FqV?=
 =?us-ascii?Q?d4+6RHMnS+tDORgDEpcwJ4S7z6uMl6VTtr7CS7RQ+KBTC55JTnnBF+AMH/wO?=
 =?us-ascii?Q?6SBk9eI/xnzTNDZ9EfiuxqNlECR83fzPpdZxpenL1vqnuJLs6GZTGQqOjj/9?=
 =?us-ascii?Q?D4NVG37XElRd77n3n4BKkxKbzgHEEQpwD3KZEauTJOVp1aJc8j4cptXOghxg?=
 =?us-ascii?Q?02uR0E420j+Z0DQPQ4GsyqxzUtbZzrFYj4g9rkEy2NgMXPHfuSJ2sbWSQLVb?=
 =?us-ascii?Q?eBIZ3adU7T8yAR49seoid5HnfwREDd6cSqljTXfHc9t8G3wgm+yT6wU5uIfs?=
 =?us-ascii?Q?/cbH0o+3ETVz9NwiZWs5+MtAJGSJFoPd+DLqYNUIxMEQMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qeIN5X+bQg0RVFlbaSgQQD/MO7BBt7UPbKsddseo9i/DKLtD4PxeYa2bQhw5?=
 =?us-ascii?Q?iQIMi63ZjqFn/T41KYOMe6beQDEQBzOVPN/vc6nxdgL0SDUo8hCZvpnehbeo?=
 =?us-ascii?Q?LuI2topj54O41t/QVrq7mmadvHHwF3Lx4GUv4lGwRn8gJzJ/LQmC/1a78jmz?=
 =?us-ascii?Q?ihXRtRCqgoxMKKWuuARXDuqJt0n5M15/cnIBfEE4R1b2efZVgNTrsC9av3gB?=
 =?us-ascii?Q?nDddq3LeeT1iSL4DTr4jtqsyHjKg7DcajHop9ygBDjiEZaKac5FUaT1NTLfx?=
 =?us-ascii?Q?7HcrPCLLzMa+n+C6BWDXoDM4E4SEq1ur5tHNz0glaiSD98zb+xuCHdGEpTGu?=
 =?us-ascii?Q?74kzzj52poMxugIXvtMIhErEQQmmjK88Sc7i2ZY+LtGEhqTT+lDwYvjUMKwh?=
 =?us-ascii?Q?pT0HWK2UUt+6vRLajwgYPojHOwAGLVgsT+NRS+MR6imC0OV9cbJzuaN/zTsi?=
 =?us-ascii?Q?2ckd4Vs3ysJBZptJ6kV9NyvMR96othdklCfilZwwvsvMxRZkC0cALefaoDzP?=
 =?us-ascii?Q?TUa5/5O1WK8Vq2mOv05BQtS9nzKYM32wK5IRrIuCwEbl60r40vwvCq3vbRUX?=
 =?us-ascii?Q?5yfaSu449cOcxnjZS56E9VAj8ffnEAJ4neNg4wtTHO1DTwppiWSgKMF+rK10?=
 =?us-ascii?Q?Yj/fAhKAuWdkoc301t4zQQeuvoaqucPrB4z00enjFDTNR93xvgIWdwrNEPe+?=
 =?us-ascii?Q?p/xPiyqItr+Az9UJkRbumBfZp2+yVA1NO+I8HhZ7F9hHivwmLxs5iH1TvnK8?=
 =?us-ascii?Q?9W1uHLKeId+1bSqpgNYz3G6VstEO+h88+77xNiL6dQ6V3ekRkWicwuONEUG2?=
 =?us-ascii?Q?xE3+JNezItbgjDaPyYx8vgxU3ggY/Yl5yU/mE+3esPslbETXgw1sascsQCG7?=
 =?us-ascii?Q?f+fHAp3X4cvpaaJn69yDJHA94HHlEY5TcqSimnghJpdvzqZgVPm307O9nCPA?=
 =?us-ascii?Q?3sUqck5RIZcAFVI9srqpOHCRwS8cJxzhiPkTBKbIG6X7fod7SIEkG0f4TlJl?=
 =?us-ascii?Q?dirWgw99Bax6NdYhbmo70dMrNb6dQFTq01wEsr4u1/if5RJC1RAGd29yYedx?=
 =?us-ascii?Q?5yAjzNnye84zcFcz8xtZMDidpvSyScQavcRuXmD5bgFG2ZBY3a4QRuavoLms?=
 =?us-ascii?Q?Ic5yQqET7rth/K2E9wEBO3PQBN0wpMVlqOS3EvXebXvrw+OWmDPR0JxrOBHJ?=
 =?us-ascii?Q?qTMphYHWz7s5/PZszFjoUcuulnfdwJdynpr3yjELPcshhmavrU41Kty4EUyF?=
 =?us-ascii?Q?61/OGuuFEMNxmLuMGteg5hsNwI5qqWt7DVHjLQHzzdouxuUSc3gKW4QasORD?=
 =?us-ascii?Q?Gc16VUFC6n5gniDIrSfu2FqeKZUyaYjnneeejLk0aSTviFNCPZmSf3Ci8aCG?=
 =?us-ascii?Q?sHk1hB8yHhETzUsRc3nFE8zDV+JNgWnTL9yf1rzsb1Kj1SRLOugfxynoeMmE?=
 =?us-ascii?Q?MaBLeusp2b5xXtutcy/CLNrBvZMIh1W9942C++Xc8+DKYAdpssRN1UjM0IZ1?=
 =?us-ascii?Q?kVnBhrDyHakZolmr9nmpfFVTUJTDsgo0ZGxlrAKoIb8RPx139N1LioqqzCws?=
 =?us-ascii?Q?j0HHuSmFEiDKHas6zBE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fbd8cc-9d24-4c6f-7ad6-08dced2cd19b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 15:19:53.1875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUvBIfk7JmW3FcwEIk2tLvVK4ZKb55CbeWuGRUzdxqWNvUmQekU7nq8w/VRnrN5fc172NEZbtOjuQptgC5HULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7841

On Tue, Oct 15, 2024 at 04:52:34PM +0200, Borislav Petkov wrote:
> On Fri, Oct 11, 2024 at 11:31:33AM -0400, Frank Li wrote:
> > From: Ye Li <ye.li@nxp.com>
> >
> > Add support for the i.MX9 DDR controller, which has different register
> > offsets and some function changes compared to the existing fsl_ddr
> > controller. The ECC and error injection functions are almost the same, so
> > update and reuse the driver for i.MX9. A special type 'TYPE_IMX9' is added
> > specifically for the i.MX9 controller to distinguish the differences.
> >
> > Signed-off-by: Ye Li <ye.li@nxp.com>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/edac/fsl_ddr_edac.c    | 48 ++++++++++++++++++++++++++++++++++++------
> >  drivers/edac/fsl_ddr_edac.h    | 10 +++++++++
> >  drivers/edac/layerscape_edac.c |  1 +
> >  3 files changed, 53 insertions(+), 6 deletions(-)
>
> checking file drivers/edac/fsl_ddr_edac.c
> Hunk #1 FAILED at 31.
> Hunk #2 succeeded at 442 (offset 4 lines).
> Hunk #3 succeeded at 478 (offset 4 lines).
> Hunk #4 succeeded at 492 (offset 4 lines).
> Hunk #5 succeeded at 520 (offset 4 lines).
> Hunk #6 succeeded at 550 (offset 4 lines).
> Hunk #7 succeeded at 577 (offset 4 lines).
> 1 out of 7 hunks FAILED
> checking file drivers/edac/fsl_ddr_edac.h
> Hunk #3 FAILED at 71.
> 1 out of 3 hunks FAILED
> checking file drivers/edac/layerscape_edac.c
>
> What tree have you created your patches against?

I base on linux-next: next-20241010. I can rebase to edac-for-next
https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/

Is it what you expect base?

Frank

>
> > diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> > index ccc13c2adfd6f..3e4c2869a07cd 100644
> > --- a/drivers/edac/fsl_ddr_edac.c
> > +++ b/drivers/edac/fsl_ddr_edac.c
> > @@ -31,16 +31,28 @@
> >
> >  static int edac_mc_idx;
>
> I see here:
>
> |static int edac_mc_idx;
> |
> |static u32 orig_ddr_err_disable;
> |static u32 orig_ddr_err_sbe;
> |static bool little_endian;
> |
> |static inline u32 ddr_in32(struct fsl_mc_pdata *pdata, unsigned int off)
>
> and you don't have those in your diff.
>
> What's up?
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

