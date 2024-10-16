Return-Path: <linux-edac+bounces-2115-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFC89A140A
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 22:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2BD1C20CF5
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 20:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CED218313;
	Wed, 16 Oct 2024 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FTl8kDJn"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2070.outbound.protection.outlook.com [40.107.247.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974D218308;
	Wed, 16 Oct 2024 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110720; cv=fail; b=Ik9qQfDI9iQg06WXLHXbJAklA85fT49S7wU04IjUOjzEA0HpswjEsrAvC5DDhT2XPsVio2oKPjE5HY3kQB2egPQioqJ9YF98TOH8yUnLFdRiuQ7fH/jJjBjJoEmywNfgRrzAc0iZM/qZOrJ/draQrScyHa9JmKo47hfuiwv5F4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110720; c=relaxed/simple;
	bh=uQlwmIwixbrtiEhQ0s/EITjv87vXrYDoWoQrwUcKDC8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=saw7Fd1A0PgulkmaC7IiSemIkxYtLIB3AinvVQ7Cu5OZu7aSpJGrbxxXpa++hqbfxuS/3wpccPJ78rV1XEH0HTeF9bZ1lSjF9d0rFQs3SSd81dmuDu7x/AkfxIoQrQ7FKfQ/h73jPT2rgq7wJgW97pIJvCbvcYMTvn73lK368ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FTl8kDJn; arc=fail smtp.client-ip=40.107.247.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq1wtsFJCWwBen3wXprQS+IpuXaVx6MtvFVuDQ1s20RbRHLkiKUFBf3+++cQtDJ4zWzrrAN3jR8RDBggEm6v4LTKHHTNw1Z/ZwI/heBcOGwKYyPTKKKmNG++sU+JzC/65Q8RNUxZlsOEkoKxIAs/EFajoJJXmkIe6iFl9+EPxCUMfgWiJVYTIwrxeij0Iu3AUqWeAn8Xml6v1jD566Vzcf3JwAg4EwDK//05iGFudAAjsyv41DFI4OS5bf82ibi2XltFmW9ccWYTZ9UjtU/9tD+KPcmMMgYuWJcA0hwypcYwcZQwvfS3OYEqpppRKMPEggQ27xrHS1FSyrirZ/TMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=in5RvYSFRwXmI05RdH8h/gSXJgH6cbfzuJX+7Y0Tn5s=;
 b=psWdpb4j2nk9Q4jyJDR5bPKwHtb8TmTvfyh0PBKXBSxOC1VSFH/Uo+SQtR23NCBZsQ/kdhUt23KJxUZz0U/FQVh74YyfN9VKkeQGFzoi6Ul6S0I8dw0nkT1b3fckg0pmUhTZwJzJXlHzCRUFoJAm8HuMF1dhNVNGH75y7aYLwE5sCle/LzbQ1AZAUW9lNbZ8xlxYu8deTAwP+V6UuoUZo7MuIrH6AnQArrh37B2SFZEvjzRNkZlnKe1eZE0K8OpeUHNNjvzksNvSmWr1gfKOOn15pRoLr7e/ZqeUmbaLZJjIjXT/lm261U4wOqo7GKaXD/nCXUPQvqUppBrTsc4hoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in5RvYSFRwXmI05RdH8h/gSXJgH6cbfzuJX+7Y0Tn5s=;
 b=FTl8kDJntCu17byf1oe2rsYEIKPJXhZ2OXfj5D4cAs3cOHxwt+zf3b2FjfqzBFTp/k2Vit7MHmPvYhgGaH8n1xo80Y0snhbzfNpJ00lGjkLafdirfoa6vGLIeS5fuBcSRQchjU68e+QhfLq0uBMlxHAWCWy7XUAzWvXqqpb33VqMtW/I7vfZf4IgTqVeq78OfKeOCkBlRgfxUU8PLtokct4LueO0IyWPYAgJCq6n3ylDz+JSU8reikH8mbDMPLixaxA2K0piouZ0od/gr/eoA+21ne8XPN5+Edv0g3DUMo8LYnK52zvovFZtRxCfdDFGTVsifRtVqYSyhFZKq+8kiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 20:31:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 20:31:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 16 Oct 2024 16:31:13 -0400
