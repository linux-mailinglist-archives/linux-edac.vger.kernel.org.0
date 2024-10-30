Return-Path: <linux-edac+bounces-2363-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3DB9B6E00
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 21:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCCB1F21054
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 20:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414B51E0E00;
	Wed, 30 Oct 2024 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ho50yEH6"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC21BD9E2;
	Wed, 30 Oct 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321172; cv=fail; b=toFlOujlYjUHSqsrUpsfjXcULION7TCL0MfqzPkVJhq6S+N1LgrxPfym5DrhGpwcfcI9DlsC8nB3S8scd0Q7pOVK9KXrzKutx2xwzurahiaBASlQP1JXaF7JamGD0YdrQsKOAanQ9QlBYNmois01Y2BSbNIcBBjAWOR/Y8z9RxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321172; c=relaxed/simple;
	bh=BQcMSHqc0OSwoaHXZxx1pQBa2kT+mn2lvKsz6J4G+6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l/4EkEdZRyZJ1pYrDSb9nRX0jGkv37KAKSUdBCgYZ336T3PJqYRKlMANGtLyQ65dB6z4X07AIilKz4ww21xwxRzoHvBWkGeAoXRCykZuJIJjxaiV9VFXZ/mtu1DRVfaTia3dLoKWX/TyzUZbLNJJYGBXoxMfrcrKvYGaqtTNrno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ho50yEH6; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8yzA77lSKmyErrLxFnxC6hXvXeOl3YCqABw5r39/vaB42lq1moLTheakYoF+2TGeSVozKeHJNaUNwldXoDPqh95eaVWAkAFDgPUdMaJby4vg1PC2D8O/nFNr5g4UmoaieYl8QnVEjzDzdA9whjioNvCmaBGT2txreSjFxdOu7eM4htgVHH6zdxGD2stowDo3QAtixGzIMExEXRVEKB8mAjfGRFzanNJoFZvseHq80u8K62JFPRohazSd8ulXFsUAUKRrS3CVEhpbY2N+jbwom/nqIQPnLFJ45BxpFjgBK17s7Fq68ZqPHZw8KoY7v0pWusUrpPxHWdM+UdL4JrH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13OGUDdM3qQc86Qtc2HpPQvmZqHEQvEWK5VoEcKQiKY=;
 b=qroB5TE6ZO/uDjp28y7PAGHQGcPg/oIbH55BPerPaljszl1zhRiSzrjMHyGVFEHiV5NRV9KSBLRYvLBBCjxUemLVXlHhsvT2f7vJvwF7F27xmG2FoEAP39w7atw6jlECibKvSv+lpcVfcY9yusFzlk7paKfK3wNhqBE8jWtUZyAc5arPF9LA3BNFI5N1/3gZnhqccPZDGKiN+/7KbQvTk8J6iiQ1eLVdix05EaIk4YYVoPmjYWgbNDdpHmWk6OL2Z25z7NK1EWkn90HPfnvO5TAJxRO8PZjPOofrYUtCVVRduh0Wy93torrNPy+uRiL6dlfb+TPQZKfL2Xj59I3gHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13OGUDdM3qQc86Qtc2HpPQvmZqHEQvEWK5VoEcKQiKY=;
 b=Ho50yEH6ii/ohxPvtFeooAiFsPec2hCcpdAqaVsK0RrB2384p8fGicVF2phP64BVGWvuTn3E8IUH3GJOX6SiEwWwBzEmK48vnNqgnd7G0Uf6uvUMrIDXZQICBst/+0LilEcdQd3qH06Hnlf2lYjSRZEsoRaOFB4xiIFnqUwG3bI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 20:46:05 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8093.023; Wed, 30 Oct 2024
 20:46:05 +0000
Date: Wed, 30 Oct 2024 16:46:01 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Naik, Avadhut" <avadnaik@amd.com>, bp@alien.de
Cc: Borislav Petkov <bp@alien8.de>, Avadhut Naik <avadhut.naik@amd.com>,
	x86@kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, qiuxu.zhuo@intel.com, tglx@linutronix.de,
	mingo@redhat.com, rostedt@goodmis.org, mchehab@kernel.org,
	john.allen@amd.com
