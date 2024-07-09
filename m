Return-Path: <linux-edac+bounces-1476-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8A392C46F
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 22:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2261F28366C
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 20:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6B7182A59;
	Tue,  9 Jul 2024 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eEJgz9pQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47716185617;
	Tue,  9 Jul 2024 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556618; cv=fail; b=OZkS2itexhFoO6ITHYnZg6HsLt0t9B9t8BVZawgMyAhNfkc5WkIk/303puUsZ3IMOLRKSxeq+6lJ/oixjtD43WEDhGf06zAfBhpz9Bgn5+9qo/aJwNmdzJjenU4UUIEXu6TrLtz8dy6BCTU8H1X6jwBLffOch+VAYEkG3OsDvuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556618; c=relaxed/simple;
	bh=UpONqte5r5Hx1nNN0JjvCuZqCq5lGesddoh8PgZv3uY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UoNDDLdlChrA5RM4hEvzxZ1W2dAkjMB+fHT/pw4nzJcMDKxoePeWATxNFPdDReO7XITxG4xj7Oa9Xk19sWYixYQ3HyP8NxLNHwWgR1kYUY+SmOH8pt/BbIGwtPsRfYBhvWyHQpgxwoiMB7bd9Z6ocYDMrICnLbgV/HJ0iHCOcbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eEJgz9pQ; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFlpWOeg4ThsxuD98daI2fwHnJMuuHMkV23ILR0qJ5zAqmyIevW3CcXPSZlSkixFdntdUvUM5YkrZIjCQSXuGLvoiB6r0R2+VrIFiSIMag/kc0uw+9rPaLllibNQYRCGRhZhXQINWn57tlbBXpVc1HpfDScHpDsF4VL74AhsYLF4NgDPT92oICLPVqqGVms+rVbBaYcNluBOyMJGeztJ1SiClIR6jTRYKonDnUYHARA6NnL47OLysnh0nhgLOso2EjJknLQvxrIQ681YLDnJkOQVWzQlJoksWhUeasx/OiqwAWh0tHuIK4mDc1zENvoKiNt4FWjFBter/m7Iw8uPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtQ3uJl8YmG6bKL+/+LLKJQTXQhg9Sbo8MTtwpVypTo=;
 b=lTTaP+IylBnxTqK6rSVh4wWgPP4B+CO9+O2+/k0VwHb1mS9GB5BNDyC4XsNLdz0fn2r7hCxYT4PVmvGVNLrEAzjUzr8cFhLbZEVzSsl6BYeke6PLYCBukkEIuL4+vg6EWP6CwrCKFvT9chdYIni20/8fFhqLqU1tHlxhfOcyMXKsy56n151T72lZSoIDPuV0PbAId4uut3HFtQlbd3zmmZGNksRNQHmVg/fDwDNSm25eaBXr6kfV32X1ueivRHHWFVY6UH1eGem4qLVcHIcluAbxwaIhhRziMxmm7cIy5B4k4RJRz0WrkRTvLlvgJ/itmls6qrYt+j+dn+B6dKkmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtQ3uJl8YmG6bKL+/+LLKJQTXQhg9Sbo8MTtwpVypTo=;
 b=eEJgz9pQKLNHpqHfuZPr5gLJU6ks+SABvW2/+UlEz17HLkYhGd5mIAw6O1B5+qnnP2nGltcx6YbhHmSEphS6cUVzDLG5c/1hC3lmIFR/QfXVxsHOBN44DmGb4UVTqRUqHXXPX8MTCtSrDZnj6jwzr4M6ZeAkFSIvVUHMTvAMUro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8267.eurprd04.prod.outlook.com (2603:10a6:10:24b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 20:23:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 20:23:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 09 Jul 2024 16:23:02 -0400
Subject: [PATCH 1/6] EDAC: fsl_ddr: Pass down fsl_mc_pdata in ddr_in32()
 and ddr_out32()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-imx95_edac-v1-1-3e9c146c1b01@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720556601; l=8040;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UpONqte5r5Hx1nNN0JjvCuZqCq5lGesddoh8PgZv3uY=;
 b=V5ZiyLvLjkvpDmrLpJjydLkxqGPR/+inkeTzXlPL4kvbNQvJpz88JEjfpoZ6Ziig67dxwb9LR
 hsXNOtjKJ4eCYHypgAbk+o+tAv5Jc1JRpN5YVdar8tVwweimd0LbrG0
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
X-MS-Office365-Filtering-Correlation-Id: 61049fa5-fbb5-49d6-5efe-08dca0550099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eldHUnVQZ0poNThURjgyRnQ4OWF5YjdCWDVoM1pvWE4rM1RTZHFuQkh1d0Jx?=
 =?utf-8?B?Vys5cjZhT0Zkd0cySTNTR2czcENCMzQxWks5NXgvWHZ1Znh3K0Y5WTVVbCtp?=
 =?utf-8?B?NEV4aVU4cktIRzVHeWNqR1prNmQvWml3TFNmUnZYOVRYSkU4M1JuUzZUWFA1?=
 =?utf-8?B?cGhBL0FnYjVKYXovMWNVdTdtZGF3TlNCRXFaVUZ4OWhlcWJ2WVhrL0pLWHFq?=
 =?utf-8?B?R1lKMjN5L1dMTGg0VnhvWmY3b0Fabk1FNStUSkU0SnJUekFqeW9vNlF6U3FZ?=
 =?utf-8?B?NldpSmpUaXNqQzNPeDg2UjdONlpmNm9vYTJqSmtNVHFWQWdHME1mbFlEeEZH?=
 =?utf-8?B?a1h2VzY2R0p6bkpreHVwam5VNzE4VU5EL1dIZE1xSDQ0SnBpazA4RFdiRFJh?=
 =?utf-8?B?NHJiYlRuNmRxKzhPWk11NXBjS1JlSlFhOG8rNDRYNUJqY2ZkSXpUMVRJbmRo?=
 =?utf-8?B?YWdQbUUwTi9SY0c1TndMYW1wKzFhTnhveFBRQW5MNDllVDBIc3FEQ3BQZlVr?=
 =?utf-8?B?c0VpcW8xc1JQOTErekViTjdQakpTRVhSNlJreU1yM3JtQlZCTHFoUHlwc0pU?=
 =?utf-8?B?bkV6TU9sdXUvYkJuV0pKcFZZQ3Q5TXJqVGFyS2ZxNGRiaGJvQ2ZJY1pnTW9l?=
 =?utf-8?B?WEYrTWsveXpZaThLQjE2WkN1eUlzMUhDaWFZbmVYUEp5Q1RHdm8rVnA3Q3Rk?=
 =?utf-8?B?YUxGQityUEtvTzhyejN2dmZtUi9NTUhvZFN0ZTAyai9oSjN1RDZzN3d4VWFt?=
 =?utf-8?B?Tms5UVFGWlU4OENmZWRvOGRBWUZGdjhhVkFuM0Y1VlQyeGhKUzFpVTlXVzZ2?=
 =?utf-8?B?VEUyYm5hRzdoRFVzRUMrQmlXSktVd1JOREFtR1lDQStmSjkrWUJZSGJ0Tzh0?=
 =?utf-8?B?OGUxUi9OUlpZNUo0L0Jxam0zWlBFc0RtL0RUb2JuN3BxY05RNm12YzJrbXJO?=
 =?utf-8?B?M3R6bEpDaFhYdW5jL3RWUENiNVcwK0xPaXdsMWxqdVliL1JwQWw0a3VNRmtv?=
 =?utf-8?B?MTVPWU5DNWZXWGJLYnB2SFZHY1NreTNTNGZMc1NTa2pBQXZ0MzJ1Mnp0Z1Bk?=
 =?utf-8?B?cFJPVUtuV01mbW5xajZRdmlzZERBNXphUnpJbVpJQ2hoSzdaZXg0bnRBZXBs?=
 =?utf-8?B?b1ZUV2hwU1V1TjBlNGhGeXlEa3ZPWlpwWkIvbThOMGRRaXIvTWZNZnAvTDgx?=
 =?utf-8?B?Zlg5Q2RMRXFLVGZpaWZJSldySVRuNGFkTlJhQm8yN0x1T2JVcHRkcFV4Zko4?=
 =?utf-8?B?Z1dPVkNOZHZHTFgycGNqbFlCdjEwbFNac251Qkp0T3o3OVJ6RFVKMkVkeVJq?=
 =?utf-8?B?QzRIOXpMMzY5Z3pQNmRpMkZFY0sxS0E5ekxEdWZXUHpvY29pdnJkVitHdnVJ?=
 =?utf-8?B?Q09GSjJWblN3N3ZkQmJkbnN4ZW5vcjl2SkNIS01tM1BnU29WT0dzbmxYR0dk?=
 =?utf-8?B?ZVdncUQrMktmNVVpWEZWdEZJU3kvZEM2UFFjM2pwNDJGaFkzdzlkRkY0VVNL?=
 =?utf-8?B?bXVvcVR1YVBOdGN1cDFkV0E0YWM0bTNQYnBBcWVIbThyV0I3SGtJdTdhRExz?=
 =?utf-8?B?S21CdXBBakR6WXlJaGlYSVNIQmZScTNhRU5JbmU0ZFdlbGo0b2tJUzRGZG1y?=
 =?utf-8?B?WlZjK2xDdWZsNjQvNlpFcWkzNFR4MXZQU3dHTlpSSEp5aEU0Vmk5aVNYTkRi?=
 =?utf-8?B?cEFHbytsYnArOWlwdzZkMkVQeTM5cW9CaS95K2EvWWN6U2t4MGRBZWpYS2hq?=
 =?utf-8?B?MVlCUlA4NU1iOExGbU93cUdqa3hjZmpYV1QxYy9EeGFlL0N3RDByOHRUVFFp?=
 =?utf-8?B?cERkMzY1SExmNXF0V25OR2hVMndpRTJ4bFpMZ1h6Y0xXSHA5V29ReTBrWlJ1?=
 =?utf-8?B?UE1QWjRLZ2RpcGE5VXh5SzYvVFdONjB5WVlDV3RhdzdyQWpqcVk5M2t3RmtE?=
 =?utf-8?Q?yD9iLWWrOg4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGFnaTN6SklhOXB3S2NiNVJFQzc4cWk4RGRNUHVGL3dUdmcyMmhsQlNURlNN?=
 =?utf-8?B?THJ6SjNMN3IxYWdrODVQVVZQdHA2NmlPRjEzdzF2OVhrc3lIVzdPeFZabkNK?=
 =?utf-8?B?SmZXSFBBenkxczlvdlNLQS82R2YzNjVUR3Mwc0xZVkhsMVovS1EyTjEzK1U2?=
 =?utf-8?B?S0ZtSDhCb2svWDBnY3psK2xPVWU1UGNCMVpXdEZkMDVxZ3A3QWJ5VHU5N2Fr?=
 =?utf-8?B?eFVyTVZ6VGxISnVsUWtpNVZGTUF3clZ1TUpnd3hGYlhpNnBueHdRMkhIdjQz?=
 =?utf-8?B?S0ZDeWhGcWdudGxkWTg2TGxaV083TDZCOStjeklTeStKNFZRakROQ1pYOTJE?=
 =?utf-8?B?aW1SeitNMG91cHQ1bElvZ2pjYzRqTStPak85d0FDQ1hIR1hUY2NLeEJGaXkx?=
 =?utf-8?B?UWVRTDNNR2QrcFBRd2JPUEpLQkd1YXZkMlBwS001a01iaGlRYXBIalR4ek1Y?=
 =?utf-8?B?T3NlRCsxaU16RlZJaXFCaTYvZ3BIanhrLzhrRWhZNDI1WmJ6MEpVUjRHdldi?=
 =?utf-8?B?aDB4ckpmQ1RXK0lOajZRcW4zeHd6OHRkajczU2JyU043V2xOYmMrVEJYYzRw?=
 =?utf-8?B?eXdLTzdCM3V5ZE42SllVS1RLOXd3M29rQ1loUEJuc1l0eWYwWSt6VFo5dnFs?=
 =?utf-8?B?Z2NDTXFLL2VadDdyWFp0NE44UFpHWGdNRld5RjdUbU9SdTY1bEtkbkpkTnBr?=
 =?utf-8?B?d0QvZDNFem5oV2xRdU1CdU11azU4Q3dxRkFMQjdmZ3NmRk9ITWIycXRqZjdm?=
 =?utf-8?B?RmEvak9kQWVucnhITVNYTXFXRmZXNXBVSGtEekVtMXkvSVVpaGNicHFoeGh0?=
 =?utf-8?B?MGNFeklWSE5DK3JQd1hkNUVWYzBPcEVIRE9memRCQU1pRnVjbkw0YWNDOXM2?=
 =?utf-8?B?YjhMcG5CMkdycG9rdkp3aTJUalliRnZZTXRjekJUQnpmR1did0JqdGJVa29Q?=
 =?utf-8?B?cHFIakpRSUxLaThTZU80cUpaM2RNdWUvWld3eTBnWG1rNFpuVHR3VDZTODl4?=
 =?utf-8?B?RlBzY1RUa2c3M2FjS0U5Zlhkc3cwWXdISGoxVVhISENDRk5aSWJzdFYwa1ll?=
 =?utf-8?B?d2g5TXJjdnI3QkVtQ0pVYVM0ZXU2aERHVGQ0OG5XdHRaRVpDRGNyWXF5cDdK?=
 =?utf-8?B?UVd3VURSck94eElNSzBqdTJYRlpFeVIwNjZ3OEZFWm1SNWJhcmVmTUFRNmhU?=
 =?utf-8?B?Z3hDMVZmSytiamp5WERiU1o2WDBKcGZVeDlKM1dvNGxUekdpRXRSRHBHcFlX?=
 =?utf-8?B?WHhpWURLNEhtYVk4ckZqYURmRkw3MWdLdVhwZzc1bnJPcGd5cFEwdmZrZGx5?=
 =?utf-8?B?TXdDOUlvZVhMbCtML05Td3diM1RuQ01jbk9IM0xDQVJIUVZFdklTWkNUdEZW?=
 =?utf-8?B?WVZyelFJcWU2c0lFTHZ4alVNQnEwS2I0STV1OFVWNTZ3SXJ5eVNuTWRxbjhH?=
 =?utf-8?B?VXovZDRGOFZ2MTFIWVJjbXlBZ3Q5dkpCb0hOM1FBejB0TWxTck5UeWx6UDlr?=
 =?utf-8?B?SmkvNSswYXBTcC9SNk45ak5GZjZIaFdtVmZMTjBNTHhRYTk5ZTBGN2x6VDJj?=
 =?utf-8?B?OVJ5R1NCWnllNVRONnVVeVJJMU1Da08rNFF6dlpla1UwTnFGWGJRMkNheUc3?=
 =?utf-8?B?cUdFYUZBUms5UkF4aWdhbzJTelFqNjQxQ1U1dmczMmN4dTg4K3RRb0J4dEdD?=
 =?utf-8?B?RE53UENXQUFpR1NBalNvL3ZBOW5ld1FJMXlhM1JDV1B4aFNkbmZNUkRXNmxV?=
 =?utf-8?B?SjljZXVRYndXd3lJQk1TdllMRW5UU043cmhRTnJ2NnVaVkRFTEUxNzk4TitC?=
 =?utf-8?B?RnMyY1lzeEtEWWR6NmNab0VqYkx2Y1VuWEVWd3BNQjAvVUpxa2gvVGhaV0FS?=
 =?utf-8?B?Wnk4TW9ZcWZYMjJyVldWa3c0WTVYZU1XUFFFNHZFeUFLQ1RtUEdsd3BNTlkw?=
 =?utf-8?B?Z3lVd3pEZGhqcUdmR3B1T1FOVlp6OHZTQVFvTmpBb3Z2bHRibHV0V2dKRHhE?=
 =?utf-8?B?UEIzeWxzQUtkZ0JsbTRjQ3MxSzNFUnBjd0dUYWdvNU5SYStDRE1IcmdFZlI5?=
 =?utf-8?B?ZS8xR3ZGZVZOK0VUYk45dVZZVWkrcU1Pb2tIeStyTHRVaDZiN1p3UW1HTi92?=
 =?utf-8?Q?5rXlnR0S1ya2St9K68dMAIFKs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61049fa5-fbb5-49d6-5efe-08dca0550099
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 20:23:32.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daMtabAcM8bGAIdmpzi0j4Oa3s1NVhyCZgo1lbcnMfRfR4KmBm6/x0lz5CbdlU8Qce50m99NaZQre6BOibtfxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8267

Pass down fsl_mc_data in help function ddr_in32() and ddr_out32() to
prepare add iMX9 support. iMX9 have a little difference register layout.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/edac/fsl_ddr_edac.c | 62 ++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index d148d262d0d4d..a7982370e2381 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -35,13 +35,17 @@ static u32 orig_ddr_err_disable;
 static u32 orig_ddr_err_sbe;
 static bool little_endian;
 
-static inline u32 ddr_in32(void __iomem *addr)
+static inline u32 ddr_in32(struct fsl_mc_pdata *pdata, unsigned int off)
 {
+	void __iomem *addr = pdata->mc_vbase + off;
+
 	return little_endian ? ioread32(addr) : ioread32be(addr);
 }
 
-static inline void ddr_out32(void __iomem *addr, u32 value)
+static inline void ddr_out32(struct fsl_mc_pdata *pdata, unsigned int off, u32 value)
 {
+	void __iomem *addr = pdata->mc_vbase + off;
+
 	if (little_endian)
 		iowrite32(value, addr);
 	else
@@ -60,7 +64,7 @@ static ssize_t fsl_mc_inject_data_hi_show(struct device *dev,
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct fsl_mc_pdata *pdata = mci->pvt_info;
 	return sprintf(data, "0x%08x",
-		       ddr_in32(pdata->mc_vbase + FSL_MC_DATA_ERR_INJECT_HI));
+		       ddr_in32(pdata, FSL_MC_DATA_ERR_INJECT_HI));
 }
 
 static ssize_t fsl_mc_inject_data_lo_show(struct device *dev,
@@ -70,7 +74,7 @@ static ssize_t fsl_mc_inject_data_lo_show(struct device *dev,
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct fsl_mc_pdata *pdata = mci->pvt_info;
 	return sprintf(data, "0x%08x",
-		       ddr_in32(pdata->mc_vbase + FSL_MC_DATA_ERR_INJECT_LO));
+		       ddr_in32(pdata, FSL_MC_DATA_ERR_INJECT_LO));
 }
 
 static ssize_t fsl_mc_inject_ctrl_show(struct device *dev,
@@ -80,7 +84,7 @@ static ssize_t fsl_mc_inject_ctrl_show(struct device *dev,
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct fsl_mc_pdata *pdata = mci->pvt_info;
 	return sprintf(data, "0x%08x",
-		       ddr_in32(pdata->mc_vbase + FSL_MC_ECC_ERR_INJECT));
+		       ddr_in32(pdata, FSL_MC_ECC_ERR_INJECT));
 }
 
 static ssize_t fsl_mc_inject_data_hi_store(struct device *dev,
@@ -97,7 +101,7 @@ static ssize_t fsl_mc_inject_data_hi_store(struct device *dev,
 		if (rc)
 			return rc;
 
-		ddr_out32(pdata->mc_vbase + FSL_MC_DATA_ERR_INJECT_HI, val);
+		ddr_out32(pdata, FSL_MC_DATA_ERR_INJECT_HI, val);
 		return count;
 	}
 	return 0;
@@ -117,7 +121,7 @@ static ssize_t fsl_mc_inject_data_lo_store(struct device *dev,
 		if (rc)
 			return rc;
 
-		ddr_out32(pdata->mc_vbase + FSL_MC_DATA_ERR_INJECT_LO, val);
+		ddr_out32(pdata, FSL_MC_DATA_ERR_INJECT_LO, val);
 		return count;
 	}
 	return 0;
@@ -137,7 +141,7 @@ static ssize_t fsl_mc_inject_ctrl_store(struct device *dev,
 		if (rc)
 			return rc;
 
-		ddr_out32(pdata->mc_vbase + FSL_MC_ECC_ERR_INJECT, val);
+		ddr_out32(pdata, FSL_MC_ECC_ERR_INJECT, val);
 		return count;
 	}
 	return 0;
@@ -286,7 +290,7 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 	int bad_data_bit;
 	int bad_ecc_bit;
 
-	err_detect = ddr_in32(pdata->mc_vbase + FSL_MC_ERR_DETECT);
+	err_detect = ddr_in32(pdata, FSL_MC_ERR_DETECT);
 	if (!err_detect)
 		return;
 
@@ -295,14 +299,14 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 
 	/* no more processing if not ECC bit errors */
 	if (!(err_detect & (DDR_EDE_SBE | DDR_EDE_MBE))) {
-		ddr_out32(pdata->mc_vbase + FSL_MC_ERR_DETECT, err_detect);
+		ddr_out32(pdata, FSL_MC_ERR_DETECT, err_detect);
 		return;
 	}
 
-	syndrome = ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_ECC);
+	syndrome = ddr_in32(pdata, FSL_MC_CAPTURE_ECC);
 
 	/* Mask off appropriate bits of syndrome based on bus width */
-	bus_width = (ddr_in32(pdata->mc_vbase + FSL_MC_DDR_SDRAM_CFG) &
+	bus_width = (ddr_in32(pdata, FSL_MC_DDR_SDRAM_CFG) &
 		     DSC_DBW_MASK) ? 32 : 64;
 	if (bus_width == 64)
 		syndrome &= 0xff;
@@ -310,8 +314,8 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 		syndrome &= 0xffff;
 
 	err_addr = make64(
-		ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_EXT_ADDRESS),
-		ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_ADDRESS));
+		ddr_in32(pdata, FSL_MC_CAPTURE_EXT_ADDRESS),
+		ddr_in32(pdata, FSL_MC_CAPTURE_ADDRESS));
 	pfn = err_addr >> PAGE_SHIFT;
 
 	for (row_index = 0; row_index < mci->nr_csrows; row_index++) {
@@ -320,8 +324,8 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 			break;
 	}
 
