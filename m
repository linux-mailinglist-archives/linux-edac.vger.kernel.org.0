Return-Path: <linux-edac+bounces-2114-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A59A1408
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 22:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915B8282A97
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 20:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CD12178FC;
	Wed, 16 Oct 2024 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Eexrvk5h"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2062.outbound.protection.outlook.com [40.107.247.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CAB21790E;
	Wed, 16 Oct 2024 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110716; cv=fail; b=Rm4ovrPMLio6XihMgoM62ukUIfFId0YLzh51o8e3dYTREmY1EOieLIjmOi20r3Q1Uau84HnljhLOemzaMD1/uZ4Tlr+Cuq4Jr9ivS95oJfqnPs8eQMSTuNkH2Y4tbEG7wbEug3b6lGB5Rchn1GSZeDu3y09IC5joA/DTKWCQUAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110716; c=relaxed/simple;
	bh=lyWe/ySMkDZ490wGZqd1uDY524RbQ2uyh4spYd1a1x8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=O2eOq5q+TgLh2M32EXvGy9J5UcbzgbuSDUJo4Q/UlRNuDwA5ZwV2MjR/SOFdl4M78w5uyFD74lbNSwHRL1xG7jZ3wu6orHeAwTSn1yKytascpMCZKEnoClut1NrnfTKV0cTqn+MqPldVbhYcaQt9OWw9sd2vfudECTbGTT4HFIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Eexrvk5h; arc=fail smtp.client-ip=40.107.247.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTFdkbS1NI+OjKOw7n4x73cTf/PvmwkPgysgY6Nr6DhoqKCq7XnFvodR1yDkoMiq6kqAvqZyiPTlID0uGeJERBNQLCdvj4gDXT5Mhs8oDncq6cU2TXv6J7Wx2aRYDbH8Qv4OMlwcxSRRvYUHuJX5usyKYAu6UNER+MbaPU1+nILS+NWx2oQrCi/hBVMQYXocXDZ1ucDBfeRIpf0W5yvHnkHjvB8VT/HUnvUFQlUyTVpg4WZdeETDXl2bJI9R9RQ7C653h/dMQVVoZxg610w6tF/QznrMJ3Id/ES4sZK7BsEEK/IxQqvhdNagVYzkwZK7qZpLIaOqM/APwNXesjlDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMo2ngT7gPC02/8eJPlx4Oq5Zz9LMuVnQAOCsuCJbzU=;
 b=xf/xhWNFo9v+Kwjb+7nnvg7QOMVZYAcyov7+H7Enk0eX+AkYe282Zw3nNOiDBvQ3/u8MBrCPwAb4scnRtRcuHCrBONIWGd/oj7a14At+T76mO9vwgHm1Babfsiqovj6bEmN55ceBxWjrrlM2BU5RBxTpfwwkQISA+cL+j1pQ1ZYftwx/XyJEnHOFbYg9AI1s5439vbvcOyoTMzrL1JFX6KWkkQ51CfDV2wo40RR+Vx6hFNJYjObgCZPPF9Mkn8/vVunoUBv8SdPvwElkcrUa1+pMkx9ejfGpEynTJTpCNZQV3bjr+w6w8nVJVxJ3kA3kINFHwF7oiK+Ny9YE2JlTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMo2ngT7gPC02/8eJPlx4Oq5Zz9LMuVnQAOCsuCJbzU=;
 b=Eexrvk5h+xTam/I2FMoMzP1beBZLqHbLUTvieQeL1/2TgGO2Wi0FCPuq4zEOYpdwIm2Ictxm8iFDhHvv6HH9MMiDQHu71X583mVDsRRZb81bzqqscmdOkUD2kzLQz4efwq5ufSGVM/1bHcBxrG/rvxPNeWXfjHKm9/n3wR+3YBu23KfF3Pj/bJuz4Q35nMnQYMAGALblRhQW4xY9aiHaD3KeEaCfrHsxVEFqBmSvCrgFmC/MG6QvJHetkyMbV8SG7SeIZVs8oRMte8heHsaWpfqRN+atK3qZRWGhMzPmEYT3aHJT6QxK+FhLpZ8SXnAwN4Jptd74ha80SWJS0r+Sww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 20:31:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 20:31:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 16 Oct 2024 16:31:12 -0400
