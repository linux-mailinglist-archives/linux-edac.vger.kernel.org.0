Return-Path: <linux-edac+bounces-1659-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAD4954C27
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DF32816C9
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45A19D8BA;
	Fri, 16 Aug 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VFt9kqiz"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93E1A3BC0;
	Fri, 16 Aug 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817840; cv=fail; b=GFM1ZtctBYbNcZCB6fqi8ccrYCoaQ0wR2o8eQCRk+3vr+Rp5F6P3Y9QnnEZnRkXj/gpdV9QJzO/ocPQg2rYP9Eu6Ek3LPOGm8Vn4Se7bPKtqtMisDrOV52+TBqVKugNh6gHWYgVg1HcIDcpn3PfHGKNKwfptPrRwZw9Qd6i8xYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817840; c=relaxed/simple;
	bh=fcLn4zGCHFtPp2K0pPsbexqml5BGn7vhVT1FC0SZ3Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F9613uUa01ksCmvuWB5LQj1Gp4NTQ9Bmn5OPqyfKcuRqCgwm7y42CWu9T3RIUG6gsW1/2NTq95CstUiZd6MDZJ7hxh/luG9lbimx/XJLi7OyQfauVojm7qh3joAc3n7Stiu8sYk8Lbp92izyWp2p72naSkltQxeeaiVWU7audgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VFt9kqiz; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1hvZt65iLWyMt8pQyocnWoM0XtKNjDRJJGQR3FITydd0lwNQpAqJIbpYqkG9M/Xsz9QwqOGcSD4TvhzDuyht+6jRlZMOBEYBalADDeoFaIkMSrjlcF98aTxj6pcv3OQ35z6+2CjMh04UtWTsuVpgLt2DX1rJP3urPq1npMZ3BmlSFwJc4FAmzdyQ01jfVpZObCQXnCehjiv+NfPH9ADCOkbEQfk5/FRYMwjVGqh2WciSEQmHhcHAWTYUa3KYbwi0+xG1I87t3TaoB46HlenCSnydcaRL0eLhLUvH57ALqYmcjPqorh07iACHG5OW1LGjAxr1k6cFwzsm5yVdTgGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMnjp0utKfBUf6STJKChEivYn6UZbPC/lHD+h+k3kJo=;
 b=WTQg+0fO/Bh1KiQIcFXZTd6FtuJL0zXh79NiAe33B0p/OSszo2FavLjbjLEENGu8eGkIu37tB/y4wXQWb+oJiV1aZXKijhrOepEc9X+HCt/SWcwrxmd+fpKplo2FB9ZVgncAIDip4T9NjH5sIFwIJdeo14QVPVoHly1qDdI3vPGjHaD8sVHguP9QwXXVwT+tQcWzrU3LwvCnWgq9RsOfFDYx22wMnF2RrT5OIgLXgIJpj5t34+oFXO+eD7KCHP2UaDwdMT1Rj4P+jTupFUHIQKOt5MBzg8J/byo8My/CA7Sdh9E/qaiwPZyE6ECrUJV2ZRhi1kBYrjTUTg8/pyxNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMnjp0utKfBUf6STJKChEivYn6UZbPC/lHD+h+k3kJo=;
 b=VFt9kqizBkmQ2uidPYgvgRnNkYXcxYB1xgiHdP/Bxm66avV4K71riAmWfVXAz59L2G4q3bptjnmJM2iaNt7PQgGpKgdL5VG+WvTj6gwxllMK0TuTHffaikKNKn9SNHTWHIhQotBy0V5PV8xeMDKh0dbZl/d+XJk4JKjWBFsqldU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.20; Fri, 16 Aug 2024 14:17:15 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 14:17:15 +0000
Date: Fri, 16 Aug 2024 10:17:11 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 8/9] x86/mce/amd: Enable interrupt vectors once per-CPU
 on SMCA systems