Subject: [PATCH v3 5/6] EDAC/fsl_ddr: Add support for i.MX9 DDR controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95_edac-v3-5-86ae6fc2756a@nxp.com>
References: <20241016-imx95_edac-v3-0-86ae6fc2756a@nxp.com>
In-Reply-To: <20241016-imx95_edac-v3-0-86ae6fc2756a@nxp.com>
To: York Sun <york.sun@nxp.com>, Borislav Petkov <bp@alien8.de>, 
 Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Robert Richter <rric@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Borislav Petkov <bp@suse.de>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729110683; l=5954;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hUQnyfJFTL94sxJNzfCg3IOb5Vka/0x2CpQy/F03SQk=;
 b=Uz7YCUC9DM7d3qQwjHo5x/2yPSms5CnmjZlbIqUL1o+tSam1kMslNv3vi7p4IVUo24iIjZYRx
 4g0+UNyUhZNBNC+Z0oQpvcFhgjlPyVR+ebRPmLZPZK1I16DxOck64xd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:a03:60::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b2c753-edd4-4f09-0d9b-08dcee219361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NE5TT1daU3RSTGFGVW53RlUySWlaeGNXZVhBWVlKNDkrTHNaeFlKalhHNjRI?=
 =?utf-8?B?TFhiRzlKNWlIL0Fwclk4TVRsSWxYZm9oaGtSdVpMUFhEVzA2c25zTzc1dGhQ?=
 =?utf-8?B?bzhmZEhXeGxnU0JKNlRucEI2NXJ5QVJGWmNyWWlWSUtMNGNEM3YyYUtaTnlR?=
 =?utf-8?B?eFZrWjg5bU5mcnMxaTJTSHo5VTlHbUJicUxhSndQeVBvNFV5QUlqOUZwYndB?=
 =?utf-8?B?eUQwUDRTOWFPMVI0bkoweUh2bFBTTS9abmJlNVdwN2YrUk56eStuMmRaQS9Q?=
 =?utf-8?B?eCtMR1FFMHo3UThPekFlRGppaVhRVU9XM3o2ZkI1cFdoNzZGcFlxSTBWWXM5?=
 =?utf-8?B?WVBqTllWb3AzeGc4THhrNzE4eTdvSmxkd2hWL3BnUzZwSzRNeWpEUkZEUmxN?=
 =?utf-8?B?M2JxZ3ZHSDRPUzJpYWtqd3NXMSt6bEpvZHExams5WHl0dVdiblM1MlhaVUZI?=
 =?utf-8?B?U0FNK2hTaE5QRE5GdTdFMm1weThISTNJOFUyaENmUE92dm9mcndianJQdVZz?=
 =?utf-8?B?dmVxSXhYSlZvTTFlOVhRSVJWbHhFa01LTWFka3kzZ0NmcXBSYjJpU0NuWHd0?=
 =?utf-8?B?T3FWdEpwVVN6WTc0ajBBRFFNV0JYMTRBQi95S251MTFDNEpZd040YlJINElO?=
 =?utf-8?B?aS83bXpGVC9kWkJ6Z0xlN2hHUjNmQi9LVXBoejYvWU4rdU92bkp2OE4xekZG?=
 =?utf-8?B?U1I0TExna2w1UnhFTkhVR0E3NHBmUnViYUlkblNNMExjMVZVRHcvMG12U1l5?=
 =?utf-8?B?VERxSy9RQlczdStHRUlrMlBRZHdOOHlDR2dtVi83QjNLU0NhMUFHZkF5eGNF?=
 =?utf-8?B?UngzdTZoVW9LUEIxSzdjVGpyeVp6aHdUbjJRUkZxc3RQdndUVnJHRGN5MHZW?=
 =?utf-8?B?aDZFOVMzVHFFb3FtbHA3QzAvNmNCWjVCcVB3azFIam5wMEdudCtIeTBPUGt2?=
 =?utf-8?B?ZDV0Q3EzNlAvUU5TWkdzQlBydTVpd3JxdDQzaGg3eFRmZVhCYTVGL1JhQStU?=
 =?utf-8?B?dXV6VVBiZFR2U04vaUlzTlM2bGhSeExFNnltVkdsaU90M3dna2hHZnRPcjFP?=
 =?utf-8?B?TnVKNlhldTY4UmpWRXNPY1FVelNVQTlpV00xd0FvUGpidkV5WXk1MlA1YS92?=
 =?utf-8?B?eExCNE1zT0hRaS9mRlpRMXIzTVBvZzVwMDdtUWt5QXhlOXRDMXlRNFUwclkx?=
 =?utf-8?B?SmRiY010WCtybjhoUklabWRpUjBjZDFNdTUzVzRlcU45Y3JQV2I4dzlwNnZl?=
 =?utf-8?B?Q1hwdnVhSjFTbC80ekRseWFsNXQ1N3RKQzdYd3BFZ0RwMVFRMjhNcG5nWVFS?=
 =?utf-8?B?RFA2blk1WHVjL3RUMWN2WHJJQnhvQTduQnNiT252WVZLbm5VZUNqKzIxbjRn?=
 =?utf-8?B?eDQ5anQvTjVabmp0T1NSMnQxQU1VUytYVFlUTHVqUEt5QlFuYlkrOEtBVlhG?=
 =?utf-8?B?WnNGbjFBWGRiY0xrQXYzVHhDaC9IRytWaGhLM1BJM01aWnJYMDhkdENoRlU2?=
 =?utf-8?B?TWpVek5xMEpSNU9yZEZYVGN4NkpIS1dnSFNGTUl2citqT3ZjOG1nQ21xSUEy?=
 =?utf-8?B?MDZlWExvVmVhVjNNTGpaRmJqSDVYSWpCTWFGOVJJRHpzYis1djlKOXNMZUtB?=
 =?utf-8?B?OFhlWCszSUJPNExleG1Pb3cyckdFSWw5M3dEaGNwVlJFd0c1NkhsbXkyNjJ4?=
 =?utf-8?B?YklDdkQ2Z01sZGpuYzh5bDN4UFlzTDRKRzFVRmNKaVFHNVRiSkVrcTd3TmJR?=
 =?utf-8?B?ZnU5bWRDSXdJUEVDazBxbGlIaEV2dlB6NGQrUm9Tc0JuRk5jdVNYTmVNVktV?=
 =?utf-8?B?U0xUaHZZVnRDWTdRQ0hQUUZnN3ljazM4UDZtVktaNWhTMkJtVUxUeVl3SDFZ?=
 =?utf-8?Q?zK82hr+QC3szq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U01CcUc3bml4L1FGbFc5UFdEUFcvZ29MaUtkU1NpcE5OVVZ5TnVtN0I1VFNZ?=
 =?utf-8?B?dWtYL28rckJYajNkK2pGWkMyaGRCdXh2ZVlBZXNMazZ3REZLQ3UydlVYRDZN?=
 =?utf-8?B?czlWUTFnbGZpSG1OQnRKQWJGWHNqOVcyVStnQWd6MWk1YjExV1ZPanFOL2xl?=
 =?utf-8?B?TVRlS2JSWTI3NUJSZmRXRmpGbDZ0a1JkSnc4VWRqemxISmxIN2FJMTE2azVJ?=
 =?utf-8?B?UndqQmhVN0Z0czZnVXM4TmlDYUNnYXRUYW1YRlVjQys0N2RiVkhVSzFOcHFQ?=
 =?utf-8?B?L2NWVTd4bFRUQUF0bktJTHQ0UVZMZFRNZnkrZEg0eFhYM1Qzc0V6WFZrMVVj?=
 =?utf-8?B?OWhWMzk4MDhyTVdVK1Z6WFFZdmpvSDBiUnBrcU40U1VaZjJIRUZkWUJxdzlP?=
 =?utf-8?B?cXBXNmRSeFR2UVhqdTAwVy9vUmExOUx0L3FSczc3ZEJlQVhQTndYZXU2VXgw?=
 =?utf-8?B?MlN1d2F2Z1hOQW5oeXFmRSt1S0Z0amZtNGxHallBNFRVeTdJV3Q1cjJBandP?=
 =?utf-8?B?SmprUkdLMW9JbjNFYWtxaGtlSDQwbFB0Zk5qZFJzR21ZNlhTajFnNE1LYnNv?=
 =?utf-8?B?dHhWN3h1d0d1NkhkUWxMcm1ONkxoRXNWYkF4SWdaTVJnNkZrd083ZGliM0hz?=
 =?utf-8?B?d2t4ZWFXczJlUlpudjJpNnJId25MK1RHRVRPYU52N0Y2SDhQYzhWeDNkbk82?=
 =?utf-8?B?SW9tTW1nWko1SEVTMm4yQ0pCQUNGU1pORnhCbHExMHNrK2U4WkNTbGRIL29I?=
 =?utf-8?B?aXJkVWZaVkpyV3RDRDNsOWpWdnk3QzVmSVRkeU1xQ043OW5IZ3RHZ0lKdmhj?=
 =?utf-8?B?Q0FhYi9oa3RjcWFuSHROcVFhTy9OcU85Q1pWYyt1NldwTUp1UjhwNDdJNnNy?=
 =?utf-8?B?cDJGSUJDMDZFQTlXSEwvUlYxbUxreDhUTDdmSFhCWXN1dE1qU1Z4MFM1WTFs?=
 =?utf-8?B?OE1jUmd0ckNkNHlkTldBNEtSejFsRmdtYkNZL09pVWE2ZWQvWEtsV3FRbzhL?=
 =?utf-8?B?NHdxaXJyc24zdGhhM1Y1NHhVVmNwYWV4YTE2SE4yZVhGaXVhT0xQWlM3cmFz?=
 =?utf-8?B?RjRxbCtoR2lXd0pmbEV2UjY3cDRPU2V2cmV4a0IrY0xCUUJtYlc4TnY3RlpF?=
 =?utf-8?B?bzhtekxzaDRkTEgyZmpCTWg4WWVBbGkvaU0wOThtc2NTTFV6MitzUG9Helhs?=
 =?utf-8?B?dnhwOWdzREZKWHUvcURneWcydC82cjBCb0ZjZyt4WHNBbldJZmIrcm8xSTRT?=
 =?utf-8?B?UDhKR2tCeXJGQlg2eVFQNXROSmxqMXhDZHVsbDA2SDN2ekV1Q3lRRzJOOHJS?=
 =?utf-8?B?cVF0bzFVeXZCSDE2ZTZzT0VuZ0Y4SFFYU0ZKNUNZekZXRHFlQmpXa1N5VFNh?=
 =?utf-8?B?QytQMW1ZMzAyeW5kd1hBOUh0RFlScktrV1VBNGI3dU5CbnViTEEzTkFvQ2hs?=
 =?utf-8?B?cVJvVXlsK0o2ckZJODNEZDJVaURzUTV0ay8rNE9PTGZIOERGS1JyUHQ2OU1T?=
 =?utf-8?B?OHJHd0lkUStYb0VMcGFnSzZwODNsaGhDOVo5Z21GQWljZmhCNEE5Q3NQdWNz?=
 =?utf-8?B?bHRJVTBBdDc2Wjh4Nkplc1h4dkNSbkxNb2FBQUYyNTduRHZ3NE9iSGFuK3hN?=
 =?utf-8?B?V1pQcStmdzNmdHNGQXVNaHVEY2RHUkQzT2p1R0RZYUR6d0QvQWg2MWpQa1p0?=
 =?utf-8?B?WElabm4zOHFMYTUwb1o5aGppU1R3U1k3L0VRd2Q2OVp6OGlqc2Q3ZzlRN3hC?=
 =?utf-8?B?cTRXeHVPa3ZVeGxhamhmdzlZZnQvL3R5OXk5UTNRRDNiR1k2eEduQS9OUjEx?=
 =?utf-8?B?UnJaa2VEZERIdHk2TlAwYUdWSUZtMk52dXJVSUVQM21hbmlta3JuclBOblZv?=
 =?utf-8?B?QWM2YjYvRWs3ek54Q202TE5qUUUvM2g4OHlIS2MxcjhMWjhUcWhjMm9FWktj?=
 =?utf-8?B?YjV4UVUwRGZCYnFJUVRUeVVLL3VrcGdPTm80OFZSNVhQbEc1ZEJEVUVyWGIv?=
 =?utf-8?B?YU1TRXhXRklPWE1tZU8rdW5TRFlMeHhOb2Q5VXI1aG5YUVQrM1Y2aDhtby9l?=
 =?utf-8?B?VTVweERSUzBrTUJzSE9aajdzR29YVy9TYmxxRWk0U00valBhOEJWQk1YelBu?=
 =?utf-8?Q?UV/XeSYXiTiw9VgdJEBeuA0kc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b2c753-edd4-4f09-0d9b-08dcee219361
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 20:31:55.4614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJFGC/RlPrwU5i2052DDbq+8rnn2bPyU+loxfPS7jfNJlRyYN3m0KZR8rqWDcez/KXnukv505zuPQ4kpdUPoQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