Subject: [PATCH v3 4/6] dt-bindings: memory: fsl: Add compatible string
 nxp,imx9-memory-controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95_edac-v3-4-86ae6fc2756a@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729110683; l=1970;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lyWe/ySMkDZ490wGZqd1uDY524RbQ2uyh4spYd1a1x8=;
 b=qavNKD3m0OnW/A7jjrg2/vgBrQs+uti8j5A1Eefj9Asqy/z29TGn9zSEI9eBCdmmWTPV9yLpp
 CKOQ8w7jC7XAuBCwZ/JfJ6Vm1NCDXSMPSS+gwGaDzkCqGmMrsP7v2cB
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
X-MS-Office365-Filtering-Correlation-Id: 110464bd-dee4-49a7-b285-08dcee21903b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFRSTlhGV1F0MklGWVVsSEdnTEtQKytRYzRkNVRCTnNxNkQ1SWcwTlNrM3pW?=
 =?utf-8?B?Wk5uK2lvVW1aaklqN0VhbFhCeXFyQmpjcEQ2cW96YjYyU1U0T21xRnNpR3VO?=
 =?utf-8?B?UUFJRllZdGt1YVFZcEFqSHVzamJsdFdVUDh2THBTUW5YL3ZjbG5WTnRXWmw4?=
 =?utf-8?B?M1BQNHVSZzNVODFOd1pJaE9NRkpJMnVXK1RFc2dtVHVQaThvbHQzaHN6cmpu?=
 =?utf-8?B?cDRsRVVYaDUxOWlkTWpZbE1vUWVRREtJNnpDYU1HZ2hjeTRGbXNBeCtJYzlM?=
 =?utf-8?B?LzdYWXJtTHNlQTUrejJkNk95V0cwclN2MkVCcWZzTnVTYjBYMWRneDhGdmh5?=
 =?utf-8?B?eU04dTFBYUUxMmx1SFJTNjBWSVRDWmVuYUlqR0ZFd2pHNU81MExsVmZqN0FN?=
 =?utf-8?B?UWFhdHZyTE9DY2NDNVhzNnVHMXJGd21HTVI2S2ZVYUdNejhXaUhuamIyNGxp?=
 =?utf-8?B?ZEVXQXhUVmF0bUlNUzhRN2o4d0w5OGxzM2FSZldPQUY3TFJpT1oyVWcyUTBz?=
 =?utf-8?B?SWJreUl6VlNQTHo3UFlnYy9WZmFJUTNKdHV5WmVTa1pVcmo5WjhjZmNXOGow?=
 =?utf-8?B?RWRuU2g5SFl1aTFsL2lnVk5IZFlKWE5YaEViZjloM2R3akpidkx3TDZqc1Zv?=
 =?utf-8?B?Vzdyc3poS3l6TldyWFkzY3RCVDR0TURvS1RRWmtsUGxpcHFPYmtHR0l4U1o3?=
 =?utf-8?B?NW5UM2I1SStrVitWLy9IR0twanMzd0JwQi9VWVFBZGlyNXc2cjd1NWp2ODJr?=
 =?utf-8?B?SjB3UWczQW9aUTFzZnZ3Y1Qzc1AzYU1QUnVPVHRkOUFKZkQyc3FFMitaUlhw?=
 =?utf-8?B?dk5uK3RKWjR2alpZcVQ3NzVrUE5HdFI0LzJxRlB3UlIvYm5CV3g0endOZnI4?=
 =?utf-8?B?T2YzdHBiK2gwQXN4WUk5aS8vd01JR3MvYUwyd1JHMW9Hck9KT3lrRkxqTzRs?=
 =?utf-8?B?UzF2bDBpMTJYMUxPTjZoQWpnemFsQjBGQnVzalFWemd1cUl1elgwcHQ4bFZO?=
 =?utf-8?B?b2VQYlBLK2ordGd4cXZMY01tTkpTM21SdDRVdnUvQ0s2eXdCeUwwL004b2h1?=
 =?utf-8?B?amVrekVTSGM0RkJxZVl2V1R1ZUcwVndMRVhzckYyVm90am5ZejVzWFo5R3dj?=
 =?utf-8?B?TUlaRkt1VFZSeWRFd2xwV0dPVDBvY25kWE5sSmpkcER4NVNGZU9wNXdNRFVB?=
 =?utf-8?B?ODlyWDdDemJaM2lCeGRZUzV1bHNXbEdPNm9oY3BHQlkxV3lFeTk1aXJHK0l5?=
 =?utf-8?B?WXN0TUlQUmNWUnI2RU1YcGdIRm9wOCtyVEZkUDRETSs5cmpQYXR2OUJ4MVZS?=
 =?utf-8?B?aGs4TXFQdmh5ZWxVRGpETFhZVXZxYThaeWJaWHFicGd3TjVNN2VRc2hLTTVZ?=
 =?utf-8?B?dngvUzBPRkl1ZktKTCt5MWE0RDRxSlJ0Y3dIN1lnQkZSZWxsa2FCTXBUWGw0?=
 =?utf-8?B?YjkvRWxHZFlsYUVHNzNYV04vMWNZaUtpcGhBUTJ5ajY1VWFFOERoWmhHYXJy?=
 =?utf-8?B?d09TWWRKTElMVjExL1IyOFRWQktyR01ZY3FKcDJQVHhXRzJBR1dPektkQXJR?=
 =?utf-8?B?M3puUDJTZjl4cTRYK3BwR3lqN01Mcm5kdTYwc1ZLWE9UcnY0aWJvNVFIM0pR?=
 =?utf-8?B?QW5xRGsrUGZkcTFtWXczb0FpcnhuUU81bGdVcjFHZFBicUg2MDMvSU5hUjRr?=
 =?utf-8?B?ajRmZzQ1STg4emN4cTBIa2E4QkZqWmNPT1BNaDJXZ05STS9JNW53OE9KdmxY?=
 =?utf-8?B?OWF6MHA0b1hmeG8xTkVGaGY2Nml3cHQ2Ri9aaFA4M0ZHdm51RFhtWjlxS2ZE?=
 =?utf-8?B?ZkI2Wm15ZjFreTlHUlZrcFBsNkJGNk90dndMNENEOFkxc2hNZjlKaWFndTQz?=
 =?utf-8?Q?I7c0abybrLXy6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFI5OEhqbXdqVXJhaHFvdE1yZW9ZTEEvZlAyaUlnSFNnRjVabW5DeStpeHR5?=
 =?utf-8?B?S25CMHpibmJaQUg3WERhRnJrdk43M2JjTWZubE1oT2F2aUd6eHQ2ZktIaG1Y?=
 =?utf-8?B?V1A0THBSZk9MUkUwSlF4TXlGQU5wSkM5Q2ZXTW5ZM3hRMTNnOTVsQmVCb2lD?=
 =?utf-8?B?YmgwQjR1OHEvamdNL3ZYMS9uRnA1bW9ScW5oM091K3RXQjJ0QjlpeEt5SkVT?=
 =?utf-8?B?blk3NTQ4dEEvQTUxM3M1NDZETmxKbWw4TDlkbW4vV2E3MlFYWHZDU2FTNXJz?=
 =?utf-8?B?SzlFL05WTTlwSjVadXNEQTNSaXZKZnZvTjRRSDlsZjBtZ2w1cU40TVVscUJR?=
 =?utf-8?B?ZE9sOFZJWTI1UWp2eUJGUzdwQ1pJUG9HWmhSb0Q2bENiYWtFYVJYYW9ubmFW?=
 =?utf-8?B?UTFnblZoNXJNakVpT01RMFNBdnNSKzAwTUIwNnVyS2hoaGE5dWwxMGZob25w?=
 =?utf-8?B?UDJTNGIzSlV2OUtES011aGhlTFlyT3YxTElIa1NDNURpampDUCt0UlJRbjFx?=
 =?utf-8?B?SzBsU2hrWERyQ2VmNUlFNUdTZmgzQldMbElqV01KbnJ5N1FKYjk4Sm1aeFBK?=
 =?utf-8?B?N2NuMzgxNzkvZ2xiQkVsSXpWT3N3QTMvV25jcE14UHozNS9xcFAyRUdwL0Vw?=
 =?utf-8?B?ZDhKazBnRjhJZkR0K1V4QlFYQjg2cmcyblB3dnJBeEVzN1pkNmpRYzZWTms2?=
 =?utf-8?B?WDJnWVRqUnlDUWRnUkJqQVB2U2JJYnNiYXpUM1NHQXAzV1BBL0JYbWl3YU53?=
 =?utf-8?B?MzR6ZS9ZbWxjN0tmM2cwdzBJVEhVU0hSREgxTWFTM0pBM2Rtd2xWMytVQmZw?=
 =?utf-8?B?cHJGWERsVlRaaS85YVNtbzB3Q0JsblNvdXZaRVpwTVNMV1BZWDk0NGw0YUx0?=
 =?utf-8?B?S3VyWFFwUDdjeUE4bDBrQmpkSkNUZWdvSTVyMGY1NHdwVXMvMXg3WkdNYjl5?=
 =?utf-8?B?N0ZYR1Frb3dJbTJrWUh4bTZGam14RDBvU0tsWmROSHlwbGNGT3dVYUp5TXFU?=
 =?utf-8?B?cXl5blBUMjdTSnVqSHZDZHlaTmoxSlJPcE9tYk1iU3FaY0lTSWN0anM1QmxX?=
 =?utf-8?B?cGRERTJsaGM0TGxVRVBUR3d6MDRrTE95TjNDaytjNkFFUGJnemRiZEJjWFVi?=
 =?utf-8?B?MlpGT3N4VyszaVYxbTFBWVhEazdkZENIUnhHUFZJWDNiK0lrOXlBMStPbDNO?=
 =?utf-8?B?R0UyUUxRd2ZKeUhLSjU5aU1hRVppUFNZNHMvWVFkV0tKQStRdy9iVnd6OFBz?=
 =?utf-8?B?Kzc0dlQ3bEEzaUlFWUl1WExuZ3Q2RFgyYzRqZHhZUzhxMG5jWFJPeDNIRTR0?=
 =?utf-8?B?bTZBV2NwVXA1Mzk2VlVFbzZlbkhhbzFyT2w2YzVKckF1dWNOU3NPc2UwRkc2?=
 =?utf-8?B?SFpYTHBQMVpZUFJwVE16ZER0dTh5Y21OVE9TUVl0bGxVaXN1QTFKY3c4enpk?=
 =?utf-8?B?b21EV0lhZ1lXQVREZ1ZtNHRWVmtDWStoNWowYXQzcTdvUWJGMlBYajN4eHFa?=
 =?utf-8?B?VWVkdzBYNGQ1QXBMRXcwV2VsbUo4cUpldUMvckVneTR6OWt0V2ZOWGxFeDRH?=
 =?utf-8?B?aEZidTBpVVhpRXJGR0paRXVWV3pYNmRyZ1FrUUlxaTF6YzExcnpYRS9mdGkw?=
 =?utf-8?B?TzNSUzAwRzZla1g3WFAza3JNejgxZnJLWlZVSmkwdmhQSkhKTk1hVHZPUVZj?=
 =?utf-8?B?TXlFa3hNSmNqaVdJNFo4dy9SNXpuN2czaHcvVksrR3dxdVBFZE5sYkpsTGxy?=
 =?utf-8?B?QVJPY1hFc2loL2JCK2RrZUJYMnZoSjFLVllieWRYOWZCZmZZMXA1T0o1L0dK?=
 =?utf-8?B?bU1lYW1XUk1EcFdLYjBidVM2MmlNcWt4Y09iR1pRL2lXV09UdStYc256OUpm?=
 =?utf-8?B?QlA0MEdmMGNacndwdFkvVVBsdkZrcmZGK0RRSWJoaEVXTzUxZWcvMFdCeUpI?=
 =?utf-8?B?TDJYYUhDMEREQ01xWFEyY2hZUWkvRXRvc1JLcFpIaEFQK1R1Q3VQa21aSlkx?=
 =?utf-8?B?bmt1c085ZDRacjRraStFVUxlcWdJb3ZYV2RMdHdtWWtrK0tGVnNlQm9DUXZr?=
 =?utf-8?B?anJJZWpNWVJyMU9Wb2ZBRm9yY1YyUWFPMWI1N2RqenNmYzJ5UkY0L2RIc3pl?=
 =?utf-8?Q?vGicdtKHVthYa90FupKc02P0x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110464bd-dee4-49a7-b285-08dcee21903b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 20:31:50.1700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LsSMPJ8YOSKqTdqHsc1hqlQsrJrSX0CM4h2V3EyYXfxA/kHWuHB3FxHGRLSIINGlBD15K9C6uanIgMwmGURQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

iMX9 memory controller is similar with other layerscape chips. But some
register layout has a little bit difference, so add new compatible string
'nxp,imx9-memory-controller' for it.

imx9 need two 'reg', one for DDR controller and the other is ECC inject
engine register space. Keep the same restriction for other compatible
string.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/memory-controllers/fsl/fsl,ddr.yaml   | 31 +++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
index 84f778a99546b..e0786153eec73 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
@@ -40,6 +40,7 @@ properties:
           - fsl,p1021-memory-controller
           - fsl,p2020-memory-controller
           - fsl,qoriq-memory-controller
+          - nxp,imx9-memory-controller
 
   interrupts:
     maxItems: 1
@@ -51,13 +52,41 @@ properties:
     type: boolean
 
   reg:
-    maxItems: 1
+    items:
+      - description: Controller register space
+      - description: Inject register space
+    minItems: 1
+
+  reg-names:
+    items:
+      - const: ctrl
+      - const: inject
+    minItems: 1
 
 required:
   - compatible
   - interrupts
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nxp,imx9-memory-controller
+    then:
+      properties:
+        reg:
+          minItems: 2
+        reg-names:
+          minItems: 2
+    else:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names: false
+
 additionalProperties: false
 
 examples:

-- 
2.34.1