Message-ID: <20240816141711.GC29375@yaz-khff2.amd.com>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
 <20240523155641.2805411-9-yazen.ghannam@amd.com>
 <20240604154635.GTZl8222q7WAEVSJKH@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604154635.GTZl8222q7WAEVSJKH@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0503.namprd03.prod.outlook.com
 (2603:10b6:408:130::28) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fee070-065e-408a-3612-08dcbdfe20fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6PflYhGxVdwNnnuMob38m1BLrOI+1vSzRtv6CL1SQrv3YEfV9xzCCRWWtFXu?=
 =?us-ascii?Q?AHKZbmxGlZiCk5LtVUqnVU43mN74ZMS2NFC7fWro8+8N5IvmeOvIpp6WayCd?=
 =?us-ascii?Q?W28MnJWG5a2CN98hUflFam1QZA/pYSe5hgHQiCkflmUptFgrwTyFjXmr3Bn8?=
 =?us-ascii?Q?+YDV5hy8mh3791Q+12ciKVI0DB8W37zMOg+AXTKCKYckJq2EzyKpanoU5T3R?=
 =?us-ascii?Q?AAPO8M5wbyXnRJsFat/N6u4xFCc92JEwh9Fk037Bq//vC6yQrngvqh7Ypb61?=
 =?us-ascii?Q?HH06aFYZ/h9OVqu/GzoaT9a7Yzy3VAAlEZlfB6TpDr5sygfB1UtG4LmNUU/f?=
 =?us-ascii?Q?87K0hwS8Ez17d15kzFlTnWHwf8aVPzgwlKXKpDO5M2gjflno+z664cn9fEZn?=
 =?us-ascii?Q?qI8kVAfkwHPRgSWjRZ2htXjFDIMCe/zp0Xf0PZO3ShefXI7WCiBh6QIrRNQ8?=
 =?us-ascii?Q?QwElPrer3UiC7x8Lt1PnZZO/4oFjy3q7Wrh54Hp8wAQ1QA6408VgAqgkRBvg?=
 =?us-ascii?Q?qBTIRw5HHwwG4gRHsMlRELaOre1Ec7XsXVMTRK8zbfVuk3crHYUfvIZ6geMF?=
 =?us-ascii?Q?Nru+PkuU/PqFTlkTXcPVuLrb53tPMc34zlL+gxnLAIdcU27Rac2xzCTNzx55?=
 =?us-ascii?Q?fAXyZbeaqUHsEayhx6MLWCTLyZ6aDXyzpqX43YOUTAjGGnmsIl9hmPS1Mu2L?=
 =?us-ascii?Q?XT0qebafvBcQXJ4YRvgjxVwRcwHxKH7/36jQWAuSad0baCyINkXQY9LlI1In?=
 =?us-ascii?Q?fgHF+7vWXsXQXbylkrU7JTbfFHqEp5b6kEAxAYzOFJPApke2ABsTIixmG1VZ?=
 =?us-ascii?Q?jOIQ0L4cHTNvSGHN4jW7QYWqLNJprXQKypgd/WBcsxFieDM5u8mNNkewJ6gX?=
 =?us-ascii?Q?29anN2RiofVmFKi+LGOxjsx94zIPpvfwgQb5dJfw8ooVRhT8tX5Yy2h7cA9X?=
 =?us-ascii?Q?dr5kYipaV27ZljVBt7Z6EtWwFUPhgEAPgQbFGlMfDZppj4YJG6f7EmQLU6IA?=
 =?us-ascii?Q?QrRVVTT8irfAB/T9j/vEyLvopOaAY/zfXwHjJSGgPvblAQ+ypgRBL7eCiwyx?=
 =?us-ascii?Q?pWqVOo0l9vgOknkYM2/r2xDm/QOFwPDfQYpTG3NM00eFU8wDIo3LEjbXya5F?=
 =?us-ascii?Q?3Skl7VLPI1e7Xw+DGkYyuVhntD8LJFtt95rfFUI4oNtP+1zgUPGNM5NPVpvN?=
 =?us-ascii?Q?ckK8RIZ4EiUEPfk0BFpQ5JOmqUMXTyzXeEoxcs1bEGNt8TfvhW7ToFYP+mkM?=
 =?us-ascii?Q?h0Icqo73h/Jm3pfeg53lJJS4wT32j2P88J6gnwFX0AJwIPLZSHEx3kEBqNTi?=
 =?us-ascii?Q?i4I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRy2+P0IS3TyulVfURf0+8BwtJBZLNWgMwLbySRY6DwxDWlNM117eAHge+cj?=
 =?us-ascii?Q?qZt8op8nfebNs9IVFrbVHw/DUCKT8QPxalsUv1GFXDMAjZBMMKx5zO8GFs0j?=
 =?us-ascii?Q?SZtUn1T5RfoScZWynJuWJ2DxCgxRYiqjTj6/kadnNmGCKxop1/VOz6pCrwFx?=
 =?us-ascii?Q?SHJsqBkDRQhBUY6djhzbkR3YvzyTKivBAoL13YC6fuB+uLzOs/iwopVB7sH5?=
 =?us-ascii?Q?KdTkqVZTAuXb1MRGKKruCKxL9ohGwa+7N6VKzOjviUlFV0/JsRyVcbBnRwqF?=
 =?us-ascii?Q?2iXw7jTP97q4Ot45qZQRbV5I9YstDlef+TZBn5Kblsk4t+VHGVIUzL0kIHDJ?=
 =?us-ascii?Q?Ej3q+NipMByqB7tfjsuLGJZF46ldwXQrf4USFtWo10UCV4vw2RFvdMny85m2?=
 =?us-ascii?Q?paHvyYAWuf84kgxmzh6GfylJIQiRqaVXhvSrsWrAHYEPcE/cojhqAICuOi+T?=
 =?us-ascii?Q?whPdJ15xbm/dYkHndqwrZt/6sHSu0qg3qCTC3+UoAclR7H4pF/PnSfW8IpLT?=
 =?us-ascii?Q?Rf2hQZIrU2Fkb/Gup57GL6IvNbb4+YWIjaXxEiAkm43nNEL/bRJZEimnbjoS?=
 =?us-ascii?Q?KBK6Y9WuisqI+RzAb9hVeXgFWtGQmhfKwElgwpK2yhgIuIpPKxcvyLjlvtf/?=
 =?us-ascii?Q?xoqZzWNsHKnSMgvb+90qZ7lvIveU4VSXRE8rdEfzYWVB0BWfktJrATtc7kb3?=
 =?us-ascii?Q?0hfRFw7UptsEswn2j4n8xBkSHopBokw0ef9rKkAXxeqmGEvRcL8OPXbHq6hl?=
 =?us-ascii?Q?EfSo1HTaELwTsEruxWvFX4BaYzhnCH63pbiLg8BVfl3YAapygSc1jjnT5vxv?=
 =?us-ascii?Q?J8JxWazm32Yy85TE16D3sQ+G7cXEAEvuIfzQf7aOahHK0BP/uhwkbhiUeU61?=
 =?us-ascii?Q?VUGL8i0G7uMbZCgmQQyYn5OkXoSdguoZFqw2HbwoxPIInFdatC5kIBuIfSbT?=
 =?us-ascii?Q?1BGXHERSwY4feZWMwWoVyGlsv867db2YC7yk05Lljl47sv0uLtb9/ZLI4L4c?=
 =?us-ascii?Q?BRT/GqSFrySxfjKbr4AzcKf+HWhiIC7ZpohJJ7zp0QK3jSItlV0DCXpdGsjS?=
 =?us-ascii?Q?P2zxfD00gT1sQgWydYIwblL1r3CXlDFl8gvm9xud2N80lkxJE9f4P3MBdWLh?=
 =?us-ascii?Q?5AfMq7xQJxnWCTxJaUFxo0cRYWhMQhQuZTdvE0v6npY1GjrRkcD6p121I/Pw?=
 =?us-ascii?Q?569+E1BPamd0NOZgOFvZCkiJID8XYgkk+yJTpFEqZaFP/WEOVFovSd6J4cyR?=
 =?us-ascii?Q?1PdQF6pfkI18BM1V2Rqf0SptO7GgdCGotkimwELgiSEbHogVBvSKkzbcthuW?=
 =?us-ascii?Q?LeQ4Y1iN8CTXxf/ZEQudUk4WvFRJ/qcVGwI4/T7z5aypAqVuwuZceeEaaMfu?=
 =?us-ascii?Q?pfUUc4tqG+rwYZ0iaOSznb0tNDph3cJ5T4hwOiksDG/ADVy52cAnn7Ph7YrZ?=
 =?us-ascii?Q?unCAfWOiuAgC7HXaskVFBxY7K6bNKGhAcLHqkD74znh4b0OE/3qfS9Kjfi2p?=
 =?us-ascii?Q?U5ycbijNlyayCqQyMl+iS90U1Nz4Wxc70Aq7JiYjW66KZ/PIRT+dFZyi8PXz?=
 =?us-ascii?Q?SyuPU9qa+d8JSyO5Vah89jKO+4TIKF6ErJgGMPaa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fee070-065e-408a-3612-08dcbdfe20fb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 14:17:15.4201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4inSK8n/wNUcKrWT690fyPZINSWPI5E3Oj7+zSaKFxap05sOK/7DB9+pyd40TI96jYWP2YYM4duKa1FaZpVvtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118

