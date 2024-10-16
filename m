Return-Path: <linux-edac+bounces-2113-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83E69A1405
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 22:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA88F1C20C9A
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 20:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E6A217339;
	Wed, 16 Oct 2024 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lh9j951I"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9712217325;
	Wed, 16 Oct 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110709; cv=fail; b=E+v7pksyDOtKinh4HN6DGWF7jsQVN6XZlZ0lhc9IZtJ938s65C/NxKC7K6QqtQZfzPWQwmO31SUA5Br+LgC6ky0o+TWRMDLvueziiXagZTKci5x9ldooeNjgoQ2xaaA2sNjgNuNV/ZrA9nWQyfILZr5xlp9auGWrKMLkSSSkc9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110709; c=relaxed/simple;
	bh=kkq2oTJ4X6AP95d7t+PEWHZQVH1ktTm8zm0a5adwArE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Z7au/KN4WDVzgAl4qniZMGNCRRZ8JjW8o3CVEtznTCMtdXS9czfNUPha2WGze3xD72Bs44rAVNZPcoJtiu6/OEmwTSc7eoJjShKJrriILi+sg7fk8lVrxuh36M910xiwQ8QP9U+FvE6Vcup8+TMrBEhXMVYf49D27xdB5rcs4bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lh9j951I; arc=fail smtp.client-ip=40.107.104.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPBJxX3eE+340cZ8GhbqwHR6GgLySNmyJkyuIh9jT5S7G7zXa3CmVLPzEDeWvQsCV3azrmE4Yt2uzo42pd1U85Uw4y5Df10iVDHXXeBwgql5vbomUcyOVNugVuGgjdMQG1PQwLauEAr/u6N/4cldBIMWGVIt/UW42ntL1k+fFkRrYhho1vf+V9iE+ey91djfNjArsFpoMHoY+oDxN/jYXunI/mojrdFYbqoDTGWuuv2u7Nk8h+fGP3r8/DcyHVXor5v2OLCyykfJR/AJvAXubpGJ1VpJhpenBsI412qG0RCNtqAkCMcS7rF7bdG4LX/D0Byrmo0g0FSgB1JXVpQ6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d8c0sNGYq4vfHYI6mkZB5AG2AIJXl/qLfLBHwapHrk=;
 b=MiB40jc6P/oGvueMDUPzG/mzJYxlpqCga0Q6i26ejlOSkf78REE8VZsWFmD+I4XcuXsNU2yQcAis+dVTlh4a7fscXYrm6vqqo5qCkb8QJED+ICAoK/BnMUxiGPHY0up0TzqGPPcWv4+awG17LpEGieBdv/tk9gb8zSkTlPsT93VzTF3E279HFGdxtFzcjLXEl8IY/b4PEJvr1qfSZamSUy6wS9cG/Hz3LzpcdTuSiEySJM/BtDe6WX4kkjaQsZHHQuB8UaU5rNJJqBUTgpUwdI4HcJ+F6VMI+iw18Tx4ErHXD5yBoUwbKjYEOHhRixScT+SCINo9L9jYeoS3Q+Cxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d8c0sNGYq4vfHYI6mkZB5AG2AIJXl/qLfLBHwapHrk=;
 b=Lh9j951I+4qvPA8k6NwA8eNbnzDlhXWaRn6HNK+XWifJy0Y6XJ0e4n7dVhCTgvjXKrrXfUlAsfwAznIE0vpdUOwQKNMqATogLPP/IukOuXkB48QfdiqrAXYvwCdK3UStj8Up/VzUVNlmlwSCwwaGde0ryIHe0XGFVxF0o1rIXRWR3kT+l460bCXUftE3dhnAK2nBypQIItjrgGIBwTLIckFk65PvfPk7JAgUVvRzY+KvBIrgkBnZY0rIFxIIzVtlFUDSRBBrxolrSjyt4VrpRg2jtuiZc2usG5u+2SltNFsJIJEf0SRRf6syiIKjF80cv1zp/9tzHJbML83taYOBbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9845.eurprd04.prod.outlook.com (2603:10a6:10:4d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 20:31:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 20:31:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 16 Oct 2024 16:31:11 -0400
Subject: [PATCH v3 3/6] EDAC/fsl_ddr: Fix bad bit shift operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95_edac-v3-3-86ae6fc2756a@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Priyanka Singh <priyanka.singh@nxp.com>, 
 Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729110683; l=1889;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZoeCNuBkYPhKpS/FeSuF2iwPzcC8UiQC1YFwpngjXhw=;
 b=D/ksnGAhxZQg7Qb7/AI21/XsrLMkiVMpm8GXiNGcFFbOwL6pE/1hRfED2f6Bk1ehUfuQTPzIz
 OWQHHVTB3AMCvG146S1knpt5XN0LpICKwrKUbOGPeuAQu35rzRyc3dz
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
X-MS-Office365-Filtering-Correlation-Id: 0c23579a-3d80-4d0b-b343-08dcee218d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck40bFAxME1tbWNwN2xRaXBYb1k1elo5RkkrSUt6UndmeWFQUjNrRDYyWTRZ?=
 =?utf-8?B?L05JUll0WDBQZ2dXdDVqUVZLVmNvV3Uvc1Axd0F0aXZkb21rZGh2ZDVGWm5L?=
 =?utf-8?B?MUpoa3NHV3pXQnAzemQwZjF6TERSQ1lKN2VzS0xiOXc3N2pVZG9CaEhycEVi?=
 =?utf-8?B?TlJWZXFzVE5NR0w2Q205Z2N3RVhmSXpXSWV0Zy8xaXJyNHNWcWxqVTcyVVdu?=
 =?utf-8?B?MHg4d0Nhck1uTlRUalhwTnMrKzljSDlkZmVqZ05rRlExK3pWMmZQTmhLaE5F?=
 =?utf-8?B?Tjk3WVR5clhkeU5INGlJVE9JWms0SmNma3V1dHlieXpzSWtRVDk3MUNIWTdv?=
 =?utf-8?B?RzI3UWNyclJZczhIQnlwL09WRmsxdmVLRUJHY3lRUTVQN2M4VGl2NGF2SHpv?=
 =?utf-8?B?WVU0Qm9pSVZLclJ0UEFGQXNnem9TMFU2bEdva1FLblp3MEQwS1NQRDNMM1Y3?=
 =?utf-8?B?VjdKUXhzQnRndzZycEh6OUNrZlgyQnJoWHJxQ3VZNFF0V0FRZlFzYTVzcjZp?=
 =?utf-8?B?cmNrZlJYd3grUUZxb1RVUlZTL1JjVEVhaE9Bc256RzBsYzNiRzdGOXh3eld2?=
 =?utf-8?B?c0ZoOXg4OTNOdlhPRXk4RDc1Y0lPcXlFVHRCTGVaaFBjMjB0bmtwMkFlaUw5?=
 =?utf-8?B?endhRkVtNXRjMWMxc1BGUmZJUEIxQmFqQThsNzNGRHBPd0MvLzlUeWFiUlZI?=
 =?utf-8?B?aE04KzNNWFBQUUtRTUs2T0dtWWkzK3VmYjFmWmF4aFJSbVR4akhCb0lYVXB0?=
 =?utf-8?B?U3dvZWl0SVllemdHRVlzbExzM1RGKzd3Vm9TY0lhb01INHdFMzZ1UW9Pbkxt?=
 =?utf-8?B?clJaQXVaT3dOREU4R21qNVNDcmh2YmhnTWx5eE1xUXBER1JVWkEzRnNBNXNX?=
 =?utf-8?B?UVN5ZmszRkNMK3d3VCtxZWo4SEIzRG1naSthUGE3eFc1MTEyNHIxcytmOEVV?=
 =?utf-8?B?Q0wrWExBRHhhb0N0L0c1c0ZMdHVldU03c2YvRTUzY1JaL2k4OEJxcUNaNWJI?=
 =?utf-8?B?MG01REF2TUk5cWdLK054eUd2R0xXQ0ZKTmwzbDh6UE1PeW8ranFVTmlPUmMy?=
 =?utf-8?B?dkxXeXFReEwxZExnc0Q3QzlSa0dSS2RuUmRhK24yRE84SVArdEx5bDFvTmpm?=
 =?utf-8?B?YTNHUkpnZW5ncmhHYXVvRmd6NmVMcmNrVTJydVIzbGlKeWpTazRhb2laYVVk?=
 =?utf-8?B?ZnFZUEkxT25ZVUJZWnpDTzJNanRHQXBnSUNlSEk4M05WL1JrbC9CdHcxN255?=
 =?utf-8?B?clNlZlI5K0M3M2VEZ2lWMWRGeVhkWnQwUW5jTDh4Z1FGWTdpdXRIdEJZeVMw?=
 =?utf-8?B?QmlmdXRZVFF5WkRrbDJLODVzM3NWcTY1azVoK1ZaS3grTU1VVjNtbWx6T2Jy?=
 =?utf-8?B?bXV1V1FBaHEvbGc1NnhyMURJT3ROdVB1MHlaNnRTQ1JuR0ZtVWt0bGJDOFda?=
 =?utf-8?B?SHA2dkZ6QnVZb0dJeXQxMUhzRzI0QTIveFpabDk5MlZqdXF2L1lMYlBZN09Q?=
 =?utf-8?B?ZUNOeDF1N0VjRXlDbTBjbWZhaisyeVJZT1JuOUYxVDB3ODRlWjA4NkI1bnZs?=
 =?utf-8?B?ZVhPdzliendMK0ZrYm9BbG82RmlvZDRWN1hOMis3di9qdzdML21BTlU4WnBt?=
 =?utf-8?B?RFU1Uko1a3lMTGMzdDBwMEVvTWJWRnFwTjgzaVBrNU9FN2JpSjg4NW1jazdh?=
 =?utf-8?B?MXIvVENuVkdlWVNhazRFZDRoaU5ZT3RDRVgrNEUvbGFXNUZhTDROS2FjYVU3?=
 =?utf-8?B?b3NoTEdiYldubmVnVS81NmUzVTVmaVN5SmNPYjRjb291OXovRlpweUgzL3FF?=
 =?utf-8?B?dmdaOXR0YXd2WFE2Ny8yQy93Vm1uM2taNmlxS3lJcEFYd2UzbnA4Qi8vTmZG?=
 =?utf-8?Q?rrdW7b/Gu1dxv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0xXcEJVUnJSZ2J1OHVKejZYTnd5UXI2QVhhcjRCSFlCYmpralJNQnk1U08z?=
 =?utf-8?B?aDl0WjFkTW8rcnN1YXVHSUFOT2ZRbTlJUlVYdUhuRU1yRHFFdnUxRVE5NWti?=
 =?utf-8?B?SEg4SnZUOWhrd2ZPZ1RHQU1iNENweGNVOXRFRTZwWEpXcW9Vb3hrdGJRaVpX?=
 =?utf-8?B?Y1BMMHRPL1l6aElBVDZYVHVrR0xKSHBQczhEMHpIcE9aR292bHRvTUtFejVa?=
 =?utf-8?B?THI5S3ZxY25BODM3UysxZlZoMWlCaUlzQWVycFFjUmJac0JOVkdkVWhPM0kw?=
 =?utf-8?B?Uk8vdE5ROHFjd2MrRGJ4NzVaTEk2ZHgwTmlMUmdMYis3NUV5dnF3bkpZUnJi?=
 =?utf-8?B?eVRuTXBZQkRrWjNjdkRYdmtpdEhaVGJQb0lPbERCYmZEaDFoRFJnUWNFVjdJ?=
 =?utf-8?B?ZzhnS2F2K1NYa1Z0QzZ0RytwNW1ScEN6RWxhVmJlV1pjT21QWitDUG4zVFND?=
 =?utf-8?B?WnJNR3RlN09PY0lnV3hDUVc5Y1QvYWNZaE1UK0xlT1dLd1gvVTJoU2ZPOGNj?=
 =?utf-8?B?UzZsRW11VnNlWGJEMGJsYXVsM0prL3ErY3dVTnJrek8zREVvVjMzdkxSZDl1?=
 =?utf-8?B?RjNYalVSdzZwRmk3S21uNEJCNC80SE9HanRVUWsvVnZZWDArQ2JOVTgxR3lX?=
 =?utf-8?B?L2dTazY0czNoazhWOWUxOStXQlJaRzY5b2FLNEtocldhT29JN0psWmdKZzhM?=
 =?utf-8?B?a21hQ3NSbUdhUlpGU05MNmhhcFBSUnI5enFHS2ZObGRZZjBRblJsQVVoY0xQ?=
 =?utf-8?B?TW5YMXplRkdrcnQ5aUNsNXF2NGFoZVhqTGlNUmdpVFB5Qmdabkp5REF5WFBn?=
 =?utf-8?B?SUxNQmNmaHM0YW5DWWdpR1hpS3h0cGZQRDZLb3R6VjFqRnhKbGc4RmJZSXlE?=
 =?utf-8?B?Y0swbDltUmNTM0Juam9ud0pjNUQwS3JxTkwrVVRjQ2RhamNMSU96eEpLaVZN?=
 =?utf-8?B?bDBpSGZmVDRwdkpwYjF0ZEFoelNsMU9jdnhhZ1dGUVN5RTZBSGhSUWJ6Y3JT?=
 =?utf-8?B?TEQwdTkxOTM3ZTZGQzIxWUoweEl3QTFiUjJNVmF5MmI3bktVSFpIOWhHNXFr?=
 =?utf-8?B?bGFEYzhlblNmQXI1QlpiL0gydUt3NzlGTGtnZms5OVJxdVlCN1dJck9WWlVF?=
 =?utf-8?B?NjdkeTBCbXFaOG9jeE9SNm9rWlppT1BHd3RzQ1dNNnkyTUNxVC9DeGdUY1lV?=
 =?utf-8?B?aG9UTXpHWVdYMDFxWmpEY0tpQ0Z3ZTFmbVJoS3lROW9QVzJPeVRROWlWWHE2?=
 =?utf-8?B?akIwUHlRV3djdmRhU1hmcFBGVExJaDVHNUprTHVLdjZQd1pzWG5aWHV4U1Z0?=
 =?utf-8?B?NHZKU3FQeFhjQTN5eWUyUnpOcEJFYlFKdE1tMXUxMk8zMzBMVzAxUWo1R3lr?=
 =?utf-8?B?VHhWV2tTNlRDaUhLUUJpOWo1VjE1RWErZDNVTk5JekV6bzJMcUxTbDcxMU9C?=
 =?utf-8?B?cGNlYmVHeFM5ZThBWE1xTWNqTVNOTk4zdUdoU0djN3Y5eTVXRlErZEZOM0xO?=
 =?utf-8?B?RFJUUVlCbnNNbkpORDB1NFdKOUJ6bWF3ZTgxbWw1TndsSFNGV0VweEJRODBF?=
 =?utf-8?B?STl2aUhXdDhlUFpVUVRBdkk5bTBQU0Evd3RLbUUraHN3MTF6d1lXeWpjclFI?=
 =?utf-8?B?YWxSaHVGY0gwNnRISEpHSnJPd2dOU0VxcElXMHlSUTRDSWV6ckpWd2pOMmQ2?=
 =?utf-8?B?UmdIbWVoL2NqUW5jeDRSUno5R2pFZFZzcmoyVGdURlBxUlQ0Z0tLUnF6Q1Nv?=
 =?utf-8?B?aVIzaEZBVnZnMVpoWEdFUTVkR0ZEOXdHelU4UDhLQkdkdys4T0l1cFZOVlZF?=
 =?utf-8?B?M2NNbzBvLy9jYUNFVGMzbEczV3BsV1Bwck1rYWhpdTFlbzN5Y3hPaDNOZGVN?=
 =?utf-8?B?MWlaREJyUzd4aWNNZ3RyL0dKSWVnWGpiQmNkT1lpK1l0TkExV002MzQrb1dI?=
 =?utf-8?B?RmdOWGxtMUlHR0VvcEMzWEZyWmdaYVVIbzlZckZraWxiSkFYWG9aTXpxSDY0?=
 =?utf-8?B?OFJRSlp3SDVhR3c1UFdhd01Td2hzdW9GWG14Nm5NVWtmbFpnQlZXZmlYRHVy?=
 =?utf-8?B?aHVzTVd4VzhhZ0RrbFN1aUl0M0p6Y1g4a3ZxYWJIdHJxdHBUdGVsLys1NHRo?=
 =?utf-8?Q?1w9dCgiqaSrb6sIaje2K0+UyT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c23579a-3d80-4d0b-b343-08dcee218d35
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 20:31:45.1031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vO39xYqeBQbkF95ABuU5xHt2IMORg+s+q6Uz+pN6/OR4CyZtgJYQYV8M61LOtODJEGcJ1y4BbCUdXO8ItPPvAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9845

From: Priyanka Singh <priyanka.singh@nxp.com>

Fix undefined behavior caused by left-shifting a negative value in the
expression:

    cap_high ^ (1 << (bad_data_bit - 32))

The variable 'bad_data_bit' ranges from 0 to 63. When 'bad_data_bit' is
less than 32, 'bad_data_bit - 32' becomes negative, and left-shifting by a
negative value in C is undefined behavior.

Fix this by combining 'cap_high' and 'cap_low' into a 64-bit variable.

Fixes: ea2eb9a8b620 ("EDAC, fsl-ddr: Separate FSL DDR driver from MPC85xx")
Signed-off-by: Priyanka Singh <priyanka.singh@nxp.com>
Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/edac/fsl_ddr_edac.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 7a9fb1202f1a0..846a4ba25342a 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -328,6 +328,9 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 	 * TODO: Add support for 32-bit wide buses
 	 */
 	if ((err_detect & DDR_EDE_SBE) && (bus_width == 64)) {
+		u64 cap = (u64)cap_high << 32 | (u64)cap_low;
+		u32 s = syndrome;
+
 		sbe_ecc_decode(cap_high, cap_low, syndrome,
 				&bad_data_bit, &bad_ecc_bit);
 
@@ -338,11 +341,15 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 			fsl_mc_printk(mci, KERN_ERR,
 				"Faulty ECC bit: %d\n", bad_ecc_bit);
 
+		if (bad_data_bit >= 0)
+			cap ^= 1ULL << bad_data_bit;
+
+		if (bad_ecc_bit >= 0)
+			s ^= 1 << bad_ecc_bit;
+
 		fsl_mc_printk(mci, KERN_ERR,
 			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
-			cap_high ^ (1 << (bad_data_bit - 32)),
-			cap_low ^ (1 << bad_data_bit),
-			syndrome ^ (1 << bad_ecc_bit));
+			upper_32_bits(cap), lower_32_bits(cap), s);
 	}
 
 	fsl_mc_printk(mci, KERN_ERR,

-- 
2.34.1


