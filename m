Return-Path: <linux-edac+bounces-2116-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C76A9A140E
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 22:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B15EB229D4
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 20:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0D7218334;
	Wed, 16 Oct 2024 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EWp5Z5OC"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561F21831C;
	Wed, 16 Oct 2024 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110726; cv=fail; b=MngypznOBMLywFLjqga3NoQ2rT07Y1pkde3mo93+KRwonfpFDodFsEUiKTd634/scLMvN9y6ObYvrFazP7qD1gy6ed5R6wPlTPRV/akzCMYE66Dno1bXrYWkUqK6YzCK44nbnEiHC0doyteIfXy3UQ7n8z0kik6BD2o3oD5/ikQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110726; c=relaxed/simple;
	bh=79MXg57Cyd0Ls8RHW05eE1dZDeIAJiwGUJukDHuBEDA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BpvkW9GL2rVSzPDEWLHE7ESGX0Z6QRbyvzshAMFpd02oUkEbbuI7FpiNi3Wp30gK2tO0ePMbtTVQFFj7zaXFleeOoB8dpKHxbup3a8SjL/p1GzJQ1EAmrLfhCQA0FTnNZmvr6zycZP9bg7IRwkcGgn7gNwAhNG1dXA073HZleiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EWp5Z5OC; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7nqWUH3ykJUMUBCJW6H51p+tq/PggE2pKpmZead8JqyQe87PKwuwX14XWZ35wnGc52m05vCzWMQtLl3jeX3URLvNFRMHHRyad4Z47rueJfLrF1o0CzHEhMz2luqSIKuqrfnAlLtYTk6HftYMAojJQaSXvpFH95NoimbWD8on+W8+heg9FE3huvkwFkVME7f8aOJK5bb2LN/jpCr2+W2SezQavKh7+jWnedAUnqd5NW23EzhZuTlGZVZLA2UJEeS3UdaLGyYWQvY4vfpwLZuuMGK6yVTBZnvzNNXIGGfeooV7mEvfgXuKGVmXKxZ0AIxck/2E0FTyrvE0XXou043qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMjEE4+kvbYP5U/kSZ9Rky2OKvC/sfNSCk6XWJ+IRQI=;
 b=qdD4WlSPqWNiPSlQYIRawj2Sm4867R/3kSZRX2fGSIGlaufcRyuw3mwrTVni2y84dsTRDlSCabHFxMUjgdux6JalOB9jezLt0spv9F1+7VeOizRQCkssjHX48VR+0XBembZ/OlUqv+T5ab/0WJfsT+BFqBWc7CGomNLZySQo4H+xu7Pc8CYD2t4b4famN08wJD3Ligg0oopGhoSmUCxsVo8QAOCXx9zVeqMGauJ7o/grj/Y/TQVcXx/y/o25hPdvI4FwIC5RC6KoMMw02mgy0+Tsc2mV3vOjkGsEnYDK5fHBNqh7zM35K1r56w+T62aF3csUvWL52jwmzS63B5bNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMjEE4+kvbYP5U/kSZ9Rky2OKvC/sfNSCk6XWJ+IRQI=;
 b=EWp5Z5OCrMn5WTB/Q8OPX70ULzvnXwLEfleJA+OEZNKtPWJ3GQlO4AU3g39EJs+601P/S4KRJtyW+9HP87v47SOevXTWtto2w/+bRkxpaCzo1AiXbd71AmZ7GdtOdG1/mwLSZ+jZxUB2pRSLiohR3mFTB8dHywxTvpPUhKP45GLD1AhNU8ruT1XcJ8VIJXaqxFxQx1Zde8zFx33jX1tPE3rgcdb4henhnoTdm3405CEBiVuZ4aOk+Ypf36kS95fcAjGXlHecbN3DnHdD7gLjUDwbJF8Qbf4JGMTKZEUYAcBjd3lUovYbPT+wns7/3VurtDjNmAq06YavBdrsrGtzzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 20:32:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 20:32:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 16 Oct 2024 16:31:14 -0400
