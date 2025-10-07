Return-Path: <linux-edac+bounces-5004-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9047BC2445
	for <lists+linux-edac@lfdr.de>; Tue, 07 Oct 2025 19:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC8004E974F
	for <lists+linux-edac@lfdr.de>; Tue,  7 Oct 2025 17:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF11E2E8DEA;
	Tue,  7 Oct 2025 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="flBiKkry"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414352E8B7E;
	Tue,  7 Oct 2025 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858744; cv=fail; b=Ip0SZy9VHnP8RBsu+RKXEKuwgZ6gIfs9VELjqjs1Irvdpb3YsMb6OXOVUIIgLlo1FJNY2yqhMLMPpOf2ZRbMEBM/Jmw3x6X/FXXqczvzN4tiOOVj/rp81VuR20ZcKUcXQ2MmkyrLejtD9euAK4mgdm5kka5BIQ8a4Ks91q7hIVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858744; c=relaxed/simple;
	bh=Mv8oUcQ4UFcfKkG07GqyUHcWXA5YiGFBfXrAAznba5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ICMOhcq0achujUOrZwQ4T+mz0j7I5dwPys2xAy7ADHQYB9rhX6UkTxk0b7FRdgx9Rzi4hb26dHNhuOujxkrCcjRBBGkOQTWoCkm9a2CFC5tAu2+jo9YTj+wP8ApgjMbIFBuQtxHxQxlIU+fHXj9KXaakyA7zUvVpciuhngET4c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=flBiKkry; arc=fail smtp.client-ip=52.101.62.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrhfsdwzMrlGPP/gTfXZHT0xXgRbNxdrD09KewQHpZ1Q3cE44MzM2V/Vo0Y/mTGqSxeTPAKxMqOWTf/VPAB0Ptr74Ib0gmJ5gwnZZOUWNhpeGk/jiBQqDvDaMHMbcoYPybuokX9rh/aNk69vf5EtaNexrqFzrcP9lV97ZDmdiAK/ekQ+lvhumiqj421C2QNZATJHOdNjdlz6zKYFjwBpiADLWbk6kHgsYptMfUT/+VXVJ+6rvOcsGngjU9klS8RuwFeDNGESk+QH9C0pjzg7QDB97mJmqBfBhka3Nl2sZ0aqdQ1LNYB6LTL1G9S055SxQwZmSWu+V75S8PN0hSfG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9x/srSKz2d40qZpusftj+Ez1O2iONZTjgkGm6gxVcQ=;
 b=fQXAN/ENVfxC3tdeGJRZQHOwkcJhfNLRYWe0WayD8d+3pyRjHo9sMfwNjG/IGQx8dxdmmKWk8F9gjJo6W8GRXvMx4sXItd9GyPzNH2xVyWmq1o4xn2vMpUU9Yo/+MyFiirpoQ2qin95LvJMHjrmxSdg9AeOXMXySof+9iv1nU+daqVvgm790aYcMfmhcMxxbZ2Xf8AJ38OPYy+IOLUtasLggT/mJ5QOtkxaU6ijDLB64R2htjvrPnDMeGf1EIQkU7Iu6DEU1Hd52duL8HmdViaytTklLnc/EBbL92oHpJEZk0h5fbCJFQ3DVV6Awy0Xrt5RIeeDkR4mIUOwmoc8pZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9x/srSKz2d40qZpusftj+Ez1O2iONZTjgkGm6gxVcQ=;
 b=flBiKkryUGSqC4WfjBk5nRFeDZWI54BlxPQNgBEz2SLuMsjute2lB/aVPYtx03gSF6aBNZxwl+P5gmsvQIe9hFZyrEGAZlli52iuU2MbrlTL+QSAruvk4Un07+a8Pu4T58U7shSLq/IpX3SllyD92F7AFzXJXMBPeast7OiAY4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 17:39:00 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 17:39:00 +0000
Date: Tue, 7 Oct 2025 13:38:51 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"avadhut.naik@amd.com" <avadhut.naik@amd.com>,
	"john.allen@amd.com" <john.allen@amd.com>
