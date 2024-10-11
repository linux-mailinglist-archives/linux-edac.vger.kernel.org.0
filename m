Return-Path: <linux-edac+bounces-2007-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B88E99A7C6
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 17:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD1A1F252F0
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C71198822;
	Fri, 11 Oct 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ag0tOMSZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18306197A68;
	Fri, 11 Oct 2024 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660726; cv=fail; b=Xq/e5CojxKX9vr9twpROMOUyHZeV1LA5AMz+kkRS3pDYniS29+AMyxa/LJ6OzzlZt48VW9y9yf4yr+T56VCI0oY8T/qZy59TF5yAnyimi6mjdWulIh8yRMbvHbpILmcASjjcF2RSh4yMfgXEwobif97SJHWyY0E5HUuZ7Pai7XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660726; c=relaxed/simple;
	bh=bYOSUeH8Tsfygywx3VBHrQIC4eU9dzx5J8svyPSfkS4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Yj0NaoCtoaD/ErZuZR3UQfX3NY0XfzXSL9jIsVsXMH0GEj5LKfJfWF6oE892clORwX67XLylRoZT7+8Dh/wTDAiIH4n6OzTHIiJ5mcQ33Yon1eMglTg5swGVSH+pA5pKFB2TS1BGY44Q2j07y4q/Dgzgw04WGyJ8OloyJTih1t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ag0tOMSZ; arc=fail smtp.client-ip=40.107.105.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEoOWXwahvR1BJEW3+lpHQb9Sa+iAmQEKMrpS58P585zcGFosZHqBSpcP0lPnXgaRrMl+FTqBPLQG4KlSP08yxYYHuvrWRndA2MrjIq27ttCxSj1Qx/gOV6S75haaVIRd/zozkFqEycfUDVNJZzGI+iXBKEus2mxabwPEO/gDZtMvfF5ForICAnTBwZa1Gja5JctlZQ6yjNFLECBbnv1sMgJ7Sf80gT4QBh1I2Nt1P7xEqcvTWt9NhE4NiH7MAWpFj7fg0GDzZxAgro8Aa3FEwm/oSJFmV8SnEWmcRfi3UQXTNpMHxYVnCyqGm0n1U+g9HRURJwEZdhYE8XJnwFbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oThGc+PInWWFzFHWkQtWRVZUx01s9iDEryoUEl8TSD8=;
 b=cJ7YKl+/OdZ60XmzS/yLQ6+TFWYNi46QMCmp/LzP5grU/IFY60rrZmWE+DOD2C/qvGWj2iEmbNVYxRxm1/vq/MYMcBQa8YN73CtwGNYj4nGoA535IBY7xD9Uz+w+b3ubwQINKUDl2rhY+wau/RZDG2vvbABFt/Y2vtl1fSaqcatjyTe24X5PxYR3vjXeXDXquNfL3w6u9QDsEqUgyvDVcvfD5CGgF2kBv6dmnvD4yBJAqhFBzr/7LUDjZQQUoq1j/NM4yYQBWaxHQj7GdZv0yqMEP0S5iCcKXno8JKz77S3Eg9Xlt+OxsrxEchrT6/uTFFSOp9TKNucSaywEQruU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oThGc+PInWWFzFHWkQtWRVZUx01s9iDEryoUEl8TSD8=;
 b=ag0tOMSZeGlCwY6HqL++k36OfWBb5CKMV/bPK0/5hIHCoIqn/1swExmBkvp43b4ShqySsy+yk+3n8g5KczbdH64l06Q5rw6vjGpsXPdoF4zQ2JlnpUn/chEL3rCOJTZFuN+9oUqdAX87/T9ZY/+cOq9i2fEKboxYx2BqVMmRzCxHCHGYQ/7M2vWG9fOrfDCGE6q/JMTGlWElhiWn6NgXhii4y5Rcsgn1CewgHRgBgmY8wbm47o7IzvbsUxvZoJKTzCazXD1OyJYMdC6iiGj8OJEeTnmcIu6V+jKbkzHzfftAqvPcxVdflZu5gokTXAk7YZfo/LHac4dmSARVX+4a0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7360.eurprd04.prod.outlook.com (2603:10a6:800:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Fri, 11 Oct
 2024 15:32:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:32:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 11 Oct 2024 11:31:30 -0400
Subject: [PATCH v2 2/6] EDAC/fsl_ddr: Move global variables into struct
 fsl_mc_pdata
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-imx95_edac-v2-2-011b68290951@nxp.com>
References: <20241011-imx95_edac-v2-0-011b68290951@nxp.com>
In-Reply-To: <20241011-imx95_edac-v2-0-011b68290951@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728660703; l=3246;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bYOSUeH8Tsfygywx3VBHrQIC4eU9dzx5J8svyPSfkS4=;
 b=Jr4ZBVdjm68AQYMozrhBBkHuOgXtkZe2yfQsG4tul8HwMEu9Uo4auwEhsTkM3jvVp+pVnWdqK
 GiUBeH7crjmAohu8MLvaUbS/kQCKODv1F1SqrqywQjvgjyJV5/5ZJCK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: a58a03ec-8828-41d7-0cd3-08dcea09d92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1ZFVGpFdk9RQkt3dEp6RkZoNThqOUpFeklPQm1WVktITDRka01yZmpHTHgv?=
 =?utf-8?B?QWNwSjZocm1pOWdvRk9YS3c2dU9lbGl1TlZxMmhuVE4rNzFnSlBjY2ZjbU9F?=
 =?utf-8?B?UDN4RURTK1diNXFEalNNQXNHYlVTeXNkVUVVaW5qMFRFOFZjelZuVmtBUy9F?=
 =?utf-8?B?VXRCaVhZNTkwY2xBeElEN0lqQ3Q4VmgyYlVrUVRTUnN5a1BNcC9KZjdBdDdL?=
 =?utf-8?B?RnpkWnJwZWNNckZpdUIvU3M0VVFHZjJpcTRuZG41d0lKQjNCT3Nodkp3YjJz?=
 =?utf-8?B?UGVuQzlsTmhWdFhuOE9YQWl0SzlWMzhOdVlxYjJ0N2pPUUM0a2R3MUtWTE55?=
 =?utf-8?B?SnlRcU9BZ3ZCVktRYWY1alc2bkpVSnd2My85MmdFbURNT0IxeVRycGZRNDB6?=
 =?utf-8?B?YlhOVDl5eTBBbFZ2SDROU3lHU3doMWQyVUlLZkw3ZWVvTTRPelI2bHJJZDQv?=
 =?utf-8?B?MkZDUUpEaTh1aFptVTVmdEpZMGptQU9hR25SWnVhSUgrZlFrZWxaR25GL1Rj?=
 =?utf-8?B?Q2N2cE5aRmdDVEJjVW1KQXhqc21ncm9DYjRZQnQ4L01sVjZnUGdySDVGODVm?=
 =?utf-8?B?ZnRzbmNveDRTUWpGMjd3ZWd1N3l4ekNmOXpIMnNzbFNNbEtTNkdSc2orQmJQ?=
 =?utf-8?B?MkJYS0g2NVBkblBYTlBJdXlCdCtFcXpvKzZ1WnVqdkVyMzg2L0pMV0ZzZXlI?=
 =?utf-8?B?ekRpbFdiSnR5S1N6a2Z4RWlUSjdnTE1vOTRQMm9pSjRPK3ZXdUR2ZTBQSmhJ?=
 =?utf-8?B?d0g1OVdVZXpxVDgzcHRieGE3Ri9SQWsvVG0zSFYzbnZuYW5yYVFoREFtTzlI?=
 =?utf-8?B?Nk9vaVMzbXo0d3NLMVR6UENHb2RDNysvYVhNdnlWYmxHbkZHelFzcDllVkh4?=
 =?utf-8?B?RnIzNHVQSlRoQ3NoTlVzZFBFUGo2VEV6RGlBR3owK255WUhvdzVtWnlNejhD?=
 =?utf-8?B?aWNia0pyRXMydHBDbHB2T3dyZy9MQzdTZGk5L0MxSkV0R0tCSXdITExuOExv?=
 =?utf-8?B?d3I2Nm1vUE92Zk1hYitQUHB3aG12V0tnNXZWVlVlUVVyUDNEUTEvQWFLN0lW?=
 =?utf-8?B?aXdwNnNtV016MklRRHZ4SHJMdjRnRFZvY1RHa1hvTmt4RmlGd1pHd21qMFM3?=
 =?utf-8?B?VWpELzdaUnJoQVVYbzFGbnVGZzdycXFQWkRkTXpabmM3QnpkK1JEV3RqbXpM?=
 =?utf-8?B?WUhFRTk2Uk54bWU1K3VxQktoMmkzV0liR3dBRE1Yd2xnZ08zWjdoc3owN3Zp?=
 =?utf-8?B?WXRwSGtxcE5qUDZIbU5CTTZEdnVtOGNIZlpSV3ZtOEF2OGZKcXZ1RFZXeEov?=
 =?utf-8?B?Mll0TjJkNnNBL09ORnpEcnlaWHlHTFFVaXNwcWFreVdzckJ2Yi9vUGg3QnFO?=
 =?utf-8?B?YWFTMDRid0ZvMzd3aUtsMDZwcmxkTmJmdGpWUFBuZTM1WHh5eU5zVzltcERv?=
 =?utf-8?B?N0FGa25BTStWanNRRVhmTjBuMG9TdE50dWZMdEpCSHpzVzg5Zmp5RUxyMExp?=
 =?utf-8?B?am9sR2k2ZVQ5bXlBQ1NrSGovYk1uYlBGQjVsVVB3TzhqR1Nyenk2ejc4TGtG?=
 =?utf-8?B?Sk05QXM0aTh0czE2L1E4U0ZMK2o5YTVMY2tzeUFITXFHdkVUZ01xbTlZdDV2?=
 =?utf-8?B?aHBUTnRmMlFicWVGKzBvYXVPcGFZazk3N05Gay9jMFdURUhSUkYyNFhBdmZ1?=
 =?utf-8?B?UncycU1VYkUzcEFvWHh4dHZJVG01Nm9wbXNYakk4ek1rZVMxMHI4V2crd1gr?=
 =?utf-8?B?WkZzQjkreFVkaFpaNTNsWkc1T2ZnRjVWUkJ1dXVCMWtQRTBqY1dqUDh4RExl?=
 =?utf-8?Q?d+lDZXZF56QkkSDNZ44Y92hZdXI6OX3KdizMI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0Jac21tZW9JbW5wK1pwek9WSjNJY2xRWUg5WEY4b3NIRmRuSHdvUWl4WndJ?=
 =?utf-8?B?elFnemY3TTFSbWt0VVZ6NVFmQ0t2aitrT3drdEcxR2F1ODhvWE1YUW4wamwx?=
 =?utf-8?B?eUdyR1ZjVnJaQ25VV3BvTlNzTkNNQVpmdTlnOGlhN0pzYnlweDRPdElCTzlj?=
 =?utf-8?B?R2xvNms3NERXYkY0ejB6elpmTDdDL2FGWTNscjRpemo3cVk4cGRCenM4Z2Z1?=
 =?utf-8?B?WWVLbkNkM1JoQkJ2WS9HQVhxS0R2Mi9YUDhRckd4eEF5ZWx1RnZERjBxaGdh?=
 =?utf-8?B?dUJXTi9zcDF3Q2loMzZvRmhBV0dta1BTc1dVcnRVeTlJNEdQdzdzanpjOVhW?=
 =?utf-8?B?Tmt2MDdKWmdBWnBUTEl0UHArNWpsRFdqcllxdVUyWVJ4R0FFUGZrYnJlY2dT?=
 =?utf-8?B?VUtpdVpVVk9rM0V0ekJKNk84bmJxRHNURjlFRDBGWTY2cDNnRFlHeHhXVEhO?=
 =?utf-8?B?eGhzc000SndpbG12L3M4cXEybmZJaE1pYWlRVFo0akVCR0pNZ3FLOW5Xdllw?=
 =?utf-8?B?T3pCTDFqMlBNOEJFVHBEdGZuUFplaUFtOFBycTR4RjRtN0ZTbk1iV0gwemI5?=
 =?utf-8?B?cC9UQnZrbGZXbWx3NU1EOEpXNHEzWENPSVU3ZFFTajBKV200MmpSdHRMVU1I?=
 =?utf-8?B?aEY0aG53QzZkMkpLaWtPYTBWS1U4bjJhOE10dzhiRkZML3JuWjg4bmZ2Ym1Q?=
 =?utf-8?B?RXZSZTJZTkdpWThUR1pLSEphRU81QTMvYjNpamRlQjhPVFNlQ09OM1JZclU4?=
 =?utf-8?B?dWFBWm1QK0VEeXhoOVhRZCt2VUtjRnlsUXltUnhuekJCSWpZZUQwZFNVQjRX?=
 =?utf-8?B?SEFWRDY0b2d5a1l1U0FMVlVkYlZEUkpGK0xJVlI2WFltU1liYzBNdjYzTG1r?=
 =?utf-8?B?TnFSVURBalZJV0lUQlUxNHhURkpuQnA4Uk1PUkZQbmNDKzErNW5QK29DalUy?=
 =?utf-8?B?T25yN2FYZWdlWXlVVmtFb1A0b3NQcklOT2dwYTIwa3Q1TzNTOXBqekxLTUlr?=
 =?utf-8?B?azBZdm04MDFCV0hzeEJPWnpiNzh6TXVxSHBLRExELzFTNmNWSlJseVZBbFNZ?=
 =?utf-8?B?Ly9KK3Y5T2JLbm1nM0xuMFNZUW9ZWm5QNmF1b016UDVUWXd6Qm5nTkFFYklm?=
 =?utf-8?B?akEzNFdSakw2bk8wMmZTK0h5clFBUDgxRmhnSEF2Rk8yQnU3ZXkxWGZRSjds?=
 =?utf-8?B?UmJ1OUE5WWkxbStQTTFrV000WE9RbDBNbS94akp6czVvZFYrc0ZQOXhTbVJW?=
 =?utf-8?B?YTBESmJTSDFNS0ZvdS9vNUp5NVVCZkp6L3Y2STVncmpqbkVjdVd4b3VUQmdx?=
 =?utf-8?B?bytJYVhPQ1R3cXBjVlYyRFNnL2FIbk9nMlJJejhaY3F3OU9UU0JPM0pTWHV4?=
 =?utf-8?B?aGlveEp5YVJiWGVnUyt0c3kzajhTeWNYTlR6cTFuUzdtMmkrZSttQVJwZFNY?=
 =?utf-8?B?TmtWTTZTZjlrMlBoQWl5L3FjOGR0NHVPbWVaeXhKVHR1alo4SFJ5MXQyUFhn?=
 =?utf-8?B?MGl4d0UxS09rV0MxcTUydVRqOHpWVlU4SldTVG9iMEVYK0JISlVVbDFhcFRY?=
 =?utf-8?B?czFjUm1HeXRQUHowNTBETEE3ZW9NK0R2RkNyOVZLQ3RkaGlXRUFPc1hvSXRZ?=
 =?utf-8?B?Q2lZUlB5L1J5bzl4UWtZY3grRmNQN2tWcjY2aHJnWHY1Ym80dUJ3bkFzQVNj?=
 =?utf-8?B?RnlJTC9HT1RUMFFlcUExdVFWZTBEMzdKSHRPUnFFVTFZbExKcmZSYWxiYnNh?=
 =?utf-8?B?a253cFBQeXpmTlNnWFlYeFdSNUdPWGpiT3RCKzNUelVRb0ZKMzdpakIybmtj?=
 =?utf-8?B?cjJBUmVwbzNpMjlxak5nT0M3THQ0NDdJcHFyRFpKNkRPNlVDR2xwNitnb1lj?=
 =?utf-8?B?Y09RZ1N6REpxNWVia2tFSUdrVDVZeUpOaTlTZzRJbTJJcE85Q29PZGg4UnNO?=
 =?utf-8?B?bGUrNGJMLzBDNmxJSTVQMUhGcS84OENMRHF6NFpyVlVQSVQ2ZEQ5akZPWEVP?=
 =?utf-8?B?dHZvZWVKRnFaOUdxTXU0d0czZlE0dzYrQ25HUHAraVRONmo1VEkraFNpb2U3?=
 =?utf-8?B?aDFwVkxXbTRlYmVLYW1XWmJQY3hIMlgyaFRpU3VMTzE5RlhtZXk4WURRQWkz?=
 =?utf-8?Q?0hMIVOI08gzqBwDTstX9p54ps?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58a03ec-8828-41d7-0cd3-08dcea09d92a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:32:00.0664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNuusndbDpAAtiRZGmMBiy3+0/o3zzKz3e2qf/miMXWs4oQGVdxFwPA5OZ71/janMXY8aBw9KRoOsX5l8CPA5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7360

Move global variables into the struct `fsl_mc_pdata` to handle systems with
multiple DDR controllers.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
- rework commit message.
---
 drivers/edac/fsl_ddr_edac.c | 21 +++++++++------------
 drivers/edac/fsl_ddr_edac.h |  3 +++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 9924c6b816648..7a9fb1202f1a0 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -31,22 +31,18 @@
 
 static int edac_mc_idx;
 
-static u32 orig_ddr_err_disable;
-static u32 orig_ddr_err_sbe;
-static bool little_endian;
-
 static inline u32 ddr_in32(struct fsl_mc_pdata *pdata, unsigned int off)
 {
 	void __iomem *addr = pdata->mc_vbase + off;
 
-	return little_endian ? ioread32(addr) : ioread32be(addr);
+	return pdata->little_endian ? ioread32(addr) : ioread32be(addr);
 }
 
 static inline void ddr_out32(struct fsl_mc_pdata *pdata, unsigned int off, u32 value)
 {
 	void __iomem *addr = pdata->mc_vbase + off;
 
-	if (little_endian)
+	if (pdata->little_endian)
 		iowrite32(value, addr);
 	else
 		iowrite32be(value, addr);
@@ -511,7 +507,7 @@ int fsl_mc_err_probe(struct platform_device *op)
 	 * Get the endianness of DDR controller registers.
 	 * Default is big endian.
 	 */
-	little_endian = of_property_read_bool(op->dev.of_node, "little-endian");
+	pdata->little_endian = of_property_read_bool(op->dev.of_node, "little-endian");
 
 	res = of_address_to_resource(op->dev.of_node, 0, &r);
 	if (res) {
@@ -562,7 +558,7 @@ int fsl_mc_err_probe(struct platform_device *op)
 	fsl_ddr_init_csrows(mci);
 
 	/* store the original error disable bits */
-	orig_ddr_err_disable = ddr_in32(pdata, FSL_MC_ERR_DISABLE);
+	pdata->orig_ddr_err_disable = ddr_in32(pdata, FSL_MC_ERR_DISABLE);
 	ddr_out32(pdata, FSL_MC_ERR_DISABLE, 0);
 
 	/* clear all error bits */
@@ -579,8 +575,8 @@ int fsl_mc_err_probe(struct platform_device *op)
 			  DDR_EIE_MBEE | DDR_EIE_SBEE);
 
 		/* store the original error management threshold */
-		orig_ddr_err_sbe = ddr_in32(pdata,
-					    FSL_MC_ERR_SBE) & 0xff0000;
+		pdata->orig_ddr_err_sbe = ddr_in32(pdata,
+						   FSL_MC_ERR_SBE) & 0xff0000;
 
 		/* set threshold to 1 error per interrupt */
 		ddr_out32(pdata, FSL_MC_ERR_SBE, 0x10000);
@@ -628,8 +624,9 @@ void fsl_mc_err_remove(struct platform_device *op)
 	}
 
 	ddr_out32(pdata, FSL_MC_ERR_DISABLE,
-		  orig_ddr_err_disable);
-	ddr_out32(pdata, FSL_MC_ERR_SBE, orig_ddr_err_sbe);
+		  pdata->orig_ddr_err_disable);
+	ddr_out32(pdata, FSL_MC_ERR_SBE, pdata->orig_ddr_err_sbe);
+
 
 	edac_mc_del_mc(&op->dev);
 	edac_mc_free(mci);
diff --git a/drivers/edac/fsl_ddr_edac.h b/drivers/edac/fsl_ddr_edac.h
index c0994a2a003c2..de66f9822fba1 100644
--- a/drivers/edac/fsl_ddr_edac.h
+++ b/drivers/edac/fsl_ddr_edac.h
@@ -70,6 +70,9 @@ struct fsl_mc_pdata {
 	int edac_idx;
 	void __iomem *mc_vbase;
 	int irq;
+	u32 orig_ddr_err_disable;
+	u32 orig_ddr_err_sbe;
+	bool little_endian;
 };
 int fsl_mc_err_probe(struct platform_device *op);
 void fsl_mc_err_remove(struct platform_device *op);

-- 
2.34.1


