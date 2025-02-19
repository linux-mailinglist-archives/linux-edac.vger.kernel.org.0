Return-Path: <linux-edac+bounces-3160-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1369CA3C4BE
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 17:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AFD1630A8
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620BC1FA267;
	Wed, 19 Feb 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gutzDP0b"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17E748F;
	Wed, 19 Feb 2025 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981818; cv=fail; b=g7YBDmpDHVw6qb++gLjpAOG0tqQ9/P1a/PgsryWlTgM5zKOPHsuBnvNnJpBTgs+WLLpqPXUNe6szcTz8kkz70eFPaGAVwX0/STOp3kna/92by9+qmlJkLUdh0er83Ltz+8KdL9WmVaarjNEydXT2sGWptZ/S+9yi1xo0D+3c2dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981818; c=relaxed/simple;
	bh=BTz5yUDWl0+RlXgf1xpS5apwEwdeWzXEVSdXbZrm368=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q0nmxJmys+z3yEIVvmlBdfOxnn8SK0kR4zdFFgl7jaMAUSGmY6G0gHCb6hIcYza5AFXRpYFf9PiID0U6qxA/vEjm6yd5OSfdT2BUcubvpgHdnQHnzYjG8pCAOGwIHAYfvoBs0/s8WIOH4jWeSKNZyza+W3G3U0B6WiUoKLHsrSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gutzDP0b; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIgk5m7XvXYehyWEbrg4NXeHALdnkPQcsn8PkgawapRWvAjwWMNiqww5brZjk6eFXLOtJrEv8r/ejgHCttaEjWDQMk8j59jSMk3Mcevmm9lQf73zUbM8ishtVSyUPa3sfNXPHU3DvmXkSpY3ut4ILb64ViBPDztELQFzBkJSvRbnzyV/0xUpiA2/z5YIIKRcwk68v80xcbuTHmLjMqDBxGm8L9hSc9ibOddixx02zncO1M4TNmJ4KUEp5i9JQNmWt2zvPqrEL3O3AO9q6Xdhy048HgEni5czIQqBb1Dj5oEned9TbqcqpVaolmFGLZsHHBUl9jJD2iWZr03teQNWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg3B5Bv8J8T6M3Qd3Co1cw75mOgzoKQ4bmbwYNf4oOI=;
 b=g2kmTQZKSsY3I6/K0rpmU/qojt97E3QNgTvflLOW/mmiIT8Mq7+Tud5m0lNUBtle+iJUuoPP+ROjTKXdfl4l4fNqI0KeZehI+0kkBtgFdGLry2fKHMsN7CJ3aju5aZ2pav7PHJtU76KyOjxHS8/53+kVzI7b3X4SIM3COj4q6uXKKTQWssJuSY0+yOuaeuAO2vyOFjgy5HzziN/zpXxBJdwTK7pDmT3RsJ85u6czgmGbVMxZdJX9+uaaAUv3Mtkv8vLU3KNYOJj3I+B/yAxoAIEWCyILKedv9exnuNZ5BTaO5Xy5bQrcaBTAKHMwVtjYH6NUiG/ChVSUzk+heMxOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg3B5Bv8J8T6M3Qd3Co1cw75mOgzoKQ4bmbwYNf4oOI=;
 b=gutzDP0biGz1b4KV+HS3P6TUeEN9bG2y7gKpT48mf9S7qrMlU+KMQkRta7vOLq08w7sXhBfbZWqCk8hoZpwVpv933w709UdLdzHQiWyzrfx2Bs43JozrHYWsVQkEsdjhMKhEK85++ih6A19029Jh512RyfMxemMMEncszuAbpG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 16:16:53 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 16:16:51 +0000
