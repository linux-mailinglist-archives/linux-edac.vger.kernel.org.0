Return-Path: <linux-edac+bounces-2005-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D20099A7C0
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 17:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D36F1F21E31
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4547185270;
	Fri, 11 Oct 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fQhrccy5"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B519414E;
	Fri, 11 Oct 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660715; cv=fail; b=lz1ccsaDLSz2lsQO8ZaT8gHHjVunxn501N6WMf+8R97LE08ZJIpV7SKsCb8tj8ix0aQ6cn7QFyfy4QAHOUE2CF9F7zIHHXS9Swm+22LHTMPTcxxB3xlkyRP4vWMAImZia00DB446JMHFIVowD1UaQKD5U6/rslc45yJoNzIDsEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660715; c=relaxed/simple;
	bh=j9MZ4TNVoeLO9BixZfmAagJeHikAPehVHiMV1OgVW5k=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=WQ0VOrcqhOukZ/zbhPGBbpIu3erBJ9QaYNqXYGbLhf+1WO6C1H/sOeLQSU7IK2FDybHxLz5DI5hH5m+Ibhe1v50EWclB/Kd63g89SJ7DnW3GZUtCnpnghMix1cUfZeZPuiByDOHGzBFOhpC8d8m9Setm8+xwJ+LMbqGt0AETm4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fQhrccy5; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTIJVZf7mMnfcfp819SQMw+ChcOarLuJbHIjkvKgGdBFXOxZTHMChtDgjT5pPYzoKFyGTp4h6nrGHYg1lz9SBRa3EqOW1JphE909joE9gklwbQn3kaqaRK7C2Wevu0YFiRfXkDQn6Dfmh8wDxUdlMje6/FVyxF4amFeOcUjHz7w4yk15q+6oTOQPNRL6IjzMDkHqvxA3FTWYKyKX38rMF7HCPxU541mMDMFz3IGqEKVAMzf0Su0BZ0YSxltbpucj9cIxHUqKeutbSb3aWpfO2Mnsx9Br12rqQNxiMtpi3a12n1RQ54usCWxisyhvWn7d/7A+HxzyPuxjLhBAj79nJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3T3e34lLgn5+XQqRIUQPGVlhuNfAaLlSsuTKPZQIIw=;
 b=R++Kn8Xvd0Q5OikJU5geuu1rxfYPEGth6VrTWAjhDZl55BHY22N0nj8cNP7ujEkVO7bv4pYwiQ19ybctJgXDj7ul5POucy3y8msrU6nmLSLda6EUY8OTwGGad97rPqzD3wEYH7ywLwJyjT3dzgn4gce2F4X8DgvHdqAYLujHw3NoBq3NhkeFi/x/lsznGGyQcJtieY0frgm5xeIoWIihIsddQr88ebjqrBLKWikjv2t7b56ETtHIBI8j1IaOTb3C8aKYYsDq89s7Lk/07nJli6RbSQ+xQ/ti/Ako+9RJLC4bhLM6VGjxX3EAywZ1qEx2hn+FTdYMgKy0YnziSpAuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3T3e34lLgn5+XQqRIUQPGVlhuNfAaLlSsuTKPZQIIw=;
 b=fQhrccy5uZ6Y56LAoJTnK5eO4BqbOjkLxYgiFj2vqIM7JugrTFSd33+KnlPr58dQ/b5/5EBjPDr1d7FjC0+O79inxK4u76rtApj1k5GIaG83iXNGqS6IcSoo4ACjJ3Bj5jqM7KDL7trDrd1WHRuHvi9tp9vu77tONeDTwiHJb26HlYUxsUAHN8SQ0uh2G8Op9T71TkOh0LvBsWrM0aSoXNFbjZO0JdYXIlk7R1z5WSBtr31GJwSYrIVRL3Qx7EHB/Nr7njvTJL9/wEPTyGfykXrkiH9fXZzLKpsuWDn6KxGfV1L57vg8vXHFKEmU+/7ur3rquJ/qG5dHzt6j3r0Gcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7064.eurprd04.prod.outlook.com (2603:10a6:20b:118::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 15:31:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:31:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/6] EDAC/fsl-ddr: Add imx9 support
