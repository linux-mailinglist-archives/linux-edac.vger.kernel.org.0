Return-Path: <linux-edac+bounces-1956-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A2798DE1F
	for <lists+linux-edac@lfdr.de>; Wed,  2 Oct 2024 16:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48CDE1C216A4
	for <lists+linux-edac@lfdr.de>; Wed,  2 Oct 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88F01EEE6;
	Wed,  2 Oct 2024 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RxQdRYB5"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2E2F44;
	Wed,  2 Oct 2024 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881151; cv=fail; b=id0tCiTqKHdDOCZjhBV30AQc0VpgOmrQNHwCTCw5oViBe3dvuXGMZbfNV7lUzTqqYJ88yT91nxmLcaWSkYe9ko4zNYedn1CGuUilhAIyKua2T8i9y7qhhxeyGi6mWmsjbO5guFDpWtH0RxBsRmrXdI9xoUa/Ju6Wiu94xVvEuWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881151; c=relaxed/simple;
	bh=XDRA7KD17wtEQovHi9zLoF6KZ1+7lOlWfCJkL9jPwQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cgtATD3O4sGK6HkdOq7tWmK5e5k6KfO7AfC+DVZIdYS/epNEr9R3hdauxq3QUxC2qY8QmzKvPMO8fLyUxRt50z89qFnDVmbvAeL58RSqP7oeJ9cWvFy07U96mwwsAeR9Cq9+pHEoLtYAlJI3A/DJcsFEiDtcn2p5gK/hXBWh0Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RxQdRYB5; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzZcbojb4T6kJWfrogjkj69lp/gjt0GZwhwk2PIeWzpEXQQSdCu7Zb5kdFV9kRbeCU2Sm9V5W2ny6/IIQVCFf+1jVJ0uTXFmwRrJQ/Ns/oNVgqRXhZlENzWNGxM/C32Kr19AwtLD2BsCmepGwJIr8zwddvrDqPbBpfcVY73pILTZa5r9CgD+qBDSHMtAK9jJDPLo5D0xkC5n7YXsiH6W952n/gsLejYC5RA5JjxgmiZrPr0U3JBOfXPzlIx4CQBqWHTxaATJQYVmeRrPr+nrkW85TJyN0HWUsI6IGqup5jFacNMIPfustserbHbCk5soelcIcN6bjzNgnrSOwooKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqv6ZGJwh77JH5AJv/jt4zuiVlcp6Za0UzYRuJJDqMc=;
 b=Y+HSHaho7Ko83ZxdKB+65EGBCnKcTq1BMAdjPsa2eliz1RxPdkwWcTjm3PTnESLGQvkKedj0T65ed/tUckak0S5OkDOKdKfbmWYhsP7mN8Mzzb1YtVGMceR9Vg+opAxnpudcdQIWxIgtzayCEP1znBO8xUScIqyvejqZaYkhYuNP9002OnnYn+OLieLXEeqh2dzQEVCcQE9AD7ZeEgLMOGDgx/7Vvi21YH/JSdCVynH1A8HlzsZcMq1NnMt3084GCYtgfoa7qaWRLVF1CJR99fgPTUa9zOyIyV5L2BZCvjZWPcFpmIvIf2r69aGf+zrcqTqY+/mt12LlKEnlPNhcsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqv6ZGJwh77JH5AJv/jt4zuiVlcp6Za0UzYRuJJDqMc=;
 b=RxQdRYB5CgOBXp2hDIjFABlXHuPTvQqr0Hhi5jqOyAwYsfunNzAjpMOYxDFKLKbJGRZkUHBM5nY4L280svmDgAhg7iu7N4BbdfIkI+gkF4F0btZtYKqo2L286p03efhBSGRSfsAAeO6k9/1xMfCIEDRKoXMQVrMDgOWz9DJRqZ5ybVroNKNKYO/fpb1PnKVl0pm7xaK9f6a46Ocm/zhTBxc+gKirnGHn6oRXELxBLuZ1XT7oP1miG+Br/qA15w70nsOuLfJ2olfk2Ez+YbWfzh9K7cA3S1Itqc3qym0h1dEgt5ZGc8Soj2L+AJYXA/pxiGdu/oGwkq35IMlP03dw8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7148.eurprd04.prod.outlook.com (2603:10a6:10:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 14:59:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Wed, 2 Oct 2024
 14:59:06 +0000
Date: Wed, 2 Oct 2024 10:58:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, York Sun <york.sun@nxp.com>
Subject: Re: [PATCH] EDAC: MAINTAINERS: move FSL DDR EDAC maintainer York Sun
 to Credits
Message-ID: <Zv1fsvP5b3a5Vz4l@lizhi-Precision-Tower-5810>
References: <20241002105211.43276-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002105211.43276-1-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 60824932-9648-4e56-e748-08dce2f2c2e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KqajRWfrQfflsOrUhMSQGKvWLMbcGAGVnNBpC/GYOb12FOeR+bfKbhlDUR6k?=
 =?us-ascii?Q?CQgG3Q9/As/mg9/O03dGFPYRQK+1V2t3o8v35Ucrfosh1fbEIzqACASq0awE?=
 =?us-ascii?Q?YT9we4jzLSEz4LUMJFffVY+/CtchQQM53tzsUQHM5AGmp1fxFeE1pghsuHzF?=
 =?us-ascii?Q?XwM8hh+W2r/u3YboOcg7K3zdne2fmimuOTif7aty+apKmPlqRzstLExzHwII?=
 =?us-ascii?Q?JbxXg2iwAlu9+uOdSQSKk/Wlmw2MyA100S3d6j9iuT9w4r2E4DqnYRw32wg/?=
 =?us-ascii?Q?JtPPsubiafutg605t9Ax1PUYW+R0M1nSWReAljxaFsRD84DtC/c+MD7W6KAa?=
 =?us-ascii?Q?Vd4ENhtgkE9bPg2R8Cvx6Op7rl8tkWJv023VsSF19eaRWTlhrANsrMPeFBqz?=
 =?us-ascii?Q?gFdeniYVbUwWg5HKEVYfhKtKVUZO2hajxWlYKul1+T/DrP7MCZUGxfIRCpoJ?=
 =?us-ascii?Q?byRpuXwif3T6vn/bGFcZfj2AuvduIx777XYMJtd7XHnYVpTLDQ7HZvc4uNEV?=
 =?us-ascii?Q?kqNntE5PfNOmwfrjs+kTMaT/vb1LD1GLgocEkQwb/cT/571p+QkiynYDGUKW?=
 =?us-ascii?Q?1cZoXtH363m+meNU/wQrGAemwSFk0sT0c5bJ2NzN+ZeBZA7iXEhWvZrQ4RTI?=
 =?us-ascii?Q?5TV1fE6MR2ID4e+k9+SNM2Kf0HrgvF0YypXkVGeo8GlgMMtKfYR/o8PDO2WE?=
 =?us-ascii?Q?sHBBYMAAQw8cVW2ESBYNhhyLSaGPqtAgAf2XUVTx3FXuxu92/CHL9+mdBnBb?=
 =?us-ascii?Q?GqRjWYzGOdfXelv3Zsf+XqyjMh5wjn9trhGqAr/QZEuQ9fYbM9A46xyHddNn?=
 =?us-ascii?Q?+m1t8t6nnLy5qYidEsqAQrCCTgMFG9CzbYT6aQVPd+dhb0ycfvXIifx27T2E?=
 =?us-ascii?Q?juELYiEc3593SxzuqXrgK8XnxmK7kdVMxbcVtqqAFx8YyFmwgV7TOGIARkrW?=
 =?us-ascii?Q?B3sYB3uksr1W+DHMB2jEpkvd2gd41FweYnwIn3EEmmLGxFxpcXVdQVLBDAD6?=
 =?us-ascii?Q?QTMbpL9hzMR/4kn6liCvJ1sBKX20/Rgni93yepBRBkBHg269Q8Zp8sRpsCQO?=
 =?us-ascii?Q?6QQVNBrQYq9o1M4Lm7Wn9hhrYVQ52968oi00sHGEijC4Q2ZDzqWgknFccHzp?=
 =?us-ascii?Q?r90KIcoTBp8SGVcbs47s4AA35LwmMqi9+f4cscnQ0IAtz739NMEYk2w2AoRR?=
 =?us-ascii?Q?5UnAIFDaGC7AlpaiRpLEiMG4kMylGnFGcKxd8ZdCusEQioO6pGg7DTz+BM8t?=
 =?us-ascii?Q?uKb5Wt6scGs5CmiRFiLqaXUzU3RmCf13n1H7PDRZXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pwr43Bbhuq6JwtkD7lY7Jfhx9PTZURGwH5JrdAbGjFJCiFE7Us+qBNZM1yF0?=
 =?us-ascii?Q?2wm/Slmb2OaKQs9dVlgxdwIkO3mSeCj8cPE7gzC4VAesSBikLIjT9iytcdGl?=
 =?us-ascii?Q?P/As1SYDNf4d8COGgE/vy5TYTguJTj3A87+BptJkMa3fLu76W7fkdhj5Uk0h?=
 =?us-ascii?Q?F94Rn2swgFZbHL/PuXh1VtFSRt4X5xWOxn7LVEywwdcDRTREb98SyAJuvsLY?=
 =?us-ascii?Q?tGauNaW4wb2D8nXYRhpeWh/rA3LoT9us39FZd46sQAZQWOLhWuzP8EFSMqWb?=
 =?us-ascii?Q?Zu0+tzjFRNJ9Riz/NfJL+vTMXF53i7fbHnAiVsR4BwsPvui3nXuC/rVTJgTN?=
 =?us-ascii?Q?5iFCxCOk2jCfCtXszJxiLJUlhaN4Bg+KRnTVekK3TWJEqTzrh0H3xsAvKbq+?=
 =?us-ascii?Q?xoJvVjD1T0+2E2QaVv3oeogYJl3+DRSODiO2sCm+xOdBLMol76FUpTUIxkc0?=
 =?us-ascii?Q?qJe0lpgZc/iCabpR14uRh1f+73sllEKvD/BfRO+5fqxMyEe4jkbSfaPFax4N?=
 =?us-ascii?Q?c7lLcgQaRRKd+W1PEobExnlxdfmMZ/BlVUgZfs98jfCPbp5SDONkKftO0JnB?=
 =?us-ascii?Q?4rFUCyyJ2yxF9yWnStHtk/hrBp3wT1TH4Dvx/NkmT/kryzoEBdlQ6DgXJfZ/?=
 =?us-ascii?Q?0loFz3mRyHC3rwanWlBgSLuftpz4G8UHf8SeSFiNpqhlPj8H7C4EnaWtkMPe?=
 =?us-ascii?Q?EZ69+mFX9Yz4Q3v2y2Gh9YmMWgL0w2ehaCxPY8Mn3/7Q9unDdNG3xhazDHVr?=
 =?us-ascii?Q?4WWK3wDsUpR6j4GzTY+KaJahv42IJjfftD5I9tiDAz4v/TdJ0e7N3pu2m4eh?=
 =?us-ascii?Q?eHi8Ov4p8/XpMEhLzpqKoqGiLjHNvFo9M4aw95A9kM5srULy/Yo+5ZRBsYvs?=
 =?us-ascii?Q?UlBKZpXu9pNg1ozoLlBA9SOLK+JuoDNj4ZEZ7YrQn1vbycK3mSBDqsfpIMok?=
 =?us-ascii?Q?dpVD/h79kYv8IPx/PX1Q9ZU33f4RlW0NFwvc1VYVN+6lZDAQ9h696AjLLcxj?=
 =?us-ascii?Q?gZwKCuLUKCV0nF4+FmMYS37xPwTbmIQRYUbYIrWCc0s1xpOlGQ0+M6rmtYrL?=
 =?us-ascii?Q?5zvDj11bsFIO46t4CVh80AhIwlrQdw/J7Uz8bxdL8xvtKlsZ5hUr4vVxD4QW?=
 =?us-ascii?Q?eWgKqsTBRomK0YogK3NtW5teuuPsrLX9VRkYHag0u5QG1Wf81RyEIAdmN05k?=
 =?us-ascii?Q?ae9q6XaGMRXsy4okxLfR7Tq4esQ4e8YJntYa4G4shOGwHnndtR+lKZs/Y41Z?=
 =?us-ascii?Q?jfc9jTJbF0QWaRus9bgkH7dsQEYgrzmy3U1c9Xgauys3sI1aoQm8+SGJRloK?=
 =?us-ascii?Q?680gJZox3S2FpkkUWDDswBMwIIU8Gu1Fq9edyUH+X8pUYnfiMMBRBopB1T9H?=
 =?us-ascii?Q?saHiF5+Y7xwxME5UjcztUYbNLmpXhldYwAkjbNvf07dc4xzIuOBoLJQwhq0U?=
 =?us-ascii?Q?PP7p1LEcBJBwvqSjv91DEma0riULhblau9ukNPNhDNYDH1KFyHxDgk0hI2bF?=
 =?us-ascii?Q?W3JuVMCSrDqVk5RTJ+qr1GEN7TPGBBE/lhAhYn4xgsAL7tfm8yC3vTZkveNt?=
 =?us-ascii?Q?BRZOa17JfLRav0bi4ZHJ6Rj+0RptWhg4O66Cmjj1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60824932-9648-4e56-e748-08dce2f2c2e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 14:59:06.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CA+MCssgaSg6hjMuXKxQLAGwX1wJeQBSOQVtueO/3/SKfJhXZTDAEA7Rd7jJUni2D5gKnK+hNbcAwM4GvrFDRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7148

On Wed, Oct 02, 2024 at 12:52:11PM +0200, Krzysztof Kozlowski wrote:
> Last email from York Sun is from 2019, so move him to Credits, which
> makes Freescale/NXP DDR EDAC driver orphaned.
>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Cc: York Sun <york.sun@nxp.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 3 +--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/CREDITS b/CREDITS
> index d439f5a1bc00..77b4760142f6 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -3795,6 +3795,10 @@ S: Department of Zoology, University of Washington
>  S: Seattle, WA  98195-1800
>  S: USA
>
> +N: York Sun
> +E: york.sun@nxp.com
> +D: Freescale DDR EDAC
> +
>  N: Eugene Surovegin
>  E: ebs@ebshome.net
>  W: https://kernel.ebshome.net/
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a77770cd96b8..b9e2824d7ebb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8130,9 +8130,8 @@ S:	Maintained
>  F:	drivers/edac/e7xxx_edac.c
>
>  EDAC-FSL_DDR
> -M:	York Sun <york.sun@nxp.com>
>  L:	linux-edac@vger.kernel.org
> -S:	Maintained
> +S:	Orphaned
>  F:	drivers/edac/fsl_ddr_edac.*

i.MX still use it,  I am volunteer to maintain this driver.
Also please add imx@lists.linux.dev

Frank

>
>  EDAC-GHES
> --
> 2.43.0
>

