Return-Path: <linux-edac+bounces-2354-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EB19B693A
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 17:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8521E2853DC
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E321443E;
	Wed, 30 Oct 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y9OXbLRs"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B51E47AE;
	Wed, 30 Oct 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305918; cv=fail; b=BbYbaY5ooN0/bJymvqUgOmqVUMQfGysU8IRaMTXJdpklpbvo7yhulvRwIBS/PYVpatTTjv+pExmzO6QBlhFwicc3ReVtJFBaZJ4wJzLO2SbTYx/UJHgw6Om6kirFv+1ZjGditq+rXeJnNC9zT7t7OhSsOBkxoWyqtc730wIaSjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305918; c=relaxed/simple;
	bh=H+MeBsGEzX+w7+SqQaCKmzlI8T5Xalw1qeSES7pzusI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JyYhsyZm+xDAXMOr06ZkV8QcGExsGJXWCbfZ5kx+IDCsP3OhYoZFDH01UmWlD+QWmsykQ1D0TkKmOx71IdEV6MDzQNk/mCxxRzm+lEGJHSbkKx5DKiBrwZEPb0kKYt8GtBSZm5Y0hBSDIP7kQOmuQZJFICx9N8TSzrV8HI0C1dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y9OXbLRs; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVS6NEd83siHG2qnEk/5EZ+nj3bXrF/yGhHG7KGRksxraWLPc+8Lmbkp3NOcHEl79tughfPyAVflkgG+ybon3U6EUxi3ChRasNYvT9zle5yxlr+Udn1Q5usDj+2LtQs3T3vhXaNG8ag3mFBCKldzlvCLIzJ+NDxCE4FdpitfHjM8oDhbm6o2TYqDs7yIOejBY/yNVieD/TbqhXp06UlM+NLSKotlJntuCzRH/scPEYX2lSfp+xxorBiHujsZMdn6WDui661dONm4vmyPC80g34tMkGKUP/pTIl4G/iqmIorc9mzIx/pmDzqvw4otvSDk8KbXfKBYMk0fkdV/2kbbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WsCBDs5vY2YmQztSCjsqGYElJnOjr+gQk7YVJRfKYU=;
 b=wKrgcAiC7UeocbwGShpy6JyelYBMNfVubUvU+0NRwjAwxGAoQ27WCvhcVoXZmr4rRUDhYliB6+6XKamfc2Psxl4ODb2FqBXdW5tlHMNnbjuTjVkjatvx7js+qxUdljZH1T+mQHxdO3GdUcCkEvhdARvthhUQCpLkkzp8zwQ2v8VJiFVcKfBxAlMLls6wHrvvBregOfjA7OmflGeK3LzI16jGwi/FUXwfqmQevGt6QO+Hqd2Xu6PXYjQIfRAcRDpaVqx8NIgtMZuvtK5vEMbGg3WS8WUGFX7rBY6hI16d+FGCahnOROprpUxbGxzmpMnxVy9GFPQcSo7afXi+PDkyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WsCBDs5vY2YmQztSCjsqGYElJnOjr+gQk7YVJRfKYU=;
 b=y9OXbLRsGjWKzM599aVsRBWbR8gjiXYmsEVlrPG1O8/MypKSxG12LpoNiv581DSR36k0XgjEUDA59tOJUKP2fpXst3DvhZ0AlXHkVCCcueuU83toUneUC8W01IXLIyRL3v5vtd5Kc6XmqXeOKJQ7/PfrqkkgzCJtrHE7QR4wPMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Wed, 30 Oct
 2024 16:31:51 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8093.023; Wed, 30 Oct 2024
 16:31:51 +0000
