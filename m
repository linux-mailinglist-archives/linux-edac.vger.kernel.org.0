Return-Path: <linux-edac+bounces-1737-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C702A960C7C
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2024 15:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25951C22DC5
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2024 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3041C2DCD;
	Tue, 27 Aug 2024 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TpPQY5CX"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E91BA295;
	Tue, 27 Aug 2024 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766434; cv=fail; b=IdDzu3ZMU83sEJdQu3gReHD7Rmmn49c0JTPVK66c+wsknch2gQHbeaFKXtChkcJR9KNJ2AaG2k8o8JBKOf/JuiCZzejCMdlEnbozcmYAhBeVVS46+wNrGIjLLDm8UW8DtHphVwVRpwWPgpAcrFfTO5AMrvNbmgsV9zFl9HtTlMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766434; c=relaxed/simple;
	bh=Q2CT7GyEbGYOYOU+IYIQ2Q8d6Je4U4wsNeZ2Sh/BtLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fiSdHfXx/z6x0BsdMjGdjhzsx+SgMRwMiikEpmmssxuL6mecAnkpNEV9mcdjA0s01B0x0OWBJz6W9e02aqR/leWx2TU+yOlbd/7wv/uCzkpdMoJ5emSpXuz8oFY672rsOX0fEDthCXSVwDNdl+WySt216ipW0hASGCFnwntsb8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TpPQY5CX; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJ92/BFJdGsZWyIItSJTOkMmLZQU4iDnLajb2ws7GkLYRaWfGjHZ6bKmOpdQCr3kuqwnm2SwPB33lV7CsB/HYa8D7Wzm5yeJNykx5FiDOHCWVGwE80q+TF3n7HWFGRB1NfPo0XS1Qk6dTmTkGswk9XhLQsMqMYWGcodmp0xRUMi8Npz0zh/nJ6F0ybD8h+LWohO7wwp0HhcMeU3ED5RPqNH7/oAAtALSUay4vaW3YGGtxJIijvrxmVFJmAESo0fTIFz6lYsXz8qHkc8J2w0MelVX0QhTMGVkH1yvPyxGA91mX2JALj9Esn9RUnZ+NXT3kYcSQZO+s9Ez3C44agA/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPxqWPXsJvglbWOMsGAGgQqH/tlE1UiHtxDE9IxUbHY=;
 b=gkCShU5+sfDa9/4XboVtA7SKI1J7oNsjLu0gNL/e0KM49z4nVRrr5BhEt2xy2V+dh53zTQEog9iwOHSiM10587CvRn+q3kt3kK+GrNq2fAWJbRoTfwtFsc4Z3Mc3AAneUc9x/rqyYhNv/QpkaL2HB+B2Nq28GmnFoSE/dxqNUXV8+tLW1sA31WyCkFGfweB5kvMdP0Nj+8lZRhyFxJeXj1l1lFFEwJITsYMk8iSBn8O9lsfr1Ju8o5hYmvYe9tos6sRElOEWZbjiN0Wbsiz1Jy0ZKbUC7EScF8qd4hHuvsWknVr5K5pxmX9sTMGf56zZMynZA9hyQrJeiNfPkNuLZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPxqWPXsJvglbWOMsGAGgQqH/tlE1UiHtxDE9IxUbHY=;
 b=TpPQY5CXUoJUCtfLii3WrrrjPtmH7vq3GwRBUDFnIWHMjS1W0TBJFcdw63j4lRbXqoZIUorVXNJyqPKl7G/oJFVLWtLywVBVNuFe+O/SwLe15ozhZDds1g4Hno6gLwPoJvTv4CKCWAVuj5pHV+h8pknox/efxcFpqkJB6tz/4ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Tue, 27 Aug 2024 13:47:10 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:47:10 +0000
Date: Tue, 27 Aug 2024 09:47:06 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH] x86/MCE: Prevent CPU offline for SMCA CPUs with non-core
 banks
