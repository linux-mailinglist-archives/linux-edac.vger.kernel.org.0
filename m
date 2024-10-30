Return-Path: <linux-edac+bounces-2362-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF7A9B6D32
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 20:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCC32822AA
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 19:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BAF1D0DEC;
	Wed, 30 Oct 2024 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KgZw8GCS"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0AF199EAB;
	Wed, 30 Oct 2024 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318264; cv=fail; b=rkaURzDinIMJksJPBBc7pzTLbEZz2QBRbfSPCbDWOsd4pi8hk50zRjAeX/YzWQ9VcMiXVfjOFIl9jRby+Ia1yOCAnBvxZdTK6DuMwfglG0/gi1k/zK/1t2gLc5YWRnaYAuOsPrgf02dWE12dtrN9yQWDiLpC89d2CjbT2pJs9Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318264; c=relaxed/simple;
	bh=Cz8XLRY/f2calR5q8af9eUmz84QCwQEH3TXNjbk+zTQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qu3hKuj3yO9TonYKLbPjwM9z3wNhr5yl/34Nkqsd8E6/BFBw6yWJXSTRWQzLYGzmyu76mNH2cnpL+sk9lRX0rjZ6Yefax8qET8Z10/lz2tLjfI657s/4V+bbUTi++gepLO+iOvGR+m90Mz+nkUd3QIjtUyKJOtkRflxxafqq1jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KgZw8GCS; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVFgp+sbotrt8F2P5I+TLld4skgPIR/iYOJ7r+hkB72JIwYJWMVD9Ku1f6aJchwBrVBBbU+ZRu+f5wTK4ow4EMo2qXNkH3c/myesSUc9R9uXGBg8hPPlIL8ULEmksJ6FtmgqBrIAbHl5mGyKwFg4U8rELCtPZrnGyNLhA79gR8K1FBxRzI2kvikURNhmsutScp8VJ/xfhjuztFBUDLAs09EwZkeuu98OhaadQ+BGpYuIa23kZfH3wL816yAC3gwGEwDl7iOuRoaww68hmRE+Zmfn3XXfeXJgSbyCDlYjjx44TAsDVp3+Lp7tANtqeb0gY827XOEigPIsGo8riFH7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81V7ABPr+0ZqtmxPSolGqdrVVSdwPP6X+MO1KNQC2GA=;
 b=GnZrn01PdXUopmCdZImkP/PC5snLdsUJFf3s009pUmXfxaJpudx6mkk1j3eDHC8DhOXm2vcf4OnVH3n5BX8fgPYReDDnWuL0qN9ZLCfPRe+EK4rMIpqup6YjOPE01melJ6eQ0WPCMfRGZ3/58lbxcoeKHxCdSYjoENhaBKlbpHtwvii5P2d86uFaZSEZbgl3CVXhQfwSohlB4e2EXvtAGKME6lPwHcJh/wL5kdffIJyt9pdqUxlsP5J1M1p2CK5iqPzr3P6bLpnehpJzYPmVtAO6dwzWKCVhblQbpqeD247GaNZml7p+Sk35J80A88n1aTky3xlSLRlPeuqzg1leaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81V7ABPr+0ZqtmxPSolGqdrVVSdwPP6X+MO1KNQC2GA=;
 b=KgZw8GCSBkP92J2EmCQDcQnmg267viLBfsQq9AouPgoIVPI+7fjYW9WUH9wgQXSLpE8MLzcsHerY+u4ra7vmlit3YE0lX2LkKdUwxpCGqo6eqCoMRZil+SReMHzL5JewnkjSchj/4vp/tjPGRaBVMUsKBoDIZ+gj6PDCz/54+Vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Wed, 30 Oct
 2024 19:57:35 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%6]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 19:57:35 +0000
