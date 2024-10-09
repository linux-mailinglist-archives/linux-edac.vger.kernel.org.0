Return-Path: <linux-edac+bounces-1987-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 177D19970A5
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 18:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D603A283545
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA391FEFA9;
	Wed,  9 Oct 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V+kG/QdY"
X-Original-To: linux-edac@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013007.outbound.protection.outlook.com [52.101.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD901E3774;
	Wed,  9 Oct 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488898; cv=fail; b=oOZP9HWWoM4gwmrsmC6cSQbAGCh1c/Nn2cmaolAk/5mTwW4lfqPeHkSDIj2vPDNgIb9kKjY8JAeFQZPs+WciOGRKYxAg7x7z68fCjm8vk1T894NNKvs8m+259vaqAZtO/5bPyq835xzo9kscNIrQoXRuXLKzvh6LChO2bC4Pg/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488898; c=relaxed/simple;
	bh=kfU63p/qrQB/JgNkzZMUPq6+lNDMEkylPiqKSk2Jo/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=caqa2Sk1O7BsGym3SakJPPH9e6WyQZZcIoiJC36LjqUM7BD3WYhsh9qSk0fOgvkRtS1CohCuiW8XudMKFQksOVawV0/ci4q9eVT0KeIcAYZYcan5couaBPGkkcmG38zW6ewV7GJUbfgENZ6VsE9j3Mk0RR0fKBql3lER2TMSc1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V+kG/QdY; arc=fail smtp.client-ip=52.101.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/rGswSrm8pkp11grz9qimOaW1YYYxebVkNcbueUIuj/j8DwiQ9nF+J7wBrKrBzop9Md2fKqpJszscGAoFwywImINpJzNjg3V5UKNdM2Q+Ymq1SsbOMqWuzvksfgSWQSro9d+/fgZjo07ubnxwG93WiVB20x+DK5sN1rZGrPQyuiEyumg8exo5xRyETZra3Jq2XK2Vl9rK63SLWEIGscEWLYxYd8IB5X+4YgPn4gyEna1vAiNAIzA4W4bIIhWr6BMEMthks31SXuhXXLRSPucC0iydvpchllWuHasm8UhVMx4KUWNjYkh6qmLgbLcQDp8xtBkijrL/syH2w48p5Yig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bkb9yIc0unJoRWDbhXL/1rQU+xSBSyc1kMuYGyuEfOw=;
 b=UZv6NJCYFqP26t3SoQKZq1dM942014vdCdwxvlv7nKcszVGLb5lr4vjbTm8mAalhcteB/PjFw+RtsgQb+XbYE8XnfKaiKGsFigSwa0biRPXKE2KHHAYy7ANTV7QclXW3LP15I6+9R6r0Dna5uw/GQi1HUpyKbqZZSJ7xmvg8n80MWuaeFmRb+Qim5Qx3PyL1yoBfsdd81NMHLKHShDONwzyjZBhDZFDK/mugmMQyV7iezxNmn4pPe0CsCtEQFJgHi+NF+7oLNsWW0qLiBtivuBdK5FeYXU8oe7a3VUEWa0SIzTnywi/Q4u6iCgn5gUHkntpZ6haWbs3EyE36bfog5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bkb9yIc0unJoRWDbhXL/1rQU+xSBSyc1kMuYGyuEfOw=;
 b=V+kG/QdYuTjWZ5HItxc8j7ps61rbXYNy68QgqC+6OGzrVaiDsKCxthj/Ps9L3ly54oG0PI5hiJHq+tkTJl/TMajZRw+N6RMIrgh0fVYywRzakwXNwz3wXibQPQMUt0tf2+jcuijjKissb8jza87Oecu9Lk1OcjcGWR6DQnTLgUGGbo8MhE/BpmabeTbc2jUs753wRCmph5AV2yLlui2uc2tSXtBwjLeBTh4nlmvdqxOT13pgjs5tyH7JmkAAbofGLWvBuvsPc5VYTtRIJHTxc5l0wZWiH4VdMgC5BWVVLw6pNA92rylRZvCHuOUCSRrnpYSizNgTLL4tJARnifuiiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7829.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 15:48:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 15:48:11 +0000
Date: Wed, 9 Oct 2024 11:48:00 -0400
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
Message-ID: <ZwalsAJdaHjtD1/E@lizhi-Precision-Tower-5810>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
 <ZvsNJrxF6TpUC6ws@lizhi-Precision-Tower-5810>
 <20241002090834.GAZv0Nkp5YKcy86UmZ@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002090834.GAZv0Nkp5YKcy86UmZ@fat_crate.local>
X-ClientProxiedBy: SJ0PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 37dc7b78-e777-4f3b-8e03-08dce879c793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ruzR1cfnStGj/XOhaAWwifcF+fj2n1gQwCImdt5Lliio6QD0ijDnH3yLM77t?=
 =?us-ascii?Q?ERphXo2dmUy4tIcsdztO8AOU23hAjARs/rUsBhL4tV22Ziu2TRabcUayawfe?=
 =?us-ascii?Q?XfVayeBblCCp+NG7T+6ifpSOFxmQ2ul6jIK2HtC7cdkpLpTdXC3tZdgFe8RJ?=
 =?us-ascii?Q?mhdg++aeIP6+Wfjaw5/rKVlNKr+2eiK651IVxI2MYfT6TVtXPSf3k0uibEWp?=
 =?us-ascii?Q?SHV+fwX0r+jC6wnoJBE4DW9TZsH8qOq1rfC7JK0lXOm+T8fT3WAKMfvELhMF?=
 =?us-ascii?Q?hFkQ9/N68vTCTOQVMLQvQqcKwoikzRthJGvX6vTibcH9GKfNtOpSx9zIrgVX?=
 =?us-ascii?Q?oh0jij5kpx0EIago+PrZT4uQTTOATXdPb+5nF7Go5EBMkSqE7XbDQj4tdGcD?=
 =?us-ascii?Q?faml8RMoK/lMZ4I17h8XldVKfcdqXmIKXekN/AwInEl+grpbN90gakC2bPYO?=
 =?us-ascii?Q?pnwvq4d5M9JSTN+sMV8aREvGOl8K9P9xmyRHfbCfOXjOC3eU5F7kmzvF9McK?=
 =?us-ascii?Q?k0gnhnn0Ont0OjcHyc2dInN1x6jSYTELIRE7HKOqp9kL4YOWwHnnW9N2aG4d?=
 =?us-ascii?Q?Qun1Mu3UnEPNEvRjqPnjuBIKT0vMjbaXiifA2lSc3Wf8s8OuZisOfuoS9iVF?=
 =?us-ascii?Q?LBYR9yPLR9YzQ5UZvu2FnSxWgaBTQfvOyoO5p3lHeU7WDDXVl9N5aaBRnihM?=
 =?us-ascii?Q?WEgSMDX9qPZlHDRqylJkjbkPO1786qd2pZ/IuCx7kBTZRE5OLLtZ0Em1gInN?=
 =?us-ascii?Q?zsiXUZExB6hcWUA6jOzi29fbcJfyILT+ZzWlS8wbGwp9QUwzHto0mKlkmLUI?=
 =?us-ascii?Q?9DdJySJgJPzhFvGr+8P3m8axvqPernRhiCKs3yBTRkcRLJT6AhUNI8wREHNR?=
 =?us-ascii?Q?SmcYAFUbctx7cnwHpOvkh0Qd20kWP0lvERwIVGWbVGd+7sXXWlGxCLjye1tj?=
 =?us-ascii?Q?ZAzjXxRvdsp37L8DYx+x1U1v4TCUAq7PiYLVzAAThMSAF29Za0DGWd1pACi1?=
 =?us-ascii?Q?AP9rBjbLHTu7QI/peYMl8Z5cr/lII80HFGo7NLlP4nOunFrIVnf9g3BFt7fi?=
 =?us-ascii?Q?/0cRZl1eVJmp4paXWduUeqalH77UF7S8fgEat295Y9DGpY9lqit6/Rw0Lihp?=
 =?us-ascii?Q?iUm1bVb+O+mFjPbqEWAJQZ3/+DNVM+WUQ+KpTNEBQqidQnIxNkiHB2NrnLUG?=
 =?us-ascii?Q?hD/u/Qid2K5p0X7CHLfaMkFxIf5PdLg1hGI07Pt0fSowcH5+3N1f1zXtDfu9?=
 =?us-ascii?Q?pZ47SWmRml6k3uemZHMmmRX28R63dNa1sH8WFCD8AUrLqjRMm4OciwerBRf0?=
 =?us-ascii?Q?x3YDYV9QUZdZkFZ1ClbONn5HwH5ja+DoXRYtDaghPZNhLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oM6IpGqyzKoUbW5KohEtsxMVN3EwfBZ4a5SECdxr0Awh9QPWFxfnMUjwb2gQ?=
 =?us-ascii?Q?nhHq5XFAZ7QmdT5VC+oKV9cQhTRIe1kXKFLYh1yQmYeHQ/Ezc07zFO5eTPen?=
 =?us-ascii?Q?bqrA4Hsv9nTI/WYwWy87bBvux+cy6tW7ZpUHGnOshfAhka68GiG+hDSE9BqZ?=
 =?us-ascii?Q?uuL5Mr3vBJTMQpQGUPkY1ezkj7HIgCt3g9sJbzvoPWNYjAjL02m4Dqf3/TVs?=
 =?us-ascii?Q?mGqu2BZAPFd8TwFqodT6wQTR5WOWH1BqbI7SqmfTX2ildxIxNqHAHKg8J8fz?=
 =?us-ascii?Q?F9r+qaO5VVR/DB0Myd0TyflzJu8JDSnsozSOARo4nNtfxsHYdqxRzeJr1ir1?=
 =?us-ascii?Q?8TFLDV0zdpAcOzl4S3ZYqUgHYdfVxBFTVZ8I8JSQUiexmoIxpTlm3la2OXcT?=
 =?us-ascii?Q?iOXxWV9FTfwCrjhMBOQUpzlBMAbNFN7Wgis9XdurMRi0cqOPEK7dtkP6fVPe?=
 =?us-ascii?Q?MCbBv6xtab494zQPzMjFX9rzwFQ3sSPiNi1r9qBJEXkZI1zecTSwzA5HEZB+?=
 =?us-ascii?Q?JIGL0mHOV6enPT9IA8RY1bD01vdT7Jmn7EbNqOwUk89dvaifW7WLvqWK5jQl?=
 =?us-ascii?Q?9gE8SSLFnwx56xWqZe+eeIGHR+Eaoo9CT7EluHq6YNrs8XtZMxjBhfNc9aKU?=
 =?us-ascii?Q?Krs2dAo134M0x72m9Ezpb31/i4AqjcPg+YxBTNsZEJKqJrY3szRyiDGJoKg4?=
 =?us-ascii?Q?IcgTCPWW/aUvtI7IBU1s7BU9Chh3f97brS8rjTELtj5Lk6pnI6d1n/gGEz2S?=
 =?us-ascii?Q?8CRdlkipUw43CXMmp28kfA7ulQXrRtE6d2ZbmzVRacx0Sabw0FB5yTXpNKgP?=
 =?us-ascii?Q?SRKzxdZQeCxkhRl/T0uTXN3CKPjev1RaJr5GB9M2t0lZRiQRuydGZ4OyXspR?=
 =?us-ascii?Q?AbBKj1Nooc5+0NvOub4D8oFZcOSgE3iZK0ubhHdbgbH0b8/qjc6LIWASjXeV?=
 =?us-ascii?Q?NqDQnpaPEhon/y9jPTHmmpLBz1wa0uMmkRMp8LUqTDVw6nj3fD259oNaX6Sd?=
 =?us-ascii?Q?qlH0I5mY7z6kxduQr+AXRO/ywEHmfue4nbGmsghcGNGkVoMHtD7ReT7oZOI0?=
 =?us-ascii?Q?9F1dvtN0zPmC8Czh5BEExfNQMfNzce4V9gNLSz1Vl6nCOzoBp17lYFXjfb5i?=
 =?us-ascii?Q?Nj5Q4ITfCFCeeFovoo5zxWe3GF7e1d4SD09DRPyq/G63ooEnWQ3cuVHGtZNr?=
 =?us-ascii?Q?7gqOva1Nkx3U8lGFSHYlf1w2WP69g+f9sYeCuhSoUaZFfAx4MH8/5L+9Lxeg?=
 =?us-ascii?Q?NGOOl5/t21Y9aFl17NCkGAAMLNpwi31zWQ2WpqHpoUm46IT3ZbOQ/9AVPMpd?=
 =?us-ascii?Q?Ur6rWFDRF7heO5WpZdolA73IGzhq4WAu5fG5CdCSijKtKXJMkC3PlWWH8ZJh?=
 =?us-ascii?Q?DTjDYAe97Rj8YBK0DomVFE3XPAp+9MGs36c3FBiZWct/4DrGyxvBpOjBBTrm?=
 =?us-ascii?Q?5BnxzfBafFibij4MJQNJOMRJgCa/p9NEzpNzxOvJsrVOiSoTKSfgKPJB1GK+?=
 =?us-ascii?Q?2fATrVDOQLJHLDR6ZPSyEDamSjwcuvDazYerPsu2YgmcbkvjH8te9/GVYv1e?=
 =?us-ascii?Q?FCSj/0r9xPOlZYRr9Sb04G2qMP8sZMFv1ZksnAb2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dc7b78-e777-4f3b-8e03-08dce879c793
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 15:48:11.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jtU+es/DwG6VOZCBUr0b5Os2xKyyuSsD++CH1e1roriaXk99SdcS0CwjTw7rMLyS0m8F9WbE06hMR3Lfl8HSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7829

On Wed, Oct 02, 2024 at 11:08:34AM +0200, Borislav Petkov wrote:
> On Mon, Sep 30, 2024 at 04:42:14PM -0400, Frank Li wrote:
> > On Tue, Jul 09, 2024 at 04:23:01PM -0400, Frank Li wrote:
> > > Add imx9 support for fsl-ddr.
> > >
> > > Patch 1-2 is prepare patch, no function chagne
> > > Patch 3 is small fix for bit shift
> > > Patch 4 is dt binding patch.
> > > Patch 5 is driver change to support imx9
> > > Patch 6 is imx93 dts change
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> >
> > Borislav Petkov:
> >
> > 	More than 2 monthes. I ping at Thu, 29 Aug
> > https://lore.kernel.org/imx/ZtDwG2xFGaUssJVN@lizhi-Precision-Tower-5810/
> >
> > 	Any reason why not pick these EDAC patches?
>
> $ ./scripts/get_maintainer.pl -f  drivers/edac/fsl_ddr_edac.c
> York Sun <york.sun@nxp.com> (maintainer:EDAC-FSL_DDR)
> Borislav Petkov <bp@alien8.de> (supporter:EDAC-CORE)
> Tony Luck <tony.luck@intel.com> (supporter:EDAC-CORE)
> James Morse <james.morse@arm.com> (reviewer:EDAC-CORE)
> Mauro Carvalho Chehab <mchehab@kernel.org> (reviewer:EDAC-CORE)
> Robert Richter <rric@kernel.org> (reviewer:EDAC-CORE)
> linux-edac@vger.kernel.org (open list:EDAC-FSL_DDR)
> linux-kernel@vger.kernel.org (open list)
>
> This driver has a maintainer. Is he going to review it or can I remove
> him from MAINTAINERS?

Borislav:

Krzy already sent patch remove him from MAINTANINERS.

Do you have any more concerns about this patch series?

Frank

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