Message-ID: <20240827134706.GA719384@yaz-khff2.amd.com>
References: <20240821140017.330105-1-yazen.ghannam@amd.com>
 <87jzg4g8dm.ffs@tglx>
 <20240826132057.GA449322@yaz-khff2.amd.com>
 <9D26E333-B33C-4FD4-9A8F-6F9DC1EC6527@alien8.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D26E333-B33C-4FD4-9A8F-6F9DC1EC6527@alien8.de>
X-ClientProxiedBy: BLAPR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:208:32f::24) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4aca9f-6154-42c3-e888-08dcc69ebfa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EftjX+7i995VnYlm1JSUx+0xh02FProb+BJ8oYej6CW4FOphQL8U4SMb7nNY?=
 =?us-ascii?Q?GHVuGYq4BmTxF4ktcR+QCDkr5wifnpeY3eIoM7o1lkYdFp5+VIRoPPXUR3lP?=
 =?us-ascii?Q?/3OTV3ciXTTg4t6Vhyjzii5GgzVCYAX++pDb4zimaaFHqd6HD6ffDQ2tKcv8?=
 =?us-ascii?Q?5xgsVM5RL1fKZU0ekmQDhCHmhQBxpRfrfbK16zV0dXK1PmE7/LHaIgX/LrMc?=
 =?us-ascii?Q?FvMFPgYE8ZLjzeR1PTe1LYGjDMiWoxB2Yf7xuAVp78JNpBD1rwQ+qBpo4sUo?=
 =?us-ascii?Q?Oq2HHJZ8zusZmly+3wdbwcM1IqZ93663sZfHfExxN1qlhtFu8X0cAU2nVEMl?=
 =?us-ascii?Q?K5VOLudZNDPdQngB1hWvt7pIWdOjWwfDaIaBKrLMTs8iNKP0CBYXMfB8M/+A?=
 =?us-ascii?Q?UAKV3ivyfvyLPwhqT50jNb6ZAXR8uvG0vxGJKduF0tKm/LmR4/ue7NWMGiSW?=
 =?us-ascii?Q?WNTnfRCdez11jo3b2IUugtTXr/e7yEsliyYAEwOTHnrF/XJrOKDFGqXrpZqE?=
 =?us-ascii?Q?T6+sSFjBwRYKbGfhj7xiwppOp41VPEjQToLauL7r3cOHjOP1icaxgWu4V3b+?=
 =?us-ascii?Q?+yY7lupAnSTHEiGGiatIEE7NmiqgnEj/TndJq3zr5dJudnEzNe2IBskzg+uU?=
 =?us-ascii?Q?0VS/8ZUNQb02C4lbeUXLI3Bekszg9kn2zQfREw/Jf/uPZQqCjteWdaad0Z91?=
 =?us-ascii?Q?gYRI5v4CV+1aSfIyfv/+rdwPC90tuH1xoLujLjHk7UC2lNNZEGQ4oXZEmY9z?=
 =?us-ascii?Q?p+0vfarYjZs8hWxthJxiuGKiQQBf1i2PE6Ni8JrdLB6msSKywqomtLl68TE1?=
 =?us-ascii?Q?0f1aHsJDjVLdrIFBTXQ6j7ogDKuIUiyGDjrWWByGUevjmdSsFc11dP10itsL?=
 =?us-ascii?Q?bT3mtNplO3yi1AHt8IvJ57jEZ+eIcqHDlyMuEPulD/Llqux5xBqhF/IPl9Gg?=
 =?us-ascii?Q?SWC158fiPNKTvmcM1xL7zBSCTpFwp/7R93XsR7YjF8cugzJOigqR373r0rca?=
 =?us-ascii?Q?6uHvPWyX/1a4RrWUOsP/8sVrXBi2K/q0b51ZSmTKevWw/8Z9MxfatTPdKalj?=
 =?us-ascii?Q?kaJ27V2t0aJDsLXv6f/yYfRCAMeHbGIuPo3hLMdJ2RZyxLz3rFFZlCsT4i54?=
 =?us-ascii?Q?AVv+xQqi/M3eXwT4BLrrQMVBscMXYu0OfsBypyN0Yzfd2GBHVomz+DXH0Npk?=
 =?us-ascii?Q?h2pcAWebHbJRRfIPOS25YDum7af+u6Q0goOy5G0yTiPtsKc6QHHts8RMLsdF?=
 =?us-ascii?Q?ePPyRsNOwICUSV+iyEw5wlo4n6ym32OFawyzfnlDQLldKvs7s4WeghHYoPvP?=
 =?us-ascii?Q?SM3wVGofLSG0TgClHy4fW7JOVZdHjp7byKzvz2Gf7/ruPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bCoqHO6/qXZHBnY/al6F7YtyvM9e1oNgkCud7U0UNiXTKU58Hi2kvQLc1oMG?=
 =?us-ascii?Q?O3kNPj8re5iVdIAiv4eKFExjUfqDhqvKqLb369EMSTWxdNF2Feyl4KrUlqCw?=
 =?us-ascii?Q?vU8tT0JLY3dZs1gmbU/dtWfRBBsSyW58yXFJfbJHxuL0gMhdkHmL4RiEAOaP?=
 =?us-ascii?Q?s2ciwt4+G1G3htbQVxhPgiD55zP8X7grAs84SzLZ0sad6kcPBZAtCaUCtqum?=
 =?us-ascii?Q?uHROsRKiVmjPsVLbQwceEiddWxAyb8yitBbhS0ndwavh36Qz0mWGc/3orXU1?=
 =?us-ascii?Q?OOyotn6iPil0OwQECLnHJEEx+XXZixWxz3wzuTJB9EQUtrqCiEpU+4O3A055?=
 =?us-ascii?Q?jGLciCGDylF/zeyoVCS6brr+wdOsVM5eVAJ71SLgxBrGCJGE0zRf9koPMf80?=
 =?us-ascii?Q?VAaVvKfTveWHSNPxjnPbBuvrxWHuICZnYNBeEUh1KknqCY99jmU9yatSnOd9?=
 =?us-ascii?Q?A013/s6WUlz9OlBT4Pg7547W0eTDCaI+5Eyp/zVeVdcTdja1XWPbv/3pD/hm?=
 =?us-ascii?Q?/Li/vfplf6LnTfiOZ9AG9M5zmTZP/MRcurUj3PFPc7fQAW8vbjrCen6q8YXV?=
 =?us-ascii?Q?aTL1G6Hgjj/M1mSz5ISwNKlJ3aTZgJh8EuGrClYFtYCvLr6B9pKnXCUsg3vc?=
 =?us-ascii?Q?sKQRaPjJDCajuoWPzCkY2FIMKFZzy/COSRbvo6IUYGK380O0tjUlJ9n8Ehc+?=
 =?us-ascii?Q?rEpoLesZ5kEVUBtsNl/1T5MbtydCq2uZxtHn9ZqrWZI43xUbXlls8eh3Tp/2?=
 =?us-ascii?Q?vgpzK82OrUQTaSa+oxHv+mBeLeJhpIcJsuPfM3ZYwceiVTxLeB1IBPmcWo4F?=
 =?us-ascii?Q?mC8etSGmvZp+2tOLdGzOoHio8eWwT17YfyoMXWHWizwie1NTUgBBLy+/pHLX?=
 =?us-ascii?Q?ld4VL/7CTBopTZzXqYy7sx9/6Z5BcF8sALp9ee3hDJZ63Gx19wRCJ0uhBH2k?=
 =?us-ascii?Q?+8tkOco90n8pFtuqVNrsMo77IEjUrKMYe8BOpnZzIzE7JfHa+9ht29U3hAbg?=
 =?us-ascii?Q?iuvRbJwYyQpq1XWJq6dp0sD+m9aakPEouuJztJoM/xobwNJV+uR2CpTWDcX9?=
 =?us-ascii?Q?RI0T9oH9VWFaLfvZUG1+QwihIygwUTJHdhqIkd+wDwJ5lfHRgE9So44o4TiF?=
 =?us-ascii?Q?cShPo5sNBueV0meevCg8HfOhhTZTwNEO5xJgLHDj+BJ6s4NSNPx9f1PAcfyj?=
 =?us-ascii?Q?Z4vC4mpVtqgEwhEPEbWYgtMmNjNdPpLnsNxeSI7w9BLsetXqzjySfk0Omni+?=
 =?us-ascii?Q?8baMuResMYFLVMl4ZjwtBw0QHJ2YIQ8osyDKtJLvKEKxIKwkcIzhl/KplTn/?=
 =?us-ascii?Q?e+s5vmtOAytPh+MCvCubiV5BoLKm/3hXJVmTxtJWRvf/QQvqgjtQ9u8HHYta?=
 =?us-ascii?Q?zlg9vlDEaJFDS/702OGmV5+tuxpOGd0FGLAINJahMG5IQ2rOGM8ObwLZHaCL?=
 =?us-ascii?Q?JiVDAxQYj6ULiGI0xWGBgLHFAJ7c4Rz8C405iNEAOrEkw7n4NrZgBFIsFk7m?=
 =?us-ascii?Q?u4yQ9HaGGGjAjW2nRybPrNBYxo8AdkQ9txMdG9LmgIOn/sPwFuxuyOT0ZU/p?=
 =?us-ascii?Q?nwI9uqQ5ndyStkDHK8NOt5OgLNovr9giwot3WeEy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4aca9f-6154-42c3-e888-08dcc69ebfa4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 13:47:10.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sb/h1WE2KjAUGXRS8KI0c6sMOUz9BUX/7KdEI8peG7NGnv7r47zfPAlUvWhXDO0Aw8u5i/zfN08qAU2jf82Rzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575

