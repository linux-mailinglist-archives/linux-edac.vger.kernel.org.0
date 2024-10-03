Return-Path: <linux-edac+bounces-1962-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1065A98F7FC
	for <lists+linux-edac@lfdr.de>; Thu,  3 Oct 2024 22:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B47B218AC
	for <lists+linux-edac@lfdr.de>; Thu,  3 Oct 2024 20:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69FC1AAE05;
	Thu,  3 Oct 2024 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HH59FlwN"
X-Original-To: linux-edac@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761F126F2A;
	Thu,  3 Oct 2024 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986904; cv=fail; b=TRDw6mc/tlCJTytFAke+fcZEBDtkxWJF7Uy4HdjhgvkttdI1ST4aDlWTm+FSVkK7Ef2ERqCKy+eKp/nQWUhVxAxGhqZRlpvIcVhfbUG4qhxHxRaE8griekRvFz/1fYcPzSxENrJ5Ev3/c1JpsdknvSIga/QiJpTHDi10CAcCAaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986904; c=relaxed/simple;
	bh=po6C7cu7OzceCQRommR1MirjwpyUgGAbxuA6hT7VNwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HYfrOZiFHbW5sf/1Y6lo2L8Q9Q00HpPZ/Ncar152t9Y6OLGAJ8L+9H1NFTk6xY6nGXoILhuWroXmV7iFT+wNZUSnU2pdozHhQN9W9fcaJI3AkHllzhteoVMijRTu0Pq6upROR47hqwj43pO3g7ZQIUnsGn/9Bv8dbfpfIjQza5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HH59FlwN; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfJnHCZ4aU6wYFsC7pgULlai3+knXqZEmloOHciTPSrfYIMkI3xqSUkzxG03i6VY0w9nw2Lq+ZT+enM8TozNZPuFSsK/z5aYRgpFgNGB4FBkjTVvfVpC6qYS9R0pSHdjcDMhDdIyLHvr8fOYi7xvhsym63X5wS4j+jfImeAmQtdxsJ/vlD5t9t6pnCL5nqsOtOycccoU+MQOgCZigztcWoEcaVV6Xf7jJudkddf5Wy33DCzuDj1scYcwy/YTHec/SXdrbtHa36CUryny2FQezodqN5eySVZz5odei6gP8SypM4wHN8Ai/btiH4OW7CKzea2zW9ZrccDF8KoFZfFq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Tx9LdmDwzEE9NEduIBZCpyoKkobKkUtnGiTfrmF0UY=;
 b=g2mAJqx3SB9gysajE7vW4/OCbq6QQ/NTt8Qm5FAR8RIlZYzhL/nxxpo56rHdYC70Wr646B56zNLM/asMZ8RAg8IBudw3E1DULxL7ej1gECQIxNpBvqB6wkRddw9ezbJU8eBWXg/1lDiuMX5+e72toQsczAXkV9k/uXCjzBQOMO5gGUviuCiM66mFUIQfcZ7UUrbLc8yJ2xm9WX+0FT41afqte2HHBQiO51+GDLDQEUZMN7pjoiGvk2dpKGEzohMJ2YlOFU5N2Up1/rAIbVwDIXagm/pyedZLrEQ1eYGhQZgshDAaLVWvzOFYIHp3Tqn7zbJtLsXYZHw13kWY9nhx1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Tx9LdmDwzEE9NEduIBZCpyoKkobKkUtnGiTfrmF0UY=;
 b=HH59FlwNVlkw5J97IEIFhQRxCUif3z8gJ7EEjCpizdaepdIOjT7bB8vsgcLWJS+dF3wpMioUFG6FaIkvQ6qgwBMA4wx11OdX2buLSdLZAejq9XMbon0kHW1ZftbmYbANddDiB+s1m0A8KydvquUmsNSHEaQ2ji8rTZoxq+3u+QLTdzRpvvhov9ldMWhRxOQm9koz77pYhwKnvOLLIa1BaB2nw/ZtP0BUEdg6TsAiqf450/R/l0gN/ppPM3lsSiMMAtnm5idlqDjP5v/Vajb/ZYL6us8Mh9Olnj6YRorDjMzUEjIHVzSEcxHjjMIo0HnjDuzWMBbzU2nZqcGQ+5lG1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 3 Oct
 2024 20:21:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 20:21:39 +0000
Date: Thu, 3 Oct 2024 16:21:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	York Sun <york.sun@nxp.com>
Subject: Re: [PATCH v2] EDAC: MAINTAINERS: change FSL DDR EDAC maintainer to
 Frank Li