Date: Fri, 11 Oct 2024 11:31:28 -0400
Message-Id: <20241011-imx95_edac-v2-0-011b68290951@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANBECWcC/03MQQrCMBCF4auUWRuZxFhNV95DitTpaGfRpiQSI
 qV3NxYEl/+D9y0QOQhHaKoFAieJ4qcSZlcBDd30ZCV9aTBoLJ7QKhmzO96470gZdMRk8GxtDeU
 wB35I3rBrW3qQ+PLhvdlJf9cf4/6ZpBWqAzvStiZ9R32Z8rwnP0K7rusHahp1n6IAAAA=
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728660703; l=1472;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=j9MZ4TNVoeLO9BixZfmAagJeHikAPehVHiMV1OgVW5k=;
 b=Tmqci9VYLeCfWzwEaQ7T+UuJEb+Laz/5x49EvjNAUZ3ww8R/Jup3euEtgd+jrk8utm4kUm8rA
 +bXxp47557HDubDedg/eQu3ilfxp/3jfdZqCzi4iIkGr57+VZ9dHpI6
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 628d19f6-063c-485e-3496-08dcea09d31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFREbW9qZUR0WGFZNWhPbDhJaHU2WVdxKzc0NFBLTXp3dU96VmxGck5OTUtj?=
 =?utf-8?B?OFZBYktLZi9qMHR5ak5qdTNVdVZhZkJFMjZXeUF1bjdBWkk2aVFIVFlVNGFu?=
 =?utf-8?B?OEtQTU5vVm9tRkFFNEkyQk1EQzFSbldtR0FVQXlxa0EzOVdCaTdjcnRvNUVw?=
 =?utf-8?B?RE9EalFUdXQ2WEZ2L3NqMGZmQTNpU0VJK2wva3NUd1ZuSHByajdEUXBMd1Ev?=
 =?utf-8?B?eDNVd0NVeURFWU9VbnZnZEV2eXM2RXFLemVmeVNxdjdJY0lrZGFHUVpYTWxD?=
 =?utf-8?B?a1h4a2xBU1lPS2MwUnBOWGJMdWs2bnNzSlB0d3dxRnNLL3dQNjM2Tjh2elU4?=
 =?utf-8?B?RllPd1RlazZuZi9RMURTL1RpRjVwUUMvcm8xYUoxWkRYb0FpWVhPMWFvZTdC?=
 =?utf-8?B?cGErd1NZR1ZhWWlsK1VHK0xmdTFyUnA2b1gyZVV0aHdWblZ6V21NTlF5aW1V?=
 =?utf-8?B?Qk85YnphV0NZNUpRU0hFN2RneTQveGRIREhPNWlmMEd0ZkhQQWVBU3FqVmdD?=
 =?utf-8?B?Zzd6VTJBN3MzYkpQNlVlUmxXVWIwajRuR0JORmdwTjhBbDVRUkpPejYxbHc4?=
 =?utf-8?B?SFB4M2VTcXIydVl2eXpUQ1BhVFBtVTdFc0lkbXRkWUlXNnRPRUpwbDhUZW41?=
 =?utf-8?B?SkZaME5rZ0hTcmFLMHV2QzJwV24zbUhRZjNraVMxZTNmemJVcnB1S2VBOWZ0?=
 =?utf-8?B?K0tRQi9sai9WOUw2SUt2ajhiM0JLUHNESEtQNE9QcUhlSnA1UHZJZG9CclRH?=
 =?utf-8?B?a21LTHVZTVZ5MHJ3RlgwY3JKU3k5UW1oNnlrQnVvU0pMKzBnbEIvQlJMTzVO?=
 =?utf-8?B?M1RsUXlWVnIwbzZScm9wTUR4MHIvZTdGSngzVjFlbTJSdGNmYmgzSzQ5Wkdp?=
 =?utf-8?B?U1MzK0xUM2JSdkQyU0dLMUVwbDIzWDlwTE1FdnQ4VThDU0svdVRWakZpa1BQ?=
 =?utf-8?B?REV0enZ5OHErbDhZYWJ3WU9VKzM1U1BRUjZLNzcxL0xXUUhaSExjdm1kRHZk?=
 =?utf-8?B?eFVPbHpUZm85Z2l3YXNRNkJ2SlF4WDBsZExpM051dHNpR2tMTXlCblN1a0R3?=
 =?utf-8?B?UUFGb3lUVmJJLzRDQnA2Wm5ZVW9yeFRadytwamh0OHhmVCt5Q1h4eDBxbitC?=
 =?utf-8?B?dmR6ZWhmYUk4azVDSnVBZktBQWJJOE5pTlA1T1FGMmJNMFF5MWtIZG5vRXdK?=
 =?utf-8?B?S1lzTTI2RVVEbW5PN3RyY3pBSHdnajhJWEh5SVJHeXgyNzYvM2wyUklIVWYy?=
 =?utf-8?B?UDVRVTlaY3NPaGU2Q2JmSThwT2VaOXRaVHJtQlowQnhsS0ZuWlQvY2NxM3VJ?=
 =?utf-8?B?S3RoQ1BoWm9QME9IV0ljYmZVNXRWMWttYW1FRkN2STJqOGdmL0F2aFc5N1Rn?=
 =?utf-8?B?cTA2cUEyNTM3NnN3Sjg4WVlWSnh6b3BLYUV2enRoSEJYV1c5Q0pER0hLbGNw?=
 =?utf-8?B?bDJIT25EK25iRDNxTEZhZEZ4azFsREE5MmxHN3VzVE9ob2c0Y01VUTl6cnBL?=
 =?utf-8?B?b2JVaVF1NmdCeGd6QjNscVo2Y0dpSktxeE80TkFkQS8vcEdGSlJ3Snd5MHlF?=
 =?utf-8?B?SndYNHM1NmlBcFNSMVYrZGZxVjkxRWJmSWpaVjBWRnNTck53RHFKdVpHRnhK?=
 =?utf-8?B?alRJZHY2anZPd25yZFJQeTJDNFZDTWxNSkdGcVZKZHF5eGxYdjhFcHltaTdy?=
 =?utf-8?B?aTJvS0lWZ2J0RzFxZjBmVWUyajExeXJJajFpcXJCZ1BUdEUvY3hPSWpyeGgx?=
 =?utf-8?B?cDhLc09YSUdkdU1oWkd0T2x3NnlTZVRmUnN5cGprbXd5QWxZVC81QXlGOWJy?=
 =?utf-8?Q?CQyLeSgOcv6RcJ5/KvLzl0acJ4/KHmwSqxATU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGYyMm53SFMyRUV6d2dkRmFuODNGdmZxWmZ3U2IrNzBSUlNUVmdCYVZBRTdI?=
 =?utf-8?B?TXdSWHFBaGpHVlhLa21WcHZqZ0J1MmYwaWlua2djN2g3VURkMjVqdVVVSFpk?=
 =?utf-8?B?a3U4U09wdWNhR0pudjFrWUV2eEV1SVNzTHl0dTNkZThGRk1uSlhOMXcxL1V6?=
 =?utf-8?B?MTAvUXhhUVBtYlpLaUZmNmdPSk1SdWFzK1hmU1I2eUc5QzAycWt5WkNTSU0v?=
 =?utf-8?B?L09uK0QvMVJvRXp6eEJ3VjFmajZXVUNJTG5wakdWeDB5M2d1NUpCYmdaL0ln?=
 =?utf-8?B?ODU3UFJEdThBZDd2Tm1aazE4dEpVdDFjVHhGRjB2VlA0Y0s0V0c1aUFRcGtM?=
 =?utf-8?B?OU9HSS9ld2Y0Q3pWOWVlWEZRMWV6NW9ZbzRYUUlNUWU1UVhxQkdmTUR0QU5l?=
 =?utf-8?B?UWhSeXhPM21CVGltZTRsKzBWU1piZHBUQUcyQzloakx0YkVPS25vZ3ZINVBQ?=
 =?utf-8?B?UTNCK2xGOEVtMFJHQkJxaCtIZnRkRUpwTXFhWWViVHFodHNITEZGN1BBemhT?=
 =?utf-8?B?MHFTVGprMnIwNmpuaHo5dll1TUNLRXExWFF3VjB2Qnh0S3hCMHhaQ3FFU1Fa?=
 =?utf-8?B?QXJRZGtuY2dkcW1kUUpPOU5IR1kwTXl2S0xGYWNCeWlTQnU3cDByNWVSOFJt?=
 =?utf-8?B?emtpYlltVWgyNUlCaG9FVERIVjNZbzEzUkZMaGRJa04vOFN5S2hTekVNMm9E?=
 =?utf-8?B?RmdiQVJIakgwTm00ZzVlQ0ROc3RPeThxYlJlZlpnM0FjYm9nZHM0WlVkRXNi?=
 =?utf-8?B?clV4UGQ5YWJBSWdSa2ZoQnZKazlpd3JxVWdFSHpyNUtmV3k5VXdSTmUzRUpN?=
 =?utf-8?B?MjhDOHVDYjJLOUMzdXY5NElFVFhSbnhERHAxS3pKWklLc3ZwRk9xVlpWZWtH?=
 =?utf-8?B?M055TjFiQ1VwbWtpSnNmZXhCOCtOM3hyUlM1a2xhdzBpYzFPNzlTSXJPekV0?=
 =?utf-8?B?a3JDRjRvQUNmOHJwNURRZ3NSL3FEYm5SNzAwd1RsQ254Y3VwaXBWVWZqQTRs?=
 =?utf-8?B?ejVMRTFLb1FjK1lNa0F6YWo3dkpnT0h0OW51NUNyVU1iYWVRd1dBcG12aU9l?=
 =?utf-8?B?S29QNXBzOXFpRHpqM1ZxdHo3bDMrZkxWWDZRamdDenJsajAvN3hrd0ZZMUpi?=
 =?utf-8?B?Tmh2SGZ2dElKejFzaU53djJzbHNYNGk5WVVKVk5mWXZDV2p5WGgyOStuU3lF?=
 =?utf-8?B?eWdMaFVZRXVxQ25xak1VUkV1Z2tnQWM1dFhXNUpTcFFVcHVMMkpzSEpVdlRo?=
 =?utf-8?B?amJiSnU2TXdrZURUR1RuRjFJcjZ0dHozZTlnOFN1UnNwQmp6bW1DYjVFNGV4?=
 =?utf-8?B?eE5qSm1MZjNnbi9qMmFHNE9BcVV4WFE3MUppUmlPSGc4bW9qR3IrMUpDVXIx?=
 =?utf-8?B?d3FodGI4b2ppOENNQWRGekZrbXJTUVVlRHVIVkdTSUVReGg4WDRTL092b050?=
 =?utf-8?B?UnlyTG1OVHkzTnZCa1hqQ2hrWnppcTlzTkZack9DSTRvSlFteTNteDlzU3lK?=
 =?utf-8?B?SGhFNnBXaXM2UDYyQnJOK2lzRVdNMUQ4cEd6d2Z0RlJhWWJmZmw3MGswRjV1?=
 =?utf-8?B?czJ2ZSt2MkFERUZQY25ITWVsMlVaT1YxTGdGcE9tdjRhNDVqY1BveEViU0Vo?=
 =?utf-8?B?STEwQWloRmZoTFZVSDVWZmtFTnlpQmRObWpWV2ZkOFRCNDcvL0dTclQzaWRk?=
 =?utf-8?B?cmxMSnFYb3V2eFp4ZkI3M3luQ2ZxZVQ0a1drODJ3ek5HYjNoZkhkZHl2ZGhn?=
 =?utf-8?B?UE5yS3RzMElGZmxKNHdjVHl2Wm5zd0V0bXFycVk4Z0x3VTlkL1BCWVVxTThx?=
 =?utf-8?B?b3JOeWlRVDJCOFRwMmlGdHpGRlRoMHVOWTVNQlFUbkxQd3dXbjV5T0dvVXZJ?=
 =?utf-8?B?OXg3a3FVMXVjaVZNdHh3NFRLZlJtZmM2UThOUmhjcCtBbDZ6QkxaeGxkSGdE?=
 =?utf-8?B?c3pOQzdZNGhDbVduSlNEVkZqV0p2ZFNwMGxCTHpUTzlsSzFiRUdnbEt0OTdH?=
 =?utf-8?B?U3k0a1JRaUFrTE1ucFVMNDc4aHptbGVYV0xQL2FBQ0I0elpwTG9LdG9uY1Rm?=
 =?utf-8?B?OGlPbFNhYm5JNVFGY2RhazVHYTdPQ2Rhb3h0QlBqNUh5WVhuMXFwUnIwNCsr?=
 =?utf-8?Q?cTJijqI3jD+72DSWUWrh33GbF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628d19f6-063c-485e-3496-08dcea09d31f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:31:49.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhQtIPcqyeqHRHzqsTsmf8CbbQklbJbG/2gCMpbK2IJs53LBZar5PPeo+v+B0adb29HER/cr68aNClWCH2smhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7064

