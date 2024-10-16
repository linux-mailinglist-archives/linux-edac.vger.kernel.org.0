Return-Path: <linux-edac+bounces-2110-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5CA9A13FC
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 22:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849DEB21192
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 20:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D625215F5B;
	Wed, 16 Oct 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P+YzUHRR"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D122215026;
	Wed, 16 Oct 2024 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110696; cv=fail; b=CR2++Njwx6iZj9PvUeh97jC1ztxNYbvUES7PfxkssLLmuH4SGOKhHjQcpgc3nOPNLjpiyFdhKk9NpeWVY00Kyc9D7/zVK5BnIWiCj5+WMlLP9cnavhR6G0qbc2TCxjZXqcYhv2zXF9+q+nCHgN3P5Lh5+12L7etV1/mmfR2g7II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110696; c=relaxed/simple;
	bh=YCIIq8J+8TqEAT9OpjtLx2fIEzkseMz+YPQVWsl21XI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=gBXUKBlswZahxLKIuIR1jebgtZnyc/jxom1ofcLmPGzGWs592HAy3160OHD9BnXo2TE5PSvs+PMY9F9yxram33Pu+Esg6Rn+hbVfqTAuv+nooeFoYjL1caMjIOfItwrxkNHIIlmtJUqxskjsyR7Qpis/+5PAw3lfyHngZ1h+NMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P+YzUHRR; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uz7VpuHYCgRirVePzaIMc/gS3jQLEO0pwR6OxhZ092lvSkCEB+hnVopmiDuCo0ELxL0Pkw++cqfoGbdBTTx4fE+jfpc0CbkiZ6b6IssCehnSzXYI6KpkmUk5nyQBVrzVHDEar8ycAqrw+xZPv89dZoAa1ou3Q/H5ZysBM6i0VeEkTlezAOPGMET5Opi0SxHNUbQuNIoSfi0PygTapMVHG8AZMEedWyk1BL5pTi9ttit66rlta00Z4xpV3rzYknIqXQ1gJUtPlzp8tISkyCKAGjWJ5sMUitwQZGXny4/I9BxXO2cs2e/PIzC1GsvAyEB9AhEHJYjsGT8OggLMq6yhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxCH2VEEwY3y6wn13hgFeIJFM1trJLXEda2XAeWJsRo=;
 b=Hid/YvlsPXike1kP4TlViYp0dSUXhzz9drFyeMp3Xav0L5vQVGPy+7YFVMpw/JtNUimUGNlwmU7dDz1uyvjDsF+RKM1OPMi3uQMEld/LRy0pYCX954/gvRf1DG7lEmfaUhp1uqyO9VgYDQMWZQXRpH8wsfP4UhqlKTdsePWaofWQEDgkOTQYLk84YKEs85oxp/idiP3as8R446cogPzOB52yQBjf7NPF6VnaS4U4L6iLw9kPmOhyJWTYKvm6tMQZpJKEekcrjroURBIFVsyThEjCXjYy4LZVog3q9amn+cwtodhu7ZEbOfW/N0VNhkq0RBk6LIA0SIDZgXvRHexriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxCH2VEEwY3y6wn13hgFeIJFM1trJLXEda2XAeWJsRo=;
 b=P+YzUHRRFTi0GavGQzeAZ/DX5p0larzlDjjP/uTiGD7yzwz1MjccRSz1vLx94mSWDfxvLkZ766tDDLotNr/necaXUttxUw3z8VWAQPf0nCy7VqdfpdoNLGR21D2Nnd8MwtCGe2lHI3bPOCSwY8Oou7Ju411nY5Cyc94VLkTVdnZfLJ5QupSF2aUzQstXM5hTfk9kxqIj/4e8Uje8nQDkT7Q5FmIIQqDl7OgyGqXoo3/k4GEFeWuC0hz0OEuq1fHcDnqlaNK7UxRP1/sOkpbyW1Trdgya/iT5TImVeobKBemTOyUD0rwEqJse417OdMDecTNN3auYuyEx9KowyyHAgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9845.eurprd04.prod.outlook.com (2603:10a6:10:4d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 20:31:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 20:31:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/6] EDAC/fsl-ddr: Add imx9 support
