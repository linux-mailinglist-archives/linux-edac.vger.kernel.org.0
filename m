Return-Path: <linux-edac+bounces-1342-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC3E912E34
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 22:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC18EB26C39
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 20:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D221A16C69A;
	Fri, 21 Jun 2024 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jijTzqZZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F162612BE9E;
	Fri, 21 Jun 2024 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000079; cv=fail; b=sTn/yYkITvBFH4OBWN5/PU1P+zeJ4GDFTrLoAFtJUHfyTG2DkidEhkAbjP7c0J1cosaVgRqbmzLyw6jG79LXNu9CGhwMdiMKc8kkZI1qmmtonxGssd52xAjEwXV3ECniTU6ICiJZFIlZ18wuPlTHfC1tzL6v3gg0xDQRs28saL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000079; c=relaxed/simple;
	bh=fSprrq+owc84hjeqyiy3aDE+RGCtWywQywUsnNrTD44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FsBxmulckKjDVgMFXCAbZ/efp//A8r72xhBS/z/AFNsiyii8ZDxLSGXm18KO+4NK5KEzNsWxjL/l0NHigAIMz4VvdCPqckpjrXooPuaU3RCkXxG8Z9Ro7KtdBY85AbrIHtY8KE3+4rx6Q5tIysq9ALR2+x3KdEoO27F1VE3U+aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jijTzqZZ; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwIWNlinFlRw39oA65K63OH7QUtw249gofCkZjm/ZkT8TxBKeHYmy05rmwhhSd9IhvJD5rUoYOME3KYLY/UcfAJ9y/UMmd/sGVlU8xnAHmvcI27Y8O+qQwHREHetxw+o46a6nS4HEg0Kj9qBQBK0s2XM2lFt/DtCIVBNiW54b2EB9minuJEuDk2lzEIBbHJI4yf5lA4fEc0JclnPGL7WH8f2edwSX2g9sIdbCKVBDEpFEq+j5AqcpwXFpadXWXGyQLghZJVerc91yYetRlVHtJyWokCpG/nZLpCL1Zj0lf+p5idlFOU0La8FU1X2IcH7RKDuAmhLGhDLXwBQ7mHAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTnZdhLhavwRSGyleVaA+odLSGgyt3LglRVG8Gwgoxg=;
 b=Ft2zlVec7nJ2RmVFUyLsfgTmuuJ8KmNrVRJT6RKxaIopeaoKE5EGaKNfCeaxt0smoqlVSVjzG5+ZE/gZ32wTS40unwuKsBReFr2uz9YJcjozn72+0hEhcXLMbxwRYGqMcqL1YNdYP3Ohjb3lX+4EK44273BkjEz29VMk/VjyDp1oD0yCZhBGjvoxWxSLbn3YPuJyhlKCLUKEZRkMmVoKOCtgrhs4g5IXPFXdGSO9utegpwyjMEpOoeiHIFOa0VQJRe8TeJ8x29qx4+KupwnpuZs5qYLi1r6ZMf3YYpIiQqoZ22CJ26tbS/UcyAuMklvSTBp6bu+U7Cks04tsMCSwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTnZdhLhavwRSGyleVaA+odLSGgyt3LglRVG8Gwgoxg=;
 b=jijTzqZZjoOJenHtvzkiLHxO6opLGpJrL+OVWwJNYSvNCHOCMvfiZJaR9uRU/yX6iBKZAgsOJcM6XjDsXohW9sqJVyDHiZZNxTkskElVIfp1N3y4vtUC1FSUxa0VBaA7SwQpbGxt4rTiboFQAwK+J/9U9X7i5BnWyxvFlTX0qyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 20:01:14 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 20:01:14 +0000
Date: Fri, 21 Jun 2024 16:01:10 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>, avadhut.naik@amd.com
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, lenb@kernel.org, mchehab@kernel.org,
	james.morse@arm.com, airlied@gmail.com, john.allen@amd.com
