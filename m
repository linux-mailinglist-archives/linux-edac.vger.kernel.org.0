Return-Path: <linux-edac+bounces-2010-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5E299A7CF
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 17:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27051C208E9
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFF1199392;
	Fri, 11 Oct 2024 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aay3Dn2j"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE7319923F;
	Fri, 11 Oct 2024 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660742; cv=fail; b=rIwzIqML6RGIo96c5mOnbX0C9Ja8uqwHIY+/Tcy3u/L32LvyGfPHBbJPWQWF9Q2GzbXMk7UH3J6lhfscgxMZZsVexX7oTecWJ3GH/UO/KdrV17y+vCXwKdsDmBjls0LjvFslthsgTt1ajegKq+JgszUu8d7AxqvHVKIjfpLPzyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660742; c=relaxed/simple;
	bh=gc6MJagSfltYpYFvAf1m4jDcabhy+YaKNDc5xPAp+Ho=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=akAb3lDhq75loYMnemFRu6+fKa/99o/kqJQNuO2R9n9a3rUQyLSipZyV+RmX92djAf3kkOgQqxGIKTSdGX0Gr2qHExoVQBgV8FBrrPU64Y2VgTvXvm5dyZzQXHbp3sbducf96NLCvt6JLHzv8K9lgcJuMv444DtNUnMdO5X9RIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aay3Dn2j; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcLEpqRJuzlGlA3iCLpBg0/IxZNqCuW0pKav7l3Stly/ABlQwtEAEyMpDloOjijXVMHh/iJ1osmpBz6DGlFlKMtgZAnRGWFoz0TqC+fRY2YjWDd+tB5mW1CmEa7zSrSO4n7j+ILLOd2j+TTEGIE9TG2K3vbof9EBaGn5puOT+8kmwD5/qJuacdydUx3ofWMKDKDKOQeFjhuDomCHosrEW40T2EQ8DvySy79u8AdqI/ShzHaUnJH+GQLNE3L7yxralF1PA58EeHIuGkUVNgPjI6lai0XJFMXMfkl2iHoVkzg5cMj0zx1Z5VGveMorEefm4yHkTYnV3yA1OgxzD1k0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxG0yqWh7JOJe4yZxrUWXuSBYgE7RS5YP+66smYxrH4=;
 b=eMyA8FCBU72m1skytn6Q3jI4wxNe+qcSmh1mdni7IvGezY1rhM8CfTmHCEimZTW0VMzGFxRqn8D8/wvQLRyaDzGEGuDmL44JgLqcA2Jkork4SHGApaYuVqW4nwXvz1UpmKjtzP69b1QlG15v2j1B80Z2oTBJ7ct6RkgjVDaGkW05TpdDi01eP/MPWxd6mds2zzokiapJCJ27S/ap2gSvp25lzVV54Uz3rTGhTOcv87rktrHHjmNm0miYNhqRGMoeSxEoS6nGjt3x2Z8N2eJ/qxQwawXmIdj7Mhstv3RnPM/8UeDNfxeWv124J8L5142dTzxA2LJJZJIq4FhH4SRGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxG0yqWh7JOJe4yZxrUWXuSBYgE7RS5YP+66smYxrH4=;
 b=aay3Dn2jnbWT2/c1UmxcgJeUjgkggG6D7a0qkmO4uYWGI44lYJEqQFuyH0Wn5aj5I6Pg75IRWLT5jgtF7juC9ReRAqrAeCP4VPq74iQYJTeWLwNz9mFXNeemBaEKwfvJKu3400CGA3R+F7bNNrHQ7wKRrTHNzg1jk54zgQuxpqUhxhjdk4datZl4m+gVP+sTsfjVnR285i7+Ao8TEAuMXypARzRiCoEgP2PhToyG6AsvIhoYO+uK3y6a2t8JJs7WiC25XbzOJt8ydowEcyhTkLyq126lt95sGmIpuyJSEZWMgBQEz4QjMj6192u8liWXQx7ATMbSoupPBNPtQFRK3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7360.eurprd04.prod.outlook.com (2603:10a6:800:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Fri, 11 Oct
 2024 15:32:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:32:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 11 Oct 2024 11:31:33 -0400
Subject: [PATCH v2 5/6] EDAC/fsl_ddr: Add support for i.MX9 DDR controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-imx95_edac-v2-5-011b68290951@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728660703; l=5954;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=M8I8hajo7XY5xWGLxmn0PTrzPVpEdSTe8Q2nAI4GQg0=;
 b=7h4BJZ3mCnPCp/AD4A6vgkBR47ZLFq3MbXdu65ZwN022GV3hyVKXT7toQyBv/9i4bctjP0Ft0
 aj4V27sIwQsDXUdWxSpOFedzyS1TwYkXpKBShyGiDlE4goRrDDvTEmo
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
X-MS-Office365-Filtering-Correlation-Id: d0c13928-fb2c-4cce-5701-08dcea09e2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW5PNDZqZ0NIOUxnVkZhY3ltbmYrUllhdytUZmVPT1NjUnZ0aTRQTWhkMnNS?=
 =?utf-8?B?dTRBYlk3TFVFSGpnTmdrTmJHOUMwSGQwR1VGSlFPZk1DRlVFZTdVUE1XS2dx?=
 =?utf-8?B?OENoa2o5cDdMaUp5WVJTN1BRWHBmaHcxQ2JYYXBycGFBNjNtNkIzQkhGaDNt?=
 =?utf-8?B?UE5ka0JHdjdVRDF2dGE3WUNycXJQRG5nekx6Wit6ZndQSDhURGpoZWxZdTFC?=
 =?utf-8?B?cGxvMlAwUXdJWUFaNXNLcGw1eUFnYmQ3K3EyWHFkcHljRDVhM3ZLN2gxeXFP?=
 =?utf-8?B?cXloN0Z4WGNKR0VhNkVqUEQxSVcyVDByR2VFYUNIWU9NZDRrT0gwekMxWFNu?=
 =?utf-8?B?VEMvOU5EZGRzNFo5WmIxRm1uTDl6MHN6TnMzWFJXNjBSdGZqR01DQ1ZxbGpU?=
 =?utf-8?B?aEQ3dE55VE92YUNOaHhvNG9kbUFiakVLV1VUR1lYMmNzZXFLRmZ1WGN5U0FD?=
 =?utf-8?B?eWNxa2FvQUM2K0diNWVuY2ZkNko4SWszQTJ5UjRHSnV6YURBRHhpelJrb21p?=
 =?utf-8?B?SmR3VGhxdVFOS2ZjOC9MZWxEdUM2SUoyREN5NmltK2tGeHpvbFhPVGlrTHVL?=
 =?utf-8?B?V0hrN3liQmNFZlQxdjA4Nzczc2hZcFlNM1h2eXdxNVZsZVdPQ3lkamJ1QTAw?=
 =?utf-8?B?M2dsZWdtL0dIUXdXUEZZeGFkbE9lTEVWWSt3UXlET2EzOXArK0FJV2ttQndS?=
 =?utf-8?B?UXhaRGlnMWN4Tmh4Um1TS3djcFFtZUFhYVN0UTA4S3JXMituUzZFQStxU2Fw?=
 =?utf-8?B?SGRRbGkrcWJ0VkJKV1psenNzNGNFcmorRTcvR0Z4ZmtPSk10TUNFbFBHYmlG?=
 =?utf-8?B?MXA0UjRWTzF6SjJJNk5QOHJFdlJNS1VpUlp0bVlZK21EaGQ4aCtmVklwYlBy?=
 =?utf-8?B?ajZLYmIzZlZiamFkWllSbU5RTzAxQk5MZWlaQlFMTnFVbGZkQ1hMN1JWTkFn?=
 =?utf-8?B?TmhDbFkwTWRxRWszV1JvRW01Qm40bkhiK1RIdHlGN1FRNUE0NUxsNExSL2xD?=
 =?utf-8?B?eHBMUzBhY1RpMG1xQzBBeXNwajYvdE80eW5xTk9UZUtMRUY0d1hDTktJMVJE?=
 =?utf-8?B?NzhzTlRoak5HNFpVOHViVXR3VG5sbEdMenVWcGZlRmhlR3FTTklMYnJNaWp5?=
 =?utf-8?B?UGFabW5CNVNTWTI3c1RDYW54dEtPMTJJRy9DZkZXUjd0ZC8rdm5URmwrUkV0?=
 =?utf-8?B?YllDeDVNak9EQk1VTlBvWWFvWVM3WGtZNGIrdDF0cjBVYzlaZ3FneVVjd04z?=
 =?utf-8?B?K2oxTm05aVJyRDJTZ0prdXovVzB4NTlGa3M4MytFRjg5Y1RFL0JsOEtySDRm?=
 =?utf-8?B?TUhSYkIyVTNuakJDbG1IOHJlRy9WUDc1MW40VTVWL0RSVGM2bFZPaHBWSzlW?=
 =?utf-8?B?NU9paytvZTQzV3JVQTdDekZBVHc1QjR3aDMwdEFwYk5ESTZOVWlhUkt1NmxZ?=
 =?utf-8?B?dVFhbkJ6ZCtNZ0xvUVNCL08zL1hlTFRGZVc4UFFNcGpqMG52eW15QlZIME9j?=
 =?utf-8?B?cFVuVmZVb092M0dudFBvS1l5UXRnS1g1dFU0c3FpdzR4Q1Bjd1pTNzcwL20y?=
 =?utf-8?B?dFF6Y0Vnb1BHL3EwTWhMVVZDekR4TTRrcVFIUHNPemNDbklQczMrTzBzZ3Jr?=
 =?utf-8?B?T2FYOUZGT2V1RmhPNFE2S1VlaHdjaU5KbFBuV0hoNVJ3SXVjVnF4NHpnWHND?=
 =?utf-8?B?aGcwQlNMdUJkanVnckZXSGFEVmRWcUJOZkpsbDRXZjRjQ1YvalpUSDZhSDVF?=
 =?utf-8?B?WlZMVW44dENwRm9HUjk4MXBaUnFiZ2Z1RitGZ1NOY2pyL0FnNGNtWGZZanlB?=
 =?utf-8?Q?nBKZtZx3RMESke0E7/EMLyfMNZJNyUcJQkq9o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clJHQ2hWNEZmNjlhMGlSMzZES2RqemZGdkh2MUV0NWt1c2JYdTBwZWp4Rk0r?=
 =?utf-8?B?ampSMVlMVnRlbHlVZmpvbFR3YitwSGdJYWFQcFpMOTJXYm8vYldGR2RkN1V5?=
 =?utf-8?B?RC82SHdONTc4TkM0S3o0V2RqN3ozc05wN09ZckpIbTUyM0l4NkJJTXlUbDVK?=
 =?utf-8?B?SnhLbFhocjIrRElia3JmV285N0o3UGdzZGRnWFJUUGtqd1RTRmpTQWdkUVJ6?=
 =?utf-8?B?VmlZTjl6YW40dUQrVjZmeGI5aVYzOXVpT3J4VnBESGNzVjZLSEZGSGVvK1BC?=
 =?utf-8?B?eHFIS3lLeGM1aDZ4MXRBMklDcmxTZVIrVkxmVnJzKzRuMTRPK1hqb0d2Qk45?=
 =?utf-8?B?MFRIUkN2VWNtbjF0RHNZbnJaWTV0cU1WM3BTS2d0Q2xOd1RIM1ROekgxL2F2?=
 =?utf-8?B?aTBLanA1TzlFK080bkt3WjRoVEh6M2kwWVVTM3RMRUpWVks0V0RHaEc3NWpO?=
 =?utf-8?B?Wm0rTkJ2d3VqQ1VsbmxkUG54eHRrWUhFdSsrM2Jod0F4ZXZwd1JkTkZQZmRL?=
 =?utf-8?B?YVM5TEd3OG1oRk5lTW9YN2RNdW91RDgwaVRFcTdrTkRiaEJ4dStabTh3WVB1?=
 =?utf-8?B?Z0VkSHNWYnEzdWx0b21mZEFTZEwvM25VcUwwbzFNZGlicUl6OFUvMHI4bEtk?=
 =?utf-8?B?NWFhR2tuZHdGeE0zZU5YOTgvcGN4WEVub2pTUlZ4QlVJN010MzFwSi83TkxS?=
 =?utf-8?B?aXVBSlp6eW1sYis0SnE2T05jNFpBR2RCRkZVWnMwNzIyRjk2NHFUMUpjZkVW?=
 =?utf-8?B?WlJ4ZTlBdzN2NnU5UFBZa2Z1RkJvWHhaREcxeEErejFUNjFvYjY2aURPQWwz?=
 =?utf-8?B?UVBtVldBVTlZOTJzZDlXbTkxd1VPMHYyNWgyeUw3VVFhNmFnQmM3U0dHTDFr?=
 =?utf-8?B?M1l4Um40TDFYeDc2V0hPSnZ2a0F3M0d6K3lKWEowOUVPVGMxM2lqeWFLL21r?=
 =?utf-8?B?ZXlaa0tIUFpVYWNROFhpVWM0QWZwSmJjSVRWUVRVbWhnem9RZmRqbTNyZEJz?=
 =?utf-8?B?bk83RzRmaUlVc1drMzFEOUxKQnN5dFU1Y1JCVkRRT1RXMXFIV3ZKdmh5dWZr?=
 =?utf-8?B?eFdoT1hESXZ2QTFPekg3ckhwNTcwUkVTZTBCYWF6SWdIQXNUMnJwZUxDUE81?=
 =?utf-8?B?NmEvMXFkSWJ3U1J4RVVudFBaQXAzK1NsRkNRcWJsMDhmV0xhUHNNRVo4YzZ4?=
 =?utf-8?B?eVNtMkpnbk52NkR4L3ZTUjJzRGdvcytxdkFqdEY1VTFNYnBnTUxmUW9OT292?=
 =?utf-8?B?K2RFZnV1UTArV0hiZTdyamhVQ2JkU0o2UmlRYnczT1QxYXRFNGlrd0F2Z3Na?=
 =?utf-8?B?elJ5QzhOWTVCSVpyVERwd0NpemNyd3lIR0NjWVF5dEpuYUhmUHBMemxyOVlt?=
 =?utf-8?B?SXZSTm55c1BPUkQ2a1VlRXFQd0Vtams4SlpGRWlFenhYc1dIc0hhS0ZmOWlU?=
 =?utf-8?B?Y2JJVDRjOFhiM1VFUkFSUnZheU5kMDdTeE8yNklVVDZRSzZJNXN3UGJRQ3V0?=
 =?utf-8?B?cks3N3BudG5yQUZsRlhERzdkYmltZ2dxSDd3emJMb0VkYTBWTHV5bWxDTnFX?=
 =?utf-8?B?T09XZ3dXRUVyZTV0Wm1VeEx3cEZib2lCdXE0VXIvMHFzSjRjN2dWSHh0Q3FO?=
 =?utf-8?B?eGRBajMwaERYSFFwNERoRTE4MUdrOWpCcWZGZ3BaL1RmSW1CRXVTdTNWS1Qv?=
 =?utf-8?B?NUZxYlJ1TTBBaWJ2SFBmVTFXaXJYNUxzcGRjTHZxQnZGMFlBRHVIb1hwMDM4?=
 =?utf-8?B?ZlJwdndybzhTd1ZVbnZ2Q05lQ3d2UjVHbEdacFU4OTJCVzcxSUdqT1UxdU1U?=
 =?utf-8?B?L3JRUEc2NEJRUDFtZXBzcWZ1ZkNMNmg3MEhFbWhScXVTdWhHcU1TcTJPb1ky?=
 =?utf-8?B?bWpLVklBMXI2VVRnYUtZblBmSzdqN2U4akNFZ0pMT1BJcnpNVWpjVE1MRnVi?=
 =?utf-8?B?bFdVN3Q1ZHBrblNTblhTOFR5ZXRPYjFTeDM0cHFYaU1tRDc4V3Y1aGRSUENV?=
 =?utf-8?B?bUtMWmdrcnZhQnV5eFlNdkFiWTRzRVZMTEVNR0c5TGdHSkg1V0JUSkxuSlhH?=
 =?utf-8?B?dDBQZk5OYk9TQUdjS2dWNzZOT0pyK0dCd1pFZE5ud0lWcjJRa2dkdWpPUmEr?=
 =?utf-8?Q?CJn/lA/KMBzvyumhiqbbYjcSA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c13928-fb2c-4cce-5701-08dcea09e2eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:32:16.3282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CM6a9wDgmT5mkqJx3mQ2KWmar3yeGEkA/uyOv60TPEmbr6WPJLnksdh+qTMyqDSYVX1Bb37il+3vCXL6w5g3aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7360

From: Ye Li <ye.li@nxp.com>

Add support for the i.MX9 DDR controller, which has different register
offsets and some function changes compared to the existing fsl_ddr
controller. The ECC and error injection functions are almost the same, so
update and reuse the driver for i.MX9. A special type 'TYPE_IMX9' is added
specifically for the i.MX9 controller to distinguish the differences.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/edac/fsl_ddr_edac.c    | 48 ++++++++++++++++++++++++++++++++++++------
 drivers/edac/fsl_ddr_edac.h    | 10 +++++++++
 drivers/edac/layerscape_edac.c |  1 +
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index ccc13c2adfd6f..3e4c2869a07cd 100644
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


