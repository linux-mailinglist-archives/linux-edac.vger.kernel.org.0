Return-Path: <linux-edac+bounces-1449-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A1A926969
	for <lists+linux-edac@lfdr.de>; Wed,  3 Jul 2024 22:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8FB1F25A88
	for <lists+linux-edac@lfdr.de>; Wed,  3 Jul 2024 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F12818FDC2;
	Wed,  3 Jul 2024 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AhcD5zA/"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C601850A8;
	Wed,  3 Jul 2024 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037707; cv=fail; b=kgC+3G+gTFQuoeuVB4XuHdGe0FQ3q2bOesqKNEdHiHA/oNX54H4EM0p3/WrCHko+AjSklaiFfd2hMwYehZL5NIAkPoUAWaF6u9lLuegetSix+Xav8L7HR44nCvGWcpzt6IzmjjwVd8HV34RbyG1UN3DAONdEx6eQT/Cf6/ZGqsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037707; c=relaxed/simple;
	bh=en8+2vZeWKj9Hq4W91uLvdCst4Qygn20jzbH7Xi2rUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ELe4KxOzDxLXRaR/tV9eIGG0EeitWwc+MvEniLKJcQoYiY4aCD/xQWx5IXZgbnsIhNXH5eilKrk0lH8GDqzDjWOJvZBQJMi/VDl0tUxev6aZu6FNIcANR1DiMzEH3TZVV7W9faHgJTeSjE5wkovmYClcj/VCQwC13RJuCXucH38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AhcD5zA/; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNHm4AuupeZegBmjuAAlqTraNh+XQY701iditxDI5gznD3B+piJuGjVqoV50aKWneTJr611XyJeZUVfuEdCm1YpCtPKXq8asuEE83HEoeZf2NftoZQLsI2Bye7kzHC29jMQ7UOmyM0eSecTYNb/xWo3vtpBSVebG7R9BXd29onq5jLUv13UIue7h6a6VNqngKXz8FVq9w9TCL7iUrpjIc0uoOgYMufNncgN2sjEWPQBc79/0qduCUtqp1gpiaWI2i5dDYbOteDyF8qISGaHEgEwTmJ0x/J3IYedOoWvq/yCuHIt4JlP7lNghxRQeHLRsJ/MS83MUB69jMzzxpYAImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WkaLcMd5JGORXN0Zz/0eofCrSvTW/ZsmtdtsYwsZws=;
 b=XAc0uOlqQNV0HmrjKyl2usNjiY51m3O+ZH9ftR/a5I9hjbyu83YPXKoKcOc1eoXAwGU+RQ1bdTYqfnSHFmunWnZj/bIYyjTeuM1t7AGvhsJ5EE+uz65uPKnwvVaZaJsD6PFSJZAoh2TXoctqpsmw0z/5urauMsccP2kGvOUxcDRNB01WrOhBrN77bLvxgneu/yj3QlPMp/9AE0DqBLVC4X7dlzNJJ9VDVJfbb8t6P3QUt7IIeN4aYstX+NULIC0+9Op0CwRh05SsHZwbvm9kSAP/L/l/p/Zj8Rlzm7rtConcCPUEeAzriUpzDinEmzskR/9AMOF9Z7oKiOWkhtJqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WkaLcMd5JGORXN0Zz/0eofCrSvTW/ZsmtdtsYwsZws=;
 b=AhcD5zA/pD681kCCbXNftVLfjzb9gkdDDmDeahjUP8vdtZ6JlJbbID5pl6RH4llGbUeC7FeUfib8mgeOI/e2idt41rEOGgfNOjhT7XXOoYIG01VguainNAVAP5RyZk/f6z11wLJE6dFX+z20s9PUjKUlN42TyAjOTkeaouRlDMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 20:15:01 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%5]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 20:15:01 +0000
Date: Wed, 3 Jul 2024 15:14:53 -0500
From: John Allen <john.allen@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: rafael@kernel.org, lenb@kernel.org, yazen.ghannam@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 2/2] RAS/AMD/ATL: Translate normalized to system
 physical addresses using PRM
Message-ID: <ZoWxPR+A3xjV1Y/j@AUS-L1-JOHALLEN.amd.com>
References: <20240506174721.72018-1-john.allen@amd.com>
 <20240506174721.72018-3-john.allen@amd.com>
 <20240628074522.GDZn5qEkTXG0EvQ4Lv@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628074522.GDZn5qEkTXG0EvQ4Lv@fat_crate.local>
