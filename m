Return-Path: <linux-edac+bounces-4804-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD13B58417
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 19:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621A91AA7142
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC5F2BE05E;
	Mon, 15 Sep 2025 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dNq3/k7u"
X-Original-To: linux-edac@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD144275852;
	Mon, 15 Sep 2025 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958946; cv=fail; b=awxPXP/HqQo0fyZ3kPcBXSwbmYTcxKN5cCh4dbRCC2EWn0crzNBwDfbhE3rG1fI9UoxpSJZfIARwTuHjqY2e82KfI5hGjJl6PcpnPTxr8O5QkFu6OHuk9pEGlK5Jfvg5XvW89+OhdxIH4Z9WxiWCZwNK+L12y2RSMyFMsY2oCdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958946; c=relaxed/simple;
	bh=zPiL1sunyckDwg4zc9eGYB4lHlEb90HxkYhTHPwz0zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EYOEkKbTK8d4WFlmuwl5QtFHMe82qyPXnLipb5OIEUaxVF8gJzoUVhBYocgM6QI8F3tM4RmxDP7/ohQawfyP3uLnig8WRDkEGZUqkrP4I7Cb2ojcJ/zIgdeKb0zrpWUyy2QCqBAWkO4iXTRjn49zUE4WCSUSBZk6sBiNIkkzRh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dNq3/k7u; arc=fail smtp.client-ip=52.101.46.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdR1pgn/ZRlCECC/AdHqpzgXpzNUQICT/SPHsYP/VZxQxuK2jXxB7VqkbLWFGU6XKBBSm2uLUYT0DQ8Get/Y25ZZk3h1+pUu+0ugRUkUtSwghZH+NnzeS3FTQ19e/F6eiqScxXa46cuPDHpsul51y8QRQl66ScKwR79PkjffZcXTSDHUz5/qlTBtpgSL6ZeO9iQR4eUVL86jY7WrxUzq/JR4mKs86jBa3rg/1+isTVrotVKe50HEVKsKgT3UQKUG8vMDHB61cIkp5VHClCtLj99rZnyWdeA7nrn/nCJ6cXEk7qX3tufYhRyOzUcR5Y3rk31rxKOO3msL79D+WtWdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxnNWAAP903ihrIgAq47j8V6djI8J4wjOmtZT9UpSk8=;
 b=PujuKOK5FqeyjqT204K/n9CgRfHZ6FmCiaN0UQ1FbQr7yXamvjXtsiFlRgralQArjuMce4h2n65sBzqzpT1ZT9DGwh9TD/nsdCZsfOZCnqDa/fQq33FId8td5pN/RZTbSDL8jJ18aGySgT2Ngj4NVLGza3CSpPYns7CFb0XmB4N1FjMXTMRepNebqS96LZkpT7hH4Uz149bsjxLn8k6+NNeq8okh95MWelHqBs579njM36gv5bvvnbY/XwWj3xJbSU3tubiUYi3JYYEqFS19++Be2gqiPrXKRYqyF0aWg8pqNURgcOpctrCvH0yLC3BbkVJMW+88JwmYFIyhpZYEMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxnNWAAP903ihrIgAq47j8V6djI8J4wjOmtZT9UpSk8=;
 b=dNq3/k7u28s6Qhl4iyz0nd1n6Viq+ltg2vbIhdEstmnMqVEA4B7X/tqMUHZVQSkLgN/hQ9N9u+AwhghQSNImk/mH/vrYeGnOWiqqd/chtFrByDeWN21ffo+HQERrSHE+j3iN4PEUXEl8Wnck7kBBfQ/zUhuCQfKLx0PZkCWxTHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.21; Mon, 15 Sep 2025 17:55:41 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 17:55:39 +0000
Date: Mon, 15 Sep 2025 13:55:31 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	x86@kernel.org, rafael@kernel.org, qiuxu.zhuo@intel.com,
	nik.borisov@suse.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: spurious mce Hardware Error messages in next-20250912
