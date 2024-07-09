Return-Path: <linux-edac+bounces-1475-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0EC92C46C
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 22:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6F61F23210
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 20:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A90180048;
	Tue,  9 Jul 2024 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zze1lEcX"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2075.outbound.protection.outlook.com [40.107.104.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01E1B86E2;
	Tue,  9 Jul 2024 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556612; cv=fail; b=IQjSNpji91y6EtfenMH9YqPcCMQfTvCUn5zNqEEjAYSwZr5cDYMTU27NkVF+7xORe05IDohskYlANVsWREA6lt+PWTP5sy/sVcS60JHDkWpfARjcDuB5771cr6jxeeQ+gA3Ld91DEjDxmRKF1IrGQFdn161TV/65u3xmOfrSWwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556612; c=relaxed/simple;
	bh=e2QBEvhSuy8S5AGa8xaacRHOS/++DQsu2K3V+/eMwnQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=dCzoDCxVwpQTMbL7t9pNB0VKhHWon1lwV9DNSg9KqEnUbLEy3/CwTfMhSrNdZmwrjrkgv6t1ObOeeYaAUZ4HxkpahfkvIW2Y0cy1Cs0S71ejIiPyrEOfwr8EPptGG86jlLhyhXK5Fey3KA7ac6lghTIf4RA5ND5InQ4WMY1OaGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zze1lEcX; arc=fail smtp.client-ip=40.107.104.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwGr7xVdf8xGOJenrRwEd1/x0kEopjIaIEhg1FnUncAVxwEi/nqSDayTnycs1DIsFeQBnNiBPv1km1h5B0TJSv31aORJ1NHfTuCea1tcQ2nMQssor0NnYSwHEbBUiOkUxTVc0GmGd6aTckboY/lCZL8rbnxnqvkLqNNI47b2vueyIhYe8IGUc62fje1OqUcUL1VjDyh3oB/yOTekLDB7uIRFCs50YlW/U45nwZ3mLlKEtuHVHChEnUgK1WEoJHsEzEw0fNM67eU/si5ubRlu3CNGj9dSHZNEhCSSKq9WFPun2zB2Q6x/n3A7KCkvCAaEqF8zb0flVHetnngxDXmixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XPPZoGJdqhZGkTgeE6aCOG8BzGsj31v6OVCHdCqQ8E=;
 b=JbmAmB1nRFBb9BzzlUVSEYVCedo0oNIKlSpLEYOy3+rYjZrGf2B6GnvNu6WShMbrB+vN9DS0V9hNh2tb/Uf+DWtClqoNNoT27xEiX+ZTic1hR7z3K2fdyT0G07eIpamD4C4qgMEHvvOxUbI48bVRiSSnIF7xcdvAbQH+CkhTKyaM5BBL1KpgaCRuvfWewVAe57A4IOZ0MuIerpixf+86Qt9fOSIAdjLFCU7+gqmrUbDlW5qht/wFyLiWTiUBPy4PivaPjE0UqkHTFIMdvAvU9boaCExjPG2CgJ5gi1J7EfXdU3Xib7tK9pAvfH3wrMXxldQz6UlyhEvpqRUWylKiiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XPPZoGJdqhZGkTgeE6aCOG8BzGsj31v6OVCHdCqQ8E=;
 b=Zze1lEcXBwqcJ1jlBjtWJti9XkfCFQvyQH3W6BzPNbE5GE2ZuYiEAm7iFb316dj8IlzGy7Yh+crEYstgQ6EyWfxwyQdh8jG1WPySXVOTGi6V1SUKymMY+Felm6M2iS24DQbjgatxBL3bx/Hb560C2gWnRubndNUNkUwuRtZwhnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8267.eurprd04.prod.outlook.com (2603:10a6:10:24b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 20:23:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 20:23:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/6] EDAC: fsl-ddr, add imx9 support