X-ClientProxiedBy: BY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::28) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0b9c05-5d75-430a-9d4d-08dc9b9cd175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kwrrzGKVvyJPi8tOwhOgsVqBVBG4gbeyCGhsKmRctYnSXJ1sS0FE6erprOCt?=
 =?us-ascii?Q?dfPmYEf1gtYFRg4qF7Fq22Zu2wZVM+MwCaiVNJDlP33pwYCrhI/+zYhBmyLi?=
 =?us-ascii?Q?7SIBGXDD5eYymj46dD6YYAcFYl2Qts3fLyOdWhBZJjfjwPSAwDIstjEb31CQ?=
 =?us-ascii?Q?7FDFLV5ZU3imNoCdaDhIERRfYaKtCffUIsdDk7k2CEbVJ1z5JPxJnm4PU+FF?=
 =?us-ascii?Q?UPkqIdc/5lzHqU/ZqthefTzDXNhR9ajew1tbq8ZnW7Re0KICCGTrF+EJxBC0?=
 =?us-ascii?Q?5lvVf7c8tnd2TLgbh7MksgKIbBWLzG4PON7AG5dDeDAprt4frE7kcM2k1l6S?=
 =?us-ascii?Q?U3myEYVWfZ0Ib/a9EzsvAwzL6CBiwfBIw/0YMuIhXJyHDP1/CBFLl1gmIAT9?=
 =?us-ascii?Q?MLJDq4dBuDNcH4gsrt13ZJq/TUz6gejkRCVOOerEM6rkbxDuKEDLgSSQz5I3?=
 =?us-ascii?Q?UpJQUlX6VvAxOY1wTP0lCyxPRSE2dGEP6e7ymnkDQd4kTfCOwmKo2uLWduTi?=
 =?us-ascii?Q?mUcyaNo15Be2oBLlHkUZltBGHVTwb7LTOgtsTSWXT4QouvkkfIgkuIN53h+P?=
 =?us-ascii?Q?UMZMApasIAm03YxextcxMrV/yecVyx4HIYq6U4Etbh42J0uqhHpXtLkXQXl1?=
 =?us-ascii?Q?vatDmDfD55B7ZgxLrxWjaLAV8qegDy/biNffIK5xA5iD6dfnoJ9Ntez/W+wH?=
 =?us-ascii?Q?3fc3JLfTRE+gMHSCMoYRKdOHxNn7ZvE+ZajNd+IGbYQHf/Xt5yQX37kkwc1+?=
 =?us-ascii?Q?PdzG/I6wCQmxlOD2QC3tptD2eHUDEltZvdm0YKPni+7K/4vUwOKqnBohJ4Uh?=
 =?us-ascii?Q?O0G35iorkoK23+lvT6LGLcdQG72vi67SbSCFpvEdUsT+O++GaX4kifcdTg34?=
 =?us-ascii?Q?FTPXOMTNr819VkZHB1eEOMP26NRFNyPDecdtO3QB5NSQ8fAveabQjFRdsy5O?=
 =?us-ascii?Q?D7IHp5opn1b/Zd/F1qSm0GhhLpcKRsAviBt4z1pah5L7TLKPATO+MAyg0dVD?=
 =?us-ascii?Q?Ev1xnQMOGNg5g2BIjNmJ/sxmuNqA5mWEpuydAnr2FNhOH9QF9dUFIN9Xm2WX?=
 =?us-ascii?Q?5c7mtG/nF6X9dS9goXGyhOM0a0sz6o+9ondbYlBV9cRwUjy0SBElR4OWlk2h?=
 =?us-ascii?Q?bLlor6iBJNDTBOrTppaESfrM6YB/Wt+xHrqcklEhWtvrWiJRzI9RCaR+zou2?=
 =?us-ascii?Q?lecPLfl6rY3jb46/sYy2Mpx3YuKKx9yYWRr5dYHUU5GdA+FG0CLzPFb3cJur?=
 =?us-ascii?Q?DCKMGn8FRQxm3QHvFcdI07mVZnP2kFljmNS9sv6P/B1ua8zgMy6UNUd0EUrp?=
 =?us-ascii?Q?EEKaxC3yViyloXocEBa0nkhdbf7OY/aLIN2XBeFM7s27Vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWWa0NQ3s0MzU7o9yQYmydeCiVMgdDgRffpH+OCyisn+GfQo2oeLQSt/ktlN?=
 =?us-ascii?Q?dEheBcFSHY+gNB1IiiFn3xNifJaT9rwKOGe2ByRPDb7iFGKn1FNDtjnvkR04?=
 =?us-ascii?Q?NMqa4NSsN6PkENAmDedSuE/9XLOAd5/X+8I+GNh/l19oaygSq29GwkLWitjs?=
 =?us-ascii?Q?4oDEm3hwIAv/Uofcj+GybvyRMK+Scg3gwEO/ZMMbK680IRhianPSIa1nBJSg?=
 =?us-ascii?Q?OXQRfD9IMRJtFflpdw8TJS3dr0dRJXlPLw73Z4aVNr8oMhMDWeU4JLAmGim/?=
 =?us-ascii?Q?kfE5YeM/F/R2IDc5BI3T0QwdaRU8cwz4+5h3JGmJxKRx2Od6zWVsIudfsD8o?=
 =?us-ascii?Q?HVLio9m8q7OkVP/KZ1SC/jiAByTfJXEdsB2oYTiOWD2GR1F4aQCP/r1SpDm6?=
 =?us-ascii?Q?w0wEDcS4Esg1haNfGwD1ATTEroMFOmTG/r0JMzGqahf0P60Qjjq0aXM3998F?=
 =?us-ascii?Q?+VOGT1qg0kq/ywhh3lToLixIiw5EQW37syoZdMw8CjKY0DizRC00Wovv3IEn?=
 =?us-ascii?Q?CpqwAEf1tJ0fP3ScvCTyFm0fAZNdhYAIcoqjIQ3vwKHWEI6xlhtmX8YEmCUp?=
 =?us-ascii?Q?0bc8bY3K3NcKbX4bD0PgIw0fWZ0/tlGFcEdSHDDkp5w5P76m/Sl963uBmNLF?=
 =?us-ascii?Q?HEoSVEBEoR+vVgQRkqWBorZdyW2in58TPnB+cUKbNqm0Q6eiXNsbdLJw22BI?=
 =?us-ascii?Q?uyiOfMc8O8v3etqjtApXXrJANEWhhQ7tBHN/PQfJfr13Kwltl5Z+3bo9saBL?=
 =?us-ascii?Q?ApMbqHbf9XH+V9LVC4hzI8yzohI4pmK9tj3zHw8/dxxl8wpAOwXEN3VQGAlL?=
 =?us-ascii?Q?sqaAAa67ZsTa4GQ/nFNoUMUP2dom85XlL2tXHccX+SuxOb7CVGM506R6t/+r?=
 =?us-ascii?Q?pBVA8SYJ6t+IL1UOsKAUhlGibpLvzjDfB7gMTMPk1j9jQEa7bFQIUvrDKyzw?=
 =?us-ascii?Q?zw/gWFplehECsamxQf90a9hmE41/3lx2EXwu1cJzSdOPWnkWiOpWFqvx7eec?=
 =?us-ascii?Q?Rt3SNdSvimkl4tdwRC7bNX51l293/FlqKRPwCYEal3XDR9BLhqbZe1zzcbBv?=
 =?us-ascii?Q?6UDqSW5/9+qmdZ0yEdZfoDKqDmCht0II0v3mNTysAD6ZJANP+rpgIKFPeLv/?=
 =?us-ascii?Q?U+y+F0+UeLXYrnPmBZyZvKXPWBYvgDn5Zhr2jmgMOxcBOUoeXOYVCvM+DxIz?=
 =?us-ascii?Q?D1mrSqp3f+FY07Qk8NF5uHCLkrBJNnT8i+T0Gkz+cdYPeTLawrw52JOZO8m4?=
 =?us-ascii?Q?DPuaC6tIUIOp7ZbCV+26y01lPJiD0jdbShBC+dm1xZL5MpXW7IEbx2HyRJPi?=
 =?us-ascii?Q?9yBx1KxX9gvo5GRu0QTRSfRNmcmJQca58AajiDG0isvikDsgL3BCidBgEWAA?=
 =?us-ascii?Q?WLkBvFYJE9y4u1Vo7fGvl+SUHB2SITFpOjk8uGRlWDZLmjXaa8tvFmKBYNok?=
 =?us-ascii?Q?jXCYKTTAe1SCtiw6MohuZ5E0+PzbaSaNtWoNHm6o7uvLvW+U8MmWtRl93mqq?=
 =?us-ascii?Q?XxXFXlkeynW4MNZtRoKcSCTxqIIKChde1AO5s50CnLkvrq2lW1GilEKvNoOW?=
 =?us-ascii?Q?Yriy0JWEUDDYUCwf6XWtGgLJKryHGBVXDNT4IfoC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0b9c05-5d75-430a-9d4d-08dc9b9cd175
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 20:15:01.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFbv9VpbJGwyAdVdLfHf58jfHMGe4P9oUjQ+Uc8ntF5K+tlQPVQgRz9UwepYY0q/Ij0kc00QV6NQE4lraRlVSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244

On Fri, Jun 28, 2024 at 09:45:22AM +0200, Borislav Petkov wrote:
> On Mon, May 06, 2024 at 05:47:21PM +0000, John Allen wrote:
> > +#include "internal.h"
> > +
> > +#if defined(CONFIG_ACPI_PRMT)
> 
> Instead of that ifdeffery you could do:
> 
> config AMD_ATL_PRM
> 	depends on AMD_ATL && ACPI_PRMT
> 
> and it'll get enabled automatically and then you don't need the empty
> stub either.

I'm not sure this works the way we need it to. If ACPI_PRMT is not
enabled, then the norm to sys translation function will be referenced by
the base AMD ATL, but will the symbol will not be found since the the
PRM file doesn't get compiled.

I added the AMD_ATL_PRM config and added the following to the ATL
Makefile:
amd_atl-$(CONFIG_AMD_ATL_PRM) += prm.o

instead of:

amd_atl-y		+= prm.o

Is there another way you had in mind to make the additional config
option work as expected?

Thanks,
John