From: Ye Li <ye.li@nxp.com>

Add support for the i.MX9 DDR controller, which has different register
offsets and some function changes compared to the existing fsl_ddr
controller. The ECC and error injection functions are almost the same, so
update and reuse the driver for i.MX9. A special type 'TYPE_IMX9' is added
specifically for the i.MX9 controller to distinguish the differences.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/edac/fsl_ddr_edac.c    | 48 ++++++++++++++++++++++++++++++++++++------
 drivers/edac/fsl_ddr_edac.h    | 10 +++++++++
 drivers/edac/layerscape_edac.c |  1 +
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 846a4ba25342a..8f64a4fe02ce9 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -31,16 +31,28 @@
 
 static int edac_mc_idx;
 
+static inline void __iomem *ddr_reg_addr(struct fsl_mc_pdata *pdata, unsigned int off)
+{
+	if (pdata->flag == TYPE_IMX9 && off >= FSL_MC_DATA_ERR_INJECT_HI && off <= FSL_MC_ERR_SBE)
+		return pdata->inject_vbase + off - FSL_MC_DATA_ERR_INJECT_HI
+		       + IMX9_MC_DATA_ERR_INJECT_OFF;
+
+	if (pdata->flag == TYPE_IMX9 && off >= IMX9_MC_ERR_EN)
+		return pdata->inject_vbase + off - IMX9_MC_ERR_EN;
+
+	return pdata->mc_vbase + off;
+}
+
 static inline u32 ddr_in32(struct fsl_mc_pdata *pdata, unsigned int off)
 {
-	void __iomem *addr = pdata->mc_vbase + off;
+	void __iomem *addr = ddr_reg_addr(pdata, off);
 
 	return pdata->little_endian ? ioread32(addr) : ioread32be(addr);
 }
 
 static inline void ddr_out32(struct fsl_mc_pdata *pdata, unsigned int off, u32 value)
 {
-	void __iomem *addr = pdata->mc_vbase + off;
+	void __iomem *addr = ddr_reg_addr(pdata, off);
 
 	if (pdata->little_endian)
 		iowrite32(value, addr);
@@ -438,6 +450,9 @@ static void fsl_ddr_init_csrows(struct mem_ctl_info *mci)
 		case 0x05000000:
 			mtype = MEM_DDR4;
 			break;
+		case 0x04000000:
+			mtype = MEM_LPDDR4;
+			break;
 		default:
 			mtype = MEM_UNKNOWN;
 			break;
@@ -471,7 +486,9 @@ static void fsl_ddr_init_csrows(struct mem_ctl_info *mci)
 		dimm->grain = 8;
 		dimm->mtype = mtype;
 		dimm->dtype = DEV_UNKNOWN;
-		if (sdram_ctl & DSC_X32_EN)
+		if (pdata->flag == TYPE_IMX9)
+			dimm->dtype = DEV_X16;
+		else if (sdram_ctl & DSC_X32_EN)
 			dimm->dtype = DEV_X32;
 		dimm->edac_mode = EDAC_SECDED;
 	}