Date: Wed, 30 Oct 2024 12:31:47 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	qiuxu.zhuo@intel.com, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, mchehab@kernel.org, john.allen@amd.com
Subject: Re: [PATCH v7 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Message-ID: <20241030163147.GA1379143@yaz-khff2.amd.com>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-6-avadhut.naik@amd.com>
 <20241030161550.GFZyJbthMO_2Wxe3bV@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030161550.GFZyJbthMO_2Wxe3bV@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0807.namprd03.prod.outlook.com
 (2603:10b6:408:13f::32) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7cb5ad-7220-429c-b41b-08dcf9005ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ae0JSpEUKAIXie9DYUxk5SsB3zXOmwPmisGj5WytcyTzFP6jSbyQW4GB7hm?=
 =?us-ascii?Q?iBksLmlu9FTuIahiKRuLINhVqbWsi8knaXXV8TqPNHSGKix0Dkt74t7tB+DH?=
 =?us-ascii?Q?5TL5eqfy5JO3m9jbkKU6d2bCTak510aiyEbei6hXHz2N9Z2PjD1HU89wwUI9?=
 =?us-ascii?Q?0ZJpyJrtgGxSkF8ZH02f5cqA0QUn7nqigyvV9mfPYPuHdR62V3Men0+4W76N?=
 =?us-ascii?Q?+nzebRjIRPwfm9hhiv1p75NT2TBkA+9++tN8QPspgBpWMZ+86/I6KtN5s8WZ?=
 =?us-ascii?Q?G+b4XZVLLwh1fqhmkJ2PIHGM9JT5JlqTxKIDrJQ9KYCv/RlCn/itEkgQ8nSQ?=
 =?us-ascii?Q?llrcQ+UniLC9F48ByqaZoEgCvQJ6srh51K1ePrjQaI4YC81RHd7H/4fybRoh?=
 =?us-ascii?Q?na5G9ofxADSA9yyyXA5IKESKUsAvg070XW+r+Pa89c5ov1+942v5e4543wGE?=
 =?us-ascii?Q?1vG0y+WuSz3NSkTYbNgSGNFM6P65l78p4wIeYen9SYUMe3sLgwBnHar9uCAy?=
 =?us-ascii?Q?0Qq4v2MAQg4HsEdQBX+a0BBDJOb3lI0axmyCB+aMB5n2y7e+fCKJJ5MkDD8+?=
 =?us-ascii?Q?jb7SFAAdzbVAWhNPL38zpM7fX8XPWhX792orjoKABK6oo77N+5b8uCQ9LLUj?=
 =?us-ascii?Q?qtUIdJOfZnuQjUAdakPhJO2kukPG8u2p4ex4QouhAE6HEuYM97hf2eRdf7VT?=
 =?us-ascii?Q?V9iJwK+jjYQ8zqiJcSCzzFr3sE0N07iSl5FMsdl+N6RJPVi+HeDlto3noLJn?=
 =?us-ascii?Q?CwOWvH/yGEWFfTGBKn1atJOQ4UAuvIs2aD8xLil/IaX/zyg5T/64M/pOYoFM?=
 =?us-ascii?Q?kAVaL84tY/L4B7/Tc9IKq5emZpenux6LKXqjGjUNHm1c6meZkAUxpIxK30jM?=
 =?us-ascii?Q?Y6uScaC+e8S0lxxeQozR/gbeVMjmCJBNyl+Ds9U6U6u5ic4hxdiFE9vj/IxN?=
 =?us-ascii?Q?vDCP2V4sw3qCsdLPKjKpPqpM69WKUlUHo0XRyKhNjGdDXkWQMLtBUj60OoYe?=
 =?us-ascii?Q?QZS8gjcaSySSLysN9TEKtAS+Sdi0o7ClbSQeUfJExAo5VDiGdn7hZTISsWfA?=
 =?us-ascii?Q?LbL0Ffp77eBDE6yuO3XaH1jzlW4iVAGOx+/5bJ65aC7cmwIz7vgQCkX2bzp2?=
 =?us-ascii?Q?Etkc0W13+7vdBqQdpclkhEnfBL6z131ian6BlhHV96RJc2GbdBrs6yiKv4K+?=
 =?us-ascii?Q?MAzdaYYueC/9nfPmjbTkkCh2GmUNS2f9IiC3s5ayWJHK/uGsEiMsMPVyfl4z?=
 =?us-ascii?Q?geGl2pfiTBzJcvyByfc7jEYiX+xso24jBAdlRqVrDk97cOx8xtGQQZPnZCTe?=
 =?us-ascii?Q?dJtKNi3ucmwjHGux5ug8apyx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EsiqkYAszlJbdqGLtZ8vllOMb2OSNDJxleDMlcyMuTqFNxDKAZ09QtQYoloo?=
 =?us-ascii?Q?F9z8G4OtMVzFDqp2xj8JQxlrfqxJ4BuHADMqT6M/bxfbZu58CntfFWndT3ZS?=
 =?us-ascii?Q?yPTyaT/hq9ZY81Y2DHCH4AUIWDC+NcebhF7xGV/734fPqjX3/kwjbLK6oSyE?=
 =?us-ascii?Q?6+7W46qNdFdQZtIqdLisdNfyq9vGRS6d3GB5Rq27I0DIzwHIPOHBkZsGEVjv?=
 =?us-ascii?Q?G6j8XdLPlSC85ZrC3EZkg4iziqb8QL3+vozr9ZWr9JUoyZ0hAPBWUE2OU98G?=
 =?us-ascii?Q?FLmHXAaCdQmTo4usn1sutOz0cFeGa/LQEsimNXrW/exk4Z4qfvyr9XLjtrow?=
 =?us-ascii?Q?z8sZ/WSm+cAFTodmUxP/VxJe5MbsR9eyH+wTIByJ/+88aol5+2jGIr05XXdC?=
 =?us-ascii?Q?4p+LIBHNIZvBXBooMpK/yPtbuf6gK/WUYrnTzixryTdqvWyhqUzZ3QwK338q?=
 =?us-ascii?Q?588KWVDXnk4b+UM90nD/5sfEE+ykcr6M/gwUKjtosObaUVMU5943Do2nSwpy?=
 =?us-ascii?Q?lddMgEcywOz2YxhqC9irYdgyMfV57KpQ0h13YOI34YNYL46h3Ugqt8zlxI2k?=
 =?us-ascii?Q?Kwmxe90PqeRsWYlFPF90ZrndD6KuSYABCSgekhprf87Ewwa2DpKEw6ptfg6g?=
 =?us-ascii?Q?GG8YMw/kczPRaoiZDJjRME9kyHIFZbm1RNY3p5MywE9ZG0QRlY+tq/eDJAxk?=
 =?us-ascii?Q?b22bFKlp0Q3hiryMByvm/Qd6LxIPTpTx+8Lv1tIDdH3a//Ak0O2he3FJLZ+A?=
 =?us-ascii?Q?RACGNaSoHjsKeHmLeaDOASMKPUjdtdSjh3auTrg9zv47tmyiuE0nVekK5NTl?=
 =?us-ascii?Q?I1jaxBBQSyu2qsq6GZPnudupU+39eKvCoPuZaJAMcWTnTwm0lQEFArBEET3b?=
 =?us-ascii?Q?eB29lrDgvoKHAYiqFv99AdiNxsfTBtUFWC8i5GY/hm2zjSt8Q8kF5h8cZ5c/?=
 =?us-ascii?Q?hk1Vs1WmLwLxUYhFqY2XHQ3erexD4qkeccorlnP5PYdX6Jm3E5e1HZM/nsSn?=
 =?us-ascii?Q?NWQmXn5TEBO0a4294oJ3djQtZlDeUTtFckNva6lTiSTVJBio9svjrHUbp0/E?=
 =?us-ascii?Q?Qozhuln8Lphgkp1goU8v5KrYbV5XkQ9lIbLrGDERxMPUlxG/vZ5sAqoAgMif?=
 =?us-ascii?Q?u9ww3D90OmntWE/2QQys2BVmw8qhbtHDwjDAhvrzI+Yuu8kJy6DlpF/wWzCV?=
 =?us-ascii?Q?9NuHtku1+VriUMpLJ5WXGZHByKwm28XxAX4NvgVWT4dE8W+xO1sMawwRs09I?=
 =?us-ascii?Q?MWUDX+jLMZSG+sNtrVKfFuoeInu1bt9L+ng5b6GylqAqLxYa5umMgd6TnudJ?=
 =?us-ascii?Q?1szLdBn+DPWx6gybRMvwmPTpfWXJ0Et6ZJw/be2QEQMe6LSkmjtQCaWZ2YVB?=
 =?us-ascii?Q?u5onNMaxY073KY9x1f5hWPgSGvPf34k/MEvm976Fzq7e1kx+j6avxpTedAMw?=
 =?us-ascii?Q?hTTLoUNgZ6Dctk8pHXXs5yGxAZSn7SAnO4eLHZZ0VFdkbfIbpZcbpHjYf/U+?=
 =?us-ascii?Q?JhY3aIN2ugzwj3KIM+yjmVknwHtAuPXtYN+mKaArevM4gTdxFkuiXXAQL4sH?=
 =?us-ascii?Q?KcPTvJ3nvOjS3+6YMDNfeCd5WuChs6zCho5unAL6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7cb5ad-7220-429c-b41b-08dcf9005ba5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:31:51.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4rlhmk+RibqfmlzQm+qhfXlLcOcZSrU10AsT9JWjWFbx0f83t9SmKXMMwlbtGD5yg/7WivfASrgxXhl/DVarg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013

On Wed, Oct 30, 2024 at 05:15:50PM +0100, Borislav Petkov wrote:
> On Tue, Oct 22, 2024 at 07:36:31PM +0000, Avadhut Naik wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > 
> > A new "FRU Text in MCA" feature is defined where the Field Replaceable
> > Unit (FRU) Text for a device is represented by a string in the new
> > MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
> > bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).
> > 
> > The FRU Text is populated dynamically for each individual error state
> > (MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
> > covers multiple devices, for example, a Unified Memory Controller (UMC)
> > bank that manages two DIMMs.
> > 
> > Since MCA_CONFIG[9] is instrumental in decoding FRU Text, it has to be
> > exported through the mce_record tracepoint so that userspace tools like
> > the rasdaemon can determine if FRU Text has been reported through the
> > MCA_SYND1 and MCA_SYND2 registers and output it.
> 
> IOW:
> 
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
>     (MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
>     covers multiple devices, for example, a Unified Memory Controller (UMC)
>     bank that manages two DIMMs.
>     
>     If SYND1 and SYND2 are !NULL, then userspace can assume that they
>     contain FRU text information. If they will report other information in
>     the future, then a way of communicating the info type contained must be
>     devised.
>     
>       [ Yazen: Add Avadhut as co-developer for wrapper changes. ]
>       [ bp: Do not expose MCA_CONFIG to userspace yet. ]

The entire struct mce_hw_err gets exposed through the mce tracepoint in
patch 3 of this set.

>     
>     Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>     Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
>     Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>     Link: https://lore.kernel.org/r/20241022194158.110073-6-avadhut.naik@amd.com
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 4d936ee20e24..649a901ad563 100644
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
> @@ -212,6 +213,7 @@ struct mce_hw_err {
>  		struct {
>  			u64 synd1;		/* MCA_SYND1 MSR */
>  			u64 synd2;		/* MCA_SYND2 MSR */
> +			u64 config;		/* MCA_CONFIG MSR */

Anything that is added here will automatically show up in the
tracepoint, since it's a dynamic array. That was one of the reasons to
do the wrapper struct idea, right?

>  		} amd;
>  	} vendor;
>  };
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 6ca80fff1fea..65ace034af08 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -796,6 +796,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
>  
>  	if (mce_flags.smca) {
>  		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
> +		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), err.vendor.amd.config);
>  
>  		if (m->status & MCI_STATUS_SYNDV) {
>  			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index 0a89947e47bc..19a1c72fc2bf 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -155,6 +155,8 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
>  		fallthrough;
>  	/* MCA_CONFIG */
>  	case 4:
> +		err.vendor.amd.config = *(i_mce + 3);
> +		fallthrough;
>  	/* MCA_MISC0 */
>  	case 3:
>  		m->misc = *(i_mce + 2);
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index fca23fe16abe..edc2c8033de8 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -681,6 +681,7 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
>  
>  	if (mce_flags.smca) {
>  		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
> +		err->vendor.amd.config = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(i));
>  
>  		if (m->status & MCI_STATUS_SYNDV) {
>  			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index 194d9fd47d20..62fcd92bf9d2 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -795,6 +795,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>  	struct mce *m = (struct mce *)data;
>  	struct mce_hw_err *err = to_mce_hw_err(m);
>  	unsigned int fam = x86_family(m->cpuid);
> +	u64 mca_config = err->vendor.amd.config;
>  	int ecc;
>  
>  	if (m->kflags & MCE_HANDLED_CEC)
> @@ -814,11 +815,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>  		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
>  
>  	if (boot_cpu_has(X86_FEATURE_SMCA)) {
> -		u32 low, high;
> -		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
> -
> -		if (!rdmsr_safe(addr, &low, &high) &&
> -		    (low & MCI_CONFIG_MCAX))
> +		if (mca_config & MCI_CONFIG_MCAX)
>  			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
>  
>  		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
> @@ -853,8 +850,15 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>  
>  		if (m->status & MCI_STATUS_SYNDV) {
>  			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
> -			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
> -				 err->vendor.amd.synd1, err->vendor.amd.synd2);
> +			if (mca_config & MCI_CONFIG_FRUTEXT) {
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
>

The only changes I see are dropping a couple of kernel prints. I think
that's probably okay. But I don't think that's what you intend by not
exposing MCA_CONFIG to user space.

Thanks,
Yazen