Date: Tue, 09 Jul 2024 16:23:01 -0400
Message-Id: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACWcjWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwMT3czcCkvT+NSUxGRdIwPL5NRkIwMLExMzJaCGgqLUtMwKsGHRsbW
 1AC3NNodcAAAA
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
 Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720556601; l=1242;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=e2QBEvhSuy8S5AGa8xaacRHOS/++DQsu2K3V+/eMwnQ=;
 b=UuT25VB444U33AlZQXfimJKUkmesR2wWPkJ3RQ9oUugrxbDByZ+MVthhlvPNfPrx9CQPEv4+P
 NC7SKta7Br3CEgkDK5dQknryZ34NF6Wh0WMNuHFphFpKPx6z0WpXb98
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
X-MS-Office365-Filtering-Correlation-Id: 3a4c2fbe-3c56-4f6c-99f0-08dca054fdb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTk5QXIyN0grMjRkNGpvVjY1RnQ4U3lHaUFNanhLOUZmNzN3V1dmOEh4QitE?=
 =?utf-8?B?L3M5cGduZEVBUzhJcXVobzA5RFloNkZtNXRWK292QTUrL01mRUlCSTNxcnNr?=
 =?utf-8?B?VEZJK3NNYW5YNUdQMlN2MHBiMWpPMFVGMGxkUi9qKzJmL3czenoybk9tdW9T?=
 =?utf-8?B?K0xPb0dkZWdhcDczVGQrSFFSTnVkbDhDSERrZWFlSTNCT1JIdEsyeXRHM3dt?=
 =?utf-8?B?N0pRRWxSNkwrR2dBU1RydzNaaW1xK1lhUytHd25QblNBUGVrd1pNUlhyd2x3?=
 =?utf-8?B?elBsMVMzMWplaUYwT1ZRMjI5aEJCSGxJZUE3NTF4SytoK1M2RWRIMEZ6Sytl?=
 =?utf-8?B?cFUveGF1Ykx1NVp4SDNaek4rVWxKVVRXcEZ2cHNSMnpDY3ZUTE9zaHB5c2JN?=
 =?utf-8?B?VW9jUC8vaVBtTXEwQ3M0RDN1WUZOYi9jSUYzN1FyUnVJdjdSSjVJTUxUTjAv?=
 =?utf-8?B?eWMwOHVjY2E4WDFEOGl0cFFTS005aytncTBaVjFRc1N5UnpMcWtUTS8zbzdN?=
 =?utf-8?B?MmxBbDRMWjdtNnc5TlhRUG9FMjJiMVMxWjZKbmZub25jZlBNWCt4ZHVsRkN2?=
 =?utf-8?B?MmdpWHVpYW5MTklBWmdoajUrQkU2MGdjUDIwTVJrYVYrdmh3ODlZejlFOTFy?=
 =?utf-8?B?THFwNVBkVXBWcTZxemU3b0tOS2lpNlhrR2crdGpDL0ErM2tzQURiRmNvYjZm?=
 =?utf-8?B?V250c1pHQXQ5bW1TcC9tR1pGeTlUSGZTWXR6N29TTTNIWWJlZFB0ME1ha2dO?=
 =?utf-8?B?Q2lXbGxQY1FYUkxBWjlFa3BHSSsrNkZEVE5SM2RKSWR0QTRjbSs0Z0VoVjFF?=
 =?utf-8?B?UWlTRW56Zm9xdDRPc2swOHNSckM1SDlLNmpHcFE2NTJkVzdXOHhEVTRraXBZ?=
 =?utf-8?B?UUE4Q2diNmNBM04zL2k5bEJEV1g2M0VycFl0TXdaR1lWU1hjTEY1RVhHRWhr?=
 =?utf-8?B?WUlReml3cXR3eEFTMndqNjRWV2hNbkNsT0VnUzgycVBFYi9tK1JTRXovaHor?=
 =?utf-8?B?eEZxTnBNdENjMThOS3N4ZG8zekRQZ01MaU93ak9jUzhiMk5KNTl4TG5od2V4?=
 =?utf-8?B?T2V5cWV4Z3RRYjVibDJqcVlJU2RkdWE4M1dUMSsrTmIzeEUxR25iSndXSFQz?=
 =?utf-8?B?bTBNQzFUbjdkT2NDMlFjVTNqRDErR2E5anBOTDl5RitrVEVldWlVVkFJeE10?=
 =?utf-8?B?MVZtRlRlTGdIRndXZVd1YzZ1bXpvOXpnZ2tIUmljOFRZUnE1Wlk0ZzN1RFBD?=
 =?utf-8?B?QjhGZFEzeHlhenBuZU9GcmlOTVMzcVFxdFh6VXVBbDRiYUVORklhWCs2SUhs?=
 =?utf-8?B?SmZMSmNNVmk1OFQxWXN0bG0yZFE1aEl2aGFnKzk5L3hkemZWbUZraGdNLzBj?=
 =?utf-8?B?Q3p4d3lsbnNUaVhWSnA5N1doNlFFcXFlcG1GdGJvdE0rc2xzTzQ5dXhDK1lX?=
 =?utf-8?B?REtQckhacVZ3aS83MU5WdmxRTndVL2JUSXVPRlY4UWxmNzNLRjEvMGZJd0lP?=
 =?utf-8?B?MGx2cjRSS2RpS09RZ3F5V1l2MlE1YXFrK1R5MjJKUDd0NTcvdXI5RFpwTncr?=
 =?utf-8?B?ekZEL0ZSc1RMZXJvRm81aUE2MzNZdnpWaHdreXBYOUZDTDd5TG1yOHhlL0F3?=
 =?utf-8?B?ajNIbFBzd1pLaVhjVDFWRTh4M2p1ZSsvVVk2ZnltVGxHSUN4eGFHRmRWTHBK?=
 =?utf-8?B?SUkwTU5lWWttRnl2dTRySjN0cjByUU5uS1pBTEZaclN6WGlTcDA4bGYwRWtx?=
 =?utf-8?B?MWJLL2U3K3BpYjA3NEZWUVhLQzN3ZmNqQWN0bGVjVzVpNUgyalIvU3Q0VzAy?=
 =?utf-8?B?UDlWMGRDZkxnMlNDbjFnMVRiVVBkQjJnSHF1b0k1dHppNDFtdlRDTWhCY0lC?=
 =?utf-8?B?cERmUy95K1MyUlhPSktnTktrcFlaZzdlMzdLbm5qbkdPWHF2QU5FT1pmTEEy?=
 =?utf-8?Q?+rB3tVlrQJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkZDUGRQcHlQVmZlVzRiQURMUkdKdHdHck5ia2NDVzZPVllQUVRMWjNLdHUw?=
 =?utf-8?B?clpvSnRZbnNnUzFySGpOaE5wZll1VjZwQzY3OVVleVA4dnFjYUZQN1hFclJo?=
 =?utf-8?B?ODM3ZVR5Rlh4V21qSFc1YnU2L3R6UG9JSTcrOGxTNUx1U1BYT0tNUXpYTUJ0?=
 =?utf-8?B?c0tZV09tbUlSVlZRUWJ2S0R2bVN4WlcveEV0NmZDYUNSNjMyYXlwVUJxT3A3?=
 =?utf-8?B?THp0UVlYaEFESzc2LzRjMFc3bC9lelR0QXhIb0VqMzF2ZkV1MWhZVUg2R3JJ?=
 =?utf-8?B?K3hmdUVzRUlNcUNabFBUVzV6MHRpQ21zczdFSW5qaWRFcXI1UEZQUW4wWXZH?=
 =?utf-8?B?WVVxKzd3QWc2U1prOXhzZ2NEL1YyV1hWUzlpUUlEL0w0ZTJHcVZlaytuZDYv?=
 =?utf-8?B?VW8ycDVPY2J5UnBzTVFsMklYci9seVlkUCttOUd6Z3lsTlF0bFd3b09ad1k1?=
 =?utf-8?B?WDAwcmVvdTF5SjgrK0pJNnNKZFF4K21qSXIwNlNmUlVva0t2UCtFbW9WWjUw?=
 =?utf-8?B?ZE51amkrTUVhM1NqZll1VngzL0dsS0dlbloyS01COEovNmRpVHU5R1R0NEw1?=
 =?utf-8?B?bXQzV0M0MWw2WnVHVkhWMmtkQ1M1NnNkODFnWnJXcnExZUgxNHBRQ0g0RHk2?=
 =?utf-8?B?RDRDM3lWS2MwWmI0YVpDUFFDWEwrdFpXbVpFTkhpOW5TQUcyYW10bTRMbnZy?=
 =?utf-8?B?SVcrSzFxZU5sNDBzcUdOdWw4ZmVZL0N5NFF6TE43TVRuK0wvZ1l3V1ZzbVlC?=
 =?utf-8?B?RGJ6N0lreDZ3aWE4SXFnMStiaGRCUHhoY1pTMm05dWZrb1UycjNiZlYzVGtv?=
 =?utf-8?B?bCtwUVVWaDhmWkF1eDJjVlpHN2w5clhmWmR4aE5DazE1dnV3ZGVyL1lPaVJY?=
 =?utf-8?B?cWFsSDJqWUlwcEl6dmhuRzFCclFXejZPd0x2Yy9nWVBOOFhPNUtwS2hPaTdr?=
 =?utf-8?B?K2pGcng0bGtoK3ZvMDNqazNqYzAwK0pBY28vNWMwVWwxaXZETlhhRUxWMEpC?=
 =?utf-8?B?V2pVVmdaZkllbEsrNnl6dVZpVFoxUEJZTXZiUXlwRFJzWlJSakJRSGlyU21H?=
 =?utf-8?B?dm1PSXJTam1NZWxGRHVvaTdJMVNkMmE2eHl0SnhBS0tBV25IZjFSVDRVajRB?=
 =?utf-8?B?cU9PWVdjZW8wdWVZTG1SdjhrS0NlUlBoZ1BlV0FPU0hvamRqOW5NYUY2Sk1D?=
 =?utf-8?B?Mm92Nm9vNUc4UnFmLzQ3WW50RTRXTS9Bdk5oMFZjQmpabkY1djkrWDZWd0Rx?=
 =?utf-8?B?SlpyT3k3aWVqeVBlZkV6bkVheEc4WWhSMGNIZ1RTZlMvYnRYenlSbFpQajNH?=
 =?utf-8?B?eWFGQ1YzeEorMHRlWURQU3l5eGlJWkM2RXZMS2RIb3NDTkVjUkRNWXRmSVRr?=
 =?utf-8?B?WFRPMVhYSHYrU3ovbWRvS1pGY3pLZy9JMHQ2QW9BY0tncXJVdE90Z2hYOG1L?=
 =?utf-8?B?NnFHOXRrWFJtc3EzbTFrTXZSK3ZqbUMzaVM3OFlYdHBqS1B0Y3BNNmZRUlU0?=
 =?utf-8?B?RVlGQ1g2c2pHOS82eDRIY2p4VXBWZnc3WjR0K0RnMzc3bXdoVXNKcUJJUXlD?=
 =?utf-8?B?cjNNZ2orWFhaakJLWTluNVVYQ09FdkxDeHlST3JVczhoa2NoR2FTQjlZZENm?=
 =?utf-8?B?SE1NMlhacG5RTGxLdEFDTWRHbDJrdy9JRjArVHRrZkdhYTdCOFZ6NHp0UW1R?=
 =?utf-8?B?TTRsK3k2THhIM0VZMSszdlE4anlydFNaK09QN2dNQlViNjNRTzFyUXVJeWs1?=
 =?utf-8?B?MGlyLzFuRWhlUFFDdTVWdlU3d2RCcE9SWmNjeFVpZVlKTXY0UHQ2VkxhYWtk?=
 =?utf-8?B?eEhGcStKeTZWZzliRC9pZlRwY0dUSHZMMWdTTEovK3B0SU9wblo4SGNnYlpS?=
 =?utf-8?B?WDBjR2FEN05qNHl5VmsrNlV4NUc5dHpna3ZYdzNZRERuUGp2OExlOHc5eStF?=
 =?utf-8?B?U2xZNWwxaDhKckt4bGZ3Wm92aUg4TTdwTFMzbzB1ZDN0VldVQnNHZmM5T3Yy?=
 =?utf-8?B?elkxTGxsY1ZXeCtZUFd4Mk5GMjQ2Zm02TjVyWTB1ZjdtKy83S3NpUDF1cXNh?=
 =?utf-8?B?bDBTZkxBa0NVZkRWR2oxNWthbnVXWWVVejlzOGl1S0tVNmxVQzVMZDN6bHda?=
 =?utf-8?Q?oxuW4ebtATDGjTmZ9uhCipwpj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4c2fbe-3c56-4f6c-99f0-08dca054fdb5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 20:23:27.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBw/ezcJRu9/XQk2iS+DMDKRQhtwbN62LIWG8eBhM3RyAVZ+TSKodqs2nOkpK2qhOXcpJSGPb4O6RpS55qtRfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8267