On Tue, Jun 04, 2024 at 05:46:35PM +0200, Borislav Petkov wrote:
> On Thu, May 23, 2024 at 10:56:40AM -0500, Yazen Ghannam wrote:
> >  static bool thresholding_irq_en;
> >  static DEFINE_PER_CPU_READ_MOSTLY(mce_banks_t, mce_thr_intr_banks);
> >  static DEFINE_PER_CPU_READ_MOSTLY(mce_banks_t, mce_dfr_intr_banks);
> > +static DEFINE_PER_CPU_READ_MOSTLY(bool, smca_thr_intr_enabled);
> > +static DEFINE_PER_CPU_READ_MOSTLY(bool, smca_dfr_intr_enabled);
> 
> So before you add those, we already have:
> 
> static DEFINE_PER_CPU_READ_MOSTLY(struct smca_bank[MAX_NR_BANKS], smca_banks);
> static DEFINE_PER_CPU_READ_MOSTLY(u8[N_SMCA_BANK_TYPES], smca_bank_counts);
> static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
> static DEFINE_PER_CPU(u64, bank_map);
> static DEFINE_PER_CPU(u64, smca_misc_banks_map);
> 
> Please think of a proper struct which collects all that info in the
> smallest possible format and unify everything.
> 
> It is a mess currently.
> 

