Return-Path: <linux-edac+bounces-3890-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F86AB5B87
	for <lists+linux-edac@lfdr.de>; Tue, 13 May 2025 19:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B133F7A3234
	for <lists+linux-edac@lfdr.de>; Tue, 13 May 2025 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A572BE7B8;
	Tue, 13 May 2025 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qIce/YCm"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C62BF3C5;
	Tue, 13 May 2025 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158270; cv=fail; b=EEerZztZTywLsRDrerB39c+JErexQXVtPurgUOosRdrup+HqX1/CFMp4Xe4CSQfnSpPw4bI3LyY0jDJA21TfKGHd6j3lD5HKT0WSrSzRkSQ4KdVXBRLWs2GyS/sLxYAj2HvxaXqUEihYe50DVzrs0W9veFjkSnD++pbilbPB5RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158270; c=relaxed/simple;
	bh=ZdDKc+saLlhC5QlbFU1SC3D6wh+sS5SP2kDomSON2ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zs5xsdYvq3NrodI5cVh1T5f+lyCGaV1KhxG31dhJHgPj3f4lQjJ+DUdCuFvuB5KR4KlQQJFeNo+Q71OB99AMhtNADuf0uItw5+ujbqFuf4cZuWoMMm8qoMk3JpQAIWKwtJKBg7DeRXMto00d4KRNQiw27HSe9hIcr/fNtdGEq5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qIce/YCm; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8KG3NxfjRvYMZ/mhVRFIkLEyf0vVS+xJrEpXm1Fqk3WKOSbauL7Sgrep51EKev20XqNt0RYwS6j4Fd9mtGZGwNBLK9QSVCWd5L4pdHyYQPOdvcK3tgIqP94sB8C7K+kCG9I2IjmvD/6Phc3ecFpTt2+bx1QawyfJUPXGiuvOri3irwlI4uzGBwpUPalQCh1sRToxLLaHlzIL8Go5+JFVMB2gI/n6jhg4MibxQXvAwniSXrfiQnCxFWKTItfl+Qt0jBw5OgM228CdhUdidrdVVPAqsLAwBcW/IoTyS56urO1T6VVOkpf3tYyCkkiOYIAy9nrkjGQwijyPWLawsphdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcO4XLAL1M5J4t5/tKbhUIoXoYGYDgamfMMmJH397lY=;
 b=vEKDq4RhCaoLHWkXBQoBDaN043JrsUebPNzNDsvjVyRbPCztdqXkS2lqj2BSpgHXezl1uJwyUe+hPR2id5hwupfDIYGnymmo1F34W5uyysIEcCvAwwPP/M15YDLm5QBwg640SIRN/TGy8xj1hIDssdTlPnB3HYzrTCoShaTmWZuW0BrPLmsCtx6NlgVrj5wseehkzrZseDFEqpyxU/BJnoXQatSdJKRK6rOsUaZYW2GMe6E9cCCOdwWY9GQHVhmicyPWElLM+pd1TBQew1PCaDr/JQkAdgngIkGYawiSd3ZSc0OMtCUDAnxRjucprbuHufweiX5YOIvfk7zgFvplVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcO4XLAL1M5J4t5/tKbhUIoXoYGYDgamfMMmJH397lY=;
 b=qIce/YCmOTV17S2ahpuljmLsTAME8IewMFODJmr4TELVSlt0zbLxY2DY/HtrJQehj5dmAusBBGNjUEyTc8NVvMePbNzK6hkt8FLgYnT+FTD6KpL4P3TAmBwMrPegkpdwhDsWtd0Cfh43b7eCJk52VymPUU1HKp/gU4K0SheAH+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 17:44:26 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 17:44:26 +0000
Date: Tue, 13 May 2025 13:44:22 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 17/17] x86/mce: Restore poll settings after storm
 subsides
Message-ID: <20250513174422.GB214682@yaz-khff2.amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com>
 <20250512074616.GSaCGnSJbBpToh2VM6@fat_crate.local>
 <20250512154315.GC2355@yaz-khff2.amd.com>
 <aCIZZIsee7roLlNZ@agluck-desk3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCIZZIsee7roLlNZ@agluck-desk3>