-	cap_high = ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_DATA_HI);
-	cap_low = ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_DATA_LO);
+	cap_high = ddr_in32(pdata, FSL_MC_CAPTURE_DATA_HI);
+	cap_low = ddr_in32(pdata, FSL_MC_CAPTURE_DATA_LO);
 
 	/*
 	 * Analyze single-bit errors on 64-bit wide buses
@@ -367,7 +371,7 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 				     row_index, 0, -1,
 				     mci->ctl_name, "");
 
-	ddr_out32(pdata->mc_vbase + FSL_MC_ERR_DETECT, err_detect);
+	ddr_out32(pdata, FSL_MC_ERR_DETECT, err_detect);
 }
 
 static irqreturn_t fsl_mc_isr(int irq, void *dev_id)
@@ -376,7 +380,7 @@ static irqreturn_t fsl_mc_isr(int irq, void *dev_id)
 	struct fsl_mc_pdata *pdata = mci->pvt_info;
 	u32 err_detect;
 
-	err_detect = ddr_in32(pdata->mc_vbase + FSL_MC_ERR_DETECT);
+	err_detect = ddr_in32(pdata, FSL_MC_ERR_DETECT);
 	if (!err_detect)
 		return IRQ_NONE;
 
@@ -396,7 +400,7 @@ static void fsl_ddr_init_csrows(struct mem_ctl_info *mci)
 	u32 cs_bnds;
 	int index;
 
-	sdram_ctl = ddr_in32(pdata->mc_vbase + FSL_MC_DDR_SDRAM_CFG);
+	sdram_ctl = ddr_in32(pdata, FSL_MC_DDR_SDRAM_CFG);
 
 	sdtype = sdram_ctl & DSC_SDTYPE_MASK;
 	if (sdram_ctl & DSC_RD_EN) {
@@ -444,7 +448,7 @@ static void fsl_ddr_init_csrows(struct mem_ctl_info *mci)
 		csrow = mci->csrows[index];
 		dimm = csrow->channels[0]->dimm;
 
-		cs_bnds = ddr_in32(pdata->mc_vbase + FSL_MC_CS_BNDS_0 +
+		cs_bnds = ddr_in32(pdata, FSL_MC_CS_BNDS_0 +
 				   (index * FSL_MC_CS_BNDS_OFS));
 
 		start = (cs_bnds & 0xffff0000) >> 16;
@@ -558,11 +562,11 @@ int fsl_mc_err_probe(struct platform_device *op)
 	fsl_ddr_init_csrows(mci);
 
 	/* store the original error disable bits */