@@ -483,6 +500,7 @@ int fsl_mc_err_probe(struct platform_device *op)
 	struct edac_mc_layer layers[2];
 	struct fsl_mc_pdata *pdata;
 	struct resource r;
+	u32 ecc_en_mask;
 	u32 sdram_ctl;
 	int res;
 
@@ -510,6 +528,8 @@ int fsl_mc_err_probe(struct platform_device *op)
 	mci->ctl_name = pdata->name;
 	mci->dev_name = pdata->name;
 
+	pdata->flag = (unsigned long)device_get_match_data(&op->dev);
+
 	/*
 	 * Get the endianness of DDR controller registers.
 	 * Default is big endian.
@@ -538,8 +558,23 @@ int fsl_mc_err_probe(struct platform_device *op)
 		goto err;
 	}
 
-	sdram_ctl = ddr_in32(pdata, FSL_MC_DDR_SDRAM_CFG);
-	if (!(sdram_ctl & DSC_ECC_EN)) {
+	if (pdata->flag == TYPE_IMX9) {
+		pdata->inject_vbase = devm_platform_ioremap_resource_byname(op, "inject");
+		if (IS_ERR(pdata->inject_vbase)) {
+			res = -ENOMEM;
+			goto err;
+		}
+	}
+
+	if (pdata->flag == TYPE_IMX9) {
+		sdram_ctl = ddr_in32(pdata, IMX9_MC_ERR_EN);
+		ecc_en_mask = ERR_ECC_EN | ERR_INLINE_ECC;
+	} else {
+		sdram_ctl = ddr_in32(pdata, FSL_MC_DDR_SDRAM_CFG);
+		ecc_en_mask = DSC_ECC_EN;
+	}
+
+	if ((sdram_ctl & ecc_en_mask) != ecc_en_mask) {
 		/* no ECC */
 		pr_warn("%s: No ECC DIMMs discovered\n", __func__);
 		res = -ENODEV;