Subject: Re: [PATCH 0/4] MCE wrapper and support for new SMCA syndrome MSRs
Message-ID: <20240621200110.GA5956@yaz-khff2.amd.com>
References: <20240530211620.1829453-1-avadhut.naik@amd.com>
 <20240621165823.GJZnWxLxd9BVhQDBUU@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621165823.GJZnWxLxd9BVhQDBUU@fat_crate.local>
X-ClientProxiedBy: MN2PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:208:234::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 1679c6f5-e83a-4f16-6b5f-08dc922ce7d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hsUwRjfSvIl94WxRHrOGeCPYcXYnpwxi52nhXVztycmn54CNN3CkxrghYhEa?=
 =?us-ascii?Q?SrMen7rN8D+503LeGnuaVnXNGHK6lPYenuKw8Tb4e85Fki2K9T+5AojbHJHd?=
 =?us-ascii?Q?2c9y2nzjBaHgU1tmV8PbUe8wbv09g6sNxhpeZ/k3VIDxS0gYZL2eUBxqZu1Z?=
 =?us-ascii?Q?5bFuu4TEPE4pWhjzf1YXBj193Jta7vfntyEy95PAp5L2KgIHRG2VEteWsRnC?=
 =?us-ascii?Q?/ey1EHmyL8NsRu65G0C9TlKHAdpj5HYHV7G0YdkJFwl81fSyzjTASbMfIGki?=
 =?us-ascii?Q?l3uixD6xUOLuAX39UMCyWNxR6UXuTMyrjCTafJEubhUYKKiU3hKPO1yI5a6Y?=
 =?us-ascii?Q?nRz36fTB98jyfo3kXiRLZYR+3xRJ5DoHLq5lVQvMvwVEdzz1fr/IdkD9ETc2?=
 =?us-ascii?Q?xMT21M0aH6gQr3lNhPHW8FFN0nXmgRT8EKSDEs1sKo3tmeaPTXlaVtstquer?=
 =?us-ascii?Q?q1RVNr55e5mXkpNZ2PdYSxpCX2uvk7Rm5OT33RvSLZlcs5donXGA0Sn1UycR?=
 =?us-ascii?Q?zi3LfDEvW7GYs0oGyCm1W+/OuDlr7JR3Hcs5w92zbtwg2BDkeLYDDs1EYamb?=
 =?us-ascii?Q?Yc2iSlzg1vQuVcPSJX7RthHW0zC/4ujm5kMoHtZUGVNCwP79U2ttRdJZ/sO3?=
 =?us-ascii?Q?Q1kenszRQ3nHSZb7TlOkr/YineQ+tE9HLdqC3sYIq1eQcT23AUh8fSmUZA/r?=
 =?us-ascii?Q?sz/rV3I73oQg8CbSeePxfi3MVXeYL+vbCIzD7VbGRajAOY5mqDCa5OTml6Bl?=
 =?us-ascii?Q?6O0Zc7c+XIXa2jdayhQ4hDjL/eLhDRkd/EDDmReYIUYfwosBVe2ZGoGvGbnw?=
 =?us-ascii?Q?xqKjBxeThGIsTXDdm+bGhHgfjJ6R4+710e68Kxa77/xOOayb4ICH+35mn8Rd?=
 =?us-ascii?Q?Toe5AToPfMFnWdlEtDn1Mrqbyp5pymR5OXNh8A2E+QoeNnKn7f6tzDTHkOmV?=
 =?us-ascii?Q?q2EbZ+iRcSCKltmsacih83v6sCTiyf8vQtbuj5BtcR/AfcJQYGCPdSOHtmoU?=
 =?us-ascii?Q?/awBDrA+84QXvaLgbRUFEDi3iRi31mTDrpQQ4dTJqW9WbpsHkPr/XqrJbfy5?=
 =?us-ascii?Q?BGcGk4KYBfHti3bsoCUv/518OnjHlXjzw9KhIAYZc3WQwfLhI68hwJRsJMBq?=
 =?us-ascii?Q?zemzrQZ+op/b8690hv3VIYaGOMT9qMSzpE2LakkUo0QeLXMHePAYXzheLiDf?=
 =?us-ascii?Q?rcthzCwbqRNu+2//b+K9LPaKkRFUlollA+zo5tMdZwf+hv388+g2RZ9g3GO+?=
 =?us-ascii?Q?U4M3x4FK5JhUw/UqYhQfm5Gu4nLzSFHPUtfRZqvqAyVR7f+qSKfyJGxoSnO3?=
 =?us-ascii?Q?0KZhfUwW01D/548ZKMxtLqMD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JSxTBJE0At0CVas3MwhOrhVDcSLK5u2gst/Lg2YBkAqFIW/2xDzX3SoYNHQX?=
 =?us-ascii?Q?KiiUz7eea+pqXZlYuVf1JgWKzXfZFF30c5YpMm9bSn9KUc6+eOwNVz07VfMD?=
 =?us-ascii?Q?f/A4BZR5oNimci/4xBTulxhevB3MlTubcUv5p7Hdf2+N73tuU3dkBxUBKMdY?=
 =?us-ascii?Q?roP0KGF04v59FV0fIHhvzHCYB3Kd6MzIefHldo3afRJ0awXCRKI80qVasXcl?=
 =?us-ascii?Q?UYNqE4KI6v5HPbTQ79o+dMaYlCl0YSZuhoWha8MTuRpuTmSCxQpqvp6QxGjn?=
 =?us-ascii?Q?x8+JSZyevJbkLkTUaw8hhXVeVYBaxlKGdBKTScrBftGpt7+hyLIJEp9Y4Avv?=
 =?us-ascii?Q?ckHgEnyShsPkE1s14IMmP5EoCwMpnMXUJC+gRM+VLv0YvuU0MrhzMOwfvLC0?=
 =?us-ascii?Q?yZGRuWkn1UH63fgPSTa4cGMjKUZb0QemavGlrsE6vH9942zAL4LIr0OHF+pH?=
 =?us-ascii?Q?3eakRanRT/mcvtLpOJpj7oonw//8zFc/bfvO1PAZYYlLsebUV/YtR/2Ketz+?=
 =?us-ascii?Q?LV6gGNn9Z9sPHlOhQXQUW+gqvmOZvyZ3HYgS3yfLrMaS47FIV8n4zL95HOQo?=
 =?us-ascii?Q?uVbEOFgVmlSXqTE4/chYlPKPjZKb5zKXb5S3FsQ6/BxEGigyntCJASs2DIhn?=
 =?us-ascii?Q?VW7sQZTxzT9hyZz3lXXIjm/5c5MZlejKvEf08aX7bEcxvV47ByfBks/uxqsc?=
 =?us-ascii?Q?d7oOD6e7/VlXCXM0WpaerX+kXXtVLzO1TtcqcwaM/1wgvPDJ0vCe40FUnpRO?=
 =?us-ascii?Q?93MfD0rENj4O7NG5wBCMf8E12y0KbojQSd/DZ9OWvFoQWIwjiolAFmeNlP2k?=
 =?us-ascii?Q?sQTevyTipnfbJIxBYEkP7JgmUlpb/ZE386PfE/6w4XwrMaafOJSgciU+0zG2?=
 =?us-ascii?Q?ssqgnRYVukgCQSY8y1I/QRpuAhHIDKJDUnBU7bs9rKcPsklHJfoU22gRMg+e?=
 =?us-ascii?Q?Mco856Z5UIqgnxtnBziyy4Setgkn6mzZPEchv2jUs529CHaOjiZTLrMgJt1r?=
 =?us-ascii?Q?qHrrFpO6JZZnCPtqaXc1s0XS92yfyx0ORh5wEm7yTMry6Q6zgQ1/odUbyjFX?=
 =?us-ascii?Q?nJ+H0t3xjtGiWBWFvuaRtlwCtm6blcQ0DDJJbs6u8/YoefJDvYexCzXyrkuC?=
 =?us-ascii?Q?d1mqy8RTvBkvgZkoXcs0ShTrMmpEiSLJWeMbkQuU2oUDC3CGKVFAITiJ3CG/?=
 =?us-ascii?Q?0k/bwBcaULrfdpF6TOjuTVCtJ0vDIsDFLRQDACFPAoI0UVemtXoc/7ERQ70k?=
 =?us-ascii?Q?IjMKHxd5p6psAFeWkufcHp19oFD2rtaWZ1VQMX9rus4fYaEalyG2Y6fVk1J5?=
 =?us-ascii?Q?xjuOF6/2c9XZ1LAZ5CTXFcUXWyVy9fBeCTUwaw0VzBvI6aCKajYcIHDrdfs/?=
 =?us-ascii?Q?NUubbymk4pLH7K4TYXm6Nni+t/8TctRYSZpJ0t/zNpIRgThcwgAwylcBp+rU?=
 =?us-ascii?Q?9iN0tOl3RkovRixvnEQ5lzhtCCZ/cVi3Fhv+6RmlciK4Wyd6Wvl3QHMoeKEQ?=
 =?us-ascii?Q?A5+NXpLfkG/qhyXSo2SlF8RiXItp8jnmhIOHDgjndfycELuFo2qDJXFApsYy?=
 =?us-ascii?Q?2f1+fq7MlZVwSVJ5vaVeBWnPzlXkpC0vVNZFDUhW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1679c6f5-e83a-4f16-6b5f-08dc922ce7d7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 20:01:14.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcsozT4/dbOa0ubSrl01XPmgRImY6yzXeLdl9egTr3UxsVrWa44WnjiTfv+JP5cebKrfvLeDnk5HYrfpWEgy+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370