-	orig_ddr_err_disable = ddr_in32(pdata->mc_vbase + FSL_MC_ERR_DISABLE);
-	ddr_out32(pdata->mc_vbase + FSL_MC_ERR_DISABLE, 0);
+	orig_ddr_err_disable = ddr_in32(pdata, FSL_MC_ERR_DISABLE);
+	ddr_out32(pdata, FSL_MC_ERR_DISABLE, 0);
 
 	/* clear all error bits */
-	ddr_out32(pdata->mc_vbase + FSL_MC_ERR_DETECT, ~0);
+	ddr_out32(pdata, FSL_MC_ERR_DETECT, ~0);
 
 	res = edac_mc_add_mc_with_groups(mci, fsl_ddr_dev_groups);
 	if (res) {
@@ -571,15 +575,15 @@ int fsl_mc_err_probe(struct platform_device *op)
 	}
 
 	if (edac_op_state == EDAC_OPSTATE_INT) {
-		ddr_out32(pdata->mc_vbase + FSL_MC_ERR_INT_EN,
+		ddr_out32(pdata, FSL_MC_ERR_INT_EN,
 			  DDR_EIE_MBEE | DDR_EIE_SBEE);
 
 		/* store the original error management threshold */
-		orig_ddr_err_sbe = ddr_in32(pdata->mc_vbase +
+		orig_ddr_err_sbe = ddr_in32(pdata,
 					    FSL_MC_ERR_SBE) & 0xff0000;
 
 		/* set threshold to 1 error per interrupt */
-		ddr_out32(pdata->mc_vbase + FSL_MC_ERR_SBE, 0x10000);
+		ddr_out32(pdata, FSL_MC_ERR_SBE, 0x10000);
 
 		/* register interrupts */
 		pdata->irq = platform_get_irq(op, 0);
@@ -620,12 +624,12 @@ void fsl_mc_err_remove(struct platform_device *op)
 	edac_dbg(0, "\n");
 
 	if (edac_op_state == EDAC_OPSTATE_INT) {
-		ddr_out32(pdata->mc_vbase + FSL_MC_ERR_INT_EN, 0);
+		ddr_out32(pdata, FSL_MC_ERR_INT_EN, 0);
 	}
 
-	ddr_out32(pdata->mc_vbase + FSL_MC_ERR_DISABLE,
+	ddr_out32(pdata, FSL_MC_ERR_DISABLE,
 		  orig_ddr_err_disable);
-	ddr_out32(pdata->mc_vbase + FSL_MC_ERR_SBE, orig_ddr_err_sbe);
+	ddr_out32(pdata, FSL_MC_ERR_SBE, orig_ddr_err_sbe);
 
 	edac_mc_del_mc(&op->dev);
 	edac_mc_free(mci);

-- 
2.34.1


