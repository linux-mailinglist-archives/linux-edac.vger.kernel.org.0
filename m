Return-Path: <linux-edac+bounces-4820-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F0FB801F7
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 16:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 096587A710A
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C432F532F;
	Wed, 17 Sep 2025 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WkJtyR2T"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA942F5305;
	Wed, 17 Sep 2025 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120124; cv=fail; b=i+fCzRnaR4wOt0LAT/KwasnY9Lq7UzHou7gAEspyWxgPWf5lXOyP8wWL0fk/F/q94VSe/hrDjx0BVucAbfjxYjAilxFw+UhQmnWeVJC5LZa8eml8bHc9egAuN8eaCNBQzJzZTl6bi+CrXOPbP9zg8f2clrk+3bL8MMt0NCJ1Cd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120124; c=relaxed/simple;
	bh=xDU/tyHGLMP1ecPj6I+AoNoakZzTT2ZZrnT0vG7/Iqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VhN28uYyWCcuou3XXMn3wTQPb2/UPvw40qEaIb0kkaWUplUi2gLxTdL6bIWVFWdLCsCJd2bE1QMHedpGWT/u3HNZiixvUXQMOK1Mjuwy9AWkRwFpccNw5OB/HHXb0siznLy+7kMxFEWkU3KtFACw/E5n/7n9yy7Td1maoDnOG8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WkJtyR2T; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFGduG4W2mwsMri6QIUBtfNn3toLfccScArfyJdys2q90lX8wBS60w9XEHoKSyCdAAL5hmvGY5tQgNEFB2OZWlVM8KybywfZ8rHslOMSxuZ0Zcqaax9xMW78AYfK/E6M2OgZpFlQIPj1YGc/GSUz9zFnVul3YUx/s++d14YLOZDHfdMgtxhfjxTPPthHu8ipbuFsl28TTRWdX44w9k3HbzIIpzVyuMI4Is2SCEUAeFPbqKGXQ7gkzce/TwfQm5SOxwCUmqqxLrx1vf1U1bDZewj4zhxOXb+gypDi+SSfjXIxYBc+snV4wI6KHr8GddhNLKyzmkkRn0m50l68MlrRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PglOBcISjwugslK+cGvY2adCxXxtpF4WgqXhthEJTx0=;
 b=OmJcaWviTvdcFoU4hnbG9pPYFhAtqYoDkRXzOXHnrAViZWZrS7O6d/9/dFFUmXdzulODa7tMheElo1dci7kVLfmhRwVXJlttP7saPVLR8qzkARsl5Pt3vupgJYiaJR60hTBfsEhbmH4smLXE1NF9qxOgZmCaY89Nslt5dg+elTtP95jsddbaz9N2jQ4zYH/pPElXkigfgl9cBTB5Kc+UgSa7PR5gvVKPyyxO+d6kkf1hMUjKSMRRdsM00hAPcBCDR72nDW4ZYffhG+vHq+f7Y5GU9OZTPTC/TkjCZcjDUyhoqdZCaciOQWP+/Faq3nCh1FYMvLRBtZ4aMx47wNcfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PglOBcISjwugslK+cGvY2adCxXxtpF4WgqXhthEJTx0=;
 b=WkJtyR2T7ZPMaaUgFifiv7W0Ask2HwXaWygs/zX2k5PDQb25gh5S9VMeO045+57RHCJb5BjxNX9YUM3RehB8R6sWg7u8DJ0g6xrcf9dj+HUQIg1h1fURRzlaolHMi5V1pP/fWE6m82tgn0/i6bF2GZxIUkDA2yv+8dLfTXf6wQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.22; Wed, 17 Sep 2025 14:41:57 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 14:41:57 +0000
Date: Wed, 17 Sep 2025 10:41:48 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	x86@kernel.org, rafael@kernel.org, qiuxu.zhuo@intel.com,
	nik.borisov@suse.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: spurious mce Hardware Error messages in next-20250912
Message-ID: <20250917144148.GA1313380@yaz-khff2.amd.com>
References: <20250915010010.3547-1-spasswolf@web.de>
 <20250915175531.GB869676@yaz-khff2.amd.com>
 <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
 <426097525d5f9e88a3f7e96ce93f24ca27459f90.camel@web.de>
 <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
 <20250916140744.GA1054485@yaz-khff2.amd.com>
 <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
 <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