Subject: Re: [PATCH] RAS/AMD/FMPM: Add option to ignore CEs
Message-ID: <20251007173851.GD310336@yaz-khff2.amd.com>
References: <20251006151731.1885098-1-yazen.ghannam@amd.com>
 <20251006213406.GJaOQ1zoXUKEk-7eCn@fat_crate.local>
 <20251007145644.GB11984@yaz-khff2.amd.com>
 <SJ1PR11MB6083CA3B5E46A4386A33699EFCE0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083CA3B5E46A4386A33699EFCE0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0629.namprd03.prod.outlook.com
 (2603:10b6:408:106::34) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3ed4cf-4947-4b56-ee8c-08de05c86643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N93e3pttz2Lf1fwkUh9dzeClZl0MmnTAgIBFpaSmZWC5KPcLWZen8vr340W7?=
 =?us-ascii?Q?S/GfiTEi05dSXVVmctoP8cn/rz8Ln/X+JRzAlHsnNKcb+p5gsJyhaKU6xK5n?=
 =?us-ascii?Q?liLzWhrm9ne77SPquC7B1ZQO3K3lxdDFosi/z7SFRcPnervEZ9fxCkSWVdmM?=
 =?us-ascii?Q?ZZOZ/HRxw7+agGcvvqGl8HNWrsfcopm861P0NwF57Dx+ed6EZ1yY8Kgxm091?=
 =?us-ascii?Q?WjT5GYdNvVeIw/Yr9zordxgNHbojJupUfvesDxpXTslf6PsvebsiTUzVUUh2?=
 =?us-ascii?Q?zNaJLn9S/AZox8RBTqXLSZu3QrNG2jDw5bhN+rPJ+D1d8/fXgxh5l6a7gRZc?=
 =?us-ascii?Q?EZiAdgOqHyUe+j7vPx0+aObwWPAGJwrxUtmfTCr7boCzozxg20d/2XRDoE9t?=
 =?us-ascii?Q?nawnnwT35cLLRXEQozpJ9u9zPTZ9027CQ1ojaF8WnS6OGt8frRxyZn0UEvVC?=
 =?us-ascii?Q?MVBvg6tBcJ8N6uprpUCoSP1v8v8MUEHgGWF4LGDrTiFSZoE7oind7hEoM5pC?=
 =?us-ascii?Q?2XvS7cXAI20z0KnF1gqc7m+0eK1/7zbrnbvWTkF/TDGjVAdVk0y71pWM8VHL?=
 =?us-ascii?Q?g60CAEZ3JyBIFk00tcSFkBVN/CeG4hiBVP8ZGfLwehZVKbSnCFWEDwMdvfe7?=
 =?us-ascii?Q?ketcBa1ihiSWX8DaYuWDebV4r/s0GZIqLVBU9yiviaQv587fofT1a6W2BcQM?=
 =?us-ascii?Q?m5RId+Y8EnR5gOpbT7aMEGHoiBJ1WjePlzj4fqx0R8p/qKsmavL2WHWMXIyU?=
 =?us-ascii?Q?1c3cKM31GjhUpgHoYNLHR7Brm1djo6PnmWM/UKZXP2sdbDhlFQ/c6/Hw/6FK?=
 =?us-ascii?Q?z1baqKz0r4Pxb/6z+NAM1UizxbFMMu4dJcxqpYmFdSXcAXOVJOgkyq6/b2M/?=
 =?us-ascii?Q?E2TnxNW9cdcEIEWIgSDN0deWzrtrxf9LGCDYFJCiIPLqbYkKkAzNpjuS3BD2?=
 =?us-ascii?Q?TtgwxAJoaQL14rhoDSELSnJIEJkGxcX115qOdF8vt3DimI0CLPyGiuTJ0evy?=
 =?us-ascii?Q?2+L8JL9yGkQKvyXF0tfd1uNogUkj3tbV9RrMIRLDPTECyCWn72MQ2yJ1Vuef?=
 =?us-ascii?Q?78OpTdiW6ve3rLqPvqi/gGFRamR9BJle8koh+9E5vHlJ5AUZHr7/BcoM8u6M?=
 =?us-ascii?Q?wEKw4NmXuQRctiiHwfN06E2KvGxem9aQl2gczDfoDHM9CX6DIJLZ7R0g5Bck?=
 =?us-ascii?Q?1gUjXjqOcmSd5ZuURqIzx5O7aH6DcNL0IDZNCFz8urmgTC0lnJCvB2LciQ6Q?=
 =?us-ascii?Q?yMNB03nFcuzOjMpL7GmY3tFduieNKNHl1g/wpcdsnh4h+WCFY7SEV4nTX3Ih?=
 =?us-ascii?Q?CrLKacDz+NwbEZ1K+8b+4LFU3ZY4BLtweC5eOkCYpYvWUAljDtOrQOctrOTB?=
 =?us-ascii?Q?/EH4YzvvJGEmCyQ4hHk73aHQ2mupMGZ7r9x6N5PdLkGYNnoFj+zqX3Qu99Oo?=
 =?us-ascii?Q?cJWoTKR/xAoFmuaACIZRZ01PArSKs3aT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z19zRbIufxUXiqIYrwkRB5/iHzVo/eDf5fLbfKIRVWfNgE0IkZjUX73cZHxs?=
 =?us-ascii?Q?08M80wWuQqofsKckDAF/CVCyh6+TYtuBLOw0a1coaORQhfb91LT7YwwPlsdv?=
 =?us-ascii?Q?i4QwbDocgr/dB3vd4tO0YbVn99csOncqF1m/YODVDAa4Y1ZM6VYTMrsgukBd?=
 =?us-ascii?Q?nvxn36zqmdt1h1IuoqqESkLg5rWlk3T27ut+WBGTV6KslT+ASWCGYFX5B3oR?=
 =?us-ascii?Q?GcWVdo50dz7uFtraaX/mZUIwcKyKAjYA69OVlhjlrrStWJNS+nxgG4Gajr3r?=
 =?us-ascii?Q?QhRuhJ+ssxy2D7mJrLGKWzJe0quSwjTUMOq5ucQ8nNXKMMrEHkDkqKNU5qEA?=
 =?us-ascii?Q?e0eJtzZJCTewIwmfMuGPmi6YFvIDQ7CO8DSPizrERnMN9KF5E36piqr14y/+?=
 =?us-ascii?Q?M/9n1ZuhzcZbHHoLUBHMGJ1Cpty9masIB6NclnDnObgzSSzrPW/RYGlHkfxE?=
 =?us-ascii?Q?K8csaAd9Y8saibn75qL0YwtjNMjzUyhVjp85j+t+BQSs7CDf5kfIHAZLYS8T?=
 =?us-ascii?Q?b9wrMDcaAvZ8defNComi9ihpjAfRxA5QS2Ra6JEvckbwtyeGdPq0vzttqhUu?=
 =?us-ascii?Q?QmtO3qKULibr3qtCIuRR2V/XD7F7s7oBvB2bGu2hSG9uB+pryd+khPI2DJZ3?=
 =?us-ascii?Q?lH+kB8/TdTIOoQ/D5lDw8Zs346NXiPhNvoAzxWf95dJY7o8eJp+XtrNX+vIY?=
 =?us-ascii?Q?5MakYboyTyy0536voDZ1WdRi6pJr/5KRg8T/UkSpQVPodmyZ16QjtY7zKZ4c?=
 =?us-ascii?Q?lnDoHmIKBLyCdf9KpFwoZMiSExhwtjXC5ZQoACMwwNZBgFenzCMrcfTY2HtX?=
 =?us-ascii?Q?uLsEvoiheR6TvriZ/tg0vCXLXZqpT0eWdMYx6nFyNg0pdXkHuohKEkZWyTga?=
 =?us-ascii?Q?Y1Jo8Xm/sPhB9pjdCP0eTq2yh5IcOveX7mt4VjT8FA5WN3gPDXrGV5UWyP1G?=
 =?us-ascii?Q?tGCBnHTV7Cf2yyw8JdyVr4ExCHTOxbm/yZZ7mTD8wL11N02EDPbbKubzT83v?=
 =?us-ascii?Q?q2n4Vr9OvZso2oHnuXEmNQZ1Bjd1x865vR0J7+Yx6c2w8gj1hh6nayGknhUP?=
 =?us-ascii?Q?HlLkUZYA3I2U1iZHLPaHjK6kTNsZR6i6x4immzfXnWprQDtbxx9kNTdL+4x6?=
 =?us-ascii?Q?M2GPj7e13L7bsuan3SiMbvlVKyHz4XSf0FZe8GJRVGMpyXRfY9auSSOUGe4n?=
 =?us-ascii?Q?tZ2jAAWvkZqGIS4xtckwj65I0L13q4TmZH/a7vf49FTDdnqf+z2ECJNRHeya?=
 =?us-ascii?Q?EMdXfdPz2WVlF+AW7MxP2r697F3Ls2D7Sx2Hvnir3g8HDIK0VmqR4muHHiUw?=
 =?us-ascii?Q?hqSxa33tWRWztrA6ETSzcnI0d4q457UqwjMx42vI+pnD9HudGHdPrDhou3Ex?=
 =?us-ascii?Q?Jqc6SvPqWa6lFKd5hDT5xehw/o7HrGFGfWc4kz0f5U/80aAeuJNcw9L3HaAD?=
 =?us-ascii?Q?+x1iPEWaUe8QuSd3WCMEZtU6m/GiIuJQRqnvHL/V15vIe8LcrxPBniPeBrUR?=
 =?us-ascii?Q?wjPL5/1jnQ+9HWzAibnpgHQKbi6xDnYiHjSs2c1c6RHHTGbqq7Q4M9zXL1Bz?=
 =?us-ascii?Q?dJ5bmecJRqv/7JsGF97xN1AaCty+ioMA4xbIdXE2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3ed4cf-4947-4b56-ee8c-08de05c86643
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 17:39:00.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnKyAZVSPn6LCobOYIajfkQdBdTvi/JkohGiv5i9RXybvi1Bqck6Ah5FeOCRH2oDszKcSgXpgSQ2g6AJ5qlcKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574

On Tue, Oct 07, 2025 at 04:52:55PM +0000, Luck, Tony wrote:
> > I think it's a common use case without FMPM.
> >
> > IOW, log correctable errors but don't offline memory because of them.
> >
> > Does that sounds better or about the same?
> 
> Linux has  /proc/sys/vm/enable_soft_offline toggle for that case.
> 

Thanks, that's a good suggestion.

We would still need a check in fru_handle_mem_poison() to skip saving
records to persistent storage.

And we would need a code update in _retire_row_mi300() to use the
soft_offline path.

Thanks,
Yazen