Add imx9 support for fsl-ddr.

Patch 1-2 is prepare patch, no function chagne
Patch 3 is small fix for bit shift
Patch 4 is dt binding patch.
Patch 5 is driver change to support imx9
Patch 6 is imx93 dts change

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- Fix first patch build error.
- Rewrite commit message with AI help.
- Add Krzysztof'r review tag for binding doc.
- Link to v1: https://lore.kernel.org/r/20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com

---
Frank Li (4):
      EDAC/fsl_ddr: Pass down fsl_mc_pdata in ddr_in32() and ddr_out32()
      EDAC/fsl_ddr: Move global variables into struct fsl_mc_pdata
      dt-bindings: memory: fsl: Add compatible string nxp,imx9-memory-controller
      arm64: dts: imx93: add ddr edac support

Priyanka Singh (1):
      EDAC/fsl_ddr: Fix bad bit shift operations

Ye Li (1):
      EDAC/fsl_ddr: Add support for i.MX9 DDR controller

 .../bindings/memory-controllers/fsl/fsl,ddr.yaml   |  31 ++++-
 arch/arm64/boot/dts/freescale/imx93.dtsi           |   8 ++
 drivers/edac/fsl_ddr_edac.c                        | 136 ++++++++++++++-------
 drivers/edac/fsl_ddr_edac.h                        |  13 ++
 drivers/edac/layerscape_edac.c                     |   1 +
 5 files changed, 142 insertions(+), 47 deletions(-)
---
base-commit: 0cca97bf23640ff68a6e8a74e9b6659fdc27f48c
change-id: 20240704-imx95_edac-209cec208446

Best regards,
---
Frank Li <Frank.Li@nxp.com>