Subject: Re: [PATCH v7 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Message-ID: <20241030204601.GA1505849@yaz-khff2.amd.com>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-6-avadhut.naik@amd.com>
 <20241030161550.GFZyJbthMO_2Wxe3bV@fat_crate.local>
 <20241030163147.GA1379143@yaz-khff2.amd.com>
 <20241030165002.GFZyJjuifxBLUDKyL6@fat_crate.local>
 <20241030180041.GGZyJ0SXfa73Q7NmwF@fat_crate.local>
 <5885d093-275d-4d29-ab13-2f118d61d62d@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5885d093-275d-4d29-ab13-2f118d61d62d@amd.com>
X-ClientProxiedBy: MN2PR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:208:237::26) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 56dadd49-982f-4bda-ece5-08dcf923dffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DQ8XNuXtAJUl+ALJIjnL5JtDWUG4NKXLeUNjuumA3tEB35lEgvHLPiwhxBPE?=
 =?us-ascii?Q?/stNZabX6YD0vOSD4aVR3pOQSnkWtkEppkqVK9meuSf1bVvfsq/jnaJhnd1w?=
 =?us-ascii?Q?niqmIFHeBdcE1snKNGNw8wDf691gW3+tG7kADdJU2GZxPR/83QY+4S9jLNeL?=
 =?us-ascii?Q?YcCvWFCPYhPlsxZOxbjc/G+qb0Yj/iOA6s5j2KJpcPMYZKE9WPt5GZE/OluN?=
 =?us-ascii?Q?b1wbhfF+nOTB2Da7JL2WPuerBMo7O5FZk3XEh5pxkvuWeH8yqbyLHJXFD1KA?=
 =?us-ascii?Q?V4qNhYEuL66pXgIa7HjZi/9BTQpICrdGfAMGJn+4SJr3AE07/xacDPPzo5tU?=
 =?us-ascii?Q?1RDpdLaiaFub0+Rkhj4/NZcC4wQt7Rw2Kd1DhFjmul/P2j9OdNi59Q16SWs9?=
 =?us-ascii?Q?jwoO0RZlblhmR7n+eSNwVn4wmAusQAvKud5GfeGRONV+Jjm/dG6GnNhXlWCA?=
 =?us-ascii?Q?Zenf4LcE88qypGf0LAFjACQ33AqO7IGnOaVTueiczD+vSMhRhzxN3r6u25SN?=
 =?us-ascii?Q?nFyvoq8XXpZi3BW08+tWP6dMyBDUJX8RKkb/qJn2XGNG2ZnkgyAQNBN4Umkk?=
 =?us-ascii?Q?5UlNdm4QFvYHggfvQVfzlJr+UNJE6qy56wLgTuQquF0RQEEuCFRmlJNnCGzR?=
 =?us-ascii?Q?3LOcNttDgEMoh5LWD+HA0JpSylAU9J0kzyZWpvliBYZ1ofW6MrVXF6CNSwin?=
 =?us-ascii?Q?wcF1ObG8qy851LkzFXQysrrDt1IVckwqTzOKyGUYTP0VvZLuuHaDthUMuOJI?=
 =?us-ascii?Q?YCLTAqeB3sgjs/lZuB4bTiAIZ2JiZSWLViTx8QSFO7rppGmkL8gFCWkZTKm5?=
 =?us-ascii?Q?w3LCMxN8KRzRe+vk+gQ1rVb9hdEv/ThDOANWi9Dd7VIP6EnmswFBK/jF1bTz?=
 =?us-ascii?Q?PWDOOBsGsm4P0aiIeDo8HF9ffQ3KyGvvh8CZ2jt6kHo0/KW3bxGR+fwsaG20?=
 =?us-ascii?Q?5ISPNIWiUBbJiOkLPkFDYyvLSFGvGZwLlpIzf9LXoIFtAbr8jiEaycEHAGH1?=
 =?us-ascii?Q?2ZIhk7ysgaIAPpdnSmC2OBSWKWc7keLpUvGgqidRNqzJctn/eQyM8SNIyY0r?=
 =?us-ascii?Q?ZynbdHZ9cb+/B9EmxEprGkYfQziugaTqc5Sa+rIYOAwBz2TWpqiC5LBwc2cH?=
 =?us-ascii?Q?h0zSH7+vc5k/gJrDF2JSixy3RVsAMHYHzikxdDF97MAL42+/DVaje+T0aZYi?=
 =?us-ascii?Q?huWOACFurPsSvwt6RnGS9tTCBMpTpR2FCi/kjrq9bp9AXRMjZlr5E1HUGzIf?=
 =?us-ascii?Q?77uQ4lZv63HEt3n/Hm5nDTOMKsleqrB1/FQ8vU+jAIobHbaNd96ERPc3xHNg?=
 =?us-ascii?Q?guVKg0Bm1Ui2p3D8OtCbDo9r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dQKAalFUCP2NWTsyFpHVU7vTdVA1Fv9xQoJtFpY+FglhlStEi13Mhr+DHuot?=
 =?us-ascii?Q?XAyqNTN04L3Ov5UWTtnKdZ94GupZ9x6YWLaZNK0eRb3WzhPFeXDnBKTQMMtB?=
 =?us-ascii?Q?22pVfjhvO8h/pCkqe6aPHFAV6zjaaJ6JTMAtl0RaEqt8si12WL0mfwer7dDL?=
 =?us-ascii?Q?O5R26gp/sEuIfeqvhL3SVQ5xWoLEKh7KKYg5YejpPbs7js37jC7vN88Fq0KU?=
 =?us-ascii?Q?si/WVWJBUPkuaIXXqmLAiVfHIOcwHCOq1fIP6Df4I6Hcw7Nmdpxb6faIiLKr?=
 =?us-ascii?Q?HAVzURvUpt1UJfxKq3r1v+LT5hDW5Z7qbpK0P8F4Zpe3Z5YbqbEeIHEoSZlx?=
 =?us-ascii?Q?JYnhkaLKSCVX6bo4A9BSvL3kKzLv0HTpBXZWbTZbRptha340g07A90SWyuiC?=
 =?us-ascii?Q?wAyOoCl+61APVlxUxvYcZRL/zT83LVogqkvDtMOyxBy8wWtahNP9oLs0WPcc?=
 =?us-ascii?Q?dRGawkuYBK7yaeIwJ+gR5IW2PeNzpL+JChFPXuhQvq/jm8NWyNC4+AvxOT/Z?=
 =?us-ascii?Q?gVTD8KWUkguig6qR+7FGV/Bl9Y3lJ0LGkjHdWzN5r1kWRE7liKFp076k78GO?=
 =?us-ascii?Q?ISd8M5lp/NXQEYt3DM8lPfJ51DS7itDNzLZ+0EejSnpfFA2ziajUIphkSR4G?=
 =?us-ascii?Q?MGeTg7qxsWe2w8rYAFHiJbvcQDU0sNeQKNnWB6UIS9Wvt3XpHf2ltVqCo5VS?=
 =?us-ascii?Q?ktx7rgoSGNFZa1KBhARENR6/mnahsg370cZNk8+UklwrJHcmG8gS8RinIxmB?=
 =?us-ascii?Q?Oib/T7uQpYfrG63BkHfnuGL7pE+HoMOV6qO7yigSl+lzKpL70u4IAch4QgZW?=
 =?us-ascii?Q?svmzTUbQhxhtJBj4gZqAoNXyAsU0bWhOeR7W0E3L10bsatHGv5UUj6QqUmZ8?=
 =?us-ascii?Q?u97nTKsSDG8lO9RdrXh3cNhIryuDaDVC58smnFt3HaPu64nujRlvQ1ETioPl?=
 =?us-ascii?Q?86YJmL4OKRIHXOGCQ2Xxvfrw/PVJ3qvT7S1dPXUiHHaNhS04g+v8nctFIJ+U?=
 =?us-ascii?Q?BayrxPaUkKB9T7vEvyJmb/nSX20Q/kS6e+yuZngUUdTsnf2GV/sEphuCI7xn?=
 =?us-ascii?Q?fngL9vxjjFqG3F2vIGIafJuZUwVCZC09QmgLidxYoxvwrksU9CQuIICtJBIH?=
 =?us-ascii?Q?gRTLl7hCnoJMFQGGUpSOYAT7zN5xizvKjvWMSjBjTOSs5QwvE0f7d7h+SuQb?=
 =?us-ascii?Q?SK5xiMczXgATNXUzUYFigU3JhmnN/YEu610DAkI+wURvQhTdQA48qa8jutjV?=
 =?us-ascii?Q?Nl1wBhW/lfm8sy3aQGB+32cShl7MZQkz5cbzhdwgQcjL+SZLZjheCc4YEAEq?=
 =?us-ascii?Q?e3RrjegfeHUrw+oPIN88VhBwBhwGuvKvmAbtCAciHC+Z2L8VWy5+bjm5+aZ+?=
 =?us-ascii?Q?s39zeClYLi7N34pzn8Dr9PkrUZKhZZzSkSo71vR0qQN0B/aAuagXTRIK+e4g?=
 =?us-ascii?Q?537WN7IHzHfcfJCrsABw93uhdG0akOj+Yt9IQsskHW9BW8/MnUOfMJF7nTNR?=
 =?us-ascii?Q?MJW47fkFOxHllchShUi7eQToyXI9uP7EwJioUYdPAgikkEvNFE0tyeYzR63Z?=
 =?us-ascii?Q?WvYPEHt3hznrcIMtniA5bOFj119pzyRvUUeAHzad?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dadd49-982f-4bda-ece5-08dcf923dffc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 20:46:05.8719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMizXGNDDgK61YS6bo1SyyNGOlIWd3p1BAFwMq68x+MGcknxIPDbZOicRM9rbPaf2MgDCEZmhF3jAk2UTjsKkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

