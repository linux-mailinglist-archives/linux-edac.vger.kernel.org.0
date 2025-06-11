Return-Path: <linux-edac+bounces-4111-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D354AD5D5B
	for <lists+linux-edac@lfdr.de>; Wed, 11 Jun 2025 19:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A4217E118
	for <lists+linux-edac@lfdr.de>; Wed, 11 Jun 2025 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD14217730;
	Wed, 11 Jun 2025 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pNav+Jpw"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF220C463
	for <linux-edac@vger.kernel.org>; Wed, 11 Jun 2025 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749663680; cv=fail; b=ukfq8ce1k/XiwV+P9+8c+L7p8BjxgK3GG+MlUR2iCRu2wr+aG59T4HrR+byg2HRfnZSaUdNMcm5NHvGWSoXEKGI+aeVr1Zbn/7x7VaryXTy3T5MgK4ZTxW15ytBoMUpYjDL/1s2tSjk7pln+EMAOtPw5p9/EV1LtD2+ZAgg8Ugk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749663680; c=relaxed/simple;
	bh=vlDWQ/rzCOk4gozQddOYIuQxoogz8Mpnb56THPa5gJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NdP+jEcMtL3EV0wJYabvj1vfmlwpS8ttt7ddOhyt4dhCxBgc65UeVkbiz+iYT96+p87mmagDV5HdThQbO8ySQw6q/w6jvgVjI7IMCPf0vGIf35KoVK7C61SVZ3wbyA6lWriFdC57KNP2sWRsvKoohzQbVVCOZnGmvBbFFZf16+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pNav+Jpw; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxWkme7wdKTvsJ7loCVe9qYyNZGrh+Bc078O0+gOXESXKechyOuBiapZ6BUunQzcp5i/uX0eT0bj3pkrEDEg2za29TBg32fpktA1vbm059BR/fSasvwAXW9cpsuCEqtNpZuT/XW4TLzhYhnu9MYZES4flODEa4tHBOK87OxPq2vT9Jv+TD7DBZRdNPegnNoAdUccEqmyWQE5filLjsf5HyIxZll8/AQLhGb0ybSeJ2VgoCMaNfgio+rs86eRnDzbGF1LosqD6fb4MRej4UvmfuLRKY6cEIvEPqPHExeyawDNUtVTSgNgXq799RsosNoeW1v4vpuQmKXeDcZJcpHhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7ipbZW4WHqShgVh6+P1EgFus9dldXUmVLQyVBMnxpE=;
 b=RPFqHMfE3HiiELh7J767YtaAKpKWuCymTtKFXbgUi3N7pHXiAiNu/DtUFugVV7R3jIMjnQJgeWXVhQ7cAKOE90GdbWkWWrbi4bOt2va+kb0mKuAX4kvO1IpV500dJoHyTnvob7HgCTO1OGTsiIyhrHHKbnLg4di06+gzVkOXSDd5k3T1xS9ZWmXs4zC4jqd53amMJXE1VqRhsgbXZ5pseCS8mCW7mBfCsXM+z5ualNF5PCFZiL1itPZy1zK87iQIR5Ntyq+ffW/6NZdwtvKMArzWKbuxM+1rKGEU3Zq9XyO6ZABGXfnkoH5ocFE+6il4PSKlhnO+Fh+z/lQSAte/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7ipbZW4WHqShgVh6+P1EgFus9dldXUmVLQyVBMnxpE=;
 b=pNav+JpwuokpSher+STHm5rB6PZ2ghQBOzuPB3/5ry4xzWbl81B8vlgtHSH2j52wecD1YnMWyeYw6QNFKKGhz2JNTxJFpz0PaS7T10spAABfWzyLHyWvAf2qAw1pR6MqEd5w9qtelV4q0B0YDFcTE2RjYwsYfoRHghIxQyn+3jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 17:41:13 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8792.038; Wed, 11 Jun 2025
 17:41:12 +0000
Date: Wed, 11 Jun 2025 13:41:03 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, wanghai38@huawei.com,
	bobo.shaobowang@huawei.com