Message-ID: <20250915175531.GB869676@yaz-khff2.amd.com>
References: <20250915010010.3547-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915010010.3547-1-spasswolf@web.de>
X-ClientProxiedBy: BN9PR03CA0886.namprd03.prod.outlook.com
 (2603:10b6:408:13c::21) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f45c11a-dc5c-4c00-8f68-08ddf48114be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zTYDDTkI6YPJoJe9qsTsFXk25snxzOUyUjncJz7df1VRfMYMdnR0J2y5B3cc?=
 =?us-ascii?Q?oj53yNr3Gnk+X3CXl051C8feo96zDI+ArXmGe/vdx7K7rdOt5RaWaOqsDZOf?=
 =?us-ascii?Q?po+Cldhen5EIk+/FsVkcLyhPByJAwOy+KpcjKdXCJFPNBoLZQGJCWVm77sVR?=
 =?us-ascii?Q?B8drfHOHj0MxYrMifaWdKEBDxvFlU9ThXZz7XhAw9IZVebeTIFKbVRBMyG95?=
 =?us-ascii?Q?U6OQ4iKvDqxSbFjsaPbH1MxeD33zavvdP7y8uL3xkaWI8/Cb1rnKEyeJw/Hc?=
 =?us-ascii?Q?RwKgnXjsoOYEqLiIlwJOROXEJkbfY4mQpvwgqqjXD1HOlAmA9q7jZkdjae2q?=
 =?us-ascii?Q?1T57//s6m1frkjN7Pf2yAjlbhwJftMMOroO1EP6DauERXLlKO4Gsg8ZxKPJw?=
 =?us-ascii?Q?nz3+3zLlOsUU47lmcSVciMWXei6FzXxrQoiWsqDO8JKudwzy6ktafz82w/Dv?=
 =?us-ascii?Q?gMCN6/FZIMo+EyZ7HFNvK8lCKrjsM0oaYlpwQPMKg0XkgUeei1+x0v50028w?=
 =?us-ascii?Q?nFX23tXm/VtBP1U2zCK9bAXKyXxyz0o2ZrKkoL3BS4cEOolBBdLmsJ5Z4LmH?=
 =?us-ascii?Q?YqwPjkT+4UaRIZ+klzeY2a6an1ttdh/V7iCLMFI93wMXN/hCJYGdzS4IjBVd?=
 =?us-ascii?Q?02fe67qoJ3X47uS8bTCPU1jhUt3HphLx/dYafnwFgWurqKt/V4c223r3Qrpu?=
 =?us-ascii?Q?lcanOM14HvvPt5NU5CkMGXLvjDIpaoPDDo0/X0aG4tbt4h5ccuesJD9SrFCG?=
 =?us-ascii?Q?WoJ6hgM/bGksv4Olr/TPzQ8k5DxqxLbtpFasB74F8/U3UjooJjJSKs1ySxtT?=
 =?us-ascii?Q?rZO9Doyom7FfitIvg8/cUwjESwkuxxsciXpOgo23JeZk5TvC8JXctXUw5Qtg?=
 =?us-ascii?Q?N1Xi73jGwLBGY9sM0GaIhBlbuPW63qmcSvkklUiPp0nDWUbpNHgRAlOe99Xw?=
 =?us-ascii?Q?BA1mw1FZn49PH8cIbWVVUSvhhiex7vAJhTx08gv90qaZFw89eJmml/0n5E3r?=
 =?us-ascii?Q?UC30t/WP9+GKll5iqFy3LamgGpc3A2hTcGrk5teXqDLUNDlCkBrn/8HSqLOf?=
 =?us-ascii?Q?JzUlxdnkH3RoLedjBdBhG5ryEZfh6JtarRhzcOf/xqj2PbFV1OHYqZ73Q1Ap?=
 =?us-ascii?Q?+O2XUnMj6wTrIErC7DqjTLOCF2k6loahy72svZNR7W8QLetcGPXh2mj8R+qA?=
 =?us-ascii?Q?lRNUFqEISQ/pN/+ALnyLPnSZshJEKnNnFvoxaeMVaut9lW28PO80n8DZR1F3?=
 =?us-ascii?Q?QpbXrau0EocZTd/1/TeI9ukF9ItKi3FTWrJpEnbUCAbw6oMf3hgAB2ToenWL?=
 =?us-ascii?Q?tqtXmV+72OPYkOCl/XFsBehC43i6gvG61Z6SckrQQ2q9VnRPble+7QKPseAg?=
 =?us-ascii?Q?KD+N1aEQ9wKQRwceDWXY8yiZ2CgWhi7h2BboDgPYmAK8DXG2q82suLN6iHP2?=
 =?us-ascii?Q?kYWn+C+drWY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AN0mHVC5sPx8HmYC/j+32KW5W9aksdJibXzO032PbhGUg+2EIu6nG03qfWjB?=
 =?us-ascii?Q?GLQ7CUkExflY9pgH42tRpOdzi/iVgse8/KfQZcLugVB5ocpj1wlFBS5gIsCa?=
 =?us-ascii?Q?osemZzkzMJmMHXG6FE2Hs7XBCDGb6xwzWRCyhpuDwri/uX0cM+9082lbtCrS?=
 =?us-ascii?Q?9/MCa6Qt3KHpQlIEBdM8nLnKLbrnUTMDmKMg9mvTBQ49O1sG93SXcr6MJT+1?=
 =?us-ascii?Q?9bHbBQV9fsRsChuz19u/3AZPNu8XBpqhHgVdiYO2XSY8FeiWjHZyt1ze/6KK?=
 =?us-ascii?Q?sIPCA6ka1W/DKlyKrZUTT/6zN0SmjT1QEBYf4ig5yNbfA0ThXOqqoTe5GMhp?=
 =?us-ascii?Q?YWd++MAIU8qAtpLaSJnBBcGdDlhh+GwnEDV3OunDwl+Ch02o9b4Xk4ESYImh?=
 =?us-ascii?Q?ycZBjUgg06q6w0D65rEwzSV7hKETI3z7B7h6yN6eNfgzu3LFJj9SCSPmdUKH?=
 =?us-ascii?Q?cR9BLU57o8CyxqyGA8ykLCJur33NtGgdHq5XHY+ducwoUngzbwxmwpL0Sf5W?=
 =?us-ascii?Q?x4vlLxp7ek5bpD8qFpOdIMJBZHfQvvd97U9t2gB46bUK4WSymr0JwodHj34f?=
 =?us-ascii?Q?acTJpCrLmE8qn+5hGutBkJMZ6XCmD13Hydo40ErmYItQuqzlCYjTueEoQO11?=
 =?us-ascii?Q?UTSduddGq7hTsV3RXxTt45Uh05EHRdIylbdh0VMYCn+1GD481fXjih0hHBG0?=
 =?us-ascii?Q?E2G8nQ3rLpytnhzW2f4sovswJ+TzU1NmfqbJJK1x8O4VCtWNpy6Up4efujH9?=
 =?us-ascii?Q?nwFtqS0DcpzhJC0jsNP++7WX/5QHo2UrrOBQbEsRt9rCYyG16hupgvq2O4qm?=
 =?us-ascii?Q?LvGUbAvs7Ca23GQe2SIoTmRbHcQLYz4Mqa7jPGHWPcVNpL8uAAhu8OgkyYZG?=
 =?us-ascii?Q?omsPR8YzeaKoXOZlX9Fhra1W+D50v6xRhJ+rJGvvYt9F6J3FqCd8hOaTwJC3?=
 =?us-ascii?Q?/nY5hywewbjnHMuo2zWxvHAa+EHCLAD0KYqtEflFx4jser00xBG/IEMBi2BO?=
 =?us-ascii?Q?fcAtb2RXAQyfKEKOre4vYr+6hqymjdVIixXo/CxlpKy3ouOG95BayAHw+OIU?=
 =?us-ascii?Q?4sb4buBTbFQx22Rlg9nMP/V1B4USsw296g6uoRpGZLZIp2a+8nJhPWuwImr8?=
 =?us-ascii?Q?sCb5YHr2BDRY/TP063I1Hm/YM1bKj/7JVWS5vcHj3mcitInKP+L60Pt8fQX/?=
 =?us-ascii?Q?JgPqAmX0AOEh4BaeaNCCFoprxnlT0WjeMhZVcDHSpP+V/XrttNA6htMdh7Ax?=
 =?us-ascii?Q?QbsSNsJVVcUpMANThI9hhRt2aIezmx64j8GKJMwQA7diBuA7/kwALXSaarEd?=
 =?us-ascii?Q?SksSEwA8BFeavG+48eU1Mbr2IjXfqpT11X5o8e9xBPix9mgPVcGKfo1F9Fj0?=
 =?us-ascii?Q?UN4iSS76Avl2hxLLhemtyFlC5J0FPmSJhJXpDTlFEvhzq62KfUj3a9e0IA7/?=
 =?us-ascii?Q?/LeZcucaxMhfLVMspVBGfTBw27zAZN3M9OcJVT33YmsmBTtUAsFUOazMy1fw?=
 =?us-ascii?Q?asHDQj/QrqMEv1nNi+YrRPQnz1MOEDW1d/Ylux6L4rQnU7WGaT6A6Y7hfgSo?=
 =?us-ascii?Q?bHlQD24V/H63+/Y4Mq7d1iNIPHJ29RJLHoq05fsM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f45c11a-dc5c-4c00-8f68-08ddf48114be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 17:55:39.5048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cTzQPD/UMP7FXZHiZJ7AKmJV9mZcpZfgM7Aa01WUUnNAZfQOmz1NbTYbLXbBvBb3N5du5ez6oCDP162dgA0dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