X-ClientProxiedBy: BN0PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:408:143::21) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b5d901-06f5-4310-55d7-08dd9245cdce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EOd2yyaIN9wKmNb4IMzSttP9SOuXkgnpoJ52O8BTniezB2AY1mJ4WXJSmc+K?=
 =?us-ascii?Q?Cc22Uq4i3o6feCy7QKVOj6on6Q2zyTiZYiPIEhYdYOKGtDs2Os/Dcye5zzKm?=
 =?us-ascii?Q?RIdM0xepWtIA4XnOM+YmqhS8HUcdGdzS2QwOoQtPC93l0kTcxgbkhzJDWc6S?=
 =?us-ascii?Q?Na8QBImYbJMh6R9WmZO//xKEdHcIDTLlY5RrS+aXeRo6Tl/q9tZUidnftjKN?=
 =?us-ascii?Q?Q/ih2A/oQ/Jf1gAKlhy0xFDSjpeonx+/ARq/oWd8rmtphKF1sl+GsGUQYLjR?=
 =?us-ascii?Q?lZ6mToixoFAHyrm/XmVcHiAuZMaJzs+/QOXDjpfv50MyklbYqieuRvsp40d/?=
 =?us-ascii?Q?CnKigoNXGNzrX7wVc5i45bLVDOZjtRsqGRaSt5m6oAe83FNqz8E/BAHUC95z?=
 =?us-ascii?Q?g2t9/zLD1VpCVQUQPO3pZ8ClzY7CuvXOc63h74wBG6o9F2e5kW9X+Avey3nm?=
 =?us-ascii?Q?iiNPWhjdiOi7054s4gJX6zrCKyJHp75LDs+qMiSk4/ZXITFIBtbfjHSjpdPB?=
 =?us-ascii?Q?50ixzbmK19EUF/iMdYDC2l845dnNW+GZtMyR42XIuIeR7onFgBqrIQ1emA9T?=
 =?us-ascii?Q?LjZ7tPBpP7HXb/fEtcmIlb0PntC/1wsu5PZ18M06KNKEZTcGTsx6UdSopKGU?=
 =?us-ascii?Q?zCDWpKj49BR4m/4jISLiSJ0lDtX9epyBWBcK4Mv1SqilycrB0+JZMtXavrBU?=
 =?us-ascii?Q?HDnB27JaFFNg39H1Qb2ydI96YcKqyBd4fk0Y6DD/c5wrIeOjRsj8ZQCE/Nh1?=
 =?us-ascii?Q?YN9Wn0fj44JeZ99SErE8GTBnvRejlakWCk3+GD6kbAiR+hE64TIpl5k3/H/A?=
 =?us-ascii?Q?TPogv8noSlU+p2f/qo/BEXRFUooRgEdlbl0LWJXRyGUeZcpB3vOfwGWsUd2w?=
 =?us-ascii?Q?z5bpfpRMhXKdEGAtubuxBebOzzUJYmtJJzk1tEuNjfBgUWOG5ABytxlvL21H?=
 =?us-ascii?Q?wxaW83aEQCL0BAh2HhUL41sy13N2ZaQWGkvH/eGJsxGolHPLEAWcxqAbzS6D?=
 =?us-ascii?Q?RR0OH3y+dKWRBjW85tWWZnxE3+B0YxZSDTBf+avq0/M+QSinHZD9rjt+e2FD?=
 =?us-ascii?Q?IX3lEmlYDOj43HEApIUcdyQRscEfJ/Caicb6nLyEmpXyJQp6k/kowQOy3TEw?=
 =?us-ascii?Q?e9c3LiT7f6yb/BojaPwa3JO7+gQ0GgAZYQ6zJBZkIWCiVnuc7yUj5D9NtugL?=
 =?us-ascii?Q?S2299ciSLDjUUQ2QQk5cPHAas17WoHV85UWr9i3wZkHQJbjJaTOgmCnlOpdd?=
 =?us-ascii?Q?VEpz9c24LoJgQm4ImFN2hh5UWrbJsI0KGvzeobl3m79IBrClLrdXlR0UQGs0?=
 =?us-ascii?Q?UjEnRAtxDLgGLw/82RfyxzqCeL9377Q9CUI9Vw7UicAPCZb5n7F3qwdubx4l?=
 =?us-ascii?Q?rV11cUbROz1gwDjHI3+Bk/vzocc+8tZeqJKkjc+EKxSKtxDyZo/l0CZsG4Hm?=
 =?us-ascii?Q?cdaO+eAgp10=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g2QCjntsukta1Hj4RfYKAiiVs6Ja+UZQTnboKD/lifKo6Ey29SHBozdpqPbz?=
 =?us-ascii?Q?PVzCPU0GBuQ3Or01jYUv0ZFFyxtSX++mesDGb9vVwhenZu4YKQTQDlx85oXp?=
 =?us-ascii?Q?qlycnveoycXpRMuAk38tsXILmgX75xXodv6eRfxpr8XBd5ykci98DIb6Zh3i?=
 =?us-ascii?Q?bFxrZE+xcYyBx7+E5i9X+Rh++haUVo8lHPPOp+Yq3hoEuKynR6LZvcacGPsX?=
 =?us-ascii?Q?DbPBDhZFRE6J5kDlGlbZdMF7zf4YGu3QlMNeZv2SkmlVtBHSY4kuYI/8uZab?=
 =?us-ascii?Q?buY6wyfNMUzKr7arSyGgeMsJTiubShqxNO0iBLliZJEmXP7kymdhTKtpqbg3?=
 =?us-ascii?Q?yGfCr1OcVx4eGiZ+igIPsi1d3upByqCF2Bf8De530PHeDrTWyJZsCV7qNFWe?=
 =?us-ascii?Q?TbzX8aecMAqVmudgL1igJhCdgm1U2HdivBcMpSBuDwpDFo5MWrjno3IpxQcR?=
 =?us-ascii?Q?4+Sb07475gVLRlTaBoHfjwYPaseNv3ffKrleIQud2BmeGWUS1/fgXrJk3gsB?=
 =?us-ascii?Q?DJZTbB9Cq4J24HFvKLccaFBReAyYkuNN2rKK6yI3aqJBQY3+LfWg1Zo5ratH?=
 =?us-ascii?Q?Bpv75fv19S6HagVFJ7MmvQUQTTHmYYRzhaC4SQOFzattALXOOm/byY7q+Sa/?=
 =?us-ascii?Q?JuMLN+IzLH3QDrc9G1FdjNqA77f86NlZXt26IfNlxvYhr7JrbrNuEfa+gQxp?=
 =?us-ascii?Q?DxAsc9117BI4sm7mv7EcDMU7N0MAQIgg/BmD0WpENbe7SG5yaAq4LuLjCTv2?=
 =?us-ascii?Q?lvz81kV/M13vQj9PNUkmVwQyE5PQUcAHBFYO8ibGHx4YXtBZNvYV+cb8rdjZ?=
 =?us-ascii?Q?HLHmBrBjDsL4Sc49Yz1y6FhmKPyloHEGAe9+DfjjpYQ9PKWnDtTtTMU2yqOq?=
 =?us-ascii?Q?SYsUz8UDFvDcs4LZxgk8soxEQcVQwMez6NBV0yfedWbclPz2wEHC++1aS1Vn?=
 =?us-ascii?Q?N66cdolLHp4V+9uzGngZspQR6M8+k0ha/BQm56Il/zgjEJ3vZ7/wNzSoe2Bw?=
 =?us-ascii?Q?ywZ3w5z88wQyjchfD4xdzNZrE/qqu9/oFjovCtnSGdZYEmOgTpJYdVe3YDjn?=
 =?us-ascii?Q?9t8B+IlbtmiqZNCSUt6FhZHYac8ysfanp47hrSq4L8Mfk3IvizJJQ/2KvRAi?=
 =?us-ascii?Q?HDtIoByaI+Rc++gwCttC0KcM1+193I0ODDbvOlIzqnIuilQHrceX7DopzwxC?=
 =?us-ascii?Q?tE1KWl1NwJqHd3I5+ymD18aynb1pese971ZPgub1OJZm3oSPHFcgWytoLo6S?=
 =?us-ascii?Q?H83Bz1Tu8IOX4TljTJUPNySTlAno9ooPcqDGUqL6wnh0+fIyvgetnVLRj0/k?=
 =?us-ascii?Q?iA2UZNRjIaRL0Qqlkb5JZqLjEY839AS2yCIXM6bKPwecUhgRzSF0DFkI+EzH?=
 =?us-ascii?Q?sBB86UgztEaQCy2rO5PsIEzDA2UMJm/VawcOs23sh4uLzj2oAz842puPmMCf?=
 =?us-ascii?Q?247GToSqqXTRqhLy25wi7nFCRRp08NEhPx91n1yb/Y0nc9MIhv2r6w3mHQ1Q?=
 =?us-ascii?Q?V3VsD95MONMqgkyaEl7e2bZ5tzgchh76rE/fQ4Rlwo/w2GkkLQHEhmfT4gj7?=
 =?us-ascii?Q?IylJT2NvzB3dB1uebpVu7Gee4JJGya2An7jIK/UT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b5d901-06f5-4310-55d7-08dd9245cdce
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 17:44:26.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGPA1yqh4BziF+ZNDWcKhm8jyHHurNMZLyHzpmfHE7lhChC99rBtfEz3u+8B3h2PeF1uTAboqqoZAqd5KjF5HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716

On Mon, May 12, 2025 at 08:53:08AM -0700, Luck, Tony wrote:
> On Mon, May 12, 2025 at 11:43:15AM -0400, Yazen Ghannam wrote:
> > On Mon, May 12, 2025 at 09:46:16AM +0200, Borislav Petkov wrote:
> > > On Tue, Apr 15, 2025 at 02:55:12PM +0000, Yazen Ghannam wrote:
> > > > Users can disable MCA polling by setting the "ignore_ce" parameter or by
> > > > setting "check_interval=0". This tells the kernel to *not* start the MCE
> > > > timer on a CPU.
> > > > 
> > > > During a CMCI storm, the MCE timer will be started with a fixed
> > > > interval.
> 
> I think you just need some more words at the start of this second
> paragraph to avoid confusion when reading together with the previous
> one.
> 
> Perhaps:
> 
> If the user did not disable CMCI, then storms can occur. When these
> happen the MCE timer will be started ...
> 

Yes, good point. I'll update the commit message.

Thanks,
Yazen

