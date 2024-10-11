Return-Path: <linux-edac+bounces-2011-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D11C99A7D2
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 17:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AE91F25486
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DFC199FC5;
	Fri, 11 Oct 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PLi83TMZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E921993A3;
	Fri, 11 Oct 2024 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660744; cv=fail; b=g4/0G+/aInspR+2sd9TCH037S7cpUDGGOEVkc+O8X+XSGe26xISBttUNTAJr9kayVDP6c6aueNxj88LMiL+DMmnmXgfB8ipqPcwyGXJnJYSwZg0zSrd84xo9OqolTQtOXHbiVrsbOC2ROkZ9QhIQFfV7+48B65oQDx4m/jcjHt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660744; c=relaxed/simple;
	bh=79MXg57Cyd0Ls8RHW05eE1dZDeIAJiwGUJukDHuBEDA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iCQHLQCowjAr8XC85jPM4FhbysgzfdwNpZQhLy8cmjOLR4ZCQA++iy8MrRmYnDi8+ZDoO8+fZb0HwiMMb1pPEUbvXGh/f2GJAIJNCAvXiv7ymisGrQBgIUcNjqsShlA7HcAkdnenCsUKCjTyqrC5VMjW1nOK9bhXRLPnE5otnTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PLi83TMZ; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yR5Cdc2Y3t2N5YYhxRYo+a5UKax2dpU2cBbaKGYsiFagmc5cq51qSscHCVlTNUGi9sZ4liSUR60S8QctwPJ3S2o9Sb6+8CMDUNDS49YDqyeGeg89g9N5hNf2Q6LQt2DCr/OjDkQF1oFdUJn/5zXYkmhUtu6Ad0ZnONgGdbAICqheq42dKILNYIFjnEaR/Bn1W8lJGyVG2irwockJYZZmiIx+5mIpG29UtPs0ZR9YAC8q4go8TXAu0dQnMyKB3pOdy/JUQqG7WSEJixw0aXwrwwg5cNHPVpqQHs3bp2veYTLIoTnyrPAxO+nwWfqVKu4zVC8NK440L13k1k+5ocJByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMjEE4+kvbYP5U/kSZ9Rky2OKvC/sfNSCk6XWJ+IRQI=;
 b=O+tSwGhWprLNHWAsFWHuyxmAu0T58MIDhuV5ojTv5RW8lZGtCcraV0LQnKxqB+4l4CCUioayvLqPmBchMPoy3oqrS23wWRx4zRxD0DJtpPcZcbrll1yBRn2/Eq7CiSv9q4a4qbP3cN5ma5XXFDm9KtQnQE/kgo+3+F3GVa7iB+Fc91w8jd9oSzKcIjOVE7MlGgsJpmGEaNabs/5lblJ4WKo2OLyiJYvOHgveJQFkh7Nu/NVjQHyuGjkdFUSv4Fq6Z/m2uhpBOF1DR70uYyqSISufwyHLXrjLrnFy7henQJ2L90WvEKoowotcI/rDclImLTvcwz22dCQfxsi33tO1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMjEE4+kvbYP5U/kSZ9Rky2OKvC/sfNSCk6XWJ+IRQI=;
 b=PLi83TMZidU4AWRXwiFqx4oEESOhJUgzghaC1b6j27pqsI98qXknViwvyGD3dGNC36rzySCHYN/re1Mx9UnctXRapwDsLYyFsLTyXY8fIDIYR8zOLIgyccSWUABP8QAkR+Q58ivQGLh/bKrBrVYYU+4MLgCZJckRJAcXAOt29exMg0/HR8MXLVISatbcmmPztltkTgYhH4cf/bN8Dsnk8QXCGIRYOaYjvxSpRm0k1bPSfVebIdnx07AnrrOiOt8t0YYJKEccCNlMCEwQN4/JmC6a2aLdtNNLb2sEKSOY0ob9eTb4vZvYnwUOr749eyWMDhoFyvgqeik1Ezi+Mf/hfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7360.eurprd04.prod.outlook.com (2603:10a6:800:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Fri, 11 Oct
 2024 15:32:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:32:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 11 Oct 2024 11:31:34 -0400
Subject: [PATCH v2 6/6] arm64: dts: imx93: add ddr edac support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-imx95_edac-v2-6-011b68290951@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728660703; l=859;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=79MXg57Cyd0Ls8RHW05eE1dZDeIAJiwGUJukDHuBEDA=;
 b=w6Ci5x6+kUwU0qSrTG7LmFOXnAYqjOYX6i/PqI9i2yScNOg94SIwsb40Ls7cAvvfpqdhHtsPA
 hsOP5cFadw4Cqf3eRo3/Bj5l9CGbI4jnuTSUm6uqBOuIIVdIxI5Xv4a
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
X-MS-Office365-Filtering-Correlation-Id: 6ecc51ff-41c7-4431-29ca-08dcea09e5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0RsUy9oSlFld1Nsd011a1JMRk5KTkZ0RWxCN2JVVE12TWpsWGdlSnB2aGMz?=
 =?utf-8?B?NUxuajhoRzRmRVlvZW9xMy84S24rMStOckprZjJkeVQ0aG42RmRuRlVTWVhL?=
 =?utf-8?B?R2VSbUY2YndWdWFjVGpQbmMvRDZVY1gxTnprdUJTUWliMzlLQmd5VDJTZ0Nm?=
 =?utf-8?B?MWtHbTBUaUxkZitpR1dhU3M0VUt1ZGg5WnpFSXhRNGJ5cDF0YjltWC9xNWVm?=
 =?utf-8?B?WGlNeW5PSEVUVEd2ZllLU0hxd0hZdDhHOFNPV05wbUhLcHMwWDlkditHSUxu?=
 =?utf-8?B?aHlIUytBNjg1VHJYTEFObitIS1ZqWTBGaC9BQm8wN2pGTlk1MzY5RUtKSjFl?=
 =?utf-8?B?SVdhSlZSbFE4dWc5YzVWUHB4Y012TXVRUTZjbGJocmtsbm4wQ3FHMXlNWEdu?=
 =?utf-8?B?elo2SmxubnFGazFWaWl2L1BaZVRLNmlLOFN4dmtqaUU4Q1Vkb1JyWnpLWTdu?=
 =?utf-8?B?R3o0NkNvRkhtSjhVTjFFSktRSkNCdElPSHZUTlVuVVVmU1dudzBRS0xMRElK?=
 =?utf-8?B?ZEIzUjFyczAvQ3d6a2JaQ3owZnBzUzBaT1hscHV0NXpuK3ZZMTZVc0hUSkFw?=
 =?utf-8?B?anp5Qk8xNCtXYlZRblBwNFYyVnVCaFFlZGhuUzZZYXR5N2k5TCt4WEJ0QTkr?=
 =?utf-8?B?dzBycDZueGhTVFR1TkU2aWxVK2c4VEJPbm5sQnNROVovOUxkY1Y1czFNOTBn?=
 =?utf-8?B?NjNyMlFzb2FGTHc4b1NoeTA1dkxTaFNON3VRVVFDbEtpMWZaNmNjMkNPWkto?=
 =?utf-8?B?bU9ES2NYdWlFRXpkR0RoZnduL0N4SG5tQm1HV05NeWVVZVFDTm1HMTNJQnFL?=
 =?utf-8?B?dWliTDZVc3RkTFliMmVYeFVvUzZiV012L1lPZXorRzUya1RJUzk2VDV5dE5r?=
 =?utf-8?B?NHBCQnJ0clhaVndVZ2x4dVZiTkNiSExOSWo0a28vdkVHSW5lRUlGeG1takdP?=
 =?utf-8?B?RCtIUUc1UEZPb1c3YlhZbHBYMlZGWHFOYnBxdk1RMGNDM2lObnE3MytLakVJ?=
 =?utf-8?B?U1U4VTBkRGdpWXhOQ3BRTk5wSlBWRzQ5WFNJeWdrdmdHdnZqRTgvL2RDZ1Mv?=
 =?utf-8?B?a2xCclY2SEM1bFZ6YTBSZ0NNajZWeHl0bEd2dzZHWS84enk2ckF0RVN3bWxx?=
 =?utf-8?B?NHUvc25wV2FWRmJOdVFNbXQ3UlFqajRpNHNidmlSaWMrdUl6YlFMY1lYTUk1?=
 =?utf-8?B?M0tZSmpseGl5Y0JXZXRDaVhPV2s0L2gzekNRYTdXaDViWDkwUFdNQ3d3SThn?=
 =?utf-8?B?RXZ2QXJMeXo1aWFneklKdDkvZldsRk45MmZjVHR0NDZxY1BwRE54ME4wYTEx?=
 =?utf-8?B?NG43ZWtnVnlGZGpYaG1HSDh1T1loSTlqWG1TVUNMejlnMWg5VlczUnZkZThj?=
 =?utf-8?B?RlZhbWN3NFczZUtMSjZJOHcwME9nd3ZNUmxaU2ZkOTBrQ0pZUDQyUjRJMC9O?=
 =?utf-8?B?VE9Bd1g4dDlLRXc0TlpJeGVIc2pVU0hmYVhnNUY3WGxFQU5jMW9hSXJ0NnZq?=
 =?utf-8?B?Zi9YbVNoWnVUNkJWM3c3YW1EbDcrVHpoZk45dzQyc0pRWHVXNG1VRG1wd1ZE?=
 =?utf-8?B?QlpZTUdMTHJ0eURuQldFNkExQWd6L00zdkhFeDRYeUJRTmYraVNxYjVUTUJK?=
 =?utf-8?B?QXdPQ01iU1dqenVTdUZNVW54ZkRTSGhUZzEzeGRlaHBZVzFwUVFEOVloUUhL?=
 =?utf-8?B?TVFSOGRJN2NmVGFMcmlxMlVwaytTSmFsTkNYeUhnSjl6ai96RnMwTVpHeGhL?=
 =?utf-8?B?dVFsY3ZPTnpSL2RkeUYxYng5L1JqelU3RVpQYkVxeUlZaWRYbVdHRmltZkJ2?=
 =?utf-8?Q?4bdJRhAbORkUaPkw9c5VivgqpO1nifDBY9GeE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWZFMTVxaGxzT3lpd0Foc2kwaFU0dkJQenltWEFrRDQ5ZmJPbE10d09nSk8z?=
 =?utf-8?B?QWpaVUl4YmxCVnVSQytWVDZhb1RsdFFRYzdzUHEvS1gxOTdMNCt0UlJhcDJp?=
 =?utf-8?B?djRMSUgxOWFBTTE5NmdmVDBUYmIwYlR5dnIxOGR3eUxuTUU2NTZUUFF2aEhh?=
 =?utf-8?B?YmY3VXZlTC80VitxV0VSUGxaV2dVeitHV1JxMC8va0ZiY0w3L0l4aXZNQUF2?=
 =?utf-8?B?akN5RWRJbzhOOTNpWEpzVUx1aUxVekgxbUo0SytWaDc5dFlrbHJGSHhuY0Mr?=
 =?utf-8?B?VXEyaUJubVBVOGVkSlJkV3FiMmxSTEJvMEc1c2QydkR6UGxIeDZ5M3hxKys3?=
 =?utf-8?B?TU5ySmd5am9KWkcwZUc3UG9SanFKQnhGZ044VnQ3VmNKYUZKTlZ6UGhUN09M?=
 =?utf-8?B?dGRSTWU3TGJhZVY1T1REQ0Q5QzNJOEJ0NTRqSkE3NGkyUVdnYWpSTy9ESENx?=
 =?utf-8?B?bkpjeGNycmp2T0ppRkRsaHJyWUJyRUkvektwNC83KzYzN2k4YjR1Y2haSGdn?=
 =?utf-8?B?dzZwbXJhSitkRC9uZFBWVlZLSDREb25lSXdPQ0pXMTBabi94ZDk1dVQ1bTlh?=
 =?utf-8?B?bXg5ZTBFeWRlWkVMcTdlSjRTaVplSUttVENpSHF6Y1F6VUhYZUNsem0zOHBi?=
 =?utf-8?B?SVVBb1B0eDk4aEU4dkdSb1NFeGU5bi9VMVlBNGRJVTJKa1dhS084bUgyRVds?=
 =?utf-8?B?L0R5bnZGVkk2Sm9rbjhSSVNEcG1wQXZ6Wld2bDFMaHpNUEZmYW5yZ0NvclJQ?=
 =?utf-8?B?NCt0MGhvNjBzWmlxNGNSR0xoNXdWVldHblpxSUxPZkZpdlNhbE1zcFVwRm9s?=
 =?utf-8?B?RThwYmtST2IrMVZrTHdUYi9ZcVZyRklPMlErQ212SnlxdWhYS2xWZ29WbGxR?=
 =?utf-8?B?bFQ2b3htYmROZmxzNURvcDA4cWcwcldpSjJSNTBTbktES3BVdWtrYXg4RzRI?=
 =?utf-8?B?UXR0eG90cUI5ak9lMEVhbEtnZ2ExbGkrTFlIZWI4MUFXMFVhdEdoSGgwc1Mz?=
 =?utf-8?B?R25qNS9YSytWWWIwTm1oL3RESUw5OEpoU1ErUXpmVTRrVk5NWnBMWEl2bENC?=
 =?utf-8?B?MUQ4NTlVSEFEeFlya28vQ1BFenNnWFZUd2VVQ0h6NTdTb3gxNTVCalg4MGxM?=
 =?utf-8?B?dW1pRGM5Q0RNYlhUWmxCSWFtV0UyVmw3YmxhQ2NtMmYyOG1NSVppb204OElG?=
 =?utf-8?B?VUIyMW83NmpQckQ3NklzcC9Qc2JIMHhUdlZHbG53anRPQ0tzSHc2c1dZNFZr?=
 =?utf-8?B?bWdNQ2ZXaGdiUWl5a2psZ0dzSGNkQmR3dERYN1B2RkJlb2tlQUQrajVJSEpZ?=
 =?utf-8?B?NHppaG1rL09qdU1HNGVXclNzN0tFaGJyaEUyZDAyS2lTRlZOZlR1L2x5TmRF?=
 =?utf-8?B?VGtNakhSV2VYRmtJSmxac1NjaFJlU2Q1c05SMG5xcytnQ3pFNUVvbVZ6d2dB?=
 =?utf-8?B?YTdXYWZ2SW5udU95RDhlVDc5dzdRcTkvWlZoNEF3VTc2NWVraVkraXd0Tmh5?=
 =?utf-8?B?d2xYT3BsVHpSVFo4bVFDalZoL3huKzBxSFFKVWw3b1R6QjZuYytOTGV4VnJl?=
 =?utf-8?B?bnpxR3RzTTEvdlpBem44cEhxZTlhWWJZdmdPYVJHZ3JWUmppclZqTmxyeXI0?=
 =?utf-8?B?VkF3cG13T2grcEEyM3hDcmVvV01NcVJBVFBZY3FUMGJNaytuY3J3Y1B3aldJ?=
 =?utf-8?B?S3IxMUQ1a0oyT2NNWU9vMnFWaVhVS3ArN1FaUHpCd1l1Q20rT0Ewd2FHcTRL?=
 =?utf-8?B?YndzVlJ2bm1xZlA5NDM3d3NXVHIzUVd5SloxdllUR1BuWHJMOTRrY3krakk0?=
 =?utf-8?B?WHpjdU5rYjFhV2kzd3YwVEQ3NS9VVXdHcCtCYVI2ckZLZmZSakFrQ2xQcERF?=
 =?utf-8?B?RVlkd1BiN3dvRmI3MUR0OHBycFBSQUVFUTVUR0lIWVBEY1JWbnc4UFpZRExF?=
 =?utf-8?B?ZFQxU2hwZXpJTEQ3TXJGUXlUNVN1ZmtvMWI5YnZlRExSRFRYdnIxY0o0R3hm?=
 =?utf-8?B?QnRFaG40eitFcnB6bWZHN2xIeWlQUzVhclFzMWNzeFRIMlhsOWV2Wkx0MVVT?=
 =?utf-8?B?WE5MNXlvdGd2aXdhRkRpWWp2OVJDVnhyYmU1clEvYVhVSzRBTC83VWRlbGdP?=
 =?utf-8?Q?TmfYIED215bweKXfCp6mqrXv/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecc51ff-41c7-4431-29ca-08dcea09e5d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:32:21.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8223AXzy8ZNfxYC4tgebjTU7tWrq3C6iRXMi7JjL1FTJ3E6suRmcNJvdXXgz2ikEi6XDl9h/GSceJt1H3EGAww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7360

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