On Mon, Sep 15, 2025 at 03:00:09AM +0200, Bert Karwatzki wrote:
> On my MSI Alpha 15 (amd64) laptop running debian stable(trixie) and  
> kernel next-20250912 I noticed the following mce error message in demsg:
> 
> [   T10] mce: [Hardware Error]: Machine check events logged
> [   T10] [Hardware Error]: Corrected error, no action required.
> [   T10] [Hardware Error]: CPU:0 (19:50:0) MC11_STATUS[-|CE|-|AddrV|-|-|-|UECC|-|Poison|-]: 0x8400aa4800a90139
> [   T10] [Hardware Error]: Error Addr: 0x006637a200000020
> [   T10] [Hardware Error]: IPID: 0x000700b040000000
> [   T10] [Hardware Error]: L3 Cache Ext. Error Code: 41
> [   T10] [Hardware Error]: cache level: L1, tx: GEN, mem-tx: DRD
> [   T10] mce: [Hardware Error]: Machine check events logged
> [   T10] [Hardware Error]: Corrected error, no action required.
> [   T10] [Hardware Error]: CPU:0 (19:50:0) MC14_STATUS[-|CE|-|AddrV|PCC|-|SyndV|UECC|-|Poison|-]: 0x8724ac0800000000
> [   T10] [Hardware Error]: Error Addr: 0x002bf52e00000020
> [   T10] [Hardware Error]: IPID: 0x000700b040000000, Syndrome: 0x0000000000000042
> [   T10] 
> [   T10] [Hardware Error]: L3 Cache Ext. Error Code: 0
> [   T10] [Hardware Error]: cache level: RESV, tx: INSN