@@ -550,7 +585,8 @@ int fsl_mc_err_probe(struct platform_device *op)
 	mci->mtype_cap = MEM_FLAG_DDR | MEM_FLAG_RDDR |
 			 MEM_FLAG_DDR2 | MEM_FLAG_RDDR2 |
 			 MEM_FLAG_DDR3 | MEM_FLAG_RDDR3 |
-			 MEM_FLAG_DDR4 | MEM_FLAG_RDDR4;
+			 MEM_FLAG_DDR4 | MEM_FLAG_RDDR4 |
+			 MEM_FLAG_LPDDR4;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
 	mci->edac_cap = EDAC_FLAG_SECDED;
 	mci->mod_name = EDAC_MOD_STR;
diff --git a/drivers/edac/fsl_ddr_edac.h b/drivers/edac/fsl_ddr_edac.h
index de66f9822fba1..73618f79e587f 100644
--- a/drivers/edac/fsl_ddr_edac.h
+++ b/drivers/edac/fsl_ddr_edac.h
@@ -39,6 +39,9 @@
 #define FSL_MC_CAPTURE_EXT_ADDRESS	0x0e54
 #define FSL_MC_ERR_SBE		0x0e58
 
+#define IMX9_MC_ERR_EN			0x1000
+#define IMX9_MC_DATA_ERR_INJECT_OFF	0x100
+
 #define DSC_MEM_EN	0x80000000
 #define DSC_ECC_EN	0x20000000
 #define DSC_RD_EN	0x10000000
