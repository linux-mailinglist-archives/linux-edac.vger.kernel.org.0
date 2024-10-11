Return-Path: <linux-edac+bounces-2006-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDC099A7C3
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 17:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6AB1C236F0
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC3196DA4;
	Fri, 11 Oct 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MztvPEz5"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBE1957E2;
	Fri, 11 Oct 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660719; cv=fail; b=kDJecrP0nG60lIePhz4k2Y7cDq8jmWkBqaopt+XDqiG8i2bslsvht03Ugf+HtlLsxq0bTJEavJhTFxAP8XeuliUH3jS1Qm+FDnp5y2MqgUEgncDev0PrlG0OWzWglDYZRM2rkJm3FcR8jFX79qbYASeUX8xdwqKg3AhmVgrpLuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660719; c=relaxed/simple;
	bh=tWA2t7dYpkCGQPCP1WcAIC7H3OdUmQUbtGujuyE7dVw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pB41+O57mhj62TFg4nWG7phJ/ncsNxIagKU96e4sEpUVovppr4bgt3jQcuHd60OZWDX9r6YfGMNf6y6q2uPs0BLHXP7OWOd7yFiS2nBTb7c3y7SxY3nHCdNdDtG/BwYbTLItxgoDLA18UUta+P0q88QLlA72Nh4/iTkc+2LgGOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MztvPEz5; arc=fail smtp.client-ip=40.107.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMlW8/s+aa0AZBC4bo7Vf0lW1J5HZ1ItCqylPjcRhvTSMI+yU9qrzP+sgAqizo4Kj/i7ANOQsUCj03PfHWd6am/X8G/XTTS5Y8z4mbC/1C+bwhzuBFhbJQKMccaJcOMi9gB7/gZAxQ3bUeJUW4cWuf/mqqfMchZVVVPGh3eCVCISvlJj6dWb9rDVoDsz2peRcQPRSKZiqxcAz7uFATtu6ZnlbQMMSnF6NP0E/CjoBw3NKrYntcEnBY9orVtPyRCsSVi+NfXOJmDtjl/ZvieQNXlIbpanGXAuOU1aE57VbBOZlW69xObLQu8vrcneoRvwH+/uPZBJsC+XOfaOI6jNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWWIgflstIVDXTjDGLYnl7metuS73gQMf9j95c82+E0=;
 b=AfNKGjJk70sjxjWT1u6INCtYyWeunol4tjK7CD0o5pIXg5uzuRDX58jKRjQWnzp1SpXsDli1nM1iWaw6CfUJ+2REzLx0KuB2C3vf1Rc4UNT+JVfr5U2eip8mVsJFQJJ65TLVQCfTHBeA3jHlXIut8LsWqvfOLUgMxr+0S3LjNIrgaEnNeDElJJ6yv0mUDG9nE9frdrmKvuaUbEICXoLUdG/1ILwaMmwwsEtjEtUtip28f5S5eBAVjLjIO34wQEZJTCjwAxAnZuXCaQ8XvVmw5hdGA7OdpKr96LVzv7UU38VPQLMHRuZHbzCfSQocvXh9eBde5wX4TBmE4BVtVjDVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWWIgflstIVDXTjDGLYnl7metuS73gQMf9j95c82+E0=;
 b=MztvPEz5iIrSku1WFfgIbQg4/N0lxtiEPtvNrB181SUNfcwKFhHzpVfmf535C8EGeUSSGeib1uiWSvAL6tNg/jx16wdDjzMkDFIS5XxJY58Hcow/iFb8XVjlN3HYBWIuG6UVsono+65yWvEsasuPRKqJkEsxYKobmDo4Deyv4VlRubZCG9mX1AhS9F/5XTVonaEtJ5M7JUPTQ6MCH327Yi1Ig5I5bdrWXRSQlPp5Tgu4Rw6iFHK/NJvo1ogGYvprjc/LvHG5xQQE/1uJOzh9BZcdHD6ktDFnzz9MqQNq4QIzIdYiTMdYKTaPlY2flFUOM2vi+iuXRYc5URr/dSxBuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7064.eurprd04.prod.outlook.com (2603:10a6:20b:118::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 15:31:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:31:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 11 Oct 2024 11:31:29 -0400
Subject: [PATCH v2 1/6] EDAC/fsl_ddr: Pass down fsl_mc_pdata in ddr_in32()
 and ddr_out32()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-imx95_edac-v2-1-011b68290951@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728660703; l=8457;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=tWA2t7dYpkCGQPCP1WcAIC7H3OdUmQUbtGujuyE7dVw=;
 b=I229zlgU2anPbvLij1cNUj64GMxTUvyazyq5Wyp0/AqlTYU5gx71QGZhHN0QgziCfhpJ2cJaz
 mfGEa/rp+ayCugzBn75mIiqFgDJHPfRIfhA7xTSpJBbwG5Sx89aN3Xa
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
X-MS-Office365-Filtering-Correlation-Id: 65113d73-0a4c-47ca-49f0-08dcea09d609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGU3OFdOem1VaUtvRjBQREdvRU9Qd3lMMmpxYlhXQldJN3A1QUhMcDBraDFk?=
 =?utf-8?B?MGtZVmR4RFBuWmt4TnhlS254TnZvUjRoMnVmVURPUlFaaVlQdUJIU3Q2Q29N?=
 =?utf-8?B?cHNWUC9RcUFSNGgvakdTb0wrd1FBWDQrNCtWbTV3NFJVeHM5dXdCYTNDckQ1?=
 =?utf-8?B?RzVFOWYvbFhiZG9oSlN2OVlWeklQbjg3dW9oTVNDT2NBZDJENm43NXRMR1Ew?=
 =?utf-8?B?aHhKQlM2Vi80aTNXK1N3Q3VCWTRnNVJuSCtzWUxqVnh5bEV3STJvSVdEaWJS?=
 =?utf-8?B?QWxtdkhoaXFnZ2h1cmwzWXJta2xhNU1qRHlid1J6Um15TWxzVkk1SmdnU0NZ?=
 =?utf-8?B?M0xKZmhFWWI4TUJBSnFqNVYwNkMrYVFFUWgwdTdIWUVoQW5uNW9lVDdtR0g0?=
 =?utf-8?B?SFZsR1ZzdzE2QUJuUGxkTERSbHhycHJuRHlyM0Q0Z2RDQnNVMm5CNXlHY3RU?=
 =?utf-8?B?eGYwM3lwNk5TMWxOUkw5d2RBSGdYS0JYa29LQ3NDNTdjZUE1elh2dGpjbVgx?=
 =?utf-8?B?bk5BS2RrME92dzBTbERSUURTMUgrTkJIcmlYSFpDaFBIWWgrRURySE5KWEpY?=
 =?utf-8?B?WkxkYk9MWitYd1ZjUWRMWDdkci9nSmM5cVdYRzZLa3FNS3lzTWt1YklLemVn?=
 =?utf-8?B?UzlsRFhrYWhWUTliNFQzLzY0Um04TXM3NVJ4c2kxcGtwYzNMci9waHh5TzFx?=
 =?utf-8?B?SHdHUUhzemc5VXRQcmYwYlNEYUtsNXVHQTFHTGVSN2lWS2doaDVzdzhhSThZ?=
 =?utf-8?B?SGltUittWnYxNnE3WGg3T25EQkg5djJXK2c3dU9CTnZyc3VvVStjSXAvL2VV?=
 =?utf-8?B?V3RadGp1c2RjQ2Y2NHIxekhUNTcxWlYwenV4MFRyZHhZRk1mOHBqMnlGSGNs?=
 =?utf-8?B?cElvMkd5U2k3Z3d4RlN1NHZzb09UU0cwNjBNYlZhakJJc09OWUpwTWd0K0xG?=
 =?utf-8?B?UlFScnZYYWhWa1p5Rms3eXkrTVpFRjlJTlVEeDdIN1Zqd2Z2RGlsaXBXZWMy?=
 =?utf-8?B?RTUvRGptWFBDbUhFeGJiZzhKcERTdkZ1RVJIRmNMV1lzWU5IZit4Mm5KTTM5?=
 =?utf-8?B?WXpyUUhoK1Q4M3lnM2lsNUhJbkhZc09OVlV5RVJmSmlVaGpyZ3I1L3VKNTEr?=
 =?utf-8?B?U0w5SFRVaWhKdldISHNkUFAzbE9uRzhTRTFHZ1A2MXFLVGFEUnJNS1Jnb0d4?=
 =?utf-8?B?KzVNcnhKZ3pCa1VITzBWSy8rZkVDcS9CTUpQK01YM3RRcmZnN2tock9xZHRE?=
 =?utf-8?B?cGdEYm43YTUvejVFYjMyWUJFQU1VOEx0NWNlOTdlV2hpRU9qL05XZGtZa3E5?=
 =?utf-8?B?ZGZpRW9DaG1mOGE0ZHgwb1V4TmRGLzVGd2UvcGJuN1JlODZPUWdid2ozSmcv?=
 =?utf-8?B?YlJVdldZZHRjcHJMS0pPcG1PM25jdmJDcUZjRjRsTUFkSXBrQXprWVBVL1Bl?=
 =?utf-8?B?SDVubDlFemhmZkl0QXFIS0Y0Y2p5UkJqekp3VGVlUnRpOHl2aTlVRm9xZWRZ?=
 =?utf-8?B?TFJuckc4c3FpSmNocHZXM2dldGY2RG9hT0pQZGlkOVp3RENXcklFcVJza3V6?=
 =?utf-8?B?WGxzYVBiOUZPY0Z4M2ZuVDZDdUJnUWRhWmpMM1FhK0c4cmRrQjRncEJXeW9U?=
 =?utf-8?B?Z3l0VzRuWU5Kays0VlpkZmorRGlzcTBuekN2dTZSVWRsb3VvWmpycHNNRHdU?=
 =?utf-8?B?bkh0VlE0VFNLYWwySDNtSlV5Q2dsQ2ZFUEJob0krc1Z0ZWRhODVhancycmg1?=
 =?utf-8?B?Ri9kVzRXQ1FGZ0JVTEZiTmFyd1pnZkNYakZQSkZZV3RJT1F4c3k1eVhPQUVJ?=
 =?utf-8?Q?NEbBOJMdpeyKDLCCIwRLdUnNzThcCx2O65too=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1A1cVh4YXhkcHllalgxM3VveEhseXpySmdJVWNYWlgzZUczRVpuN3libm1K?=
 =?utf-8?B?NFFIckIzbjJKTVE2U1pKWlhIa0FUY3FWNmpQSnl6c2t5dE5qTjF4d2xscTBx?=
 =?utf-8?B?R2NiK0w3NHM4T2R0M29lVHl2RmJhQ0VEUG51NGUwcmxuTU1kTmIxT0cwTFlL?=
 =?utf-8?B?QkJSZXpZRWt4NG5kUkxDY1ZiWUlDWjQwWHdXMHdnV00xMXBsM0dGRlB5VFpT?=
 =?utf-8?B?bnZvanFuU2tySzhEMmdUUkRlNHpYN2JzL3RkeE54S2FPNXR4ZFZJTW1EVEM3?=
 =?utf-8?B?QVFOSDQzSWFiaTdWVUxSM3ZGR3o2M0labHVGNG9aUnZtdzBGUTBQQzBqSnZt?=
 =?utf-8?B?emxqcVIzc3RKR245Vlo4N3dYNllFS1ArclZIZ3ZBM1hFT09WUXRFT0ppamRr?=
 =?utf-8?B?OCtSMFBQUzU2VWJQa1hHUEptMDAydUdiS1lka015eGVZZGttbHk3d1VncVpM?=
 =?utf-8?B?MEgzeVUyVTJjUFNYdXFRYmdabkxvOUtQcS9wN2lrb2Rta1FkUVhkZUtoSmRY?=
 =?utf-8?B?bVJPWFFwZTlYS0pKNnBHbzJMTkdLQjRRUTN3M3RHUEZZNVZkNUI5MjdiaHBM?=
 =?utf-8?B?eXFiMkp4NElGc3cxdkxpMklOTFVEUm9FS0VFSVRGWnpJS1RDNlc3RnJiUTRZ?=
 =?utf-8?B?ZDZrenpIR1JLTExDNXVCdG5lUnBrVjNBRWZRb3RXSC9TeFlpcUJZU0NBUUFV?=
 =?utf-8?B?MTZwQ2hUby9ncjZGTzRJanZOWEhpZmw4VldiM2lmbjdFSG9zQ1BlMm4xUW9k?=
 =?utf-8?B?UWJMWnJ0RzFCeFhiOXpxeUxvdzJuQ0VzcWswREkvSkNSL3ZiY0J2c2dadWo1?=
 =?utf-8?B?SUhjSlBLWml4TE5yVXNiZkR3QjB2eEdjQ1J2bUQ5U3oxTDY3OUtraXFuY1Uv?=
 =?utf-8?B?U2UwNXBsNHhWa0RuSGdhczJWS3oyd0drYVA1SjZvMnJheXBNTCtPRkFzKy9G?=
 =?utf-8?B?U1QvZUdZTThEb2Q0Z1kyQ1BHczJxRXpudHZ1QWhjdHNuZVRNK0RNY01wRDNs?=
 =?utf-8?B?d0lwdDNnRkg5TWJXbUgrenNJYUt0a0xaZ21IT3UyT2gyUmVScjVJNFdpY0cw?=
 =?utf-8?B?aHFQZHdSdXVGK2VZUDArdlNjb2pnVHN5OVNmVlFPTlVyd2o0NTV5NDZ5U1NH?=
 =?utf-8?B?MHpTSE54MUFLL1JxUk8zQnJic0FSNGNYSTJWRnpxSVdzU2xTQ3lGWE05c21x?=
 =?utf-8?B?VXJvQVFvZmJXdFFGTUZheVhxWjRtMlF1NTBmWUh6QzZUOTlxSlduaUM4emFH?=
 =?utf-8?B?Y2NvOCtuaFJTUEpxWitMS25sVy8wMTRlMkdFM21uZCtFQnFyVGQyQ0lmSWxp?=
 =?utf-8?B?SXk4dllqWm9xcXZpNE9RZkhTZFBJWHFWN1pYVVE1bzRKdXE4TkFJVjhuTnhp?=
 =?utf-8?B?RWFFTkFkZFIyYXJkcVZNYWo3SDcrdGpBVVpCZ1Fnd240a1g0M2tJeTNXaDFO?=
 =?utf-8?B?Z2tzbERLdDVQVFBPZUJJbW8xRjF6K1dUTzhEV0wybW01ekdWem9QL0FXWG1u?=
 =?utf-8?B?cVc3RjloajNiNHJZakF6SGhLcGhKNmcrdkxrcERJeWR1dmtoS2RtbTlndXFM?=
 =?utf-8?B?Qm5TQjZUeWxOYWpMSi9ZN3IyTzZmQ21pVkJSc2U3NGJCMDdsMG1qWEpTZ1pC?=
 =?utf-8?B?b0gzR09GOVR3amRvaXZMRjZzK3NnUFlURXBVck53SWp5RUxyR05ScmVoeDdr?=
 =?utf-8?B?dDBXWndFcVZKSDZTMUUvTnhrblhBVEplT0FQUWE4bExiSzQzSUZiWWtKQ240?=
 =?utf-8?B?LzhxMVBvZlcrTDB5ZHVZM3EvUWdhRkdPK1BHdU95QjVWQ3RtYzdGdjNueElG?=
 =?utf-8?B?b3BHQUdZVmE2RkEwWlAyMTZsSTVkZU51NUVtWVcyMUhmaVhNZStNaCtiSnIx?=
 =?utf-8?B?VXhJdGRKMjhQTVlnZ2UvZllSMHJqZk5IaW9oTDdrbjZaQ1ZvWmV0WmVKOWlR?=
 =?utf-8?B?dDJYOGFRNU9YUG1Wd1AzUDF5eVhaeXFXQWwzdHkwYmYvSEtTY1Y5OEg4cGlq?=
 =?utf-8?B?L0tibmQ2WjFzbWx3ODB5NkpQY1k4aFRaQnVJYUZrWk43SXJueFR5NXRyZktV?=
 =?utf-8?B?NGdNbi9vM3ZLelFSZ1ZjaU1SeVFXejVmc3dCdEx0T3draVcwM3d0L0pMSW5n?=
 =?utf-8?Q?2WEd49SjoZn7+i8/kKCAzzN4a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65113d73-0a4c-47ca-49f0-08dcea09d609
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:31:54.7271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShSsbeseJKCZ+yntuCUGoY1kVabxTWaIshAzKovM4mZ+tfN91p3aUrZPysq9ukvlCnIcE7uTeaiV+KUX5xvrdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7064

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