Message-ID: <5885d093-275d-4d29-ab13-2f118d61d62d@amd.com>
Date: Wed, 30 Oct 2024 14:57:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, x86@kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, qiuxu.zhuo@intel.com,
 tglx@linutronix.de, mingo@redhat.com, rostedt@goodmis.org,
 mchehab@kernel.org, john.allen@amd.com
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-6-avadhut.naik@amd.com>
 <20241030161550.GFZyJbthMO_2Wxe3bV@fat_crate.local>
 <20241030163147.GA1379143@yaz-khff2.amd.com>
 <20241030165002.GFZyJjuifxBLUDKyL6@fat_crate.local>
 <20241030180041.GGZyJ0SXfa73Q7NmwF@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20241030180041.GGZyJ0SXfa73Q7NmwF@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:805:de::35) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f8ebae-6092-430d-35cc-08dcf91d1938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVFLVmFTclkycWlJMEZRZjAvejhCOE5ISW10YUwzUGpCdjJFSUdLZTQ5Z1Yr?=
 =?utf-8?B?TE1vQVIyM2J6dlg1V2lIRUtSaGxaTkhCWTAwNUY0RTNGRTVLanR6cUdHdVRE?=
 =?utf-8?B?UGtFZUl0UzJRQlBPeWU3VHhvY3haK2dmTDkrWTJvNENQdFVQWjBqZENyZTF3?=
 =?utf-8?B?K1NhbTZ0RC9qUENLMlJKSzVHOURUa0JZaDNNMWErbEk2akhEVWR1SjNlWXNm?=
 =?utf-8?B?bHZ0ZjFxZU1wQmRhY2tIeVI4Q09DNlMvTC9KZTZ0VjcvNWlIRGFoajBJREk3?=
 =?utf-8?B?THFOVDVoYzJTaGM3ZS9HaDZCdW5qTVlWUVQvbGJkT2lRVWs0YXF2OFd2UEwv?=
 =?utf-8?B?aVRSNzFXUk9iV0t6Wmc5YnBteS94ODlMZlFqSjMyUXFJRnlxVHJpN0thNnR5?=
 =?utf-8?B?dHlyVVU0dEkyR3Vjc0N2RGp5M3B2bFpQMllyb2pBbER2eURoa250b3RTd0ds?=
 =?utf-8?B?U2toTHVXc21sc0FIU3RXUnNRSktSZ0IzVmUxaE9ST3MvdnBvTENYcjBZRnQ5?=
 =?utf-8?B?a3Rpc2g1ck5lTmpWalBzM3laRmtwL0VJTFBJS2F5SmdzclluTkZtcEdIb3Mx?=
 =?utf-8?B?N3BjWC9UU2ZLT1RCa2dRbDR4dkwxZ0MvOXl4T1EvdjdIQldjakhvNjloY0VY?=
 =?utf-8?B?RFQ2anpJRC81TWQ4b3J1YTNrdTRXdmc5VFlXVW9uMnpIckU3YUNHeFpiMTFD?=
 =?utf-8?B?ck8rWmQ5QVB0R2RvUkFqeVk1OHVlN2dIWmR1MU5KeUZiTFRqTzNVUndXbllD?=
 =?utf-8?B?N3ZGRW8rSUZ6SDc3MVB5RnRnZE55SEE4d1FmV0Q5YXQzYW5OZ0dIQ0tDSHBR?=
 =?utf-8?B?VERxNGJDRlpQMzhtTXFDUmJEWk1NZU5zd0Z3RFdHcis4am1MSmY1alE0c053?=
 =?utf-8?B?bGxiVlprMFowSHdCM1A4NXB5aFVxQ3JZb1hSelJsdThpQTdYUXRlZ3VpMEht?=
 =?utf-8?B?RTdlOHUzMkVwemx6eGFtZ0ZpTlVXbm0ybXlUaUFwQnJXYVIvdVh4KzFIWWRu?=
 =?utf-8?B?NHY1SWE5VVR3cllRY3c1VERTYmM1Y1dFRjhYMlVIZUcvdDk5aHZaUDRZb0J5?=
 =?utf-8?B?K0tkWFk2cnlzcjE2T1ZOMjdwY1lnVGRxVFRwdmRVa3pOSHlFYXBIWEFkMGtI?=
 =?utf-8?B?N1hPSVpoblBKSUZWR0RiZ3dTZTU2Q3dmbW9xT1Q3eTB4d2htcGJ0UTlTMEN6?=
 =?utf-8?B?R3Q1SUZwTlpOUUpKK1hTYVB0S2hnSk1DelJWTG9RNWlmRXpFNnE1S2MzWmFm?=
 =?utf-8?B?bzczeXE2ejVOR1NuakFzancvMXZOOWowODFZT0EzemdvVlVCV1BTMklybVJ1?=
 =?utf-8?B?UFB1OFVJdjFFS2JJQksxS2NabGJPenZvZkdjL1p3dFdvK1JYN0k2bXVDUnh1?=
 =?utf-8?B?REw5bU1tT1RoenhXcWM0azZhdWhPL0d6bUlEcnFyNkVmTENlWVF6WE9qNHh1?=
 =?utf-8?B?UlFFQ29uSHNKd1RaYkVVbUF0K0RRWjFzYXRhN0JUdXlMZmVYMW1nQThSVTNx?=
 =?utf-8?B?R0hrQVFGZFdpQk8zWmM0K3Z6SW8xZldCWDV1RWh3dFdGTGdkZ25tVjhzZ2pz?=
 =?utf-8?B?TkY2NWdyOFhxYlNKYTFCcjFKU0ttVW9HRko5YkhzUUNCQlRrKzUrUVBsQ3A5?=
 =?utf-8?B?cTQ3ckhZSWMwWmtCbzRGTjd4Z1B1R0Jqb290UWNzSjFFOEorNVkxZWhMYktI?=
 =?utf-8?B?blY0c2NyUGxMQ2RUR0ZlVS9NN1UzVEZyVjVNV05rQVNzd2tSbnczMzFYbWNH?=
 =?utf-8?Q?MTFUkse6OqIP8l69KcankfgDwKhUpzUctrSGP9/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0tOcDFRdGNkaVczb3c5WUhlK1dWSnBUeGF2UWtxdVFKUkRqOFUrYkZHMkhC?=
 =?utf-8?B?NXlJSjJhK3VNSTY3b1hCSTZPaVV1SnpINXBuSWp2bVJIdmMxMm9aVDc2U2Zn?=
 =?utf-8?B?bXVEQU5VSHBoem1Kdm9jME9keTRsWDE5SHJ0YlljSXc2ZGQxcWpjY2tuNDhs?=
 =?utf-8?B?cXNCaUFWSnZZY1R0OVdGRFZYY25WelV5blBybmtqV082RVN5NGpkZVJBSDl4?=
 =?utf-8?B?NlBjNXovZmVYWEhBTjdPWkE5VUR2ZFY0aXkrQjhnTFl3d3lSQ0RJTk54TkJa?=
 =?utf-8?B?ODZSb1Z2eFNZMmIrY1Bzcnk0aW52ck4wL1g3UUphZ0d1WjdUMDQ1OUhSNlkr?=
 =?utf-8?B?bXhkdGNoeDNxRjR1ei9CQkU3RWZyUWwyL3FjTk5GYlNtZjFiK3dsdG1OZ0RH?=
 =?utf-8?B?Tzh5SmpkZWNVSGVEZkdUM0JyM09FRzRUWW1TY3diTC81TTRlSDBrMGVZNGZ3?=
 =?utf-8?B?RjJVdjhvOFUxSjdrVC9BUDdQbkE2aVNXUHdMZFc3cUhvWk1WUWRRdFQveG1I?=
 =?utf-8?B?M0NJbHp6NjdxMG9ZVjlUTUxxS0JUNUM0THA3Y1NnVGZYWThKeTdsQnJ5Nm56?=
 =?utf-8?B?Q3pUL1NTRjQwNkJubU93cW5xdWhxd1I4dnJRa3ZWYVhiVlBOWDUxOVVtcFNp?=
 =?utf-8?B?MW16YUd3dXVWYW9EWE4xSGx0MUNndUlCVVBTdHhySVA1Y2ZXdUlBNkV6UXF4?=
 =?utf-8?B?Q3orUmlxK1c1Q1RhQTMwY2Fwdk1WSXJJUDJacFc5cG9VSzA2K0JhVHBXTmU4?=
 =?utf-8?B?T2RXbkJjd3dYUytPMlBsMUtWeHF0NHduUmZsckdadmpkamQycDM5ZUUyR1Bs?=
 =?utf-8?B?cW5WTjBLNE1vdzFZQ3hQUHp2RFE2Q282aU9KR0RhMDJ3anZKVjZhR0p2dHZT?=
 =?utf-8?B?VmFNRzhIR29Hb1R1cmltb09vU0hqRGFoOFdoRWNyRmlzNzF0VDk5NWJzVjZM?=
 =?utf-8?B?QXQ2NXBKMmpaTk50OHVnOGhDZTdHc2JtR0p3RXFkU3d0aW5OZWJYNUlnSXRU?=
 =?utf-8?B?TStHcHNQem9ZQXBRZ2lIazUvM1VWbWVLajR0R3ovVTVMcFRaemJpVnQza3A0?=
 =?utf-8?B?c1F2RWFpWWNXUldNSnVQMktTWmpJczZSTEdHdUowUXYvNFBZbGhDek5lMXJR?=
 =?utf-8?B?bnFYNno0MEcyU2xJMmxwUjhJcVE2L0hzWHpRaGE1VmRBTmFCeTM5UzVWei9Y?=
 =?utf-8?B?RStUaW9WTUppM2RPTUVTdUJ2ajhYTUlZU2tBajJNRW5VenllTFo4bnljaTFW?=
 =?utf-8?B?VG5oWCs1R0xpZEYzek5wSW9nL3pzdEpSN3dWSklmWHVnTDZISXI5OHAzdUhx?=
 =?utf-8?B?cFRlcWdUMVdoVytITEJlOWtkRXNyM2FXK2hEbTVNQ2RZc0YwbGV1U1N4Uktr?=
 =?utf-8?B?SzJCaUh5TkZmVzAwSTBpWlQvZEpmRmk3RjZyQnpsTjJKVmdMTWg5U1NEQllH?=
 =?utf-8?B?VSt1b3Fpc0RwcWFQeThYKzFkSVNQZXBWaG5QRVROei80RUV3Z3lHS1lNd2Jq?=
 =?utf-8?B?WUZCT3M0Q3VCWFNnOWNQS2xKNnU3cHhWYnV2RWZkSzFlWXlwUHhKbHZXb1h6?=
 =?utf-8?B?dDNsVnlJd2dUM2hOalhZNFdDKzRaSE5tRTdFcG8xYmxRUVQyVUJwSnZoM0tz?=
 =?utf-8?B?emxtMnUza0VhdHlXOCtGOFAzOHlQZVY1SWtOZTNaTjVNMURpbkI0UE1lUjh5?=
 =?utf-8?B?MnZsU2ZZcnZtTkpyTDFxamI0ejFqcXl2b0tac29JZnMvSzNJRklWVlBGRU5x?=
 =?utf-8?B?dEJQZ3NudVptejVZUFJINkRlTFJ5NVZOOXROQjVLbTlBekpBVVpTVUtrb0E2?=
 =?utf-8?B?MzhMSkJBakI1UVJsWFMvRExCNjV3RmF0RENtTGh0S0dRWE5jSzFzM05VV3dQ?=
 =?utf-8?B?U2hRTFhxZFBuSlVDNGMxZndtN2VWcDh4M3pGdUZPSzB3NUc1OFJtV1Q5Ulky?=
 =?utf-8?B?cEhma2VZcWhCbDNqN1dSeGNzRnBOb3F5R0ZNeG1abElpdk0weDRnNGVSZHkw?=
 =?utf-8?B?WHF1eDZhdnNQcEVDTFJMQ0pxSGU3OS9paVNhcnliL3RGVHErbEI0dmZ3bHMr?=
 =?utf-8?B?VG5NQU5mbTJnSDcwWXZOaGFCM0lJdHFmYy9KdVVIZStlL2xPWnl0c0ZwSFcw?=
 =?utf-8?Q?2DwC8RQzHKQ4uYwXjJqx9JLvX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f8ebae-6092-430d-35cc-08dcf91d1938
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 19:57:35.4983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAN4e7T0JKoHpiRBxanp9h54+n/HpLCjD6qSSgIPAC9i+SMOcwg6540Eg4tj5WKMsRZa15RGAuSTAJgY8DN9CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355