@@ -46,6 +49,9 @@
 #define DSC_DBW_32	0x00080000
 #define DSC_DBW_64	0x00000000
 
+#define ERR_ECC_EN      0x80000000
+#define ERR_INLINE_ECC  0x40000000
+
 #define DSC_SDTYPE_MASK		0x07000000
 #define DSC_X32_EN	0x00000020
 
@@ -65,14 +71,18 @@
 #define	DDR_EDI_SBED	0x4	/* single-bit ECC error disable */
 #define	DDR_EDI_MBED	0x8	/* multi-bit ECC error disable */
 
+#define TYPE_IMX9	0x1	/* MC used by iMX9 having registers changed */
+
 struct fsl_mc_pdata {
 	char *name;
 	int edac_idx;
 	void __iomem *mc_vbase;
+	void __iomem *inject_vbase;
 	int irq;
 	u32 orig_ddr_err_disable;
 	u32 orig_ddr_err_sbe;
 	bool little_endian;
+	unsigned long flag;
 };
 int fsl_mc_err_probe(struct platform_device *op);
 void fsl_mc_err_remove(struct platform_device *op);
diff --git a/drivers/edac/layerscape_edac.c b/drivers/edac/layerscape_edac.c
index 0d42c1238908b..9a0c92ebbc3c4 100644
--- a/drivers/edac/layerscape_edac.c
+++ b/drivers/edac/layerscape_edac.c
@@ -21,6 +21,7 @@
 
 static const struct of_device_id fsl_ddr_mc_err_of_match[] = {
 	{ .compatible = "fsl,qoriq-memory-controller", },
+	{ .compatible = "nxp,imx9-memory-controller", .data = (void *)TYPE_IMX9, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, fsl_ddr_mc_err_of_match);

-- 
2.34.1


