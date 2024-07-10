Return-Path: <linux-edac+bounces-1491-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E92092D45D
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 16:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F57B242D3
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 14:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80894193472;
	Wed, 10 Jul 2024 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qj4vbpVd"
X-Original-To: linux-edac@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67869192B83;
	Wed, 10 Jul 2024 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622343; cv=fail; b=uiR7vKNosMJbj4wx0mwfmg0sCmfAypBsxddS4nPVxAMfDFGQcPP15wrBtURHAuqZkAkPivayJZ8VtPesFYzc5sE/6zVJR1/wB7J0SF8zxOjv2oqbDj4CQg3Xw/iA77HFQfsY14L7T87EaXeaYOAmZPipyhraRWL5e0zUwsp3VLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622343; c=relaxed/simple;
	bh=LP7TWGIlLhQAzWwyVJMTTm+nI9mexP8zxJ7/Ei+Vd7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p2DUF8xzrD82QfkS3D7JZ7ECj9GaRv+0Thv3ZiFdlv2eXQPVX+tXrwQC21GF+CHMX6bnouKjs3KAyg0s5vaZJjF4CaRsqMaM83NrgN8iVbjG8MYOjyR3OomRMR/Pev3nrogSJVmthhZutIpTvc6JFANf8BMODbufYM3PXGDWw8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qj4vbpVd; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrakN8Q0H377v6gnOSiJWqAdbcK/Bc9j6+BK0m8Lgn9Gys9YOlrqaYM9/z0RCy9jg3jEmS3lm5MTOAxjKZbqxh+svV9pIqt42uZZwXO13Tt9ws+9tL4gxMLz3RTp+O0TeWKW87/tSVmm9Mf1PtMEpJSQMIr4GIBr0LwV+jIFcZFwRuKq57+RZvN7n7756oolTvvM84ZJ5b1pqDfcEuix/PFS272w49dK+EankvGzQts0TfY+ReQqvMqMlVaYePmLHyYU1ebGsYWaoTgmuZ8MvhHzQ9S5VGkCoFE+1N+I0ycr/MUV4oLmSO2I/N2WmJYX9kwVKIsb3oWP1uQAgvf4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97Krhge18YVqBe+fqm0+vB/q78cbtR6p+mjMYdpVxac=;
 b=SWE2cP70SyQnpfh3wZea2esSAk4kjiAwPhdOmDFmqxkg+PMAKetS7kpnPLYyKhNFqsISLI5SSQ1asI1FZySwFG33m/H8lwEeCBcuM2Fc0vC0nQdmifhTYYYEIU80WxZi5GLp9q6EiPTNlTyPId/ynS1jJEF62vtNSoAyrPJ9CZLM0ov/x/fJFzEjaM9u1rdidnX66XPqvHffbxOQfKHvcyeYflICTdQ4ToNnPNcdT3ZiCUu61MNVn9kus7vnhbjdG+7+RNguMcyWqxhcFJe7+n7zLfDTgulYV1g2OjTQM6zIWTZJmg9bqNB4Fm68gC8KpRAZGRY/89Ni0bAjUES7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97Krhge18YVqBe+fqm0+vB/q78cbtR6p+mjMYdpVxac=;
 b=Qj4vbpVd6/GreKqvLZPppy3+Uk4LLPGXHPwU+sisBAq9hapOMjvcgkP33XjSKA3TVCh4t0pTy/lKWr1RYyOH9QIB2W4porq/Uu9GI9B+FvehsUuqyWIhrebfJtabUwwuASLhOsyaOOdVXKkdk1JnG7URgUdSjh0MqUDFZ2LzvZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6887.eurprd04.prod.outlook.com (2603:10a6:20b:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 14:38:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 14:38:58 +0000
Date: Wed, 10 Jul 2024 10:38:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: York Sun <york.sun@nxp.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 6/6] arm64: dts: imx93: add ddr edac support
Message-ID: <Zo6c+cFt3LL0kQEI@lizhi-Precision-Tower-5810>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
 <20240709-imx95_edac-v1-6-3e9c146c1b01@nxp.com>
 <PAXPR04MB8459D5061624A819C70E985188A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459D5061624A819C70E985188A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SA9PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:806:22::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: edd780b6-96e2-4f8a-c7fc-08dca0ee0867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IycUKIAD2oV9PNxvjll0yEDg2S0sS3icEtM4BFbXHff6DvHc9fyhpsF3xnq4?=
 =?us-ascii?Q?bvylbhNASmCYoOPWEJinT712a5A6lKy92uKjoP9uFEYIBwjdITKxOqc/ZkC+?=
 =?us-ascii?Q?U15tJ+QR7I9LahKBFqNvuJ6yOTSopbByrkWsNbcvgklZj9C42gUC8DW/V4Mq?=
 =?us-ascii?Q?ycLj6Z0q4MXPDALwlu6/pGAGjZpWGoSfxaAB99b+tQ7U74iJefPAXfLkEiCe?=
 =?us-ascii?Q?ctahNmVLx4yEuzWazlcJloVK1DVRLYNip/vXRDkVHyLctf0zurmcKuk1MkA5?=
 =?us-ascii?Q?AQH9bzjfs/qD+w3csAfpeug3Tj1e4/6E5szP26nmb/voLiVqSP9Jtqsb2GaJ?=
 =?us-ascii?Q?JsXTRPVKcikFWtmeP5HJegQTejR+CW6hpRPsWJ7DL87llkKj/Ke2AFfObNav?=
 =?us-ascii?Q?7VfRtQXdWI6uHP2LdGPEm59xjFKug0YZzGMCkoJtmq07f4N7eCyyBabdgYug?=
 =?us-ascii?Q?kB0+Oal84zm4fBQjN+8SLjks5PY4SOIX+u7BlbG/DILR3r30htKn1nyySwkk?=
 =?us-ascii?Q?c+HwXYDCI0wP1HAoNrH3Q2SZQ9oeUY6sOntaLyDTSh8eeiW3uPULbzljJwAk?=
 =?us-ascii?Q?C5pK6lcMPKU0GRF9sdTfB+o0y+Ly5Lp7XLn1lmyGmdwDb1YllHyECKKJq6Td?=
 =?us-ascii?Q?2rzuuSEAWpQgcuDRTm1mUzMRAFchuzj29smMddzcIy67EH7DJMXPWLH0s/ji?=
 =?us-ascii?Q?ueC86co//DHESQfXSFFKbz/YHweUCti5+prsnHTHhLWhClZSWTLyq5q29CCv?=
 =?us-ascii?Q?u3XfifFOggGZ2mVjkVAu7RfUPY/we3ThoESrC+Fi5DocpJslRoq8yVT0biWD?=
 =?us-ascii?Q?1Z0DE/CbUv2uBd4hgyVk0BFykNfhm3CK8YTCyWUzvO8t88pgCwJwK2OxL84c?=
 =?us-ascii?Q?IZTCU9rzXl0M/ttgGD4IQaIqQVMEt2NI8oDTuRyMjrHB2nz/e7CpdOiztWf2?=
 =?us-ascii?Q?j7qK2fh0u8uAbDVNYa8GUC7Ui2fWOMQlxL+y2JtfiW7SABxVfMfP4v7mSVgX?=
 =?us-ascii?Q?w2G/QMhc82kYsgB9pSNXnDCVYoL4EXy6UleNO3BjBUJiZXrEltlaZKT4AJmE?=
 =?us-ascii?Q?HLCOT9JoJKY+Q9p5h5hsCmsDzPK+sdmwBUYv0pycGWG9hV7DcrjlxiLPRspj?=
 =?us-ascii?Q?XwQMEWKSUKw2MFpkBSu98Wyze9vJyXhwbwLkIZ3aQuaLe1SKa76AEDLe063Y?=
 =?us-ascii?Q?WdT7M1X2VGERMFTPmSpN/uyXJ7vfeWXt8S57xQU0LwW8DNyxZaG7wS6DI0bE?=
 =?us-ascii?Q?f943W0FfcohoA7eFQZfneuNSWVwdmCvAi+3qko1FzDjPJGCsydihS0w+yGTG?=
 =?us-ascii?Q?N54KhRJtgATVBtAF1KbAaUW9/vomV1IpkyMc+0IWduvTMBMaxv72fgJinM1I?=
 =?us-ascii?Q?s6LVMUcgQS/jXvK5oxIPqIJuc+Ta1DyKSsU9r/qBmEX+8WHuDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iC/KjaeifBonu2WBCZhEih5W7MqfB9Uc5EVPoUElqap5vhVjk7gnf9Fx1+yi?=
 =?us-ascii?Q?PRyzFjIWxBXpHpnn0WI0nTjRRVUaG96aM0K962oRytFFDvBYQdvrart2OBNO?=
 =?us-ascii?Q?2qvclFqWpN7IeAk2ouGHsjo3ASKWr9mLPIlL++xolygBez10jEP2GGUAmLJw?=
 =?us-ascii?Q?mg2ZPV/3ret1mdo7vWTWzGENIIX4tZEGKwlxyqYTQm8HQhcTK9J5Vd97DCSm?=
 =?us-ascii?Q?x8KhWEpAqPNQUWEZCzPXrm/hNato24f0sez4LqMZbYcUSKEsxWQsZ1qzi283?=
 =?us-ascii?Q?r9VYLtdvVIEBDKxMWPe5fyvwDCIimYRe6mDiYpAibsmNbzIUY7OkGKEedNGG?=
 =?us-ascii?Q?IXJo7dqp2fYrHaAuB1k7eQDhHFJ3ma/o6arZ0alCG4B6iQR/yG/RU7e48NIM?=
 =?us-ascii?Q?AIFAMlrZZD8GVZtI/nmNnbWwxu1p29NkX73cCpJJdbOokI41qSza5bQbGmB3?=
 =?us-ascii?Q?uwvcKktmFMSA5QORNu6XacWbYaUi3EnVglyusjBPmEZR2pxr8bDm9WTj+Z1U?=
 =?us-ascii?Q?cb3OhaiP8Ey8y2BHWQH9inCwENHTN2WaQUpyQ52vDlPrS0B/Q8+MG/a4tbZb?=
 =?us-ascii?Q?8WVGR0+eRBBqKYaP2rb9CwqoiHSq7TXB+K1rn8KCYQ+UkF7xHWTBrHCe8UHC?=
 =?us-ascii?Q?Mz4aLTDTJAi9w/zFEvaGegepJhPyFmObDVPbux4AHCQYLlm1TqePGrj5oHYN?=
 =?us-ascii?Q?o6AMr6ziM0206bR8QreAIJijMxDlIwj3xb55uVfmljO9OaJHI0I9Go6WJhY1?=
 =?us-ascii?Q?/hl1CZGZdqDwCOlEfNn/s2X74aDdt8Jy+za0rJMkgNlzv0ndkG/wDlFOet8S?=
 =?us-ascii?Q?x8sNroGLGgHOGFsXJyjDu0DGDbc2NWXfkZS7WJHapV14tW5abGyFyDSsMXT/?=
 =?us-ascii?Q?eyb+kn9qeJQKe0z49n5opLH5owczc/aZAcSYBNMhpYML0aiD/wVCtipb66Cn?=
 =?us-ascii?Q?89ouxgimTYwgxal7dWxgJT93FYaUbE57PRuG3o6HEQrt55hkiCPIKQkEGMJO?=
 =?us-ascii?Q?zBCHfQ40YEDzBn6mS4c2YfpEWn4261nk5xyitQuHy6Q7AUE+jHHyUxVUynLP?=
 =?us-ascii?Q?2xyQ92X4YWHKVC/3N/MfRsxZBWoRD4ZP7gU1JrBMbeB1r7X8kLrdPv3aG8dj?=
 =?us-ascii?Q?nY0KUyr6XY9OVy7cElPlvihYYIDCBUZhkSyIcceZVMySFhnkgIs6VE/gJoVz?=
 =?us-ascii?Q?/JzBHzV6U6RLssNbFZibQQ2Oo8ka0d8UriDo+KPIhkkER/8sRQN9MHGtMoXC?=
 =?us-ascii?Q?/Wsqo/ut8qItMsgCjymx09xwrxPTdcaeYn3Z6OchxngyymR8rlAszcQ6XDW2?=
 =?us-ascii?Q?MCIRbo7BgqffIffGSCtz062K+G0LaaaZH7QMLGAKmia5nG172138nhHecAlX?=
 =?us-ascii?Q?Cf82i7N6jBTpI2NaFhHCrK3hou0D+5hQpzG04oepkr16BqngazDKSye3GRZI?=
 =?us-ascii?Q?MglgL8B7pxa93IvB6N80Ap5MusgkLwmKSgM/N5TlpHFGGguKaopX2OIYfjVQ?=
 =?us-ascii?Q?6TN3D3ao6qDfLMCXDQUp6J6iN85N4FJ0rtFBqNDitoc+j8/Tf/VJSl8AiYZV?=
 =?us-ascii?Q?wGswUWqTvNx8G7bigUEDsxErcHr9vhjyY7CbLVOo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd780b6-96e2-4f8a-c7fc-08dca0ee0867
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:38:58.4664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CO/6lnwJ6ccL/j7BpJjNUrGpsd6IgbPsX3eA9IlHtG8KfX7/y+H+gX0oxAhvpfXYBEcYgsRM60RMGWvSt30/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6887