Agreed. I actually want to remove almost all of those. You can see the
goal here: https://github.com/AMDESE/linux/tree/wip-mca

Of course, this is out-of-date. I'll collect any new variables into a
struct so we (hopefully) don't repeat history. :P

> > +/*
> > + * Enable the APIC LVT interrupt vectors once per-CPU. This should be done before hardware is
> > + * ready to send interrupts.
> > + *
> > + * Individual error sources are enabled later during per-bank init.
> > + */
> > +static void smca_enable_interrupt_vectors(struct cpuinfo_x86 *c)
> > +{
> > +	u8 thr_offset, dfr_offset;
> > +	u64 mca_intr_cfg;
> > +
> > +	if (!mce_flags.smca || !mce_flags.succor)
> > +		return;
> > +
> > +	if (c == &boot_cpu_data) {
> > +		mce_threshold_vector		= amd_threshold_interrupt;
> > +		deferred_error_int_vector	= amd_deferred_error_interrupt;
> > +	}
> 
> Nah, this should be done differently: you define a function
> cpu_mca_init() which you call from early_identify_cpu(). In it, you do
> the proper checks and assign those two vectors above. That in
> a pre-patch.
> 
> Then, the rest becomes per-CPU code which you simply run in
> mce_amd_feature_init(), dilligently, one thing after the other.
> 
> And then you don't need smca_{dfr,thr}_intr_enabled anymore because you
> know that after having run setup_APIC_eilvt().
> 
> IOW, mce_amd_feature_init() does *all* per-CPU MCA init on AMD and it is
> all concentrated in one place and not spread around.
> 
> I think this should be a much better cleanup.
>

Okay, will work on it.

I have a couple of other "init cleanup" patches from a previous
discussion. I'll fold those into this set.

Thanks,
Yazen

