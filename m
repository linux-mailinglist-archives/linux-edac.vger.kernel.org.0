Return-Path: <linux-edac+bounces-1478-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC83A92C475
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 22:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2B01C20ACE
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 20:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661EE18785D;
	Tue,  9 Jul 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GxngbnE2"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F5187856;
	Tue,  9 Jul 2024 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556627; cv=fail; b=CCCrF6hrgupzHZNCexQQ+Q7tvcD/3NRD3Ptxh18tHtB3FhG4GF+CzcHzU9dq5dUyPZTY5NrkZkiYRnJq7SIWWWj4LVUWEGtc5MQtVKCETt7bL96V42qg8IuAo3GNHKag1GiyqeDUEpF26QjnFF3DAMU1/R2bZRGTLqYi1E9XI3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556627; c=relaxed/simple;
	bh=w0nRzozlUKzyaSgoCBfno/orQTAg8Z8csRiuGUzusmA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HsIcY6SBYdSOMc90J4657q9AEFijViA2ab2h8q0s8+pPkaxi3ZbcsVMbwY2NF7Oxmn+X7JMMRSexcLkswHcGLF9zE6yuyL7XDD/l7GlEdXKFP0ku2eJpYRCbWWiguQrEbkJwAYUVg63ShW+W7QKbPVN4vkh4QEKwlMSFhuWn4uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GxngbnE2; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRfFcRjES5+NCMe2aNsL1z+KPE9k2BsDOo+1VbA8xLDSeB4yoIeboO971wkmvt8b+fm/zHMvy6I+wmJtBOnQ2Q6TJ1S0CH7QCOwxkJCqlEDx+rfziPJPAh0/LcLeJY9DWyymYZ2Hn/mRpjg1uENxP3tqvx0zciU10itsEQcnPxOgGDF0jFK1v/EvSLRUDvDiSE9HsE+IdC+z/8+iN7VerKY+NMrK4Y6ZwYuIWlfSD31HUc5SVvLwFVmqD2FbZ/xe/XX0vQ0zMXM4o//amfLJgXtaPIZOXmO1OSVWi9YXxSjkS0Rhib9lS41B+el0saPZuU1ia5PwfaunOGU2JmbZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuCZ+qtZuHwlK6whSWPf8p+h6hNNgJzBMctNbfek56A=;
 b=LpGL42Q2woBPdiAx8Jh54mvgJ8NjCWS8Mxw1HQu2T8fWnkAfdkTlyzj6DJW4omyjBWUA7fco9q7+Lfk0aXseiobvNE8gLKgVJxn1VYjYqzR+ZlrwfFmjBSTiDZBG/bZaf4Kx3T1KwgIkpraEtFy1yH8bN8krnHHCdUV18TL79TDEIxdnX+NgSmXijyBqtxgIZIo6guCzzK5MIVeHzI/BnFeOx/VICX+Mbp0sIfsBqj3fruy5asedfqLSNN8VKVRl0WlBZiIJY6hOs5JgnvYUIWzYnv3trMV+Q3oHR8yjuMnpc/xpMiULNqmL9E/4K2PMgYfJJXRhuFNcmQrpwVLvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuCZ+qtZuHwlK6whSWPf8p+h6hNNgJzBMctNbfek56A=;
 b=GxngbnE2yRRyl0jdZZGSxkcGHuGqLUtKte4r5PoDh6MLXhTPjW6xoJWxOsjxi9vIGfeufJcXNjGVtR606JQr/Cqidq7EksP9JV/JmCoixq3Np+f1PTFzjuV/80Xrmu3T1nwtZ7xcSTmsVmA/KOGHmZ24GP1f8KAQpe/8S6PTVkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8267.eurprd04.prod.outlook.com (2603:10a6:10:24b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 20:23:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 20:23:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 09 Jul 2024 16:23:04 -0400
Subject: [PATCH 3/6] EDAC: fsl: Fix bad bit shift operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-imx95_edac-v1-3-3e9c146c1b01@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Priyanka Singh <priyanka.singh@nxp.com>, 
 Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720556601; l=1758;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yIBDEMa1tOArl3nH5oE1mzsXvIC+50RpgJfJD2pCSww=;
 b=puMEO4pwlHPQzAg1IqC+fRj92Cu/EFmnqVMekfg3xaM+mcKdL7bovGBGfwQZKOWQSEJjcHrgM
 c9UPnlILtDwDBxTuLn+efAGFo38VutXUjDvmdyv8jCf6ck8PKxMiVPz
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
X-MS-Office365-Filtering-Correlation-Id: f71cb98d-c8ac-48ad-6511-08dca05506bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlBjYnJxblFTRDBYYk9qbEFLTDZWT3NhWG5yVnQvM2lic2V0V2hNZGx3NExK?=
 =?utf-8?B?YVFxT2RZbGlxMDhtUmYvcFQ1TjczU1NGTnJyMVJjcEpCcXhzd0tKeSszWndN?=
 =?utf-8?B?a016SVZQcFpBMFZqMklPbWRzSjJ3Z2xwbHdMa2tGbzgxdzl6VFZXNkcwYmFK?=
 =?utf-8?B?bElXaC9Td1JUc3lqN3ZzQzVkbFY0VDU4VTRCMnlJN0FMZ1MyeVZnRy9QbFRu?=
 =?utf-8?B?WTVaVnhCamFGSFZJWjJ1Y1htL20zQUF6c014VFpDemdRWi8zT3JwVVJqTGRm?=
 =?utf-8?B?bHpwbE5PTFk0QnBiWmR0UEV0OUdsNCtJZEVadDExNmZBdmJLYmtGVjRBRVVo?=
 =?utf-8?B?d3gyK2o5VUczajU2RDVBOWhUeDhyZHJ2ZUwyMXNGSnY3WmFzTXY4bVJwVVlo?=
 =?utf-8?B?aVR6MkZZajBiTmgwUUpnWklBODZ2M0U2c3JIT29SOURSQUdrOTRqaWJDTm1X?=
 =?utf-8?B?blNMcXJ1a0tlSytzKzA2eDZyVDlWSnl0Q3AxY2VxTjFEUCtBa2szL2hSdTZj?=
 =?utf-8?B?bXdiQThGK1lhZ0tlcW1icG5hUW5IR05DRjJWelhCcjQxUEdubE5iZFd6RkUz?=
 =?utf-8?B?OFYraS9NYThKdXpWbTVEU0F4UGlWK0pkZUp3YjV0SmViVW5PSjFINEpNeXZJ?=
 =?utf-8?B?SmtFYmZmbTUrb282Uk9DbC9veEZ2MUh5dlkxZFlJMm4yZHR3OFN2RTkwVjVy?=
 =?utf-8?B?bVdoeExJVklIZlVCaTdnZkxaQmduamVzM2RRS1FSSm9rVDZSNkJHdnJ6bEoz?=
 =?utf-8?B?OFVKM0pGcm1JU3o0ek8rWmZpM0VuYjlkb29OTVRYNm4rMDA0aUpPamdOUUhY?=
 =?utf-8?B?QU5lYmlOWlVoRCtWLzBRaVlpUTMyUmdlNWtRTDlxT1dLWGRYY3ltamczd0xC?=
 =?utf-8?B?K3Y1WHRvNHBKWENUV3UxMk5jL0Q3eHhaRFF5ZFcwTVFRbmRjQTdyK3VBaWRO?=
 =?utf-8?B?M3NIMytaSUp6Vi9VOGFCa2doMXMwWkdZcGdpcitkb2JwMjdWK3VlenBrdHZx?=
 =?utf-8?B?emgvbDVJQTRtRHRuRXpIVXlVQVQ5UlROd3NqOEp2WElueW9JQXo0ZDhPTWlF?=
 =?utf-8?B?S2hWbG5iU21MOGtQb09ObE1KT3VUWnZhUTNlTDlNQy9aVEh6dzZFR25uZFQx?=
 =?utf-8?B?N0xLSGo5aW12VHVYMVc3S2YwakQ3di9FR0Z4VnBRbjZPVmRvaFk5VzhkRHlw?=
 =?utf-8?B?SzI3aTMyVGRMVE9ESU5NT3BkbEtjWVl3VDBsVEoxVjk5QjdFYXVVckhpckpY?=
 =?utf-8?B?UW10L3BDbWJ0a0NiYTdjNWRING93a0d5cHlJZWxtMGc1N2FROFFNVmNMc1ZR?=
 =?utf-8?B?Z3E3UFlqN29zT2hTcitCWk9BNUVnTTc3QWpxUGh1L3RHa1dNdUZyWGYxNHRz?=
 =?utf-8?B?TVF3Q3dCOU1jRHBmRGFRZ2I3U3h0M1FhUjQ3c2tZdUhWMjJ3dFRNNEZGQmt5?=
 =?utf-8?B?eThjbE4yT3hEdkxycW5lNGhyYTI4NUxhNmJzYzM5ekNuL1JaTGhVUWw5Uk9n?=
 =?utf-8?B?czY3WEltY0xQSk1UZU9JUkpENkRaaE1SdDg3TzNKVG9uMThVRzNhYVVoS0hO?=
 =?utf-8?B?bkJxU25aNGJZOXdDcE1Wclh1ZzNzU0ZYbGJBa1BkWFdUVW9yMG13QnhiVXl3?=
 =?utf-8?B?YjFiVC9FSjlPMnVuazJTaHdSWjI5ZWZPbEdGd29sUmR4MHNjbjJVQjJ0cG4y?=
 =?utf-8?B?TzA3dXN2Vzg1OExFdmR6SGNxMmt4MlcxVW1qWHRjdklyeHJ0eWlTVE10NG1i?=
 =?utf-8?B?dm1WbXM3VkNlRjlMczJhUkxxaXMzQ3orN1RoMDlDbStBWG5wenhUalJYRVcy?=
 =?utf-8?B?dlNqR0prLzF0UGVqWFY4dW9tZFJkeVIxdXhhWkNhMFdFZ3lRaW5ScWM0R1pH?=
 =?utf-8?B?UmkzbnBRV0E4NGZaUk1DQkwyTElWdE40MlphVmZIRUtHU1YraTNaTStCL29O?=
 =?utf-8?Q?Y2oDkBgtCcE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blRjU3p5VjRNWFNRbXdaSm00WW03V0FhWUFTajA2MWFnV0xscFhSeTBxMHdG?=
 =?utf-8?B?dWhIa2ZiS0s3Q3c2NkEvQ2puZktzaUhtMlZIZk9ZYjUxdWF1RkxJSjY0dTFl?=
 =?utf-8?B?N0FpdFJxRzNxWnRGUTJiVy9rUXpvOENOK29mZHNRaUFQeGJtR1o1VlVnTGpL?=
 =?utf-8?B?T1RGZEZoMUJpVkppRjM0UjkwTi9mQjc0dDVhZVk5ZHNqbCtya3ZtTnNGNGZJ?=
 =?utf-8?B?TytJTnl3c3pEdXB6MFlhMmx0WWNaTGxzdHh1dUYwbmg0YVdCVmloSG9udURv?=
 =?utf-8?B?UUJPOTZqOVFPWDhXR0RQMUd5WGxyVGJRUUN6SUJOSC9GSVNhTU9UMnZGdjlF?=
 =?utf-8?B?MzZQL3lCWWU2dU5YZ2lZaTdmT3JPdERRQmt4elBiamFnZ1BtV2xVOEVEajJ1?=
 =?utf-8?B?Q25xZUMzekhEbmhWUHU4N3k0TFdiQjZiTUdrY3JydXlKbUl4aDlJSGJQUVhU?=
 =?utf-8?B?MEJUNk1KNkYwQmJWeTVUZnFXc0FQZzFGQ2ozeTlwTFJ0aDBLbVVrSXhJVmFX?=
 =?utf-8?B?WDdyamh3bCtWQmRpOEJOdGlncGJERldVckIydUQvQU51SU1CSkNjSHBYV2l1?=
 =?utf-8?B?Y0RUKysrWTFZRUdJSnJpMjcvUUFiQU10SUJVeGJXczh6aDA2NU04Tm1lUyty?=
 =?utf-8?B?ODBQMzhlZG5XWTRMVTE0KzhtU0JzcnBNeEt0UmVhUm1SK1ppbzI0bVkvWUxY?=
 =?utf-8?B?amoybkltejR3dThjRkUrMGEzNmZnUTlvRkdoWThLeFRMd3hHSjM3Rjh4aHp4?=
 =?utf-8?B?QU92QWUvQk9jMzZsQW5rdG53d0UzS1g0bjJkWUJkUjFDT1p0UnhRd0NHYk9q?=
 =?utf-8?B?d0dudy90dGNtekVWOHVXRzdCVUVTMkRXSjFJUHhmOWxjMDlxKytwcXI3Z0Rp?=
 =?utf-8?B?N1FTREFMK0lTSk45WXR3Y2FRUE5mcHF4dXZUUmJtcDRvSnZvZHZsc0pyclBl?=
 =?utf-8?B?TThzOGFrSHhhd0loRnJTL2JEQXUyWnJtRm5yMm1xZVRSNXRLcE1LTEI2NytQ?=
 =?utf-8?B?NXNYSXJZVHpZZDJrdzZocitZeVZ5SDRQelFVeWdBQzIvTXNxdlZuUWNaNSs4?=
 =?utf-8?B?Zzk0b3FzOW9ZRXk5Z1NzdUJLTWMycFhtdnZqclo4SzRPVmk3b2xmSzBwdE5H?=
 =?utf-8?B?akhnVFRmUGJ0TU1sZ0Z3OUhmZ3NnVlJXNFJCRDhrOFovVTdlZ1h4VGdrdzlT?=
 =?utf-8?B?ckJZUTFwdC9CTDRob21xOWZPUklJUWdTQy9Nb08rclVsQ3NBU1BDNTFnSlpN?=
 =?utf-8?B?VkpsOStJbUFuOUpCOXVrVy93RXBHbVZqNmtldmxzQTAvcFc1bEZkUWNqSFp2?=
 =?utf-8?B?MW5vaEVMdHV1MTZyMU9PaGRaUzhjSDBha2FWU2VmeldPZGRlNEdLL0MxRkI0?=
 =?utf-8?B?dzZCNVJFQzFxaGFrZjcwR3F0RXlyNFJuWTV6NnU2aXBGTHZjRmI4WEZxbFlE?=
 =?utf-8?B?cWVmWjdyZERONkpGTzlzMkZteEdnbWpCbHdkNENKWDhmMUwvT2hXODM3Sk9F?=
 =?utf-8?B?TkdnZXhZMDZ2RXY4K2ZHcHJMRTdqUEQ2NXZucXBZd2g5bUorNmc1UXNOU0hi?=
 =?utf-8?B?NHBreW1RdEdtNU8yUUNCL2IvTElSamxmdEd5bUw5V1ExZk5Bd0RQY3d1TjNM?=
 =?utf-8?B?TzRqcThhWWw2bzFCUi9HcWUxWTBFTlcxSFVXSml6Tk9kcENQUWhvUmo3Witm?=
 =?utf-8?B?YW1xamJhdERxZk53ZGp6SGV5MXFnSDBPanRLY2VzN005VUNGQnVxVzYxUmZ4?=
 =?utf-8?B?Z2xZblgvaFlnODU4SlcvOHFQNHdmQTRmSGNuWi9xMmp0TFFEMUMxSVg1RGs2?=
 =?utf-8?B?Sms5Q2N2QTJrNTg4a3NoTDMweW9PeVdWQmFoVytrdXI0ZjBLZFhnNWtzQlZ5?=
 =?utf-8?B?cUNuVDJoOUpDR3RVRmQ4RUVGNmttT0hEcnR3d0FNZXF4WkhXNVJWSEpnb2Rm?=
 =?utf-8?B?Q3dTbDAzS0xlRGM4NjVXdFhoMEoyK3loQm14Sng3bVhHcGxIbEhveElLK0pN?=
 =?utf-8?B?aGtkQktVTmc5TmNlMWJKUmVqSmZpVlg2UkZOM3pyc09EVHJ2V1daMGNQcjlp?=
 =?utf-8?B?TFFIYTM3TlQ5MStOaGxhemVMZEtNVStsSlFsK0ZtclRUZk9iZW9iTUhuOTJT?=
 =?utf-8?Q?eNHkdMmQQ3AeO2Dh/FfjlsxUv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71cb98d-c8ac-48ad-6511-08dca05506bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 20:23:42.6521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XstainIzzxSB29QtlC7RI/USSLnwdc7EIL3+j9luyi7GaoP6YxGWrHQN76kEE4f4KYSEAkc5NjO+KbyThfUW/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8267

From: Priyanka Singh <priyanka.singh@nxp.com>

The original code:
	cap_high ^ (1 << (bad_data_bit - 32))

The variable bad_data_bit ranges from 0 to 63. If bad_data_bit is below 32,
bad_data_bit - 32 will be a negative value. Left shifting a negative
value in C is undefined behavior.

Fix this by checking the range of bad_data_bit.

Fixes: ea2eb9a8b620 ("EDAC, fsl-ddr: Separate FSL DDR driver from MPC85xx")
Signed-off-by: Priyanka Singh <priyanka.singh@nxp.com>
Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/edac/fsl_ddr_edac.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 10b0a46669f3d..da743cf8a95e9 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -338,11 +338,18 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 			fsl_mc_printk(mci, KERN_ERR,
 				"Faulty ECC bit: %d\n", bad_ecc_bit);
 
-		fsl_mc_printk(mci, KERN_ERR,
-			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
-			cap_high ^ (1 << (bad_data_bit - 32)),
-			cap_low ^ (1 << bad_data_bit),
-			syndrome ^ (1 << bad_ecc_bit));
+		if ((bad_data_bit > 0 && bad_data_bit < 32) && bad_ecc_bit > 0) {
+			fsl_mc_printk(mci, KERN_ERR,
+				"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
+				cap_high, cap_low ^ (1 << bad_data_bit),
+				syndrome ^ (1 << bad_ecc_bit));
+		}
+		if (bad_data_bit >= 32 && bad_ecc_bit > 0) {
+			fsl_mc_printk(mci, KERN_ERR,
+				"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
+				cap_high ^ (1 << (bad_data_bit - 32)),
+				cap_low, syndrome ^ (1 << bad_ecc_bit));
+		}
 	}
 
 	fsl_mc_printk(mci, KERN_ERR,

-- 
2.34.1