Date: Wed, 19 Feb 2025 11:16:47 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 14/16] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Message-ID: <20250219161647.GG337534@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-14-3636547fe05f@amd.com>
 <CY8PR11MB713437893EB56A76A5685A6489FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB713437893EB56A76A5685A6489FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::24) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 167f9af3-1c5c-49ad-0451-08dd5100d173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zm9u4m9aUGplRmMPgfTRcDEuIaQuDgOYdeohJ3k0rxCiOk+2tI/oHZTqdzhs?=
 =?us-ascii?Q?m8Xr9J5Zd6kgh3uo+tqncVcCyK+//pGTy2C3kxoPgvWbbZH5pfJaouDR7TT1?=
 =?us-ascii?Q?4vZ6jtdypaZwPpxD9SR+otzuh51IG5lNYXZD7NL3nUn7yDL8xWz3qwDcwRkL?=
 =?us-ascii?Q?D1VJhV2MN0diloiNAYamYF4JP0XUkmYQjqNJ4nxdKPNBpT9IN7eRfpqpAjY2?=
 =?us-ascii?Q?vRahWa/nUuxsluT0Qag8twQaKYi7H8E4to6a7SJj/eMKr6/jk81UD/iRZ4y7?=
 =?us-ascii?Q?PoQxSZQdLocji5FJrYHnBeSI+oyPoOYhgfEA2yZKeCBf23WTqeUiTuLqx4P9?=
 =?us-ascii?Q?vEnznGYihpYu+r1zAm+gzB0drMdT9tcUeDm0ik3RKa61r8BWXW96FupIuBjs?=
 =?us-ascii?Q?4Ca1aPJgY4JT9qNvtdXYgufye8HmJU2UrD4l6CG0uww517VVsXgzMz0Km+ox?=
 =?us-ascii?Q?dR2vhKFTHp7xvC30ByPUa8dKujF7AfcBPHQkIr5VDAXrF1LdiG5vbWTO1p+r?=
 =?us-ascii?Q?Ni+D64nDvMaw/pSAUAs4M03rI93d8ZlUp+tM9oZqg7KLgyQGrwM6+0mJ+Yx1?=
 =?us-ascii?Q?daQSiKoPSTJaDDFcaNtew8gW0E54CDp9D3dsyBpejnRR89Yvm8XSmtrKcmjd?=
 =?us-ascii?Q?arV06vtUDwDvIeXMSMCh1hS0ekTwiXkB5TS5s70xXJBUeTvw20f0WsHyEEmW?=
 =?us-ascii?Q?tI3AeaNFcadVrzyEZN2aBG8EgoPSgXzjKlaFjj4RBkM96KYA7QGNxp18wu+F?=
 =?us-ascii?Q?aZqIn7+zwsrNAu+ODqDCkDj2lfK+OkYzwgM85JL8ENt4RY9lobmoQ9xPAiIh?=
 =?us-ascii?Q?mE57JQdl8L+DJBIYr15wIZ6ID2Yo6klYRiq0R4wEXc0nOfezIwo7Ydb4fXk1?=
 =?us-ascii?Q?2e8/vt/Kjq/yu4/HFUSxM39mz0J9EeEz1bKVSfEPL7RCZ5M09KqPlGxCi+CQ?=
 =?us-ascii?Q?cvqp/JWf1tMaCiyLylcMIHorpReQkLrsSSG/x2Hj4pom0BjvA4hvGoVio0Nz?=
 =?us-ascii?Q?lEO0Ng579+ttuwk0HGxI8JxoIAnrXVHa/F/k2IeIiSTgY0izItqBA1aAiLpF?=
 =?us-ascii?Q?S4QjdFgkqcSEHEa5fG0v9lixBzphh3b10dCpvp+CycvMA5r3Ke+xIKz7zMz4?=
 =?us-ascii?Q?cVNHWVidcWjmtP0E2QGcwcpslLHuH76pAyylb0GMmWd08rdS/hoaXKMqP0CP?=
 =?us-ascii?Q?U9l9y1dI9mhrVWSiWTZMPWUcDVAH+3GPQsgwVqUqU9HIYQGwc+r02P4krnE8?=
 =?us-ascii?Q?VZVlg+wOWZxpiu9XjaoJPXwFQkBtQoyB/vCT0LRj1k6tlcrSvbbdPuvm0pff?=
 =?us-ascii?Q?dGHkS4ajm7WqWSnFuCtCVBY+tbPaqezQFc7Ju04/DsXfIooANB2cTC4Rs0qM?=
 =?us-ascii?Q?sNRTIPhtaFXomDCRMYB1AFHz0MEV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T8OJJGAoK3JhnLyQIWtmEEGk+BRKZNByrMJWIdq7GQPWtxJ9GjZQYB5Kg7Sy?=
 =?us-ascii?Q?KCRbLPN6HrMNXgpRPwU+9OsqO1fU+W2TtBGepvWlU2GPmhATu172wKPGHfbC?=
 =?us-ascii?Q?p39JZe2E+w9aJ3n/JrTcZEX+WlxBQyl7HikstNdWn6MmYSnLMCdG7HMY8Sqs?=
 =?us-ascii?Q?t1XCdkZ/qjuuqUJ32PBl7cYx8tgfbiyE0wmEuEJytCf5juzeNMSB1/FSEyNo?=
 =?us-ascii?Q?cySnorgAh9DWAfDgV34yX/l/4BUuh7IFwHAg6Nr9YlJPsjk2XTC7D/dgvDn3?=
 =?us-ascii?Q?mz23GeaCaKq0hK50XfGXV9LBoyFTbWkznAUznpS4EQVA54VxH5INWSVTBfsf?=
 =?us-ascii?Q?4ugNz9kUNHXVfpZ8GVBWwRXTleFdjvimrWzg/8SwvtICc1M9Bxpw5FiitGqO?=
 =?us-ascii?Q?0UjGtpWZD5MKCV2gaB4YPCcGJyN7EAWpiRLfJ1W5H6ohz3MQJCpO/2sXTwGF?=
 =?us-ascii?Q?QNfC0QV9CaZzPA35ZixJB05R8M5a3W8WLbOgu9n9eblhysfKqv4TT6W4NO4i?=
 =?us-ascii?Q?GklLgnF7W4lEjx1Li2PXvbXVbF9AcLkywgIZJ1IJU+Ju9u+RsKz+eeVhHZdg?=
 =?us-ascii?Q?CXm2yLY9ke9hyFQPoKn1Ej2y+VTKG3XDIw6DnmgAgrp/EG+ELvb9VFeKxb2R?=
 =?us-ascii?Q?7IKX3MNK8eoEYaCrJ0DPi1uRpOGM2VUQdWTW+4N+7S7Ek1bxe5UI7b9vjEDG?=
 =?us-ascii?Q?0uuSVbqiP4JIUkiMmtKXAX66NL8v6UUoXVmgLNf7UQS7Eckh/o/tRryviFAd?=
 =?us-ascii?Q?ev0K3JbhZZVhgYCjrUmn8wlyV+iWnyldFKl94EjrXvtnA2xCbRfyx4NOzIPy?=
 =?us-ascii?Q?Hu1xxnARbYCPPuU/Lzsi5c1HOski/PqSEUKYNXbXQLpcVg08ShHYY1RbChlt?=
 =?us-ascii?Q?6bV7JRZ6Yjoy98gUZ9AqSr2I2TLyQndLK5wuk8jHPEt//FXMy7PODpoRS+PG?=
 =?us-ascii?Q?Lkk8D7A3qLDCIa/SCcpOA4AE2Q9UAap4pShMZMkIXDzfSHbRG3vI76cDI7t2?=
 =?us-ascii?Q?PK96PiIOyX+bzjc8+RtPIRT3op+NDA9GfEGyXnCnqbwDsXlqeuhizOy/hSTn?=
 =?us-ascii?Q?wxw5/vxFADOfzUfHGsLpATXlFTG7/mOk8zrFZXcwdHUeGD5yo5jf2aeFBjVi?=
 =?us-ascii?Q?/MjJg6SJ+1HTfpV83moT2z4cdZZGLKdAZwmhPZipKETIcD26KPvood8Z0/WQ?=
 =?us-ascii?Q?OgipZHIGld6xhH2XIcfIcPZB1fVgInKYRnJONpYwNopPqxJeWZ+jxCJWZ0VL?=
 =?us-ascii?Q?euO8vXdX2mLDzJWVdbDUQwKz7KvhXTDZGr7ehcufI26VwmHzxQZQ0CDFehOF?=
 =?us-ascii?Q?gHWPJoNWtMj6zkznRcJxcK1Ib/bc+DcW+cYQVk/ctz/nYkbHJ2GmlUDX/9V8?=
 =?us-ascii?Q?gv78EqrUVlJrJqOghzyXjcjeV0xxUHbO7YntUbH63ER2WDNkGVx1qIK6f6FT?=
 =?us-ascii?Q?CvAwfcFuL9P8kLGR43YJyolby7IODm0tMzP5+70X5/D5GMdNrKOYcyCUZsMD?=
 =?us-ascii?Q?PVUaQr12HFj/3wPz0Bo50m8FBaKaM4w6s8JEOt7KEowCHxeBLkZIyzD2Qqbm?=
 =?us-ascii?Q?BN+1PvbBjOVwigxlLhqDYLdCMuxWF6VqZ/ISrHO7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167f9af3-1c5c-49ad-0451-08dd5100d173
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:16:51.4277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVZ1/MPoOhAc5bBjvcSrUh3J2gvYmiGjA2gLNO3Am4XuhpdX2QhjmLqhqvQKeze9D0g0EeuTNnRnpk6zRrSLjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650

