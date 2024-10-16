Return-Path: <linux-edac+bounces-2111-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243B59A13FF
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 22:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58702B22002
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 20:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98E0216A2F;
	Wed, 16 Oct 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HaUuf68g"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A1176AB6;
	Wed, 16 Oct 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110698; cv=fail; b=KH4mLWEB5Yi54nCwRFbMUqUDbKRyWaUtyZmj/W6NPRRRHwUpLC4zMH60f64izpWIWgsEK5OvXf3iWLG6c4KPNHVurboCOuo2VHaSd7DR/VdRJx78eqUf9yT4frm9Lvsu+5kRy8sODNXDwsL4/PzNxJMVecFFbFV9yfPVtbLz6u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110698; c=relaxed/simple;
	bh=tWA2t7dYpkCGQPCP1WcAIC7H3OdUmQUbtGujuyE7dVw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZEm0Juc0VJ5Qox6US6nwRqSRScFtZie5slRtr8L6y/qmZGUzUggHDzP1UJ6KhI+yn3T5FEzHw1l+MILPgR2tUI5cZzJDz7bhH4//sgjaVyjwixAR2fCn0UzYhoRFvPY1RhEix1YFQhelxS1cEFrlA5WTWz631cCoQdZ+QtjHV0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HaUuf68g; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rArMl372FD+nVxbux3L3mBZabLu/qSSChwHXmhakA3I0TyjZ5ggdjx++PMDiiyO10U5YBjCb9wfJDea3XQcbp8p/hNO+d0Ypu/xrL2vCLLEUQb9Km7jFlBerGyRXINqqmAMV8xfNQFXffozTj8U4i9yHNMc89g0gOEA1Yk3b4loB91WzVjLpQluyMHDIv9lh5J9eCypVyeFXekL7PjBNeZTDs3Yi1/bZGWSEgtDn9W5sOwsj7jRAMgSZVrilbl0IH7uraA/xpe9i/SYtGcphnYW/e0yKA8F/gXYD9KwdZgKffyHf4BtKifSfjUaTJkY9nyPAyGM4HY7/fFkUkeGf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWWIgflstIVDXTjDGLYnl7metuS73gQMf9j95c82+E0=;
 b=urJICd3lbSdxaxqeEJplrHvCl1CJfsObgNCFo7v2RW2v4huggHbO3aVv6rkAeIFc/D0rk4lDMLb0NOOhEToreqtV/pyuJ0KmnSBzsJDiW9zV6Tjw6HpEOuxSqNnBU/VGuLtno/F/omV1pR12sHbfzbnKXJ49vFuB/wj/KRGBxbrqp7I1hfiN3fm4ZeQKEO3UrhfbUVHqN6Y0/L/ogqu9d0o+wfLh41inQz3ua2RzuU3BiPWFcQnIiDgjMxD5eAV1OowavrVjYCUVLZAjukL3OowcoEzKUsALTeHRHTb3veTzZ5wrelxw/awTUBduwnorEYOkuwzcMWVX0efeCCq8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWWIgflstIVDXTjDGLYnl7metuS73gQMf9j95c82+E0=;
 b=HaUuf68g2dbWxFoph3+axCosMY3+NBHKGOWhZ9NruHfWVJLIRswwoq6oSSdpkgbjL/7faaLBFdQHnCInv6glhsTL6XPF7zIMfn/rDAJTXGgDVY0FPBpLo/L0y4ihGalAtZS1As9GIl99I82zxX88tdoj7fJ71SUs4lbnhEvdHxt/+IzUU2m1kAXHVsDQK7VEPzq9PJzmVPUi8huZxGgI1IQBFfnsnGaX5zlAUVZEhsPrvztmZ9pyCkiNZhysr7TmzJ/O75rpv+G/usIUmSeu6xOFrDvPHOm67Zcl6dhnPzNiWX4n2J7qbRbYfg5li2cBD6m0h5+TacnlQvFU0pevfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9845.eurprd04.prod.outlook.com (2603:10a6:10:4d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 20:31:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 20:31:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 16 Oct 2024 16:31:09 -0400
Subject: [PATCH v3 1/6] EDAC/fsl_ddr: Pass down fsl_mc_pdata in ddr_in32()
 and ddr_out32()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95_edac-v3-1-86ae6fc2756a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729110683; l=8457;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=tWA2t7dYpkCGQPCP1WcAIC7H3OdUmQUbtGujuyE7dVw=;
 b=34tuxc5Oxl6QFwxosBHK4hU0B75MJTe51HVmMDYoaMh+3EeG/jrcNLOw3slkd7+tm2ffcoHTI
 jkuMYiZpWtCD1/fhprUINqz30X9P7tU1Tv7YHghohKKDFDt09Ynp23S
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
X-MS-Office365-Filtering-Correlation-Id: 85a3b70a-3e17-400c-beeb-08dcee218709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2ZqSncra2RtOE0zR2ZPM3ZYakVjcWZ1UE5VdEpkSm43dExiNHc2TnFIMVVI?=
 =?utf-8?B?QW14WVpoT2R1bjRBK3RwZjErNkZaUTJhekNmWXVjWHB2VDU0T01FNGU1b0ZR?=
 =?utf-8?B?ZGF5bVlrT0J2ckVQTDUyN1hvWlpOUCtYUnkwWkowSVlhRUkwbCsyVXMzQnRk?=
 =?utf-8?B?NjBkcUtSc0F0SmpkZkZSK25Hbno2cTlIREx6NjQ3RTNUa2JtS09MaFNqRk9B?=
 =?utf-8?B?eHAycXkrRWZpRXo0K3RiOUg3cWowSHRTT29VTjBOc2lMRXBSMVhoeFVnVElx?=
 =?utf-8?B?eG9ERHduOWpCdUF2V1hqOUFJTlhyNHBFVUlWZUJxcC9pS0FGbU1IVmg1alBL?=
 =?utf-8?B?QUtwRE8yRWlSekhaNWhYSWt6NGxNczgxYW90VVIyZHBrYWEyYkNZdm1UQzZV?=
 =?utf-8?B?b2RSVFRlczAyNmZlMDFiY2xLZDl1VkZVdjlRL3F5amtPc25VYURwaDZZaXhP?=
 =?utf-8?B?cXU0RmRhMXJCYnBKVGlGZFpDazJGL05BdTFPQnlycjhrazI3TGZobzFlQTcr?=
 =?utf-8?B?NVZjODhoMStsMURleU5iUkZieXNtWjlLY2RIc3hrNVV3WFVIYm84MW9qeEFy?=
 =?utf-8?B?L0x0aXdMMG1qZVBxYjNmbXBaOFMzb2lNMTJjTzNXOTR3elQyY0Uyc1A4SVRV?=
 =?utf-8?B?YkxoNmJDQUpjMHNuQVNGdzBmN0pLVHMvdFEwR2EweUY1WW4vQUxFT25pVENs?=
 =?utf-8?B?cnU2TDRCVUtJd1FUQzNDVC9hR2QvT3hJSUt0NysxRDBFVGlwQmJWVTlQR3BE?=
 =?utf-8?B?OERaTXFqL3RTZ0JyR1JUWjlFU3BXcWltMkZCT2cyZ2FnWi8wc05tUXlmTTE3?=
 =?utf-8?B?UTFCa2NFWXh5Qm80dGJwUWo2SWRRemp2WlJPa2JwV3lQNC9Gd2ZKaXhxUGRy?=
 =?utf-8?B?eE5xWXJUOHZ4NFlxL2pjRTV2MHZiWDBGMi9EdEdYaG5ZZjdkcW5DOFBSTDZs?=
 =?utf-8?B?Qm5QQTFtTE11OEowYmNCRUNFandDTjlPMjVvU0VlQXhQTmRva3JLdGRKaFhx?=
 =?utf-8?B?NFdiNDF1UmJWdmIrVnNuSC95ZWpIckJ6K0YvWHRQUVZONkJVN2IyREZiZmR1?=
 =?utf-8?B?N0VOajVIZVhLeDNNeUJNRktzVWNTY25WOWpYR3MzNXViekY1OTRLNlZsSHQ1?=
 =?utf-8?B?dzM1NVRwNlZ6ZXRVZjlWRGx4dy8wZFl1REtHS3U0cUpFemFFUlZ4NFBGSmZz?=
 =?utf-8?B?MVd5a0RSQTJtK3lhUGFvNHl2TGxnOXNvRW13UEkrVmYwZlpQek9FczBsVlVR?=
 =?utf-8?B?enNZanJsOUcwUWtkVlE5U25neTE4WlI4dmc5MzJIam8vbXl1MTcrQ3IzZmcy?=
 =?utf-8?B?UXE3QUUrRUloTzB4dis4a1B5WWZDb1UyemRjaG9yakpSSDVWdVhHc0M0djJB?=
 =?utf-8?B?TVFIWHNDTXRiMU53NmMwditMNVVzV1cxS2JWSkZKSTV3bDg5cy95dGZ1MFdV?=
 =?utf-8?B?c2NuZEtjSnEydHhFekhwYjNKU0U1NUVHOHRXSlV6TFljOWgvb2RsaVJLZy9r?=
 =?utf-8?B?RDFudUhOMG1QQ0VHdnIyZWY1Z0ExSC9qbXQySWJ5SC9yU1J6SG92TitiK29h?=
 =?utf-8?B?VjNKaVlZMUp3OXZjdzIrVnIzYmF2ajkwcy82ZTRLSEpoR0xrQ2l6SytRY0Fq?=
 =?utf-8?B?ekJhMkhBMDBzc2tFaHJaK2FuSDR2R3VEUmsxTGpjak9GU0VxenhLTEh3OVJp?=
 =?utf-8?B?UEZxVXp5Z3g0OXVDUytkZzhYTW5rQ3ZaYkYwWlFXYkZleWNSQ0xBeURRTXBu?=
 =?utf-8?B?czdscFVSVC9vcEJnRXhndU1OWnFvdDNScmJNbmxzY3BDNHBqZWZYL2FLZmFW?=
 =?utf-8?B?OWJRQkRJSGo1VHVSOVNmMVAvQWk3NE9vYmJ2c1dRTlJUb0JxQ2xVV1hCTjJC?=
 =?utf-8?Q?226FE5O1mRc2M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkxFdmk1Nmt4OEgwWGtPWWtmR0x3SHpXRlNmTkFQSzBPbmRGZzJiayt1N1Er?=
 =?utf-8?B?d05jSWJjdmt4K21lOHVCRTBFQjBQbC9JejdTeUpQNGZzNzhReWhhT0JOZzA4?=
 =?utf-8?B?SkcvRTdmSGtnaFNxMkdiMmFGWmt1UkhwZk1KTUh4enRmVnB6VmUvUHgrOFgv?=
 =?utf-8?B?QU5Ec1QvY2M2NUQ4Y3lwU3JseURPMDBIRHp1WW55UkxvRVBnOWkvRWRhcWUz?=
 =?utf-8?B?MTczSnYvUnZHck5TOExhZkhVMHVuTXZUK2VSVVZMd0JFY0VNUkV1Znczc2dG?=
 =?utf-8?B?YnVPTkZpY3VFaU5tcHZhT2ZGNEdHd1VyRm9qbFhBMWg1Z3RKMklGTy9haVVO?=
 =?utf-8?B?eXhTVEgrdXNmc2pUTFRMSTZ4TXI4QmRSM3ZucVlqTm5JMmk4eTl6N3lEOE9p?=
 =?utf-8?B?amxRdWJTYVU5MW9STk1Kam5SaE9Kdit2L0xLNGEvdlp4Nmc0ci9oUjJuRzhy?=
 =?utf-8?B?aCt1OVFaajhIVUwwVmRaRE00WENzckQzcnEvdzBpcHBDTU84Y1Fad2xSTVl6?=
 =?utf-8?B?S1FBZ0l3MlFIeVNmUFhYUU5xZHVnbjZVM2l4aTVLakFtSG1VYVFiV2oyRGpB?=
 =?utf-8?B?TWoxN0NHc1lTWE9tR2lhVU5jMVZPOTM3T2tLQjJtZ1A4ZnFBTjBudXhBRXQr?=
 =?utf-8?B?ZXA0UWNsc3FzZ3pNa1Q1ckhZQkFaTlljdDI2ZnhuczZLNlI4OXJQUm1jcVJU?=
 =?utf-8?B?eUhUZTRQWUZaT2tWM3FIRjBGRGN1c1A0VFRtOEpLNzV4dW8wWTZBRWxaUkZx?=
 =?utf-8?B?S2haQzM4QWFLUU1MK1dXOGZMU0VpcGJHeTRHdjVjUWc4Wk1ZT1ZjQXhuMmtv?=
 =?utf-8?B?OHlDZnNhODI4UWNEaWVVZHJxRklJcGRJRXVzd1VkTE4vNTdPM3cydlc2ZS8z?=
 =?utf-8?B?Z0ZmL0VhVHlmajFqTXFUUFRBTjRHNGVGUW9iRVdIR2pSOTNoMmM4ZXM4S3F5?=
 =?utf-8?B?d1BkamNaMWRTOHpZODhoQzlIVHdHWkxBU2FUamZQUGMxc1Z3Z3dOQTZWNDhU?=
 =?utf-8?B?YVl0TzhTYlVhVXdjdWFYTlIrMkp5RjkzYWh6aFYxZ1NHR1lSajJoWUFrcnpr?=
 =?utf-8?B?NEkyZjZweTlxYVZlMk5nSTVHd3ZMY3dCdENDVVV5aUVCUUdyTjlNdnBTbEhq?=
 =?utf-8?B?d0lLNGE1alZGMmlCYzJSVVI3TUdxOTZ2U1A4SGJXcFNlR1pLRTFodzhpQkp0?=
 =?utf-8?B?MWZSZWt0dVUzWWxsMXFNOXUraHpwbXUwaHg5cmpmMDU5dHJ1dGlrZlBFWkNY?=
 =?utf-8?B?dmFJMTNBblFJc2NqenZEM084Y2tKcEVOR01EeXZSNElmRy81T0lWSkp2MUwr?=
 =?utf-8?B?ZTcxc1B0aE1JRXZyRWwvbWVrSmZaQjlEY2EyR3MvR2JlcG1KUmRaTFNYdnd2?=
 =?utf-8?B?ekhsU3ZXWkYxbTlXRm9qRUE1b0l3blBBMnVCVzhoc2x1eTFseFBDZ0hYRU4x?=
 =?utf-8?B?N0pXako2MDVvNFNMMFVya1FPcDIrbzZoSTlTSk1IWVdxczJiSlBOQVNseEdt?=
 =?utf-8?B?eFgrNDVMOGM3elozcVFtL0laTzVnam0yb0xBdTM3TVI2anZ1WDRLcVRUMy9E?=
 =?utf-8?B?dk0zdWFiMWhrejZlNkZVYVg4bGtkWHZ2anpyMGFTTEdnZzY4c0RxMS9zQjd5?=
 =?utf-8?B?d0JUZ3ExdFpvVTl4TDZwQjdvbnUwVXlhOHBtbTdrTFU5VDMvcW9iT0FiMWVM?=
 =?utf-8?B?MTB5ZHpyc2hzOTlwcFJoakgrNGJMWHREMWpmaERPcWg4Q05DVnM2NmhBd1lN?=
 =?utf-8?B?R1hSeW44RWVYZDdMU1pWejJQN285d0RHa09FYWVxdTUrVU1sUlFtSFYvNWRl?=
 =?utf-8?B?RGtXL0pPTE1od1FJQmZxRTdYZ3U0Uy8rSXE1WjFxTWQ4MzQyWUVraEhTV0Na?=
 =?utf-8?B?OS93cUpvMmlPbjhHU0swc2VFMnpzUzdkTTQ0dTJrNkgvajJSWVZEYVpxSDBi?=
 =?utf-8?B?bkd4Q3dtZFJ5R2JFR3NKVkJ3WEJCS1lLbGN3T0NDaHpsRTI1V2dLOFRQdTU3?=
 =?utf-8?B?em85WUZMeFl1d1lZbnVaWEQvbjJZZFB6MWRyUlh3MXc3UVJLU1dSZ3FqTnpL?=
 =?utf-8?B?WDBnR0FhcXlrVzJ6eUhPdC9kZTBVMnRhbnlDd1l4S1ZDb2dYTGMrMlVWdlhm?=
 =?utf-8?Q?UUv8IqWiF6lm23mnJiCkd7ZEP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a3b70a-3e17-400c-beeb-08dcee218709
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 20:31:34.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JS4W3mH56qcjr4pbP4NIchaULlI6C7dV3qAds6E/iMq3ZfaGY6XeXunXXBPDcZGcEwi7gPy5zUNGgcp+UzBmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9845

Pass down `fsl_mc_pdata` in helper functions `ddr_in32()` and `ddr_out32()`
to prepare for adding iMX9 support. The iMX9 has a slightly different
register layout.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- update commit message.
- fix a build error.
---
 drivers/edac/fsl_ddr_edac.c | 64 ++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index d148d262d0d4d..9924c6b816648 100644
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
@@ -531,7 +535,7 @@ int fsl_mc_err_probe(struct platform_device *op)
 		goto err;
 	}
 
-	sdram_ctl = ddr_in32(pdata->mc_vbase + FSL_MC_DDR_SDRAM_CFG);
+	sdram_ctl = ddr_in32(pdata, FSL_MC_DDR_SDRAM_CFG);
 	if (!(sdram_ctl & DSC_ECC_EN)) {
 		/* no ECC */
 		pr_warn("%s: No ECC DIMMs discovered\n", __func__);
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