Subject: Re: [RFC PATCH] x86/mce/inject: Add sanity check in inject_mce()
Message-ID: <20250611174103.GA288240@yaz-khff2.amd.com>
References: <20250529033256.31554-1-wangxiongfeng2@huawei.com>
 <20250529094534.GAaDgsvhdl-BrzlM0J@fat_crate.local>
 <aDq6cecrsKYrwra2@gmail.com>
 <20250531091746.GAaDrJOuUlQyfRjgv3@fat_crate.local>
 <aDtEyl5A36zRyV7B@gmail.com>
 <20250531190724.GCaDtTbBgz3dFE-BDJ@fat_crate.local>
 <aDt77p9GYCIRIOMa@agluck-desk3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDt77p9GYCIRIOMa@agluck-desk3>
X-ClientProxiedBy: BYAPR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::19) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5b42f3-c072-4d1a-3e18-08dda90f2824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K1lJng+Air1+fHnabY0s1JJEWA/yHB6IrLS//8a3ctxamxu+s4Vavz3aSR+C?=
 =?us-ascii?Q?LkkYPlM7PpsBZyH+UN+cj0pbRIFJbO8yS2CgzHkADpSpEMCHV2ejUIX6WdnM?=
 =?us-ascii?Q?UbYbistoUT0g9dCuzXhgHPnsESA60W3fCnaOzmqHwnCzJbsnzQS+CTifEbQH?=
 =?us-ascii?Q?5cy1IemfSh1QAIvofv1pVRNYgh1mXpV+FRfAPmCguk9tmn78s2aY3/eI/qSu?=
 =?us-ascii?Q?wFtCzHjyjLcol8HZX0q5EaU5CMljqaR95dbr2acLgBD9PZulMH7WrM/iNHnl?=
 =?us-ascii?Q?IC/l0aSSIQrM9FBLj9nCnuBrP5Llw0CyKxCu0LKq7SrYGQgEHDWd+vyPA/SF?=
 =?us-ascii?Q?0LSufs8p23dmboh4eb2k7ueg5PVJCDx/k71bbI/qxZh59Hp1lLDK6PQrrA61?=
 =?us-ascii?Q?tOf4Z6E+Hbx/umi0dL43e+FvrHs7rOHevZSVqlQ/2v/XFoZyNFZ8kxQzJ0gq?=
 =?us-ascii?Q?aZx5RXWghc2zoYflGPToSeCi0YFp7GXkvYUaz14GpRCnkKs2F/om08mm8Ya+?=
 =?us-ascii?Q?jgZKwDiuHvi0KSyE1hWHwlaZ5z0Ro6uL2ZWZPOQfRUYXMg0jRSaNQamRzY7R?=
 =?us-ascii?Q?hp29FZsJnM02OXCRbO6ypcxnV2AUu1s6Gw8txptC9CFqoLLRp+lRssxaZLeg?=
 =?us-ascii?Q?geQEeHM8UdcroAohaYGA4Fhn2Qv7ieA7lztRas6ozqKCyYig+4PEy+bbU+JD?=
 =?us-ascii?Q?b4xkNSXkpCrh11iVkn37DjOCJSyJq7lIw7JO9sHZYcgFgaanc36/dwwhiW/d?=
 =?us-ascii?Q?F94a4a2pK5gr12hTxZ3TmrtabKQMTKl0ZYSEM3dwrkpqCTi3y4RPJsnAFBti?=
 =?us-ascii?Q?unmJNVDcIXsA7OKqGk5H6R3TySvjxWxcR2+rZE+tebik5DwL255hCNLhu6/d?=
 =?us-ascii?Q?H9TiO8YgF58spHPC8PiHaNFUx6m+Tu0DwS+WkERCxiW+6fZqeyJyTZITXlzi?=
 =?us-ascii?Q?imP3ZBK9UjlKk7i3EPZgadihuleKvOh7rTwOyYj4VXLVAM15Ig91MMnU5jMQ?=
 =?us-ascii?Q?mdzYdRxzgJswG3X3/nNkss+RU/EVG20izayO8bzBhwB/ce+FjT00EiLGAjeg?=
 =?us-ascii?Q?qn/J3YtDHvDJ9wZPMvQK7DD1Fg+Qan/Ngd0NKVpibf0anxhyTKfFxVOs6Q1N?=
 =?us-ascii?Q?CgEgGhoSs5E3/TfaaDSzKqZeGzOA4Qe9PifiKnxhIcXDac/GcNpzRRA1IJK+?=
 =?us-ascii?Q?muE3KnhF1Y2jEbalCetMlOMkx8rRDax0POLSz5RH/FjqpxxayPsH60JQxIX2?=
 =?us-ascii?Q?+kja/e6XYaD0UnSnnZlfEbeodP56jB06OCeZvyhOCW4spYyV3+CEb2ayWYWc?=
 =?us-ascii?Q?8GH+TZLC49mh671RuZjlbdZf64KCZ+zps3/2AUc8TtOwBIBD6Ui58pE8uFsP?=
 =?us-ascii?Q?2qsMnCdqFxgZ/4KRLNXiu76F7O7ckME5ei4DrAw0FvlE7VPIH0Cv9WcFBK5B?=
 =?us-ascii?Q?Kd2zeCEpQ8E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YoBVRlrRYijkPtB3/4o9iosLkl3IduAm6bxCEdZ6ucCKXYK1eGPYTQjtoKEM?=
 =?us-ascii?Q?P6wDgD4R3Td6f8nRrL05bx8QY8A7YJJMxEHoZ8wTUPKZWMyjnvnkoJJ3TICF?=
 =?us-ascii?Q?TO+t/PaWoDvyBmOQHJ7IFBPicWN/uS6PEwXT+/e+dJiCBgmxcFKk5adN2Xes?=
 =?us-ascii?Q?qz/zl/NoVzMUHx5KNU05JSd5IvpTMgvaJ0X0BlNcRXOPUynYHmriBkEZNWeQ?=
 =?us-ascii?Q?hNWkvauzVi1y5baxU1GrV4GczGn7cqw0hBbkE57lK18V+vnG959ZJY287mCL?=
 =?us-ascii?Q?/fNia6Fo0HA2NdmvpjHgbIHNhYN7qg1soiS/4KLZi+28xuYK2N3EzxiVvrJG?=
 =?us-ascii?Q?4ngqFUva6Gjl4JVjSu2g/SENh8liLEXk/MlFZ4ypXhsrg2CpknS/ljxBI7zn?=
 =?us-ascii?Q?KfnoK1yR5F5XtqcKzSy+ua2F/pYYvz3xu7SrXjO7ojxc1Z/IF/ldIh/CJmfu?=
 =?us-ascii?Q?Or8cxvZo5F+qPXGaAPWKnDwOdOLcbJVVkUTGnEe63SbJ6/nYue6KqlEQ3mCI?=
 =?us-ascii?Q?6FdHGDVOSpnoTACxulQchbr73rI4a22xMOjnhwsxGxm7s0/YFl6FgFYItxg9?=
 =?us-ascii?Q?eslLdzLh/YFfsEpJOdEnx23iytWPRqRZkno1R/VZSOmMZP32SSqlC0kNWVC8?=
 =?us-ascii?Q?U6ax9kjYhlfWfPgJXeUkD01Wpo0z0UmyE5ZnDDRBZywlx5g1FaZHsS0KdQm0?=
 =?us-ascii?Q?jlFxljIg4+FyAb7RSYMz+icuiLlSwTJAkHFahOm5bRlHTshf/zOlj9zaA/9+?=
 =?us-ascii?Q?ozF9B3sAd57pJmTT8cb3brrgwObzVM6i0Ln8VR5g55BoeCGl8nf24P5IDfBe?=
 =?us-ascii?Q?iIVOAtgzBmmlCTWZxjT+ko29GxhiCyU90XSTG94scDY0Vsb9ZzLf//ygB2tb?=
 =?us-ascii?Q?tytE0gFIwewuEwviB3SsOIzXAMbSoRArAUqBCmeT0UTiqwT29nXbEYFWqO/E?=
 =?us-ascii?Q?avnTPfrFxyF0zRr4Wh87wqLKxKhZq8vXOvgjohh5cm8RPznxcOD0oefaw/WU?=
 =?us-ascii?Q?6EsbN7dKHEcOOtW1w/joXfKNFm5PDp0OqjUKgxYSwOwHbZCwxk789erxKset?=
 =?us-ascii?Q?PIciXCoc+RK3HvTP2U4ulIO0nnRiWVU4PIa4M0kGNGUue41nIrTG2J7nDZGG?=
 =?us-ascii?Q?z/r9uUwG5CirfZvwWpoZ1kGwHmhCLzLhphn/Gq+Y/pZnQocf4+6cm/Sj1Zkz?=
 =?us-ascii?Q?OV7DZI3UbHBeckuX60TftbRoAiUvVBOWACc4V9QHxUjo8t1l2CRkrkUMCnLI?=
 =?us-ascii?Q?VewPPSgSrIoqd+NpKtB3lBUUcrbga/1zLFUSFESNzUYZMxoWvbN+KqFkuQVX?=
 =?us-ascii?Q?p8eiI1RjzTo/HQ2hRigY7HgzVeKnphaoI2y6J8vj4llcU1s/OEqbTO1gd1w9?=
 =?us-ascii?Q?GSygKzw8Uo1Nd+r7CCGDRsXbPZa1GdsFCxymcW6RwEl4gNWxkqqDnUHrRTk3?=
 =?us-ascii?Q?uqFtYHmCIW2kt5hbJB03J3KmLN9RusiibVbI0bC+AD/KCznlRWbZYHiTEwTH?=
 =?us-ascii?Q?0KO5l2UUdtFiNZzpIwdlQBUHTmBUYOZSWAdBujM1o8fy3fdlPCsxNyQLdBJ8?=
 =?us-ascii?Q?mGBqPOXb0osN+BBt5VuPxNiSq9CUgXp2m1o5NQpw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5b42f3-c072-4d1a-3e18-08dda90f2824
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 17:41:12.3957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZ1eAWDAchbPkP68zlX1dFIi9dcN8fbiTXxiuVTABbxbVBEHtA719PyJizhHP1Rum9rmRYsI7RQFpkWras/OYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745