X-ClientProxiedBy: BN9PR03CA0764.namprd03.prod.outlook.com
 (2603:10b6:408:13a::19) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ad0e42-22ea-4b80-1aae-08ddf5f859dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wi/RKK5aBgWwaiCvBtoCVnrYvs14/45VkVwgG8U++WSvXUoQ5pECTfHWSlEJ?=
 =?us-ascii?Q?HrgPFy6dDBAVODeqDAFILavBRTIhtnq6Fq50XON/yI8WxcL5N83gCAXOz+7E?=
 =?us-ascii?Q?oi9xveXn2O6pEToYcFuML9VzQR91e0/wCDqbtQSMxcPzQLjBbUpPeYs3FLHq?=
 =?us-ascii?Q?jvtl8JvekiI4p2Ws9zU+U0IZ0HseTRx7BBPtSPieJ0Uj4ae9enlN4zK2O/rw?=
 =?us-ascii?Q?0ExZ4cNsb41QeHrlnUFQ7NCb7h7BUX9r08YQM24IozaBms3thWo9As0J7Vf5?=
 =?us-ascii?Q?IwmGbE+pICtTIBKhEDdmbNLQFTGCFhVjM6/tTee8nKqiDSXWWvHw6459RCer?=
 =?us-ascii?Q?r6Kg340jVgbmvBmO1503wYB3GNXBTOlW1Bh7Z6HH2R99n5gH69IBtaXUuG6q?=
 =?us-ascii?Q?D0CJqZPQybZywkyCHU0O7WY1BTFXO+zzwHEulsN2JsNrGAurph8RtqmDLSbI?=
 =?us-ascii?Q?2AQmOCkd1qCaPbvY4kq0bl9UzA7hyBhTXb/nLEAV8aTFhVXu8Jx/1EGdQm09?=
 =?us-ascii?Q?MfUPNdHBqwg5eYowMzt5ToHe1x8SEPaUvI9u5x1QGEpvikxbJxbxSf2bip5J?=
 =?us-ascii?Q?cU/soy8lrpd8VhgQa0+/I/eyNu5llcEPHu/B7sC8OyaPs5ytGmTdDRnMeaxz?=
 =?us-ascii?Q?HjVYwsVo4342+eF1tJnon/3pVtOA2rIOkRGIlE60iLkt+T/DOxiC8uidgiND?=
 =?us-ascii?Q?Qpvp9CSsVZ/dT7+x7YpEtkVyObHgs1F09XaKYhNCyj1Qdd+djygvnqGGVde2?=
 =?us-ascii?Q?uNKusWImPzpIoH+wUTzVBRQqOmm0gtjYSTkCJ92KJs611JlD+A5c5goPX8Re?=
 =?us-ascii?Q?EYiQL6HlaR4Yxqc5pFFUx4JSfWHAijUgViXTONOePjbIF2zxy6Qe5BjHBO+T?=
 =?us-ascii?Q?5NIbK6tEzlAiFPycLqKS/Fpva5l11tlSdMYBaETdY8yXZr4pipIAtW3mVf5H?=
 =?us-ascii?Q?I5LXyLvVWiB2pTIfayPL9SujcQVAI+s5henXw6T9Ls0SAHYehXTJgDuQ14ZM?=
 =?us-ascii?Q?9PBfG7pKwwY6Ch2nqxbExqmSAf/NbweDvm5AywCeCCh9jsIq1KWgUPfEW1qU?=
 =?us-ascii?Q?8yP1eyJc1Wzes8EJHryhIo7o1SV0dLSV9GfIgELa3/NwB2ShGS58vXoToxy5?=
 =?us-ascii?Q?g56x85TQHSwUc3lb1n1UVDGILLjI7rqScGtJAEc9+IenbXOlcT3IxFqmiGQc?=
 =?us-ascii?Q?MaN4R9BfKT5YW1YrXgDoZMab9CmQNQR0Zm1jZuhD6Bsgqv/w0eJ17yyeHm5N?=
 =?us-ascii?Q?PU/ZwDRVG3rk4RgHSxV13JtK1OTpX7yAyu1TKeegaNCunJpMg0ZRMIVviLUF?=
 =?us-ascii?Q?2ZTKyUCT2MSBYp/X3Ctg4Bt2u6tGalz5k+MZuJrPnjqjFlIUDys/KmI9sBX9?=
 =?us-ascii?Q?hYqvaXk3cvcqhGm0nItpMWcbOS+72GggN2mTakqULL9yRnWGcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DkNT6hI+0qeRRbhDmTDKw+68tLAafgtoM4i7xWzcW/45rLYWhA98lPMwULkw?=
 =?us-ascii?Q?bWHzeYR2cjoAiE/bU9NUGvjcj5V4foI80oZrjNgiiV/MqZu1ZMel1WZvHcvg?=
 =?us-ascii?Q?WcBumno6gnjB8RpD3doqrbdvzUmo0C261gr16Hnem0lpE9W8ja4Gx81XSBMp?=
 =?us-ascii?Q?YAaky+gcoPGbDYt8Sg7VqubpNrApYd73d+1OkkBVyfHduNXm4VssWKWxBXw4?=
 =?us-ascii?Q?c0fAF/++DeSkaxBLRbCJGc97AvUXax+qKqpsIsFOCn2NC5pulXGhjdCb0Li8?=
 =?us-ascii?Q?bDj3kwv0SyCBWyxSKzkhIZu4UPfN97clZGW5PO7wQOWTZgGoGW9aM7FVqhu4?=
 =?us-ascii?Q?GVkJCC9K2ASKkpgzHUbNxCRBq2FHMhxkMb0HEKSweifbshvd/H9T/F56uhbm?=
 =?us-ascii?Q?tEWDhd2xkWUcIMrF1yiay3uQdcSQX8fYzd8cuJUl2OEbtX/TPMoB9Df3rJJ9?=
 =?us-ascii?Q?DJQTgxzebDg1+4Llt3I5PJcvYoP4r0FZ67Gz50lBBrPz2AhSvSjtc/c452l+?=
 =?us-ascii?Q?nUWqOHre/nrc/G/zFpWZ5T8NUVs1iDUvofW4UpMVO2+FTfbwnle/hWqytUri?=
 =?us-ascii?Q?6vGZ086MMY0/9hwOAXzWqumFpzsPXQqJZxKkoRJZ25BI/mR3kAVgzisuNjmG?=
 =?us-ascii?Q?9bHOjGDiKloqXHJo6HRZxu5PhIiIJUDV5GKwEbdEAj6b0sBlp39CkZ2qsuc3?=
 =?us-ascii?Q?6Jxj6/+mWtiyCblX/mhMoSEn1D5BtLYN3MKGNPhBue0fMgViA94S4CxORouQ?=
 =?us-ascii?Q?p0DBNtlSTQj8JSXM9ChcekCvaMMz3LFiC1I7fECuCpoO0d7h7vhTyfjpOyfi?=
 =?us-ascii?Q?Dro0XaXjlY+7OjSYgHA+EnoJA95uZbaYNyakJTplEXL6U5J9lnmBXsEQFG4O?=
 =?us-ascii?Q?xklscJvE/PGonE8l5wqnXTQ0iUBhgUk7VywToyxODPBLQRrXb2RMb7MYP53Y?=
 =?us-ascii?Q?GjnaUWFYCMv82LepkUr9692KSPv+3uH6Nd/88wpOZdUGpMMZcZeSFt4uexPy?=
 =?us-ascii?Q?Dcej2yZBEE2u/jFBb3eTJSpLCTyanhKWectV64txCskYVHiMGSzxOhqWkOWW?=
 =?us-ascii?Q?IWWB4CtaWGMkaGzKA3mDdsB6hOqyJsBQmKVjQRqEIaypQHflRpO/v135Xi8e?=
 =?us-ascii?Q?FONRYPwLO0LYZwBmd77iWNaOtW+bt3ivAXaSPCHJ+lLLgtd1uqt+9UyvR9rE?=
 =?us-ascii?Q?qZlQwbsJmaUXqMn9Pb0EFCtqfSuspMYN3CprO2SGqSMzPi/EcpGA2uXd35EP?=
 =?us-ascii?Q?L2svqiaRwjKr922hQRicM5VpWhP//m6OpgHQA0SGBBSbh8FiMT66/Kv7hTQ3?=
 =?us-ascii?Q?CUJCKZVBh5071zR3tO523e5snArCJjV0TKXI9lpazB/1MPAkSLIJpoq9owmN?=
 =?us-ascii?Q?qkrRIUYGS9XXZpn9nsNJLypzuuvN7CtdXLnPYX77/U1YGBSFsE7urN3rbpg3?=
 =?us-ascii?Q?zCI0gvB/cNt/PXzIbJ3LEWjSZDWBNp6AD+JYUftTNH8q/m9W726vEjwuDrAv?=
 =?us-ascii?Q?u2lsTcsCS/1RxZsWww4UnWMS4xDyY8QBPKp2UYarqZvwgPnpzGa9X+rykmZW?=
 =?us-ascii?Q?VVPdQ7J+uIGL5MkD4JR6hwSwIPSXGtsl+MELZSSX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ad0e42-22ea-4b80-1aae-08ddf5f859dd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 14:41:56.9207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7c6bSvLCtKmLHtXaIzLOp1cecOIYVYQMCK3jjY0Z/vnhzAO9dHlfWHJTKB5R2edeOxUECKMbzzZ0VyQapeZWVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121

