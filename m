Return-Path: <linux-edac+bounces-1480-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3B192C47A
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 22:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564B01F2360B
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 20:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB7189F2F;
	Tue,  9 Jul 2024 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EBcm16ac"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DFC182A63;
	Tue,  9 Jul 2024 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556637; cv=fail; b=QOT6gpRjXSKX54DYfzSpUrlIIiER6yyB/+Sc1QZ+6juxyj1ztb4g2WFMP0MuQAf9iAPkHbdumd2PnQwb3FYMobluYyrOFrRBV+mGTYhWUXUE+KtwqPYwPd1ZGSXWjnof8WS6g+njRnxi8MHPb4A0/UVaDhxt7R+p5nBydb42Qpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556637; c=relaxed/simple;
	bh=f6OXDb6eLZXmBH224OLnsfJkq1Rey5aQ1bBhSuWJ1I0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DbEcyTPi9qbiugTZWKBf0XS4hcNFcwsQQ1hMTuMJW7xhEfKu5u8allRPtdHjdO4A7EwaSEmloUSrfRQmgpFyjoWt2T2fskt59w/eVQWgxp8222uAaG+Gk5U2ZlVa1Fg3BnVw05E8ohHPX2+t0vDS66DDKf0+FWn+l6DKB96oZk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EBcm16ac; arc=fail smtp.client-ip=40.107.104.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGlgL9MiPPt95cwOQvk+r35JyW3+4+vVGBeZFn5G8UWiJhuCtkGGghbcOLe1phQo5Ve43hbmCVQsKSsCdrk93leFYA1KG3UOhz8v2L/CMQnVEteKqV7epc48IBzRBU+cTJ9ILurUc1tqKVEsMghqYaggbHXsCcNtJZ9dYMLpcQ8WTd5rZFwPs272V8PcdeEkl9DJf8k2YmXj3HE6GKGIM8XlitIDycNLgvXm+rl8OMUM5yeHbnUSh3s9y7FMYC6YNph9yXhyHGUfCCenrHK1tnFaHawM4ec2VDwu7abAtV2ULRiXklx0CdeeUwo8REdSsvlWwKhAxqk/3fbeNTIWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+llaZGd3ThH3xZSiE12Yp5AZPrupVBjPLiolbmqn1fQ=;
 b=kds9oSw+zuuodEBQZBRP/sQwN36059gXLKQQVmX0Fva5yvOdjBh5nTcF1dWPJBIq/1OKaIZv25l785TXgoRIMAVAl0+kXwei1fGvjI+tppZUUhOF+3BqChDL5KYKtN7jdIIcUWncJUdfmi0jXbUJqbY7fvovOTIqw+9Os4pwjTFLmfisq/i6MG6DPPN/gVVXqx4YvoWY4+fRvBDCMpvX+jh6LfuJiJCtickXk2XPieZUkpch1ZixE6qu16qt5od6AMLc82t/DYzQZ+xmhJbqw3SUut0BwWBwArHaUHCOdxw23LX/Y9HP+YtN4jYJ7g5dst8WRhFwB4sz4E/9MXdjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+llaZGd3ThH3xZSiE12Yp5AZPrupVBjPLiolbmqn1fQ=;
 b=EBcm16acfCydMBRxh/00Scer1tPv33liamNlzQZg0ScOkUFMdsnDCCzLy67jSORJMDdx6/gXaBd6BHiWk+cvRj9di7p86lBOB2QqApQzeIGk40j+9ohMIrGaGIk8uyM/kDURMkjJufs27qddX5b27mLq/EJL+4gJBHOAkovbEBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8267.eurprd04.prod.outlook.com (2603:10a6:10:24b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 20:23:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 20:23:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 09 Jul 2024 16:23:06 -0400
Subject: [PATCH 5/6] EDAC: fsl_ddr: Add support for i.MX9 DDR controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-imx95_edac-v1-5-3e9c146c1b01@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720556601; l=5882;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CpSB72KuM9NooGj6fUi66TJ5cUJ4AKdkHQLj07U+ubU=;
 b=L0yyp80JaWeD0GEbKGknTPd4CW06DeRi37o5TJXaY2KIWlxwHNbkGFGntW35phVgM7t7X+yn6
 sKnBbBqTuwRDqYTXkl/qPuJQddcEKzTlee7X0wB3DrZkRq8JIG7/4xR
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
X-MS-Office365-Filtering-Correlation-Id: eaa65157-5fb5-4466-8a5c-08dca0550cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzdSRnJlYURJa0ladVM5MjVTTWp2cGRuNEwraVY1RXNkYmQrZ2FlQyt6R1ht?=
 =?utf-8?B?T0Q4UHJ0N09wU2NBenNKV296Qy9hVVRUWG9qMzVuSURRK2F1RlNPbVJodURn?=
 =?utf-8?B?UnlLSCtNdEl6STRHQ2xkMjgzeDhvQllaRjhwR0xGdGxxWG5SekloU3NpZTJn?=
 =?utf-8?B?S1ZLWElRZThWcnVrL1lKejhnVWR6a092NDB2L2o5c0N0aEp2ZmJyZmY1QmdR?=
 =?utf-8?B?UFNudmFOdkNyOTNXYmdqdkhUSWhaTForZzJFd2V0bko4UVp2Z0ZrYXRad0RQ?=
 =?utf-8?B?Zk1tTlg4Ly9Vam8vazNXNUVWdXRzWWZjVXlDdjVHUzZBOVF2VDBlanRiVENp?=
 =?utf-8?B?ZyttdGdBRGN2ZWpNdVlzRzc4UlVDN3UwTWYxdEJ3WEM1Q25UR2s2L3EzWGdz?=
 =?utf-8?B?Z0laTk5EOGtZOWtRazNFV1FzSEpUQUpnc2JPaTJSenN0Syt2d3VMUXJ1SEFu?=
 =?utf-8?B?blVON2VEODRoVjJGdmgxUmxsdk5TUnd5VmRjdVNnR3RVVjArcWdxSHJSczFw?=
 =?utf-8?B?NE9sUnh3Mlc5Z295aFhGaG0vMjFZUVZlZzRwNlVubWp1NEw2dUQ3WnpWZnBF?=
 =?utf-8?B?b0NmcDZIazZZUXRoa3ZKaTZvK2V5MkdlNHNRdkRxWHRmUk9xRFN6QTZnZTVw?=
 =?utf-8?B?bk01dVJ6Z0ZJQXlkbzV2NnI0L0xzcituMTB3OTJVaHcwSGUzem9BNU5pRTh5?=
 =?utf-8?B?WmV4Q2M3VHVwNDM0VEgvSlI0MjFGMHhSdDZVckVFWXFEeGNEMzhPUVVKWVdD?=
 =?utf-8?B?ajhSdlIyL2VnbVY3YStjVkZYbXE3VklISnEwTlFhWTJ4ZGpxemFJem5vZGRK?=
 =?utf-8?B?T0lqYVZ3YjNKYzA5cUJXU1RualR5YlZ4S0Irc1ZqZjVIdXFhbSsyU0NpT3RN?=
 =?utf-8?B?NEw3aWZaTnhna2MzWGlaektCUlRVdFhXTWMvK0VzdW14Sm1oa2F0R245aDg1?=
 =?utf-8?B?QzhOMFE3WmJreDJteDZPL1VuRFRpNDIvZlZWVU9DcWxTNWFra1ZvU1ZNQU01?=
 =?utf-8?B?RWhDSlAvOWVqa1pDUGdaZmNMQ1JQSExvSUc4Sk16TWlOeGkzVmxtb1pxelRR?=
 =?utf-8?B?SXp5Ym5aRU10RXplY2t6YmpYeThMUEM5U1ZKZXpkY1NhUUJpV0N0TUFXYS9P?=
 =?utf-8?B?bGVhVmVnR2E4cmoyYVUxL0kwbVBLYkdJMDJ6bjhGSHpONTVnU0FJc1hzSm9l?=
 =?utf-8?B?MWpsNDR3cGJBNzlJRkJISVRFVHFSUmwrVzVoSzJiRkRsRHJxS0NiUEEyN3FF?=
 =?utf-8?B?SkRFR2dyZzZXd21Rak82WFBOcUVYdUxxUkU1UTAwbjg5ZUJESTRVUVFtN3FM?=
 =?utf-8?B?ak9uYnFWOUlsTWhjelBWdFNxWjZpaGxraWQ4eW1ib0RaZ3crZ1R5WkFVOVpy?=
 =?utf-8?B?MWtVdmFrMVAxTFllelR3enFadmtKMzFFckxlZFhFNW9aa3grZ1ZmVmk4VjZR?=
 =?utf-8?B?S21HYnpRVXViWkhicXR3NnNsaHorS2dmblN2ZE5JcUtSZGVJbFhtZHZNUTBT?=
 =?utf-8?B?VFZISkhMVXAwdEFYdVIxZmp3K0FXbFkzUnhoWWpVek92bFBPSTBSMGdXYS9N?=
 =?utf-8?B?dThIb29aWWtFY3JuUHFFd2VOOFBFbmdZN1I2dlJ5MnhSb2w0TkdMWHdFcEYw?=
 =?utf-8?B?aCs1RjM0RUtzVGtVU2RVc1BRS1htL3R3Z2RFODZnMlNtUkNwdW1pMjV6ZVlU?=
 =?utf-8?B?ZUh2TGNrenNEUlI1Y0ZDN1ZBVkZ6SFRoVEVzaXhPNktMRTRqR09XWkptS1RK?=
 =?utf-8?B?WkZGVW9LZ09ZUE05ODQrWXo1bU4zaWxEcDRMYzFIVkRUUjZUTnRSek1uTUxa?=
 =?utf-8?B?bzhoZW13ZlBHalVnK253WXJuVEtYQ3FyZkNZWFZLMDhTL0NiMi91UWgzaWpO?=
 =?utf-8?B?MGI2KzZNRlRzRUJVb3ZLQ3JJS2R2aFlSSmFNVTM2ME0zb2ExY0NkWWF4b3d1?=
 =?utf-8?Q?1h/S3SV69dI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm02TWMrWGN3MlM4NVNSdWMvRmxnUkdaTkxjWG50MEVEby9KalorS3FjYUNN?=
 =?utf-8?B?R2tXdVJ6UzNYd0U3U25xNSt2VEl1QTdVVFU0TytnWGFEMDVDaHcwdnZwL25t?=
 =?utf-8?B?aDFlUVRGZE9xenFkdVdNWGIzSXdpRzB1SlJaMjNjdTJtajdBZC9FQWNYU2RI?=
 =?utf-8?B?VUVDeEpLclFrNEMxR0ZPS1FuRVlUSlRzdE5vODFjOXJ2eDdkcnFHMjlhcnZL?=
 =?utf-8?B?NExNbzFSTjRIRld1cStVVUhyU1c4RCtKeTFDdzVQRXNocnJUa2RpaXZYZGFs?=
 =?utf-8?B?OWFuWjZXMjNVeGxoSnRnQW04VE13T1Q0SUdYUzRGblgrQ01lem9sWW80TjNO?=
 =?utf-8?B?dG9hcm1KQ3BNWDRDN0VONlhISkVGNWV4K0lTblZ5K1RVL000SndyTXpsRjM2?=
 =?utf-8?B?bUlZSEtlOVFibGY2NFBkclNVbnBGNVAvSmFxK2QwNGdvUzJtd00yWFhad1F0?=
 =?utf-8?B?bWdVVW9xV1REc08wVG55S3QyaGt1djVubjhRZ0I5b24rWm9iNGJtQlpZOHRk?=
 =?utf-8?B?dzVPMC8xcm9DVi9PcXgzakVWdU4xNlYwYnVFRnB6Wkt2RWFZMVdjN3V6UWUy?=
 =?utf-8?B?M2ZpOXNBYUt2RWdTcFplQ2NqUFhid2VFcEZVNEsySlRIbG44dkJtRXlCdTl0?=
 =?utf-8?B?UVNOdGdzS2ZQSFBnUFJxckxmQWp3a2hBd2laNCtHQjQwOWN0NDNJOXpVUnBY?=
 =?utf-8?B?SFVza1hnajByR3V1OWpEaDExSjc4Z2lkU2Mzbjd6L09FL3cxT29IOVNNMzhX?=
 =?utf-8?B?dWF5THNHSlFrZjRkVTkxNHNPS0M5UmFoZkpaZEpJd3FiYmg4Zmd0c05JZng2?=
 =?utf-8?B?STZ5aFV1bEI3ZVBWR1BYaXhJTTJJNTFZTmc5Vzc0SW5Ocm5KMWlWWTIzaWpp?=
 =?utf-8?B?MCtiYWVtK1cyRG1vaUdQMjFtSWVCcUdXOGxTajJoelkrdU84b0dsNVJqRytu?=
 =?utf-8?B?cEw5VFVaajlmdmJwdnBxMkI5enh6SFNXNXlGQW9uT2hLNTBSTUdpS3N6akVJ?=
 =?utf-8?B?K0R6NHVURjhtWlo4OWhvOWF0TStDWi92OFRrVGVndzM1YkE3TVpHMkZiTU1o?=
 =?utf-8?B?d2RjZlVBWGYvT1VGWnBBZ3RVK0twQ05PcTh4aVNWOGtZRnZMbHJ2TjE1eVFs?=
 =?utf-8?B?L0tMZnp5R01Wd3BsNFVvWkRDQWxTak5GOWRGSGlFMmlma3kxY1lsb3NiYjJw?=
 =?utf-8?B?dUp3cDF1SDAxZnR2bmlZZkdLcExqWWttMEYzRnFoQkJ5NjljazNHL2t1dDRQ?=
 =?utf-8?B?andmNGRpK1hyY2dETmYvdGQ3UGg5VzRjRzZJYWZ1TmxFa3NCYzl5VHdvZEFZ?=
 =?utf-8?B?ZEoyL0xnU09wMGVYY1dGVXVxQ1JnSzZhWnowM0dEbnZrTitmU0pVaFRYYlJ1?=
 =?utf-8?B?alBKNDJrYnBlWUFHakJRNlZaL0s0dHpGbkJ0cnZkU0JPamlVWFhUaUI4THl6?=
 =?utf-8?B?WGJmTk5GYk1MamxKM2Rjd2JjZVlnRCtQTWJsZlpZNFkrcjFIN3VNYUgyek56?=
 =?utf-8?B?U0FISjBpR3VCOVFYUis0RGtZRTV6NVBDaUtHc1d0VnJxdmMxOXkxcjI3bUtU?=
 =?utf-8?B?K21MOW1TQi9jM1JhK0lYZU9zZnZFQnpwRWptYUNHbmhpS21veHZOWnM4NUZx?=
 =?utf-8?B?R3JxbU5LSTljLy9HREp4UDhoallWWTNJK2ROd2FUaktyWTErTnkrSVdtcmZC?=
 =?utf-8?B?MGxPL2RtL3dQdThnclZ1VytHeTNVUkNDM3lkV2FkT2VSU05KZXJFNGNtN1Bx?=
 =?utf-8?B?c05EeHhiTVBja1FIYkVIQ0FCOHpaam1GNXJjeEkxYU03dVlwM01IbXQ2MGQz?=
 =?utf-8?B?QkR5STQvanFIbnppZkNRbEsxcGsxSTNBV01oYklOUE4reEZBZ1Z3QkR4RFNE?=
 =?utf-8?B?ZWxLc2h4MzVVUUdRYTJKVmR5SXp1OGdQV2hVb2FsUmlLd0VWbXJjdE5OVFZo?=
 =?utf-8?B?SWM4MGRkY0Y0OHZ2VllpamhUNXVZYzB6NXNnOTk5eVhNbWZHdTMzL0xmRG45?=
 =?utf-8?B?SmdieTFCbTFreXlrZHRhM21LcVI4ODV2SmdYaFp0TjliMzk5cTd1YkFBNVQ0?=
 =?utf-8?B?dzMwK0ZXWUx6SVA0RGlvNFRTMGNTMmtKeVg3NHdNeE1MYlcvRDJEV3Z6UDhX?=
 =?utf-8?Q?yGHdcbIs6P5DjbgKXh3tHXFYH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa65157-5fb5-4466-8a5c-08dca0550cc2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 20:23:52.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUZ37exuyuQbl9uFcGG/cvbjh7VEIw0iyg1QGMlmELG5HIlcQ/gBnLjIwGOeTBX3KWoOu1XUgAs7oUdrdM0D3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8267

From: Ye Li <ye.li@nxp.com>

i.MX9 uses an DDR controller that has registers offset and some function
changed, but the ECC and Error inject functions are almost same with
fsl_ddr controller. So update and re-use the driver for i.MX9. A special
type is added for i.MX9 controller only to distinguish the difference.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/edac/fsl_ddr_edac.c    | 48 ++++++++++++++++++++++++++++++++++++------
 drivers/edac/fsl_ddr_edac.h    | 10 +++++++++
 drivers/edac/layerscape_edac.c |  1 +
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index da743cf8a95e9..438b995066f2a 100644
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