On Sat, May 31, 2025 at 03:00:14PM -0700, Luck, Tony wrote:
> On Sat, May 31, 2025 at 09:07:24PM +0200, Borislav Petkov wrote:
> > On Sat, May 31, 2025 at 08:04:58PM +0200, Ingo Molnar wrote:
> > > What tool?
> > 
> > mce-inject. The module.
> > 
> > > Or if you mean the MCE-injection interface, that's not supposed to 
> > > trigger avoidable crashes either, it's an injection facility for 
> > > testing purposes:
> > 
> > That's an injection facility to TEST THE MCE PANIC PATHS too. YES, IT VERY MUCH
> > SHOULD TRIGGER CRASHES! That is actually a feature!
> > 
> > I have fixed bugs in the MCE handler exactly because an MCE signature gets
> > injected unfettered.
> > 
> > > It's really simple really:
> > > 
> > > - If the kernel unnecessarily locks up on the receipt of a 
> > >   hardware-generated MCE then that's a kernel bug that
> > >   should be fixed.
> > 
> > This is not a hw generated MCE - this is a user-generated MCE signature.
> > I think you're confusing things here.
> > 
> > > - If the kernel unnecessarily locks up on the receipt of a 
> > >   software-generated MCE then that's a kernel bug that
> > >   should be fixed.
> > 
> > No, it isn't. I can inject a MCE which will lock up the whole machine. And
> > that's a valid MCE which can also be raised by hw.
> > 
> > > TL;DR, this is not an acceptable kernel response:
> > 
> > It is very much a valid kernel response. The MCE injection module allows for
> > testing the MCE panic path with all that is involved in it, including the
> > machine dying.
> > 
> > Yes, because MCE is special and it can and *should* cause panics.
> > 
> > So for patches like this one which is masssaging the MCE - and which is also
> > wrong for other reasons - not every Intel uarch supports local MCEs:
> > 
> > NAK!
> 
> I'm solidly with Boris on this one. I don't want mce-inject to sanity
> check, or second guess and "fix" the signature that I requested. I want
> it to do what I asked it to do.
> 
> 1) Sometimes I want to force a crash from a particular signature because
> I want to check that Linux accurately logs the signature of the error
> that I injected.
> 
> 2) Sometimes I want to inject "impossible" signatures that can't happen
> on any CPU today, but I know will be a recoverable error on a future
> processor. That's how much of the early machine check recovery code was
> developed and tested.
> 

Additionally, we have a "fake_panic" parameter/debugfs entry that lets
us test the panic path without truly bringing down the system.

Thanks,
Yazen