Subject: [PATCH v3 6/6] arm64: dts: imx93: add ddr edac support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95_edac-v3-6-86ae6fc2756a@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729110683; l=859;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=79MXg57Cyd0Ls8RHW05eE1dZDeIAJiwGUJukDHuBEDA=;
 b=+gFAjp6tDX+H4YcIIkzuo7LJNBC1YPQKC7TDTJEGw3ddJQr0Dk3ODfdFOXjBH2OrTcULesOJS
 voCYDaMaGY1BYjS0gaaKNaAp1/JIYNDrTjZSOlydj0iLjNeJ03X4y4L
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
X-MS-Office365-Filtering-Correlation-Id: 12c8962b-6a5d-42c6-13b0-08dcee219649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akwwc3hZUzBjczBUY2RVcnJ4WE5QZ3l0NGhQYmYxZzlBU0JqNm9tbUV1dk5T?=
 =?utf-8?B?S0ppNGg2anBtcHBSTEZ2ejVDWHZkVWhkUUpHVytHSFRTSVhMTVV4OGZwVmcy?=
 =?utf-8?B?aGNiR2c5ZDduaTRvRUY5dUdwaVZ6WUdmd2krUEpCbXFpTnJVRTVGUG9FOWxo?=
 =?utf-8?B?RHhpazBDRGRyaUJXa3g4VWZUaWNGdXJjbk5FcUtpN2NLOFAzR0ljL0VKRy9z?=
 =?utf-8?B?UTZBRk5PWnRmMk5pdDVzdjhocUU0K0FSTkFvRkNRb1hQcTN6YmlmL1V1cFFS?=
 =?utf-8?B?ZC83bDBVRFM3bnRydE9NN28wN2l0OUhvTko0enpCQ0VDYUFJUVpsYytjeS9N?=
 =?utf-8?B?TWh6NDRGRE80WFRUaGZZQjBOL0hwZjVhV09qalhVditDTUJROXFIQjZCTmR4?=
 =?utf-8?B?UEVqSnpOclRJZzBGTjQ4MnkxWjBPcHNkQjExZVRaTHh3RVUyM1FYWXZleXRL?=
 =?utf-8?B?bTNOb0dNb2lBZFpndUtRMnNtNmc3NjRkUjVicGF1SGJaVmNNcVRoNDZoakh6?=
 =?utf-8?B?VW9HZDZaYWJGd2dTL2RQak56RHRqYmw4aE1uek5UZHhJam1NN0hQb3FqMCtJ?=
 =?utf-8?B?cm9ieWViK3ZiZEFjaTJvZjlmWVE3cHBpSlFydHpXWThTSDJXcXowVXpXR2tV?=
 =?utf-8?B?WExuakMweFhTOUhPb2FPaHJ2a0h4UEIrV0I2d1NIZVNCMnJWNXlXejFab2Zh?=
 =?utf-8?B?T3NCQkNKQXFLRjc5cnJsVnhVbVdESHoxemxRMldXV252enYxd1hCdGpuY2J1?=
 =?utf-8?B?SXNNRWlXcmkraVZITGtSdkpZYkppc0pMN2piRU9KL1c1Rm1aZUhFaC9JbDF6?=
 =?utf-8?B?SU1JUzdWZjAvK1JmUmljaFVIbkdZTmUzdVM1VWxLMkVaTlpTOUNReUllR2I3?=
 =?utf-8?B?SSs3clFPYkhGdnBYRW42dFphUktNczNaUzkveXlsY3BuY3c2K3BPMGJJWjJp?=
 =?utf-8?B?dXR4dklSbnE3QlEyM2lZUlFxNWphM2sxVHd6NllGV1A3MTBtWGNwK09KMkll?=
 =?utf-8?B?VG1oNE9Mbm9qVVM1VC9RSzJQQy9Zc282RVQwQk1EUjlSdkRGQ3VFZWh5RXJS?=
 =?utf-8?B?eU81NVNQQ3ZXckh0REN2WXdxVXlyRDZON0J6TCtSOUlCbnFhRWpmZ01kYWVH?=
 =?utf-8?B?ZHhtWWs1R2pTaWhVMnkxR2kyeFViU09oSXMyOThSOU9CZ2R1cU5ncWh3YWlq?=
 =?utf-8?B?ZitYREI0R3BIT29LcHhLZS9MdmxlQVI5Nk42UmkrRFZyU00vQnU2bTF4emZ4?=
 =?utf-8?B?eU9DUmFZUlRQa0VrSnpsSUZEdWRwenZ6U1pxdERkSjVEdGhQNTJuVXZSZEZ6?=
 =?utf-8?B?OVovVXEvdEhyWVlDVDNJU0Z4WDlhTXUrUW1hYW10dWJJOU1kL1pCRExKdVVp?=
 =?utf-8?B?VGRYYWcvQTBpejZCdnAySVVWWUJYWDJ0NGcyYlFXeFJieHhnL1d5QmdkdHVj?=
 =?utf-8?B?K1oyUVUrNit4Slp5K2IraW5NaWlPRDFPMkxTbnRLdmgrSmZJQjJHKzgxUWto?=
 =?utf-8?B?VGRPUVN4Qk1yV1AxL2pWR1FaTW9TMEZrTmZRMWtrNm5CcWRLbkZOVUhDU05k?=
 =?utf-8?B?NTV4VVhOSk5qQkppYzZ0amVXOXJPN091MmR4YW85ZEM4YTgzcGZkM1dVTTZw?=
 =?utf-8?B?eVJvdnNDVDhNZEhJdHArQ3pFYTJ6c2RYajRMMVZKVmxNZEsvNUYxUHpremZS?=
 =?utf-8?B?NFg4Ykc4bVByc1VaOWxuNkswaERadW5ZcHBsY0Z6TWlVS2VqK3JvK1hjTDIv?=
 =?utf-8?B?R3ZNSUwwYm9lRDFFWk9Pc1hzM3o5NlJnOC9HUEswdjhvcVZpcklnMEdaeW5w?=
 =?utf-8?B?TXh5VVcxNnU5UHZnR0lkL0d1ejZ4bVVqMnlDZjJISW9vRnlWeHF5SFBuV3lG?=
 =?utf-8?Q?APGqXq5XcMG3v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHdwN3FOS3JEV0JxVzdkUlRqekdwM3BDTjJHVDlmc25lYTI0L1dqb0k1WDRV?=
 =?utf-8?B?b1ZIY3NFdXAvZ1NsUW5RNFZjYzdKZXQxRkdwNlBmN1A5T0tuYjU2emxKV1dU?=
 =?utf-8?B?ZlgvZ0o3WDU3V3JjT3lVaUhZN1hDcUcyRVlncmN2Z2lJc1BGVTNONXJSdWV1?=
 =?utf-8?B?M1dvU0hRc0NQVDRkMGZpVStscjc2cHFTSVBwQms1Z29aQlAzMjRhL3Y0VFpZ?=
 =?utf-8?B?VHNzOHdGOW9RblJFREl5MThObGhobHYrUmpScU1heTlKUFp3YVRwRmlMbTh5?=
 =?utf-8?B?NUxPZCtPcitkQ042eVJXY2lvanRTS1RkbWJWU0o3QXN1ZzZuWDRtTGw3cjNa?=
 =?utf-8?B?Tlg2ekxMeWdaek43VXVMNkNISUpHb0orekRRcUw4a1BTSXhjYmx1elNEcE1r?=
 =?utf-8?B?bURxOTdPMDFBeFFBcHEwQWlpOHhMSXcrNEJSOGNPanlrSkxCZjRFc09URERL?=
 =?utf-8?B?WklSakVTRmFEVjAzMWkrclI1QnFnSlp0bFRuZ2pKUkpMaEZwSmRSSWNRa0Zu?=
 =?utf-8?B?MUM0VzFMejNxcCtvZVpsQStXdU5YaTdBamtCUlA5aDgzbU5rUEJheXhuMmVL?=
 =?utf-8?B?NFFYSTQ2ZlRnd0pzQkhhU1BveVFqbnNLVmRyWFpiQzJPK2E5TGVMV1JDTHlq?=
 =?utf-8?B?VUw5ei9GNFVQQ2Q0cUNsWHFnejdsNXNvc252dkU1U0JDWkJVS0I4MklLa2I3?=
 =?utf-8?B?OU1BN2JBYU9mYWRYVmxZem0xM3ZVTWptSmtId0ZUWmNhK2tHMHg2QjZ3R1dO?=
 =?utf-8?B?Z3gweHhyTFNVUHo2ZVc1dnljNWZIaWQvWjdzVXRXci9xQWZiYVJpc2w5WTJR?=
 =?utf-8?B?Z1JYWm1ndEttYXZLUm1jZkV2UURxM2dDTGN4dzdUd0doUzAxbERZZm8wWHB2?=
 =?utf-8?B?N3JoK20zZEVRNnoyZnVwRU5TT0VQWjlPRHhsQW5USENDZlI3SWJzYlJoWS9h?=
 =?utf-8?B?R1pXcjVGci83K01xek9Hd2RXQ1RaZTZhR0d3OU1Td2NvdVF2R3JUM2ZJTStv?=
 =?utf-8?B?dkV2ZkU3UzZpWEF6RUxicWZlekVjYXpMa2l0bFFLb2pjRFlTd1BvUFgvWFJ3?=
 =?utf-8?B?bEdzb1RvQXZiSnU1ZzNUeGtCcnJmMC9vOGxGMHRhRFdXWnJpM1hoUWFweTBT?=
 =?utf-8?B?VzZ2ZEV5cGwxUjJiODFQTDJaZHcwQnVPYlEvUnMyVXQ4eThrNDZzNXNscU5Y?=
 =?utf-8?B?aGdHSHZqcnZ4MjVIZUxCZ0N1T1h0M2xHcmpmOUxDMlVFK20wWmtBbHU1cGdu?=
 =?utf-8?B?QXZkODRiSzhsMEEwT0RIRWVjd3UxOUthcFFHYU5iOUl1TjJVeWlqQ3laM2RV?=
 =?utf-8?B?c0VPOXZNSy9XOTFJWHIzWHBxcUdSNlhELzRSSm1CK0hWdHQ1K2Z6QWVDZG55?=
 =?utf-8?B?VHBoTnVhN05ydzlCZVBpanFrMWk3MGhPM0txQnc0NjMxbEl6Qkt0ZFFuN0JP?=
 =?utf-8?B?UHRVQitNaGJkOG1TeFlTUEF1RXY5dGZtTkFmcHFHb1RNNGxlWXdJNkR2c3JV?=
 =?utf-8?B?NXZlWk1CaFdnVG9CeHNpbUptZzdBN0ZvSCtETU5xeXVCMThxTkdzODNMTUJF?=
 =?utf-8?B?V2JlUkE4aC8xN29CMVkwOHYvZ2VkZUpOQXpQOVBnbUxJWmZrcFlVeEdvY3I5?=
 =?utf-8?B?cEttekNUZmtJMUVMMkZNOWJ3Vlh5dVJZMUw3eXBybWh1Y0Y5dXpUcDlha2Ji?=
 =?utf-8?B?SktRNkNGcGF6ZWpzT2tVenBCU0hyeGwzN3doR2lGSmNVeXpNK3VHTlEwWFRB?=
 =?utf-8?B?TWFSUURyalptamJSbW5uci94ekNzMWF3dFpiTUNodWpNb0NWM3BMMjI2YXFP?=
 =?utf-8?B?eVd5c240akozekhSNEV6TTUxSWlMWmU5clNFSElRMWRmUHIwVmRXWE9YTEtj?=
 =?utf-8?B?V29kRllSTXIvUWlGajl3ME4yWWxnbnc0SCtQelRWVFRqR0psUG96ejJsaWJu?=
 =?utf-8?B?OXBMYXFlbFp1cHJaMmNvTnNzK1Y4TVRZMUZqZzVDdnpROXEvTHBGdnI4U21N?=
 =?utf-8?B?M0diY01xdG9mRExQbXB6bXQ3TlRPVXpoNHNLMzdXSWcyK1k0UjB2SERRTHY2?=
 =?utf-8?B?aVQ1am9wV3N3dGtSaEJXTjFRamdsMXpadTB6TUFyMDRPWEl4dFdKcldCbzc2?=
 =?utf-8?Q?4RvTnJw7a4SmPzKBKM2wSKYNe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c8962b-6a5d-42c6-13b0-08dcee219649
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 20:32:00.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15LK+Gco1OhZ5bkpR593crZ9JJ26C4Bplm0bptiZBvn60qkJOOdHdfJeZiQtIm6kvpqZRfesjdBRPwfm7qQGKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

Add ddr edac support for imx93.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 04b9b3d31f4fa..ea83e38ae4d88 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1326,6 +1326,14 @@ usbmisc2: usbmisc@4c200200 {
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