On Tue, Aug 27, 2024 at 02:50:40PM +0200, Borislav Petkov wrote:
> On August 26, 2024 3:20:57 PM GMT+02:00, Yazen Ghannam <yazen.ghannam@amd.com> wrote:
> >On Sun, Aug 25, 2024 at 01:16:37PM +0200, Thomas Gleixner wrote:
> >> On Wed, Aug 21 2024 at 09:00, Yazen Ghannam wrote:
> >> > Logical CPUs in AMD Scalable MCA (SMCA) systems can manage non-core
> >> > banks. Each of these banks represents unique and separate hardware
> >> > located within the system. Each bank is managed by a single logical CPU;
> >> > they are not shared. Furthermore, the "CPU to MCA bank" assignment
> >> > cannot be modified at run time.
> >> >
> >> > The MCE subsystem supports run time CPU hotplug. Many vendors have
> >> > non-core MCA banks, so MCA settings are not cleared when a CPU is
> >> > offlined for these vendors.
> >> >
> >> > Even though the non-core MCA banks remain enabled, MCA errors will not
> >> > be handled (reported, cleared, etc.) on SMCA systems when the managing
> >> > CPU is offline.
> >> >
> >> > Check if a CPU manages non-core MCA banks and, if so, prevent it from
> >> > being taken offline.
> >> 
> >> Which in turn breaks hibernation and kexec...
> >>
> >
> >Right, good point.
> >
> >Maybe this change can apply only to a user-initiated (sysfs) case?
> >
> >Thanks,
> >Yazen
> >
> 
> Or, you can simply say that the MCE cannot be processed because the user took the managing CPU offline. 
>

I found that we can not populate the "cpuN/online" file. This would
prevent a user from offlining a CPU, but it shouldn't prevent the system
from doing what it needs.

This is already done for CPU0, and other cases I think.

> What is this actually really fixing anyway?

There are times where a user wants to take CPUs offline due to software
licensing. And this would prevent the user from unintentionally
offlining CPUs that would affect MCA handling.

Thanks,
Yazen