On Wed, Jul 10, 2024 at 02:25:02AM +0000, Peng Fan wrote:
> > Subject: [PATCH 6/6] arm64: dts: imx93: add ddr edac support
> > 
> > Add ddr edac support for imx93.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx93.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi
> > b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > index 4a3f42355cb8f..6faba848fe286 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > @@ -1279,6 +1279,14 @@ usbmisc2: usbmisc@4c200200 {
> >  			#index-cells = <1>;
> >  		};
> > 
> > +		memory-controller@4e300000 {
> > +			compatible = "nxp,imx9-memory-controller";
> > +			reg = <0x4e300000 0x800>, <0x4e301000
> > 0x1000>;
> > +			reg-names = "ctrl", "inject";
> > +			interrupts = <GIC_SPI 91
> > IRQ_TYPE_LEVEL_HIGH>;
> > +			little-endian;
> > +		};
> > +
> >  		ddr-pmu@4e300dc0 {
> 
> Should the ddr-pmu be part of memory controller?

imx9-memory-controller is actually EDAC, which independent with ddr pmu.
I think ddr-pmu should be seperate node.

Frank

> 
> Regards,
> Peng.
> 
> >  			compatible = "fsl,imx93-ddr-pmu";
> >  			reg = <0x4e300dc0 0x200>;
> > 
> > --
> > 2.34.1
> > 
> 