Date: Wed, 16 Oct 2024 16:31:08 -0400
Message-Id: <20241016-imx95_edac-v3-0-86ae6fc2756a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIwiEGcC/1WMQQ6CMBAAv0J6tma3FKSe/IcxBsoqe4CS1jQYw
 t8tJBo8ziQzswjkmYI4Z7PwFDmwGxLkh0zYrh6eJLlNLBQoDSfQkvvJFHdqaysVGEtWQaV1KVI
 wenrwtM2ut8Qdh5fz7+0dcbXfjdlvIkqQORmLurTYAF6GaTxa14t1EtUvRED8C1UKk2vKShkwx
 S5cluUDEVh+ndsAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729110683; l=1721;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YCIIq8J+8TqEAT9OpjtLx2fIEzkseMz+YPQVWsl21XI=;
 b=IOkNcGUPncxz6IvTKRviYkknyF9AA8SbLMsjcLiqn8euXKoRpeY7zXUV3D7YiteBvQPESftjX
 NvSaNSadM7PD7GbX+R0rjIapRFSoaf9j8l8TeH4mFJbbMF20AjH6uE5
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9845:EE_
X-MS-Office365-Filtering-Correlation-Id: acf56a47-0434-427c-309a-08dcee21841e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGVTdXB5Ti9ZdHlKU2RBc21iUmpkNklJeWhnM1NpeWpWUFFYTFcxK0oxMmhK?=
 =?utf-8?B?cUw3MUZORUVkRDN1NEVMUEg1cm9IWk04YnpsYkprM1p5Ull6MXIwQS9HZmJr?=
 =?utf-8?B?N25maU5wc2JqdE9tV1VOaEV5aWIzRTFvbVl6dGlkVUZGMUtvNGhLdENpVndW?=
 =?utf-8?B?andvN0hIN0YrOUNXYndhWGxCYlRmY1FoVW1XRUZtZ3JhZGNuOVdITHNkK2Jk?=
 =?utf-8?B?RlZWQzI5OTdXcy85YVRhb3d0bDdFMzJESXpXek16U2l2UlRmNlhKeGZRdzlu?=
 =?utf-8?B?TEd0dk8zVkViNnlSSW05R2tZTWN6bWJuTXM1Q0FtcFAxejRUZEQ3cGdqQ0NU?=
 =?utf-8?B?dDIrbEZuSlpuVVVnZGxObmlIRzBrSzF4SlkxYUdxa3pVNlk5d09zQmR3NkxB?=
 =?utf-8?B?UXdueUZlc0k3R3phcU9OUTJjMUE1dUFBVlNMWWhhRk5hY0tVdFpMN1JqUkFq?=
 =?utf-8?B?K0RJSWIrN2JXR1RPeDEvZC8xMmtvS3lVSkVVek01QUJwTXdGWG9XdGZlUTRD?=
 =?utf-8?B?S1ZwYTZNWlpXampHVERHWjVOL0dQd0RqREpWOVpSZ05xdXYxWXdGZGR1UmNH?=
 =?utf-8?B?TjNBdXNwa21IaE5VMXFxZTVPVHRVTTREVlZzT05IYlpqR2JnWGt4enNxbUpo?=
 =?utf-8?B?YWFvSUx2ZU14bk5ZeE9vQ1ZtR0RZWFg0c0VBR1pxTTJGbTFZa3ZBemNpRVkx?=
 =?utf-8?B?ZG5MZmp3N3VldE1CUHhvbDNiUVQ2enpnb2E2MHpQS0dEK0FKRU9hQURZRU5E?=
 =?utf-8?B?SEdNazZUR1ZTcHg4SVMyQmk1UTFoWHJ6QXdXOTRXU0hwblhPblg5V2pEd28r?=
 =?utf-8?B?WUhEZGtKTjlqUUlodVVVM29xZGtmWEFJanc5aXd4THJTVDRrQ20zREZua2xZ?=
 =?utf-8?B?MlJKL2FaWHZ1UUhZMzhqem93dmJNc2ljMVlnbkF0cFJvd2RoYWtQM25vSk9S?=
 =?utf-8?B?R0duLzdMSE4ydlpucXg3SVBNNW5hY0RVaEpwQkEzN1kwVG9GckFrUTZ6b3NI?=
 =?utf-8?B?VDRKRGlPeXBFVlBzY2xUYmp1RnA3TTNnZlNwczcrbFdSdUd5Y2k1L3p4SjFL?=
 =?utf-8?B?OC9MMlZ2bGpnT041cWpXOWc3UmJxNGc5b2pFNXpTdUE5d2huL0dGTWltalFz?=
 =?utf-8?B?MWlJUFpmTmxhN3M1ZlhUcGdEb2tmV2w3THU0M3F2WVN5Z2VOalh3clAvYkY4?=
 =?utf-8?B?Vi92UitYakpSZmtYRjNHOTZhVzBXaXlxMEJEUHY3NVRZNHFGaTR0ZjhqNGJq?=
 =?utf-8?B?UEprMTZMb09uUGFGcGhGaHZodU95K2Fkay9JVkp2c0cySmxoWlJ1b0Fmb2V4?=
 =?utf-8?B?QzdvaEhIaThlRVRYZXI2L1FwTk5YKzJkZVZkS1pmTzZtRVNpemZ4U2VrMTg4?=
 =?utf-8?B?WFNkNVV4anNDNWV2SU5ISjZVaXpHaURaVm9sL0NRY1JBQURzNXEzZ1RGbkFr?=
 =?utf-8?B?Tm1GbGtCcTBiU01UckJHMkpuNU1lTWhmOVF4a3JwSUUvem1MUDc3aGhSQjBL?=
 =?utf-8?B?RGwvTit0UFdKT0szRWNJTjR5WTNTRFVlc0xvbkl6NGJzeThnVG1QTDhQaklh?=
 =?utf-8?B?S2VDUmovek53dWdFdGo0WjhnSk5Sb1BQY0NYUmJPQlpmTFRLZmZGQmFMZHgv?=
 =?utf-8?B?U3JCdHIrQmZwbnNlZXVsbUVIeVlMTDdWdi9WY2h5TVNJWEx3djJTRFBwekJV?=
 =?utf-8?B?S1Nxa2Izam52MEorQ0tzNkljWFgySi8zQUYrNUE1UlBYdGxma0VCNnBwU05G?=
 =?utf-8?B?amxFZjFoaEV3UjliZWd2bkNJblBFblBmTTQxQXc1N0xUNnhmY2N1VnpkejNv?=
 =?utf-8?B?RVpMeWo2dFF1YXVPTWdKaThZMlNwVHNJcDN6anpMa0tUS2ZESkRzUmdWaGFm?=
 =?utf-8?Q?7/AJZfGY1Xyox?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWdEczlKeHJvS01QTXRvZVBlVFhwRjlDZWZhb2J2R0JpWlJNMVR2Ny9uWGZh?=
 =?utf-8?B?RUV5bXpmdzlCRmZTYmpTblh3RzE2ZElzbnE1clBsQWEwZlRER2pkTzlaL1ds?=
 =?utf-8?B?a3RYSzJ6bnUyeHk3N0d0UnUvS3RkNlZDNXlFZmFKczZMQVNreGgwbW9WWVJK?=
 =?utf-8?B?eU1iSERheEo5cThMNC9PeW0zV0xMMDdCdU1mRjMwbUhiRXRFR2tLUVpNYVI2?=
 =?utf-8?B?K0pkVk8za0I1V1JFUDYrU1kyOUM2a002aXR1SFNzTlYwSUc0RXhsVmJ6Vndn?=
 =?utf-8?B?bWV5L0VTUWppNG8vSEk4MVhOeVc1bzBQaUxva3RHOGY2K1hnemIwdnFwVk11?=
 =?utf-8?B?NzY4N1dmYVpqcFZzbU9LQTdXcTByNVZRY3ZHYy9kWUtYbGRVVGhHS0lEMDRr?=
 =?utf-8?B?Tm0ySTloZHBQMWlWbWI3bTdlNnpQMGZVMUd3R2gvQUFCQ2Y4V0xSUUJlWnVU?=
 =?utf-8?B?d1BUUjA2dUR0OE96U05MaWtza3dlWm9oVTBLSGNXWFFnQXlxZFJkZllIN1Ns?=
 =?utf-8?B?TmJKS2tSSXc4N0RxdmhQUkV0b1ZNWXRnSnlVem9HMis2MFBjYWVBUlJpTXVG?=
 =?utf-8?B?VHQ5K3B5cDdGRjlXaDhrZVN5MWZKODgrdUx3REE4S0NDZ0RKdGxSbWpIeE1t?=
 =?utf-8?B?TURIK3Q4UCtnKzN1OGROT0kyelE3dXl5RTM2RjVtQzZLV01BNDhGYWlCc2xo?=
 =?utf-8?B?VEcxZ1B2TEVaNnRsZnIxR1dUUWhSVXlOVW5PbUUyQzJ5U3hZRWFIQS9EdDU5?=
 =?utf-8?B?bktiZnJYc1V1ZkR6S21NQmxNQUpZbFpKb1BXVEVISUtCcDJScXUzV2NRekU5?=
 =?utf-8?B?dWxVV250M0dBalJCZXBrVllzbFdtK21Rc2FuNXh6ZnFqRWNZNU9uaTRmbGh0?=
 =?utf-8?B?aXlleGhCcGNGdjFkeUlWdDVzVzU0dVkzVU1JMlM3T0VmdENTMXpENG5tZlhM?=
 =?utf-8?B?Q1dFU1dibFZPVVdTZXdMTWEvYTdCUXZSMjRGTHhwMzJvbjVVVnY4aTNYZDM2?=
 =?utf-8?B?MUlGWU5kTko4TXFRb3lnWkczcFVWOUVMV1B5b04xZU1Ja1ozVjdkZCtIbXFE?=
 =?utf-8?B?VmpoOVZzK0treDJWaXllQytzVWcyOFh5WmlFQlVJemFEOE4zS2tHdldtNlBW?=
 =?utf-8?B?a2o1N1FVR0hmSStZb3VxNmlzUFJtK3l4QU5BUjQ4a0VUWHNHSG1kbDIrbG5x?=
 =?utf-8?B?OGN6QVBhRkZlT0cveTM2ZUFHZXlNNHRVYnRpK0NFRWZEL2pEdnZEOGdDNlk3?=
 =?utf-8?B?eVlQczJLTU0xK2lqK25YN092QnltV1loTUtBdmd6VlhHcWlJTzg5dEdEQm05?=
 =?utf-8?B?TDBBN0VWSFMyWEhiMkNOU0t5RUxaTHZLcFBFRytjM2pIMVhSc25ZbFZzWFR3?=
 =?utf-8?B?b04zMDZENzMyeXZvUzUyeXBaM0p3TjhhUHpWUUhYTkcvUEdaWnlEYzM0dTZU?=
 =?utf-8?B?dEY1bnNsanFueXJwSVZONHdyczBuNGdoK3N2VTVGYXZDR0Z6Y01FTEQ3WTNX?=
 =?utf-8?B?UUJ0NlZ0WmtFRkl5VVRGYnQ4Yk1EaU43TjR6M1U3SzRDVmRZOXZOb2MvSytW?=
 =?utf-8?B?S2hISnRTQ1NxYkRWc29zUTVBbjZsS3phV1Q0d3BxNmRQMDI5UXU0YTZlVUEy?=
 =?utf-8?B?SHAzT3lqaWdhTTkwL25wZVVpQm5sUGhNOUsxRmdkT3VpNGpqYkwvbUMzVUFT?=
 =?utf-8?B?RUVVbkFJZGE0Z1hRTFB4VUlTMGxsSXdqMG5FQ2hKVW9lbjhaYXB1N2VTUzhx?=
 =?utf-8?B?QmF4S0hqWWFuNHBQOTNhNzk1Sm9XT0JHSUpMWkswRkxQbUMxUFdGaG1BZS9O?=
 =?utf-8?B?cFZ0ZDU1MVBRMjBCRWFHTU1CSlMzN21uSTVMZUU0dGdCSmMrOStjN1lld2U2?=
 =?utf-8?B?emMzYWNIaHYvYUNrMlBwaWRqdWM1VSt3ejMwNXJrYURObWpIaHVOWjBObzVH?=
 =?utf-8?B?MzltZnMvQTI2WWFrRnY3bnRoVGszNEdudlFwaHZ0REJpaUxmaDQ5Wm04YVV2?=
 =?utf-8?B?eVVkVTlIdGJYL1BmYzVjYzBraG0zYlBqdjBQNVZsQnEzc0s3WE5OdlllMDEv?=
 =?utf-8?B?dlh2ekN6Z2dVSk5MYU5EMVBrYk9XQ1VzVW5xeW9RUlI5b0ZZQ0NCTkhNN21i?=
 =?utf-8?Q?BGW4AOZTLAmCXEau4pkB9i18p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf56a47-0434-427c-309a-08dcee21841e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 20:31:29.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwuRHOoltfs2baGMM2vYUC1R60moP7DvjeJHGQjJ3rn9ntjTke4/R9iQcGwcHjAlN2vy0hnS3qbzBJCNc0NbSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9845

Add imx9 support for fsl-ddr.

Patch 1-2 is prepare patch, no function chagne
Patch 3 is small fix for bit shift
Patch 4 is dt binding patch.
Patch 5 is driver change to support imx9
Patch 6 is imx93 dts change

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- Rebase to edac-for-next https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/
- Use u64 to simplify fix for bad bit shift operations
- Link to v2: https://lore.kernel.org/r/20241011-imx95_edac-v2-0-011b68290951@nxp.com

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
 drivers/edac/fsl_ddr_edac.c                        | 132 ++++++++++++++-------
 drivers/edac/fsl_ddr_edac.h                        |  13 ++
 drivers/edac/layerscape_edac.c                     |   1 +
 5 files changed, 140 insertions(+), 45 deletions(-)
---
base-commit: 0be9f1af39022beac76771eeac08256076f6b221
change-id: 20240704-imx95_edac-209cec208446

Best regards,
---
Frank Li <Frank.Li@nxp.com>