On Fri, Jun 21, 2024 at 06:58:23PM +0200, Borislav Petkov wrote:
> On Thu, May 30, 2024 at 04:16:16PM -0500, Avadhut Naik wrote:
> >  arch/x86/include/asm/mce.h              |  20 ++-
> >  arch/x86/kernel/cpu/mce/apei.c          | 111 ++++++++++----
> >  arch/x86/kernel/cpu/mce/core.c          | 191 ++++++++++++++----------
> >  arch/x86/kernel/cpu/mce/dev-mcelog.c    |   2 +-
> >  arch/x86/kernel/cpu/mce/genpool.c       |  20 +--
> >  arch/x86/kernel/cpu/mce/inject.c        |   4 +-
> >  arch/x86/kernel/cpu/mce/internal.h      |   4 +-
> >  drivers/acpi/acpi_extlog.c              |   2 +-
> >  drivers/acpi/nfit/mce.c                 |   2 +-
> >  drivers/edac/i7core_edac.c              |   2 +-
> >  drivers/edac/igen6_edac.c               |   2 +-
> >  drivers/edac/mce_amd.c                  |  27 +++-
> >  drivers/edac/pnd2_edac.c                |   2 +-
> >  drivers/edac/sb_edac.c                  |   2 +-
> >  drivers/edac/skx_common.c               |   2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +-
> >  drivers/ras/amd/fmpm.c                  |   2 +-
> >  drivers/ras/cec.c                       |   2 +-
> >  include/trace/events/mce.h              |  51 ++++---
> >  19 files changed, 286 insertions(+), 164 deletions(-)
> 
> This doesn't apply anymore - please redo this ontop of the latest tip/master.
>

Avadhut,

You can drop the dependencies on other sets. We can sort out any
conflicts as needed.

Thanks,
Yazen