Add imx9 support for fsl-ddr.

Patch 1-2 is prepare patch, no function chagne
Patch 3 is small fix for bit shift
Patch 4 is dt binding patch.
Patch 5 is driver change to support imx9
Patch 6 is imx93 dts change

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (4):
      EDAC: fsl_ddr: Pass down fsl_mc_pdata in ddr_in32() and ddr_out32()
      EDAC, fsl_ddr: Move global variable into struct fsl_mc_pdata
      dt-bindings: memory: fsl: Add compatible string nxp,imx9-memory-controller
      arm64: dts: imx93: add ddr edac support

Priyanka Singh (1):
      EDAC: fsl: Fix bad bit shift operations

Ye Li (1):
      EDAC: fsl_ddr: Add support for i.MX9 DDR controller

 .../bindings/memory-controllers/fsl/fsl,ddr.yaml   |  31 ++++-
 arch/arm64/boot/dts/freescale/imx93.dtsi           |   8 ++
 drivers/edac/fsl_ddr_edac.c                        | 134 ++++++++++++++-------
 drivers/edac/fsl_ddr_edac.h                        |  13 ++
 drivers/edac/layerscape_edac.c                     |   1 +
 5 files changed, 141 insertions(+), 46 deletions(-)
---
base-commit: 82d01fe6ee52086035b201cfa1410a3b04384257
change-id: 20240704-imx95_edac-209cec208446

Best regards,
---
Frank Li <Frank.Li@nxp.com>