The error messages are very odd. The MCA_STATUS bits are inconsistent.
They show "corrected" errors with "uncorrected" bits like "PCC" and
"Poison".

> 
> The messages start about 333.34s after boot and usually appear 327.68s appart
> (Yes, these timings are reproducible!):

This is likely because the errors are found during MCA polling. The
default polling interval is 300 seconds. There may be some drift if
other tasks are scheduled at the same time.

You can change this interval by writing to this file:
/sys/devices/system/machinecheck/machinecheck0/check_interval

Do the messages follow that setting? IOW, if you set it to '10', do you
see error messages every 10 seconds?

> 
> As these messages do not appear in v6.17-rc5 I bisected the issue 
> (from v6.17-rc5 to next-20250912) and found this as the first bad commit:
> 
> cf6f155e848b ("x86/mce: Unify AMD DFR handler with MCA Polling")

Could you try another recent linux-next build without the MCA updates?

It looks like 'next-20250911' doesn't include the commit above.

> 
> Are these error messages a new error that was not reported previously or
> are these error messages a sign that the new code erroneously reports errors?
> 

It could be that the recent code updates broke something. Or there may
be other kernel changes causing new, spurious errors.

We could also be picking up errors from the hardware that were
previously ignored. I'll ask our hardware folks if this is a case we
should address.

Thanks for reporting this!

-Yazen