On Wed, Oct 30, 2024 at 02:57:33PM -0500, Naik, Avadhut wrote:
> 
> 
> On 10/30/2024 13:01, Borislav Petkov wrote:
> > On Wed, Oct 30, 2024 at 05:50:02PM +0100, Borislav Petkov wrote:
> >> Bah, crap. Lemme go back and take a second stab at this.
> > 
> > Second try.
> > 
> > The reason why I don't want to expose MCA_CONFIG to userspace is, well,
> > userspace doesn't need to know any "management" information the hw gives. It
> > either gets FRU text in that tracepoint or it doesn't. But it doesn't need to
> > know what MCA_CONFIG said or didn't say.
> > 
> > Ok?
> > 
> So, for now, in the kernel, we log SYND1/2 registers only when they contain
> FRUText.
> While in the userspace, since MCA_CONFIG is not in the picture, we always
> interpret SYND1/2 data as FRUText.
> Rasdaemon might need to be tweaked accordingly. Will take care of it.
> Overall, sounds good.
>

Sounds good to me too.

Thanks,
Yazen

> Do you want me send out a revised version with these changes?
> 
> > Author: Yazen Ghannam <yazen.ghannam@amd.com>
> > Date:   Tue Oct 22 19:36:31 2024 +0000
> > 
> >     EDAC/mce_amd: Add support for FRU text in MCA
> >     
> >     A new "FRU Text in MCA" feature is defined where the Field Replaceable
> >     Unit (FRU) Text for a device is represented by a string in the new
> >     MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
> >     bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).
> >     
> >     The FRU Text is populated dynamically for each individual error state
> >     (MCA_STATUS, MCA_ADDR, et al.). Handle the case where an MCA bank covers
> >     multiple devices, for example, a Unified Memory Controller (UMC) bank
> >     that manages two DIMMs.
> >     
> >       [ Yazen: Add Avadhut as co-developer for wrapper changes. ]
> >       [ bp: Do not expose MCA_CONFIG to userspace yet. ]
> >     
> >     Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> >     Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
> >     Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> >     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> >     Link: https://lore.kernel.org/r/20241022194158.110073-6-avadhut.naik@amd.com
> > 
> > diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> > index 4d936ee20e24..4543cf2eb5e8 100644
> > --- a/arch/x86/include/asm/mce.h
> > +++ b/arch/x86/include/asm/mce.h
> > @@ -61,6 +61,7 @@
> >   *  - TCC bit is present in MCx_STATUS.
> >   */
> >  #define MCI_CONFIG_MCAX		0x1
> > +#define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
> >  #define MCI_IPID_MCATYPE	0xFFFF0000
> >  #define MCI_IPID_HWID		0xFFF
> >  
> > diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> > index 194d9fd47d20..50d74d3bf0f5 100644
> > --- a/drivers/edac/mce_amd.c
> > +++ b/drivers/edac/mce_amd.c
> > @@ -795,6 +795,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
> >  	struct mce *m = (struct mce *)data;
> >  	struct mce_hw_err *err = to_mce_hw_err(m);
> >  	unsigned int fam = x86_family(m->cpuid);
> > +	u32 mca_config_lo = 0, dummy;
> >  	int ecc;
> >  
> >  	if (m->kflags & MCE_HANDLED_CEC)
> > @@ -814,11 +815,9 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
> >  		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
> >  
> >  	if (boot_cpu_has(X86_FEATURE_SMCA)) {
> > -		u32 low, high;
> > -		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
> > +		rdmsr_safe(MSR_AMD64_SMCA_MCx_CONFIG(m->bank), &mca_config_lo, &dummy);
> >  
> > -		if (!rdmsr_safe(addr, &low, &high) &&
> > -		    (low & MCI_CONFIG_MCAX))
> > +		if (mca_config_lo & MCI_CONFIG_MCAX)
> >  			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
> >  
> >  		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
> > @@ -853,8 +852,15 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
> >  
> >  		if (m->status & MCI_STATUS_SYNDV) {
> >  			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
> > -			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
> > -				 err->vendor.amd.synd1, err->vendor.amd.synd2);
> > +			if (mca_config_lo & MCI_CONFIG_FRUTEXT) {
> > +				char frutext[17];
> > +
> > +				frutext[16] = '\0';
> > +				memcpy(&frutext[0], &err->vendor.amd.synd1, 8);
> > +				memcpy(&frutext[8], &err->vendor.amd.synd2, 8);
> > +
> > +				pr_emerg(HW_ERR "FRU Text: %s", frutext);
> > +			}
> >  		}
> >  
> >  		pr_cont("\n");
> > 
> 
> -- 
> Thanks,
> Avadhut Naik

