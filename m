Return-Path: <linux-edac+bounces-1481-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307EE92C47D
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 22:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537281C22121
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 20:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FFC189F41;
	Tue,  9 Jul 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BVvG2akz"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257A189F39;
	Tue,  9 Jul 2024 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556641; cv=fail; b=X2NhRcu6C3carLMasGXgtJXvlUD+VFZ+Unl+asi6C51ZpQ2xrSS7VyhshL32SrR28t0U/2UPrcfYBYXo/yNC34ajaZYzTkfJ4nw7aC81Egg0vCBEWS3Y92fDs/MDZ3E5ESEFg+oLuuANQfyDQGejPMra93A+dzW/Ok2yUY2QwzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556641; c=relaxed/simple;
	bh=s8pNnrdq56Ppj8eEPtENwxRkzkEKcLwgHNFgBUHLUgg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HK98liiZUU/rYD7ShyXcNusaki/Ihndw0OH/sg4gcuowNgp8zWJqhPE/MkAqym2pIzI9qMlEIvw+TVQ5x+5NN3LFcjpF4vkuu1v/oJ/1oDs5vUFVHBHAlPkBbZeJ0KBH2YaZiH4UJJoM234f4uv9+TnXG1D0vMKzQJnF7cQvZKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BVvG2akz; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SR8qnkzscrWlPVJDR/g6CEu8oZqAruVjoT94dDBrUzDiZJANQxxRMuBwBgpFXTO1k3trQ/kubNZPKduIyUCRpu/cipYripFzhtAi8oOmLCKC0KsHhI6SMCilzRSnDRF5hm18duTLLtdF/ijlrGbwMp9ro0YL88aXrDzkxptvfOSI+4SNnjv4fVlBgGFlpqtRC+v2yrK5xzn+Iw5kLxnZ5P9zaxHrh4wZrXJx1ViPwlvlwOwi24K4Up0alGtXKmlwGDAbKGd6hWRpehClbi77VuykBM2h/zu/bM09Ph9LZWI24ESCmpVTHouONvg1yL2xQ6xktAVJ67MOzTt3DCLvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcyyOpXR/elxOWjMLNQTI1/X+neU4CKgNbG534icVsg=;
 b=ZJRnD8yxBDwlVHM1Mz6rZMa7Q+edvvKJfRofdznhVMt6z08WGA5dcIeu2eOqjE/v9O8T6efYrGk112HMfJn1uHQ33YI8RSaPKR5CbbC044LgZNenxMAPG99dRAg1zxApln/G9fs6BDu8gTZtNTy04LBKLbp4Ih5YCf2azv3SGoAOVQokNXXWVBior0IskvcwXiLheIHCb50ydybunyMCrO83Anu1X/8i0FMf/LHK3OBeZ4g5O7PNwwBJgd65dJMRlOfmNmhKD6m4eOZeE2kQfn6w4z5boPmUQksaGB9VopsaekLb658Z9L3+06b3LADA1e1spdch1oEZ90oPHwirwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcyyOpXR/elxOWjMLNQTI1/X+neU4CKgNbG534icVsg=;
 b=BVvG2akzLDSCVCWhNcPW7uLqXwlY2y+VXFbe4Ayirod2iScDiyUlnterDlvcy6Bd0vV7f0/F5gI2uGa6I983q5CSZ+0G04emiP1q/KJoVy8mXlj8h+Jo4I1rdJmL0/+9EmB0EBBOgCSLZhFogNUfX5ULeRkpj9KEORP8iIQND7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8267.eurprd04.prod.outlook.com (2603:10a6:10:24b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 20:23:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 20:23:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 09 Jul 2024 16:23:07 -0400
Subject: [PATCH 6/6] arm64: dts: imx93: add ddr edac support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-imx95_edac-v1-6-3e9c146c1b01@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720556601; l=859;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=s8pNnrdq56Ppj8eEPtENwxRkzkEKcLwgHNFgBUHLUgg=;
 b=AwHYQq0Qcdnoz25sGb152A0P9wfUumjviii1fP58m1xcjkJv5OuEUCOxuWuyKAwnM3sXhYyDH
 y+rERn1bs2xCQ/2h5MQW40E6KA4RolfzBrPvGIIlvDP5Ad8nFMSDUqu
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
X-MS-Office365-Filtering-Correlation-Id: d8358489-1b22-49b1-6d95-08dca0550fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjdLamNlMWpSRjRMQ0ZGSkRLRWdmM1R1R0F4dUNzakUvSXFGUkpnMEl6V1l3?=
 =?utf-8?B?a2dQV3R2K2Rub3liNUpudTFYZjJscHhKSVl1YlN5cDFucTdjMjZnaE9yWk9D?=
 =?utf-8?B?ckgybDVVZXhQRThGNDZVcm8vVlRkWHJoU2h5VDZQMDBoN09sOEROVzNqaytk?=
 =?utf-8?B?M0svb1NCVDRKMHgvUGNVdUZCSE9CYU9LYmVqQWZSVzd0RDJSY0ZFbXpXb21B?=
 =?utf-8?B?THg0Qm1BT0xmbXdUci9RSEpyZjZobE12RU5VMUM3Vm5VY0xPeTJJS2YyUTFU?=
 =?utf-8?B?eU9rdFFKeVF5TWpkaTltN1NRY0JpanNDQmxGT3FKOU9aVno0VjdLeGx0eHd3?=
 =?utf-8?B?bTJyZVNPZUs2NFlrTVpwd0p3REYxemJLSkpaTmNaVG9wU1h0Ym1TRkxHRkl4?=
 =?utf-8?B?UEZxVk1sbytoVER6eU9QRDhyMUtCTitheFJXZ0dIRlR4dXhhUVRnVXVISEhk?=
 =?utf-8?B?YTdxQ3RnVXVmd3ZlWDErV045MHQ1cUVIL2xpdmpSbzcyRjhtYTNxcUVFV0o5?=
 =?utf-8?B?SDdBRzhrcWo0c1lETFIwSXkzODE1V05paVMreitDS21hNEVaakVwMEdqaWMw?=
 =?utf-8?B?UHpFLy9QUEZ6eW5xYU5ES2RoL2Q1eTJHaUZXUEZ5TWlXMy9Qb1RJdGxnRHZy?=
 =?utf-8?B?bnI4TTNIQnliVmdLZ3pLaUFZbWNhWDhPWlhUb012YXFwL1VMa3RVanlnLzRz?=
 =?utf-8?B?YzUrOS9YTDF6YUhQOUkveEFMaldTQjEwaXdBYlBERWlkeXVzYW5kZVVFYkJ5?=
 =?utf-8?B?YksxUmt2Y2prSjdyZ0xVd21tV3M2clA1MzVpZFJjL1YvZHNxRWI1bFVGQnNx?=
 =?utf-8?B?d09rZVNQNmttOGhEWXNKKy95NHNGdFg3Y0V4Y1F1WUthdzdEdmFHOE5LQU9y?=
 =?utf-8?B?VzRCT3IvazlLREVodGVUVGo4MHFVWFRtL3czOUowWnVWSTBpNjQ1empZeXhR?=
 =?utf-8?B?eWsybXJsekU1ellzY1hYcWFsbHhpTHMrdUR6NWp4RDVRdW1RRnVSWGIyQlV3?=
 =?utf-8?B?dGZlQStrQWdRVDhNcnpvY3hTNGdNYVE3NlAxeVVQTVRJSWhFY3V3dzlUajRs?=
 =?utf-8?B?YVFYd2hOdHJHVzZLa1JWVlVFY3Y3eXJCaC9FcnFSMUE1UkVnOUZpb01qbVdJ?=
 =?utf-8?B?MFFndkV5aHNPbFE1QU4xODU4b1VGZTdibzZobS8yeGY2RWxDMTdGWnE2dHVv?=
 =?utf-8?B?Q0U2VlkwMUlaQThzSXhNV256RWtISkROeGw0U0s1akkzVFlicW9ZOFh6M0hI?=
 =?utf-8?B?eGJBYm5oMlhWOVliaTZPM0IvZnA0NWFqVXRUSDJHYUltUjRKaHduUU85amR6?=
 =?utf-8?B?STVxYXNQQzZ5UC9pSi9rMUxjd1Y5M3hkVkFPY1Q4MWJIODdUZnVLS0dDQUNF?=
 =?utf-8?B?cEtzTHArSkRLNElQU091L1NzSWR0bEtHc1ZuM1R4N1FnNHg0MS9oc1lFZkkw?=
 =?utf-8?B?anJJVnhlUExIWVF0U2pvc1daRFZPV0JVKzlLK01aRThjekdpdzlQMEd1STdN?=
 =?utf-8?B?WTA1aDJTeVlSUEtXamhwL1VZRU9zenZNekNObVFxckc0WTdhTll4ZnV0cEds?=
 =?utf-8?B?MVZSSEc2cFoxQUJpNlBmYU1EZUJndUdxLysrdHJnSk1tSVJkMHh0dkErRXRL?=
 =?utf-8?B?eDhFSGM0Kzc2UzkzYk1nSjdVL3hsZFNJUmNwNjlOVURQMmZzaFJKejhsWnJT?=
 =?utf-8?B?WU95eXdRZ2wwaWZzWi9mU09HMTRpRVV0a2VlOUdEc1V5eEp2aU1aN085Mm9W?=
 =?utf-8?B?emR3OVRiYTJjc2VhV2RtWU1xbTZOcWw0OS9BVXdOY09RQ0ZSdFV1cmF2MlB3?=
 =?utf-8?B?clZGZEcycWQvZ1NNZWFFVU4ydmZjY0xuZ0ttV2ZBajhnbkFHbmVGSHFsbGhm?=
 =?utf-8?B?amJUVDc4Rkw5NmJ1ajFiUXBQd0VMM003SG01K0hsRFkzbys4Uld0Tm9XMUdX?=
 =?utf-8?Q?P4TL9CudueM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2hQT2k5cC9LZ0lma1dRU0xaWmxKbzlhRG9hbU1MZ1JMNUo5bytOTkpIYUY1?=
 =?utf-8?B?SWM5UUFVeWNDVDE2ZVBFWHRlQUFaOXFVOVNFQkFTTElGc2swRDVuSjk4K1pm?=
 =?utf-8?B?ZVgzRm5UMzZ3bERwWEx3UmRuZk41UWFIVEd2cXkrdUoxdWlTRjV3Vm9FMldC?=
 =?utf-8?B?dDNnVXNwaDFCVyt5L0NtR1lhVEFxajFvSnh3K1ZiVVVOM2ZybFFUc3JXd1Rv?=
 =?utf-8?B?a3FmbnVQbDRDb2kwZE5hUXZabklxcDRjQUJDTW5pdkRGMlUxOEh5ODBhUjAw?=
 =?utf-8?B?d21aVHNHSzNoakg5eTNTZUc0a3dCWFlxVk04aHlZMDI1YUROOE5KejNyS0Rs?=
 =?utf-8?B?ZlNYM3NXZDk1c1FUbTV0T3JDNXpzdnZwcFdiWVgyRmszdXVxMjR6U3Myd1h3?=
 =?utf-8?B?M0RLQnRvalZoV2VKSkZmSjgrYzJSWUhTUmlYdmRYeG1zK3UyNW9PaHlLWFNu?=
 =?utf-8?B?RGhXc21EZytURkRnQXpBaSswTHVNSHpPY2s3QjlOS2d5aHpjaUd6b2t3bDFh?=
 =?utf-8?B?cWJUTkNqZnhadEtuekd0MUJ0bys3WUN2a0ZGbC9LNk1oNDVQZGRLaEtkWi9w?=
 =?utf-8?B?OUdCV2FMRERqVCtJT1lVTlZlUlJOQXNjQ21OVXQ0bUp2MHY1Q1NwSmhUMW9N?=
 =?utf-8?B?dGkrZkFEbU9RcU94UHNudm1vMVQ5Z2Mvd0pKM3JKck5QOEp1UG5HaExNSTQz?=
 =?utf-8?B?TDVXSVpISnYyeGIzbXhSM21BQi9MNWhTcTA3anFoZktxcDY3Z05PcnYzOTFX?=
 =?utf-8?B?M0JDNmtsVkdReThGU1lINjgyS240Q3Q5aTRKSmZFVy9CcnZjaXJVdE1aTGZ5?=
 =?utf-8?B?TG96Wkk5MUlNRXFBTEkvQ3JUWjg5QWpydkxIWUI0VVNiRnB2dWVWUVpQQzQw?=
 =?utf-8?B?RFh3bCtzQ3hjaFAvcERybWZNK3d5alNibnlmZFJJRWRWeU9sVUdoUFRPSkNE?=
 =?utf-8?B?VXpUdHF6YXlZekJHTGRHcFRZc0RwTzhmUUlJUnBNRE41YUJ3NU9vdnVGa3ZK?=
 =?utf-8?B?Q1g5RktyYmk1TTJKRG81blZkTjd3SnhGT1k3azJiSlB1S09sZHdPaDVjUlVt?=
 =?utf-8?B?dnBmYlZ2bGdOUlFKS3RNVS9FRE8wMEEvb2MvL1JkdEZEVXZ2WGdlUlpyRTE0?=
 =?utf-8?B?ak50MUxBU0xBbkNrQ0JhdWYzT0t2aFpOYzY1cjQ2NHVEWDhnd2xyUzRXcFd4?=
 =?utf-8?B?K0J4WWVMdXVtbUlMRXlnRVczdG5VRkFwV2pzc203WEFVQUtwbW4wMVFQcG9E?=
 =?utf-8?B?dWZyUEd4aFhScHl5UXNpYysxUHF4dlRKcC9kNWNNZzdZdERHWmRmdlh0VkZl?=
 =?utf-8?B?NDJwQ01aRG9KQjdIT1ZYYUs1V0UyalBmQ3IvK0FBSkl1RzZCejM3T2NCUWpy?=
 =?utf-8?B?NTYxNlZMbDRqN2FOTi9VTnBaTThBOVNDTkJQMkdiT0hRdjRpMFkyNWNHajNL?=
 =?utf-8?B?aDdBNVNCbmJkSVAwcG93VER3L2g1bHJrdTdYTWtrQkhXb24rYU1TT3g1a09P?=
 =?utf-8?B?cVg1MVVUNHBaZm9GWDE4NUpxSTlXSWJTblFJU0hza2JuNmxoWjRGczRLMkF2?=
 =?utf-8?B?eTBDSHN3dVF4K0ZYVUhGb3pPWWJ6aUJPaklsSE51UlN2NHJMRjdEZDQzS3NO?=
 =?utf-8?B?M2t0WkRzRUNlOXArNmJJMGNZN3hGeWIvb1dsaUZ1czl1Z3ZwWjZGY0UyVnpm?=
 =?utf-8?B?RFliWmRhb0tsYzFoUGlEOCsyT2hYZjViL01lZ0JSL0JrbW5sSGdqYXNRRjlI?=
 =?utf-8?B?Wk9BME1lM1JyWDlxaDRtdWUweW5TWDBVWUtlNThYeEM0R3VqVEsxcDA3TTgw?=
 =?utf-8?B?RTA2emZ3V1d3TVBBZVBuRTl1dm1nVlZ6dHE2bi9Ea3Z3c2VYbDcwb28rL1Ix?=
 =?utf-8?B?NVlxc2RiUm5KWXVuZGJ6azE0Nmh0aEE0WkpPZTdpVzJLZ3ZUVzAyMmRHM2xT?=
 =?utf-8?B?c09nN0h4K2Mwb2E3SVBGY2NQSDRORlFvKzFPS0JWQWVLYnpwTFJ4YmVONk5a?=
 =?utf-8?B?bUhSL1Y0VDZZTTZBNnI0Rm9SRmRUaytndnZaRmJJY1VGYUZFT0ZFaFhvbHNj?=
 =?utf-8?B?VnFpQUJta0NDc0JKRkxwb3hZcVBXcEU0MUh3TG12ZVBvSnZVRlVoTjlrQlZl?=
 =?utf-8?Q?ImqAerI0oybYJKjI+HFHNsuUP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8358489-1b22-49b1-6d95-08dca0550fb9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 20:23:57.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /59MVkA05iGzu5pp0egeyKki2ltqHT3DkA8rxiT+1xCe9zDAZqV4dKMh7ek8TblbFT6zbemvjVNFo5/PHH3zcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8267

Add ddr edac support for imx93.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 4a3f42355cb8f..6faba848fe286 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1279,6 +1279,14 @@ usbmisc2: usbmisc@4c200200 {
 			#index-cells = <1>;
 		};
 
+		memory-controller@4e300000 {
+			compatible = "nxp,imx9-memory-controller";
+			reg = <0x4e300000 0x800>, <0x4e301000 0x1000>;
+			reg-names = "ctrl", "inject";
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			little-endian;
+		};
+
 		ddr-pmu@4e300dc0 {
 			compatible = "fsl,imx93-ddr-pmu";
 			reg = <0x4e300dc0 0x200>;

-- 
2.34.1