On Wed, Sep 17, 2025 at 09:13:11AM +0200, Bert Karwatzki wrote:
> Am Dienstag, dem 16.09.2025 um 22:27 +0200 schrieb Bert Karwatzki:
[...]
> 
> I ran a test for 10h and got one real deferred error, I also looked through
> older logs (which only go back to 2025-08-17) and they do not contain any
> mce Hardware errors. Here's the output of
> 
> $ dmesg | grep -E "mce|Hardware Error"
> [  333.338548] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [  333.338559] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [  661.018541] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa8800000000
> [  661.018553] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [  988.698558] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013b
> [  988.698568] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [ 1316.378440] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a9013b
> [ 1316.378452] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [ 1644.058491] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a9413b
> [ 1644.058503] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [ 1971.738263] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c13a
> [ 1971.738271] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 2299.418242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a9413a
> [ 2299.418249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [ 2627.098248] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [ 2627.098256] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 2954.778252] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [ 2954.778259] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 3282.458257] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400a2c800b0c155
> [ 3282.458264] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400a2c800ae8156
> [ 3610.139239] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400a2c800b0c155
> [ 3610.139244] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 3937.818244] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [ 3937.818251] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 4265.498243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [ 4265.498251] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400aa4800a7813b
> [ 4593.178503] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [ 4593.178509] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 4920.858243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a9413a
> [ 4920.858250] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a7813b
> [ 5248.538455] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [ 5248.538462] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 5576.218247] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [ 5576.218255] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 5903.898266] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424ac4800a68133
> [ 5903.898273] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424abc800ab814f
> [ 6231.578280] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a9013a
> [ 6231.578291] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400aa4800a7813b
> [ 6559.258262] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424ac4800a34133
> [ 6559.258269] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 6886.938260] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [ 6886.938267] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 7214.618259] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c13a
> [ 7214.618265] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 7542.298249] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [ 7542.298259] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 7869.978261] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [ 7869.978268] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 8197.658242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424ac4800a68133
> [ 8197.658249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [ 8525.338253] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [ 8525.338263] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 8853.018261] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [ 8853.018268] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [ 9180.698246] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a9413a
> [ 9180.698253] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a7813b
> [ 9508.378244] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c13a
> [ 9508.378251] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [ 9836.058240] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c13a
> [ 9836.058246] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [10163.738241] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [10163.738248] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700900800000000
> [10163.739261] [   T9326] mce: [Hardware Error]: Machine check events logged
> [10163.739265] [   T9326] [Hardware Error]: Deferred error, no action required.
> [10163.739267] [   T9326] [Hardware Error]: CPU:0 (19:50:0) MC14_STATUS[-|-|-|AddrV|PCC|-|-|Deferred|-|-]: 0x8700900800000000
> [10163.739275] [   T9326] [Hardware Error]: Error Addr: 0x0095464100000020
> [10163.739276] [   T9326] [Hardware Error]: IPID: 0x000700b040000000
> [10163.739278] [   T9326] [Hardware Error]: L3 Cache Ext. Error Code: 0
> [10163.739279] [   T9326] [Hardware Error]: cache level: RESV, tx: INSN
> [10491.418242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c13a
> [10491.418248] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [10819.098244] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [10819.098251] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [11146.778265] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [11146.778273] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424abc800a50134
> [11474.458240] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [11474.458247] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [11802.138254] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [11802.138265] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400a5c800aa014b
> [12129.818252] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [12129.818259] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [12457.498260] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a9013a
> [12457.498267] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [12785.178246] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [12785.178253] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [13112.858251] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [13112.858257] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [13440.538242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [13440.538249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [13768.218258] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [13768.218265] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [14095.898258] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c13a
> [14095.898265] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [14423.578241] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [14423.578249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424abc800a14134
> [14751.258243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a8c139
> [14751.258251] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a7413a
> [15078.938245] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [15078.938253] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3813a
> [15406.618241] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [15406.618248] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400a3c800acc152
> [15734.298248] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a58139
> [15734.298255] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3813a
> [16061.978243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a58139
> [16061.978250] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3813a
> [16389.658247] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [16389.658254] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3813a
> [16717.338261] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a58139
> [16717.338268] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3813a
> [17045.018239] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a58139
> [17045.018246] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3813a
> [17372.698252] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400a4c800adc14e
> [17372.698259] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x84008ec800c80188
> [17700.378422] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa0800000000
> [17700.378433] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [18028.058269] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424ac4800a30134
> [18028.058278] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424abc800a18135
> [18355.738423] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa8800000000
> [18355.738435] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [18683.418450] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa8800000000
> [18683.418462] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [19011.098284] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa8800000000
> [19011.098294] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [19338.778473] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa8800000000
> [19338.778483] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700a28800000000
> [19666.458480] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724ac0800000000
> [19666.458493] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700a28800000000
> [19994.138515] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa8800000000
> [19994.138527] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [20321.818576] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [20321.818587] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700a28800000000
> [20649.498506] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a9013c
> [20649.498517] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724ab8800000000
> [20977.178462] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a9013c
> [20977.178474] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a7413d
> [21304.858526] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a9013c
> [21304.858538] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [21632.538259] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a9013c
> [21632.538270] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700a28800000000
> [21960.218257] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [21960.218268] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [22287.898426] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [22287.898437] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [22615.578456] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a9013c
> [22615.578467] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [22943.258444] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a9013c
> [22943.258454] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [23270.938455] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x84008dc800cc818f
> [23270.938467] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [23598.618475] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [23598.618485] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [23926.298262] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a9013c
> [23926.298273] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [24253.978513] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [24253.978524] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724ab8800000000
> [24581.658496] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa0800000000
> [24581.658507] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [24909.338474] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a9013c
> [24909.338486] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [25237.018513] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa0800000000
> [25237.018520] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700a20800000000
> [25564.698280] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a9013c
> [25564.698292] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [25892.378257] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a9013c
> [25892.378268] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [26220.058272] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c13c
> [26220.058279] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [26547.738258] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a9013c
> [26547.738265] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [26875.418266] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a34135
> [26875.418276] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424abc800a10136
> [27203.098459] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a9013c
> [27203.098472] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [27530.778493] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [27530.778504] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [27858.458406] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [27858.458414] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724ab8800000000
> [28186.138241] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013b
> [28186.138249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13c
> [28513.818242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013b
> [28513.818249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424a9c800a4013c
> [28841.498247] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c13a
> [28841.498254] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [29169.178271] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [29169.178281] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [29496.858247] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a9413a
> [29496.858254] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [29824.538243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [29824.538256] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [30152.218241] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [30152.218248] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3813a
> [30479.898242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a58139
> [30479.898249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3813a
> [30807.578254] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a58139
> [30807.578261] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400a44800ac0150
> [31135.258244] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400a34800b00153
> [31135.258252] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [31462.938242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a58139
> [31462.938249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3813a
> [31790.618243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a58139
> [31790.618250] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3813a
> [32118.298254] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a58139
> [32118.298261] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x84008f4800c78187
> [32445.978248] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [32445.978254] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3813a
> [32773.658242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a6013a
> [32773.658249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3813a
> [33101.338251] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424ac4800a30132
> [33101.338259] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c13b
> [33429.018251] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a58139
> [33429.018262] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3813a
> [33756.698247] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400a54800ad414d
> [33756.698254] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a7813b
> [34084.378241] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a9413a
> [34084.378247] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724ab8800000000
> [34412.058256] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700a28800000000
> [34412.058265] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [34739.738409] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400a4c800ae4151
> [34739.738421] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> [35067.418242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [35067.418248] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa0800000000
> [35395.098491] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [35395.098501] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700a28800000000
> [35722.778629] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a8c13b
> [35722.778640] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa0800000000
> 

Summary so far:
1) Errors are found on CPU0 banks 11 and 14.
2) Errors are found during MCA timer-based polling.
3) The data is coming from MCA_DESTAT register.
4) The status bits are not consistent with documentation.
5) Likely these errors are not generating a deferred error interrupt.

Bert, can you please collecting the following data?

1) Output of "/proc/interrupts".
  a) The MCE, MCP, THR, and DFR lines are of interest.
  b) We should verify if any other notification types occur besides
     "MCP" (MCA polling).


2) Using an older kernel, read the MCA_DESTAT registers for L3 cache.
  a) CPU0 bank 11: "sudo rdmsr -p 0 0xC00020b8"
  b) CPU0 bank 14: "sudo rdmsr -p 0 0xC00020e8"
  c) If these are non-zero, then I think we can confirm that the
     spurious data was always there.

Thanks,
Yazen