On 10/30/2024 13:01, Borislav Petkov wrote:
> On Wed, Oct 30, 2024 at 05:50:02PM +0100, Borislav Petkov wrote:
>> Bah, crap. Lemme go back and take a second stab at this.
> 
> Second try.
> 
> The reason why I don't want to expose MCA_CONFIG to userspace is, well,
> userspace doesn't need to know any "management" information the hw gives. It
> either gets FRU text in that tracepoint or it doesn't. But it doesn't need to
> know what MCA_CONFIG said or didn't say.
> 
> Ok?
> 
So, for now, in the kernel, we log SYND1/2 registers only when they contain
FRUText.
While in the userspace, since MCA_CONFIG is not in the picture, we always
interpret SYND1/2 data as FRUText.
Rasdaemon might need to be tweaked accordingly. Will take care of it.
Overall, sounds good.

Do you want me send out a revised version with these changes?

> Author: Yazen Ghannam <yazen.ghannam@amd.com>
> Date:   Tue Oct 22 19:36:31 2024 +0000
> 
>     EDAC/mce_amd: Add support for FRU text in MCA
>     
>     A new "FRU Text in MCA" feature is defined where the Field Replaceable
>     Unit (FRU) Text for a device is represented by a string in the new
>     MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
>     bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).
>     
>     The FRU Text is populated dynamically for each individual error state
>     (MCA_STATUS, MCA_ADDR, et al.). Handle the case where an MCA bank covers
>     multiple devices, for example, a Unified Memory Controller (UMC) bank
>     that manages two DIMMs.
>     
>       [ Yazen: Add Avadhut as co-developer for wrapper changes. ]
>       [ bp: Do not expose MCA_CONFIG to userspace yet. ]
>     
>     Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>     Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
>     Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>     Link: https://lore.kernel.org/r/20241022194158.110073-6-avadhut.naik@amd.com
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 4d936ee20e24..4543cf2eb5e8 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -61,6 +61,7 @@
>   *  - TCC bit is present in MCx_STATUS.
>   */
>  #define MCI_CONFIG_MCAX		0x1
> +#define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
>  #define MCI_IPID_MCATYPE	0xFFFF0000
>  #define MCI_IPID_HWID		0xFFF
>  
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index 194d9fd47d20..50d74d3bf0f5 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -795,6 +795,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>  	struct mce *m = (struct mce *)data;
>  	struct mce_hw_err *err = to_mce_hw_err(m);
>  	unsigned int fam = x86_family(m->cpuid);
> +	u32 mca_config_lo = 0, dummy;
>  	int ecc;
>  
>  	if (m->kflags & MCE_HANDLED_CEC)
> @@ -814,11 +815,9 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>  		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
>  
>  	if (boot_cpu_has(X86_FEATURE_SMCA)) {
> -		u32 low, high;
> -		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
> +		rdmsr_safe(MSR_AMD64_SMCA_MCx_CONFIG(m->bank), &mca_config_lo, &dummy);
>  
> -		if (!rdmsr_safe(addr, &low, &high) &&
> -		    (low & MCI_CONFIG_MCAX))
> +		if (mca_config_lo & MCI_CONFIG_MCAX)
>  			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
>  
>  		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
> @@ -853,8 +852,15 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>  
>  		if (m->status & MCI_STATUS_SYNDV) {
>  			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
> -			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
> -				 err->vendor.amd.synd1, err->vendor.amd.synd2);
> +			if (mca_config_lo & MCI_CONFIG_FRUTEXT) {
> +				char frutext[17];
> +
> +				frutext[16] = '\0';
> +				memcpy(&frutext[0], &err->vendor.amd.synd1, 8);
> +				memcpy(&frutext[8], &err->vendor.amd.synd2, 8);
> +
> +				pr_emerg(HW_ERR "FRU Text: %s", frutext);
> +			}
>  		}
>  
>  		pr_cont("\n");
> 

-- 
Thanks,
Avadhut Naik

