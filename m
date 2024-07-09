Return-Path: <linux-edac+bounces-1479-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AA092C478
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 22:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618B91F2334F
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 20:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F6187873;
	Tue,  9 Jul 2024 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kowJTigb"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925D18786D;
	Tue,  9 Jul 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556632; cv=fail; b=NAvG3oe7eXgYzsHPImYEMKl01oRdEiPfweof4NoIDrYo+ZLvdG9OTcBCIFs8ZoUQFVFh/TAHkjAgf7xd6nC2FucmXQIz6Z9NJhLPdj0XKXZ3ZaLpp7qyTNPBoa+zz3mCcz3AskmeiN6gdF0XvuOJLl4itotmI5E02WfKDCg4Z9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556632; c=relaxed/simple;
	bh=sEQ2s5DOaJpFElpdRGOeANeI0KjitaYMW7pvhbkIm/o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=psCKSrvvTs1knuQpFmXh+8hrj/z5tuicpZ0TW6DaxwiTZ7tS6ffGtAkdNXHAogRwsjue3/mMMvO97H+NDsEW+ksD9vnVdh57axV5+1LzvI6xRtwJMfhiIG9xiKjDXZExrkXdFtNMWFMPfU2LOGnI4dTCNjk2DwDmsT1tL1hILcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kowJTigb; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyyLR0hypnLLAMg5sF/rZdjgcc+IlRVs7caqIItBgKrOu5Vg/CCYa+I9zGpvfLeIOj6u5BGZA6Yq22VAbhl9SErQkJFlxJoSXR/fg2Lj0u9yXWrEe2RngXQxjsRV/8tT5q7TnzeavaA2nJoy9qe8S5bsShW/jXLw+n9vT2HIZ8M8nF5DfXKKGBUt2bu9My1i2LWi9PfH/mzt3uV06VRgf7o7WJLp+ihh6n6ElHVZ+iQEaJDseFjFoCG5IOuDzXDnixR6PgHq6dAnjf3K1F8A5KgZaA9H/xEUdYyjoNSVqhj23r52gPsApRJ2Lbd+d+DBLmS+ab9N3asfJhdq0pG10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M18oDrIm0n7SzSLcID9y8NvUus7H0YWm2DEQVvXaTa4=;
 b=g5HBjqeNMdhMdvOoYaWBCYLzeqhIXwq2aSWV0d2S1fZMQVCPkQ+rKNIypTc5a2sPQU/C2WHYEjG+8F+9/DqThL/2iSsPuRdJpI+IBrDiIqdVz92PlWS2OD6O7cr1n7V/9IKqK+6A0SW0EVrUe2k5tYvVSiBp2tAlbjC+pu+Zaym6M7Y913Pec4Q9qVCL/GK+6plLUVKtb1T39MmJ5qAWxOymD5SrG5DMIYj/Wn0Vm5u+hUMaDx6BAe3o1EKYsi2b25u4TVFNQPx98SK0JVl5ZWowsJZN/uI+axxXgKwBdAHja9GRblOHv26TClnLTHGTK5TA3CRpLbPeRSwoAUQ6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M18oDrIm0n7SzSLcID9y8NvUus7H0YWm2DEQVvXaTa4=;
 b=kowJTigb5+Yy8KmG6MgyhdmlcUxrDJN7b99FqrhtMKhQYofMhtfigg9wMOh580JYa/XhFu+vNqf9L+eLd08mhOxyYUyT+d2ZBQKcYTBn1Auf8EMFCKPhkdRaModdcC6GG9PvTvURKuDektqhSYkxrb9qf91cRCvrdec9jQPOpYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8267.eurprd04.prod.outlook.com (2603:10a6:10:24b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 20:23:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 20:23:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 09 Jul 2024 16:23:05 -0400
Subject: [PATCH 4/6] dt-bindings: memory: fsl: Add compatible string
 nxp,imx9-memory-controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-imx95_edac-v1-4-3e9c146c1b01@nxp.com>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
In-Reply-To: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720556601; l=1903;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=sEQ2s5DOaJpFElpdRGOeANeI0KjitaYMW7pvhbkIm/o=;
 b=Vn4XK7e4+72Pi4m92N5oOm/JDIRynHBP8bwx2ivq6Qq5Aq+1ByMcJxulB0TemTYYyw79FST35
 MR90BpuRCgwC/GukSWTTSdmCUIs1G8hfDgKGMUAZTUuKcCN6oq/Lge8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 2032ff1e-d238-4907-dc00-08dca05509a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkF1RzNKTTgrTXJCQUIzWEFPRVE4cW1WaGlhckQ2Mk04clFTSXdxM1JKN0NX?=
 =?utf-8?B?N3ZzNHN4Z3dpa05aYU5yYXdMRU9EU0FXK1RpVkxXckhWQjIzNmFVbjErSE5W?=
 =?utf-8?B?c1o2TXhMSXNubDVqZW1heFh2ajNvbEZ2elpRZExyOXJEZERpVXRPSVpFQTBO?=
 =?utf-8?B?VzhLZXZiWm9wODR6TnBPMHNheXZIbmphbStvWHlnUEZjYURmR1p5RFBzRFUr?=
 =?utf-8?B?VlNsUnpGWmY2SWxqSDZnYkZJbkxwN1VKbjJnT28zWlJ6OUY3TFpEaTlQMkE3?=
 =?utf-8?B?MnBYMEdwVDdvSnhsWHlsYnBET3F3VTdtdDZjb1VEcGh0TGo5TGVHREZIVE9z?=
 =?utf-8?B?VlFEeDJSY2hoUjhoSmJ4R0M3Qk13cWVLdDUwQ2FMcTl3aVQ2SkZkaURBOVdn?=
 =?utf-8?B?VTJUN29RWldvS0tKS2FsVnRIT2Z1NWJjbzlFK25mK3UwOHp1NkU3RndDVi9R?=
 =?utf-8?B?OXdiSWw5Rlo0MFUxaVpHMDRiS2tObVlpbldsWWJWM0FFRUxtZFlzNWJQdExB?=
 =?utf-8?B?V0IxTjhOd0orMEpaR2c2NmlMK29jd0M1QXZ1dWZwTmk2MEJwbFk4Q0R0WjBZ?=
 =?utf-8?B?UG93dEFRZWgvdWltVjR0VVBDVVlpNzAzaXdYYzFOeXk4ZVNkc29MZmQvSnhS?=
 =?utf-8?B?MVBnS1ZIZE9jemViNW9rZ0h3MXRTMXlVQ2NERitsTWYwY3pNTE9IMzVGVnEv?=
 =?utf-8?B?UUViUU54cDJLZVFiNWp6VU5GZzRoRHFEYVkxZlNqVGt1TXJyTlhrV1NvTkJL?=
 =?utf-8?B?R1dSaitOVDFkamFHQ2FaNFlvWFdTaFhFWDZnZXNVOEowY0xCRnJOQmxvd2JD?=
 =?utf-8?B?ZFBPSlRvbTJROEV6aDhXSjdFSG1DREFQdm53Y2daNzVLN01SQi9Vemd1Skpl?=
 =?utf-8?B?RHRtem4wYVRtVXhCREhuRkt2Q0VDMUpWYlV3eVpHTkFRVG05K0x4VGpJa0JH?=
 =?utf-8?B?czJ6NnJYd3FIMnliVjVmWFRiYVZqTGtEK1RQNHc4NHhjemVKOXFTc05NM1No?=
 =?utf-8?B?T3pYakx1eW90M0RWL3NwRnBNbVdUTXhwTldQVkdNUUpZUUxVVDBmczlWZzZR?=
 =?utf-8?B?TXNyU3VwNEdKTHZPL0ZDVFUrWVNhR29UdXIyNnZnd3FsWWFmaGp4bXJtcGlo?=
 =?utf-8?B?UjF0N09URlZnc0xUeE1DblYzYWlmMjlxYm1ZdGkrVUswbzdVaWg5ZWV5THpy?=
 =?utf-8?B?YUZTcVMwVU1VTGdoQkt0cTc4b25CRDl2d0NVT09wdmd4VDJyVlY3ZGNzbkRF?=
 =?utf-8?B?NnBpd3Y1ckpWM3VvTDJJVVFlV0YvcEZSZm5xdHdFY0VWRGlJQTYvNzh2SHhr?=
 =?utf-8?B?VDF6V3pOV1V5UFRDZllYUEIxVG5WMGE3UUpzK2tEK2xIRUtZN2JTMFFWNTBP?=
 =?utf-8?B?bHZRaFFObWFCNDRxdG9BcE8rOFpWbmRZU1lZN1JtVCtuelpaUUhUMGlVTG0x?=
 =?utf-8?B?UEZ3dWVQanlQdTJ0SENVYUwycTd6NjU3Zm4zdG1sdW5pTTF0VW1QRWFpSkxk?=
 =?utf-8?B?VDVkY1drK3VCR3ZlRi95aFh3ZnJmYkthOS9RWjNrR1RkVUdRWE9ad0xxK2Fz?=
 =?utf-8?B?OHcvWUVILzIzNHQ3djJWSDUrejRNWEdzRERGNnJxM3Zsb2hVcnBIZEZIVVZC?=
 =?utf-8?B?MEtIaFFjcjNjN2VHYm1ybjRaT1RWbjZaa0FSY2R5RlNjTkllVDhwb0FBd2RR?=
 =?utf-8?B?amlhaXVRVTFDd1dVTzJydGN0WlMxb21JaDA2N2MyYnV6MHlJQjVqWXhycFdH?=
 =?utf-8?B?SXh6MkVxRmN2NGljbElCT0M2Wk1KNmVTMWNPNUlETGYzcjFTMWZ6bnZsS3Iv?=
 =?utf-8?B?b2VGd3pFcHhDeitPVGtXdXJHTFJoR0R1NTN3aUJlMUZpVXpyb2cyOVI4T1Rl?=
 =?utf-8?B?MURuK21vOFdPa1JWVVFzclNTM0gxYnNoekJXaGkwYVFyTUgwR2JCa1RjK0pG?=
 =?utf-8?Q?vUI2EqKi+/4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0VKNnVHNU9mRTh2WFJJQjVJT0dTdWxmN0dNbWFYZ25QeUZObytBcnNTd3du?=
 =?utf-8?B?Mm9QNk9XRTR3YnJMTVJXb0tGWEtTQjdhd2hPMnh3WjZ1RW1pQS8zT0x4NzV6?=
 =?utf-8?B?cDRWYm1mQ3BTZUtDQ0I1NjZWYzJJZFNDbVVIQzVIZlIrbXhvcjJEVm0vOHpi?=
 =?utf-8?B?eERVWlJTRmpMLyt4NkRNaWdMTzhxWndOQzI2c1VSZ2FQUjZHa3EwWGptRWNs?=
 =?utf-8?B?cGxCRlh6SlJtSTI1SS9MRVlWRFJpZmNraW1NOGJIV1NQWjZFNEhucEhVRC9m?=
 =?utf-8?B?Mmw5TTk1Z0IzTmJGeDFOcFp4ZUVVNmtzQ1g2ck9ETjRla1piMDZqekdkWmkz?=
 =?utf-8?B?ZE9QVW8wMUhyOGRIR1gyenR6VGx4UVZ0Y2F5WjJvb0FDM0gvK0ZVUzRpSTBG?=
 =?utf-8?B?NkkxVHdpS1NzL0k2YmlpbDhtRnplZXpqVW8vNWNjTjhrTEl3MTBNaWErVGZY?=
 =?utf-8?B?TUVQYVR0Rk5hY0hVTkVSZ3JZNElYUHd5YWdCb2pYRlB2STJ2YTZOTko4emhX?=
 =?utf-8?B?WU1Ibmo0M2dkMzdaTDM2Yk16a0U3Nk40M0U5MFR0RWRkWkxxQjZXT2pFeUF0?=
 =?utf-8?B?ZnZKVEwwUjAxejVYZ1VDRjhCbUtqWW13SDVxaXlZUVdmbmFqdGVhM0pYRnBZ?=
 =?utf-8?B?dFdWcG43MXJqbzUrYkJGUTExaVJrdkw3M2pZWVpDVkFnVnJCNWF1enkvay9v?=
 =?utf-8?B?ek1kd2Z1UWdGUUVUd2hLeEhoUUZwWStEUjVkSXpjaWFnOWtlSUd2cjYramth?=
 =?utf-8?B?a1RLMDh4YktRM096YWgvdkVPUTNlNXRrcmVLVkhCQURPOXltKzdwdWRVWWdY?=
 =?utf-8?B?NFd4Nko2ZS9IMWdjRTJxbGF6c0Z3VENqR0E1K1FmVFpZS2dLaHpaOUZpWkhx?=
 =?utf-8?B?N1VFK1RRU0RRclVEc0hEL0crQVlQV1JXWThKSTVzeUJtMERhMUhQZUR5b3pQ?=
 =?utf-8?B?TVJMWXJuK3VySFVPeDdPWlMzNjExWE96dWZLeXpFZWYvcitFTmVNdi9wbzU3?=
 =?utf-8?B?N1pSVzZBMWxJcCtla0h6KzRvYng2ak9JYmFYNE1oL29MRHhTRGU4MnRvYmNk?=
 =?utf-8?B?eHJvZ20xajNHbUNVNTIzbGtFaVZ3bWdYTm5GZE5QM1B6RXFlenFXeWtVcHJl?=
 =?utf-8?B?aVVpMmdxMm41aFZ2Q1lGekJMTjVpQlNUV2w3L0pONHdvWCs1TGRlRUluK2Rr?=
 =?utf-8?B?M1Y4Q1IyVkpEdmRWdXlZd0M4Wkh6T05GK0UvMUEwc2MrKzB0a2F2T1dISEp3?=
 =?utf-8?B?WjhWaEd6UE5ZMGtuSkRGYjZpdWNwQU54Sm94RW1OWkwzc0JXMy94OEN3QWFB?=
 =?utf-8?B?a0dyL01ZVEl4aDlhbWR4dzJkdGtadjNNbGVpUndLWHNGSS9PM29HeEdQQloz?=
 =?utf-8?B?OFI4M05YcmJCd2tOaVpOeElnSE51NzZYOEVEOU9NWXhNU1Fub1Rvanp4Mkk5?=
 =?utf-8?B?dHhPQzMzT0d3ZFRJZlZraDF0Y0F0UzlwWC9aSEUzc2hEeDVHUXprQ3ZNMExw?=
 =?utf-8?B?eThSS1ZmRmpYZzB2dk5FT254eDdUU3FkSHZBR1BjdlRGV00zbmtjSE5vMU9H?=
 =?utf-8?B?dTJvWXp3OFZSdlR6cG1ObjlZblpuZWVLSXozSHlJMXgyS1g4ZkJCQlVUcU92?=
 =?utf-8?B?ZThoZ0FoV3ZLT29maUozUXJzLzlrV1NuOWYwRTlEZkR1OEhvRndJb3N1V1FH?=
 =?utf-8?B?dk03U0pSTFFmeGNORzE4TVBzOFZrNll6MnBrM2NDMTluNW42b056VUE3M2Rk?=
 =?utf-8?B?aVpWRHpPMHZMVjhSQUZTQ2ZNd004N0E0V0s2YUlYbzdvRWRaTFNDOGY0d3dZ?=
 =?utf-8?B?cVdtWTFBZHNIaDVaM29lME8zbnRQY2VQWEE4NVhQanhFaGJob1o1N2JoZDZv?=
 =?utf-8?B?eGxFek91WlhWb3BablJDaHhrMEVqbjhjVEJMajVPdUlKQXFZekRjQWNxcEJu?=
 =?utf-8?B?TmJ1cU5RNDVHUUR0d1QrSDVuTDdiQVAyQ2t1QUFxMGwxYzJLVFAzMHc3R0Nv?=
 =?utf-8?B?dWQ3SmZBT2RZaU12OCtnOVd1U0FKQlVJcGIxbW5vL2tqRm9aNGovNUN4ZGs2?=
 =?utf-8?B?UGduTUdiSnc5RWY0bmN1K0lmRUNXeW1oNDJHeTdNaUhFRFRhK2QyNm8yVWd1?=
 =?utf-8?Q?lXMzHEN8BsEP80VXW4BeFMk5Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2032ff1e-d238-4907-dc00-08dca05509a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 20:23:47.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGgxXaA2c//yA9Cu3x7GhhR15yBLvrBjbkCm3uD1ZKQwXiJDre2sFToU026xQ6xouC+OEMuNxgzwT8QsZZJlBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8267

iMX9 memory controller is similar with other layerscape chips. But some
register layout has a little bit difference, so add new compatible string
'nxp,imx9-memory-controller' for it.

imx9 need two 'reg', one for DDR controller and the other is ECC inject
engine register space. Keep the same restriction for other compatible
string.

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