Message-ID: <Zv78y/ZlHNC5RiLs@lizhi-Precision-Tower-5810>
References: <20241003193348.102234-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003193348.102234-1-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: BY3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:254::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: d749a545-763f-448c-259f-08dce3e8fca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hs1EmlQbPTBU8SueJIqJStcUwsVYBu29CMCsQoxau0+mQYyJ/lFL4fsGTCf8?=
 =?us-ascii?Q?zzG3QlZdR4QM1+mbPXDXUPUm5KZ/wygMN9P8yotEbLI+nKX+tUa4p9i1u4DQ?=
 =?us-ascii?Q?TECo9zaxeX28lx9LSwD3pDILWt8088+iu3MzG8nI+cbchJA7NuF8E9edCqD6?=
 =?us-ascii?Q?rz3y+JB1JpGFLQ8Ca24vV8j2hBMxuK9F3fJacHCD1lBdyIRAyrh2mwN+zEOE?=
 =?us-ascii?Q?JNthjcUoAniYnz0j1X+A+KBPk+IWG0jJdA7RiyZjmfl5bpox0doWqmysXsqq?=
 =?us-ascii?Q?5/rcdsLYaZMw4Y10d2hoGDoue955LjMU4wKqVWtX1B9+Y5a3kSAGcVh993QL?=
 =?us-ascii?Q?FLjwszGdcSyJakXTIJr5Xdbo1b5eHu94SGTtNnTl9YcJUGF6FqMouLD7yzRP?=
 =?us-ascii?Q?HRe22P2fBKeMkPdeZ+SXNbHQGNb2yAsFvmV9hXfBUQOX6CJg8vy8kfYOIEkj?=
 =?us-ascii?Q?dCMtMoZ2itjFhUyLiECnF8qhRfE0iPSifvcb+GVTXPs+uW4sEmAXz+JqxGeZ?=
 =?us-ascii?Q?fhpDrHOZ7rdx1FitQPA7NsFgQQ37lCHp7ryHe2/RpBqS3NA0iS92kIS3X9Bj?=
 =?us-ascii?Q?x/qBMhlBkQMD2paeJugOczFSSIpUU+hCw4ymx1luJjDtNEjDrcVSssmm9NIk?=
 =?us-ascii?Q?ggsoiwc9MJcWB7HbY5RY4gREGi1bz4we5o1yito+NXCnVt+rbbaHPna5uKJq?=
 =?us-ascii?Q?NTaOSNnPb2SxRCTvHOfy+dby5ui6tuTX+2CDwk8hj+UJTVQkg5rbMncRxE7c?=
 =?us-ascii?Q?t6pwhKt2HzG5Lyeu3By8xeKuwG2S4KR6MFwQ2P1HTS5k8jRfZE8P/4L6AOiF?=
 =?us-ascii?Q?WTkw5sm80Ze/Y2+SGRKHgcVYHIsgPPyonn3K8WJ6uVpPFk+K62oSoJcOf7i/?=
 =?us-ascii?Q?arN4wmnm7IiHbSs4OIx7lbqAbMNil6Lcpou60Jxehl7NA0k304Tx5ki2DlcW?=
 =?us-ascii?Q?RHDxSRLMBpd/5jJRaFDb7W4Bs7Lm2S+u5q1o/OQvL57x7AIRxFk/A5ZfiK3I?=
 =?us-ascii?Q?hYaKSFnvHfzY8pPrCl44zV2XHA4XksWMd9Q2xTPu3tRDfTPuiyvwqOL8/8QF?=
 =?us-ascii?Q?oguVniv5BTubb+gtWkx54vQ1GfNZp6fqU3P51MV19Ic0QQad+QOLgjfuKS+G?=
 =?us-ascii?Q?t7hj8dS1jWxmDrHdqYtBpMdqCAFu3QBvLu2CnYleyK7hEtnATkR6r0/eXyR+?=
 =?us-ascii?Q?Tzn32M4FbtAF2DtiOGdKESHkw3F20wVaNaUPVC7hUzalguGdW7Ud9tDHDwUd?=
 =?us-ascii?Q?PngCOhUEjTA7ilamYbj74FXhWSMsYQwwOpHUmhOCVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?60HIOGP2ivjOXXYi7ZLkLn2vzaJbZ+rHusnsh3aAcqU8yuOG3tQwlHO0AezX?=
 =?us-ascii?Q?4UMVFZQYIICuyV7Ac6lZFNphWBnGwLZ8ZNVrH0AZfOYbI/H45X/TnJT0OLyB?=
 =?us-ascii?Q?cp+gvXZUl2HU4WDsYBRmdN9BJnXGa0Cb+ASw18+0FEqkYplRT5AOitoEFD4z?=
 =?us-ascii?Q?MW0D9bTlYCpX6hYazTAzkgLh4gcb8mwuz1+4wzr9iE2VJiOXOPry5V9GFjsS?=
 =?us-ascii?Q?67R2xwn/agEZ6aumsckJChp+74vUtObj+Sk22ySTmdh3Dn7tBQrrxuwIYZpI?=
 =?us-ascii?Q?3ASfNQ7JoXc0J0he357uiUr1x489Ckp5bs0mLfKNG/8blE5kFnyxv4QMosEk?=
 =?us-ascii?Q?fCd8X1Ae/zwNypI7aR4rBWjTvw6NR3jC16iZK3Tr++wTG6wAeEaV9pvmeq7H?=
 =?us-ascii?Q?dm0BsL2oOwqPr+pEhsCfLsozjL704RY1ZjAb4jRVuV2SlUjpRfy1yCtLzHR1?=
 =?us-ascii?Q?n+ZCh/16Gi8fG87N5nKXBsgtAQoUvIrp1Iix9eG44MAZ4g9+NqWWWNzRUcBB?=
 =?us-ascii?Q?C6YPOLWeJiI98865cLmgkPNMCUqvwx24qvIgfFAhfwSpBNjHdy192/8HXV5X?=
 =?us-ascii?Q?mLvN2o/msA3mCuN0ktFOtpWJYYZBf5qUk0z9eySWq2vLs7drXqjeqbqGEZr4?=
 =?us-ascii?Q?7mJ94ChjJhnqon5O9InryEXHXCjuaXATT5GzQaQRnJAVk6M9q/mrPP/ZSrcz?=
 =?us-ascii?Q?BNVimPynCoWqezk7vnm327yvI+DQ1XSuW58f4ZIgS883UtRq5czAAN8I4Yr2?=
 =?us-ascii?Q?O/nlHqiwu6+3OpPAa5dwUsUrwQOVgkluv3wyDd3qLja/8kTo0elLaAdD1d8Z?=
 =?us-ascii?Q?FDWzBz+wqIzRzcVHs6OAyItAb1qRE0Dad9u8yD9kLsUu2S2XycLBkRMmyL/s?=
 =?us-ascii?Q?vaPfxyki7aI+uQAse61FAGv/xRd1xjL2xADXqTAY0V5cJm6naR/1ZQ5dEkQ1?=
 =?us-ascii?Q?qFIvcnkscsnSHQ1VyIJnJMimjqrfWAFb1JLNWhVGOomv48CQ7P4GPtjlYF3x?=
 =?us-ascii?Q?eguC3IpPxb079vX7HrgKLO9NUJE8bq7e6J0mVAKKSzAugte8KZ4t2GP12/Ab?=
 =?us-ascii?Q?q7gxMntVMqf5nMBuKd8FHHagIRt17vmj4DQSlMghVrq5Q9Sbiy7XNVQm4Frs?=
 =?us-ascii?Q?Hen9SOE0IjSU3xVAEGv+OnbJ+M8AqC2ExsrKAbtZVa30UZ1wYr2SckfDROWO?=
 =?us-ascii?Q?qXeOYj3+GHWnFrO2zPvHxk9DKY6Xd3QcEsZKmNyixDA92EydL/MisqbWfglh?=
 =?us-ascii?Q?jBi/Lfdkwv2ySFfwYjOJkYZzILjMkDDFIwuZQLXAWeVSmJ+OAMj8N3isISKT?=
 =?us-ascii?Q?Ub1y5U2N+aGi5OUzYEqpao4vIDxJyUIWQ1a2DAGnzgcaeKGGnmC931b/cVqW?=
 =?us-ascii?Q?NCLASP2MiCqiDoK7CCJQk0FFnTnxC4vz3Vj60FGfFGriiSgcDFj1/7tIJwmP?=
 =?us-ascii?Q?gGSD3XDc9+yR/pTFPjIlOx3jss4lj0aBuCUfI2QA7uJlyhPKNSdVl2guWBu4?=
 =?us-ascii?Q?mZE2lBuA3NMfheT2KBSJAjLVsFMwv0++Qt4s4P7hrlksxMYw58cPgEc7ImUZ?=
 =?us-ascii?Q?EGJCyTcFGYtgqEWCrcM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d749a545-763f-448c-259f-08dce3e8fca6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 20:21:39.1376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oy8gQ/uEeGIY+yyeDIIwm5110SRctuCezYdpccevaGy1ErZF7CCrqzOfYl7P94xiB1kxUWe4QnCzrCoRwIAAaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481

On Thu, Oct 03, 2024 at 09:33:48PM +0200, Krzysztof Kozlowski wrote:
> Last email from York Sun is from 2019, so move him to Credits.  Frank Li
> volounteered to keep maintaining the driver.
>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Cc: Frank Li <Frank.li@nxp.com>
> Cc: York Sun <york.sun@nxp.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
>
> Changesi in v2:
> 1. Switch to Frank Li, do not orphan the driver.
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/CREDITS b/CREDITS
> index 63f53feefa0a..1c0ed4b16226 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -3791,6 +3791,10 @@ S: Department of Zoology, University of Washington
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
> index 636a84ccb5f6..03474c934930 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8120,7 +8120,8 @@ S:	Maintained
>  F:	drivers/edac/e7xxx_edac.c
>
>  EDAC-FSL_DDR
> -M:	York Sun <york.sun@nxp.com>
> +M:	Frank Li <Frank.Li@nxp.com>
> +L:	imx@lists.linux.dev
>  L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	drivers/edac/fsl_ddr_edac.*
> --
> 2.43.0
>