On Tue, Feb 18, 2025 at 08:23:22AM +0000, Zhuo, Qiuxu wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > [...]
> > behavior. The deferred error interrupt is technically advertised by the SUCCOR
> > feature. However, this was first made available on SMCA systems.
> > Therefore, only set up the deferred error interrupt on SMCA systems and
> > simplify the code.
> 
> Does this description imply that:
> 
>     if mce_flags.succor = true, then mce_flags.smca must also be true.
> 

No, they are independent features. However, in practice (on production
systems) SMCA systems also support SUCCOR.

> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > [...]
> > -static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c) -{
> > -	u32 low = 0, high = 0;
> > -	int def_offset = -1, def_new;
> > -
> > -	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
> > -		return;
> > -
> > -	def_new = (low & MASK_DEF_LVTOFF) >> 4;
> > -	if (!(low & MASK_DEF_LVTOFF)) {
> > -		pr_err(FW_BUG "Your BIOS is not setting up LVT offset 0x2 for
> > deferred error IRQs correctly.\n");
> > -		def_new = DEF_LVT_OFF;
> > -		low = (low & ~MASK_DEF_LVTOFF) | (DEF_LVT_OFF << 4);
> > -	}
> 
> This code is missing from this patch.
> Expected?
> 

Yes, this old code is replaced by smca_enable_interrupt_vectors().

> > -
> > -	def_offset = setup_APIC_deferred_error(def_offset, def_new);
> > -	if ((def_offset == def_new) &&
> > -	    (deferred_error_int_vector != amd_deferred_error_interrupt))
> > -		deferred_error_int_vector = amd_deferred_error_interrupt;
> > -
> > -	if (!mce_flags.smca)
> > -		low = (low & ~MASK_DEF_INT_TYPE) | DEF_INT_TYPE_APIC;
> > -
> > -	wrmsr(MSR_CU_DEF_ERR, low, high);
> > -}
> > -
> 
> This code is missing from this patch.
> Expected?
> 

Yes, same as above.

> >  static u32 smca_get_block_address(unsigned int bank, unsigned int block,
> >  				  unsigned int cpu)
> >  {
> > @@ -551,7 +516,6 @@ prepare_threshold_block(unsigned int bank, unsigned
> > int block, u32 addr,
> >  			int offset, u32 misc_high)
> >  {
> >  	unsigned int cpu = smp_processor_id();
> > -	u32 smca_low, smca_high;
> >  	struct threshold_block b;
> >  	int new;
> > 
> > @@ -571,18 +535,10 @@ prepare_threshold_block(unsigned int bank,
> > unsigned int block, u32 addr,
> >  	__set_bit(bank, this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
> >  	b.interrupt_enable = 1;
> > 
> > -	if (!mce_flags.smca) {
> > -		new = (misc_high & MASK_LVTOFF_HI) >> 20;
> > -		goto set_offset;
> > -	}
> > -
> > -	/* Gather LVT offset for thresholding: */
> > -	if (rdmsr_safe(MSR_CU_DEF_ERR, &smca_low, &smca_high))
> > -		goto out;
> > -
> > -	new = (smca_low & SMCA_THR_LVT_OFF) >> 12;
> > +	if (mce_flags.smca)
> > +		goto done;
> > 
> > -set_offset:
> > +	new = (misc_high & MASK_LVTOFF_HI) >> 20;
> >  	offset = setup_APIC_mce_threshold(offset, new);
> >  	if (offset == new)
> >  		thresholding_irq_en = true;
> > @@ -590,7 +546,6 @@ prepare_threshold_block(unsigned int bank, unsigned
> > int block, u32 addr,
> >  done:
> >  	mce_threshold_block_init(&b, offset);
> > 
> > -out:
> >  	return offset;
> >  }
> > 
> > @@ -659,6 +614,32 @@ static void disable_err_thresholding(struct
> > cpuinfo_x86 *c, unsigned int bank)
> >  		wrmsrl(MSR_K7_HWCR, hwcr);
> >  }
> > 
> > +/*
> > + * Enable the APIC LVT interrupt vectors once per-CPU. This should be
> > +done before hardware is
> > + * ready to send interrupts.
> > + *
> > + * Individual error sources are enabled later during per-bank init.
> > + */
> > +static void smca_enable_interrupt_vectors(void)
> > +{
> > +	struct mce_amd_cpu_data *data = this_cpu_ptr(&mce_amd_data);
> > +	u64 mca_intr_cfg, offset;
> > +
> > +	if (!mce_flags.smca || !mce_flags.succor)
> > +		return;
> > +
> 
> In the old code, the deferred IRQ setup just depends on mce_flags.succor,
> But now it depends on: mce_flags.smca && mce_flags.succor.
> Is this expected?
> 

Yes, this is described in the quoted part of the commit message above.

> > +	if (rdmsrl_safe(MSR_CU_DEF_ERR, &mca_intr_cfg))
> > +		return;
> > +
> > +	offset = (mca_intr_cfg & SMCA_THR_LVT_OFF) >> 12;
> > +	if (!setup_APIC_eilvt(offset, THRESHOLD_APIC_VECTOR,
> > APIC_EILVT_MSG_FIX, 0))
> > +		data->thr_intr_en = true;
> > +
> > +	offset = (mca_intr_cfg & MASK_DEF_LVTOFF) >> 4;
> > +	if (!setup_APIC_eilvt(offset, DEFERRED_ERROR_VECTOR,
> > APIC_EILVT_MSG_FIX, 0))
> > +		data->dfr_intr_en = true;
> > +}
> > +
> >  static void amd_apply_quirks(struct cpuinfo_x86 *c)  {
> >  	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array); @@
> > -690,11 +671,16 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
> > 
> >  	amd_apply_quirks(c);
> >  	mce_flags.amd_threshold	 = 1;
> > +	smca_enable_interrupt_vectors();
> > 
> >  	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
> > -		if (mce_flags.smca)
> > +		if (mce_flags.smca) {
> >  			smca_configure(bank, cpu);
> > 
> > +			if (!this_cpu_ptr(&mce_amd_data)->thr_intr_en)
> > +				continue;
> > +		}
> > +
> >  		disable_err_thresholding(c, bank);
> > 
> >  		for (block = 0; block < NR_BLOCKS; ++block) { @@ -715,9
> > +701,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
> >  			offset = prepare_threshold_block(bank, block,
> > address, offset, high);
> >  		}
> >  	}
> > -
> > -	if (mce_flags.succor)
> > -		deferred_error_interrupt_enable(c);
> 
> The old code to set up deferred error IRQ just depends on mce_flags.succor,
> > [...]

Correct, this is the same reasoning as above.

Thanks,
Yazen

