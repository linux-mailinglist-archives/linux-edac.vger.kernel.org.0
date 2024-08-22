Return-Path: <linux-edac+bounces-1725-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0738495B813
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2024 16:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287251C2301B
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2024 14:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966C91CB316;
	Thu, 22 Aug 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dB9r1qo4"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097751C9EA9;
	Thu, 22 Aug 2024 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336079; cv=fail; b=dlKfF6p0GzW2Z2JtYXCLkHzOZBzxV8rBxEfMoe8XyKTqvcdThBs+GaxXXFDQnCy0Jo4g97D9n7619m/KfYrIlA8i3FYn7Pp/wduZk70v4AFSKxy1xleyqDox94yiuubUt2gjVY1STEWgPwiDw74miGf/q2Bg4CN8yAGjEfCIfQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336079; c=relaxed/simple;
	bh=udRzTz8ZW0XoabgLnqLG9OzpD+asa5+wDPZWPzY+2B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CgN5PEPNbJHCsssq3lbISM++n6c39VVJhNrd/NIEM1TWEAKTlwNLC0xfY9TFxVgIGkXCu/hmjTlK13yjtXu2JJiJokuSdp1TMYAu4QqTdcYzGqKxjCokEPnS2gTlBC7q89MXzFBNwsRfaHFuwrVo5fW8vfUUTMo1/0tZKsDZqoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dB9r1qo4; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idX2wzi3UiTZpTSkbPXoLzUOKYa+/F0t3oaSBWKI5n00ml/CfRr1ouyu1uzqTPLPFnDovzVyv/vO0S94H8Cl1S89x3TlY5iacIOk40KXhnI1SfBoJe+HqCZpZGqcBWt06xo6eAtYk64T2FVCVWXyiC+NpIdRl2nQDM/52CcNGiDyMG/JqH3j5Wcc59AauZNUFuaWz0Z6tfohYFotyvJnGeBxHOkZAjfLfj7toW5G1jqMbShzt1kb8G6/CTlYwcFowGGKR4r8RnI8pEoiO+JuJkfGiC6DRLXy7TLlAVDOStcF9jQzlNIaFqVOOVzyLHBHZJ2gfOELKAL9Uy4zfChHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv7z4PFms4MdkFSSHF3P+Fr9mjBMuRoZrlNCQ+FpS6U=;
 b=bZ8lSUWgdeCphM6KlncgNovN1qXM2qsR6asTvCQ3RQX5VYgDGi/0S+LL0+Lx00RgGoGGHm9Uiy3Tbfj83qWW2DFx+HZN3hOZSn7aYn0x0OVbfuHTsbmVfUjJeLx7RUuy3sfWCz+czaWaM9ozKnmV50ubAyl+mLOObXQ72yDWO0ONPpu7Nvnn2ukttYtkgRwGBfimEHDCs/vxOWrVlqUS2xvOXaB+mcdRRAMwsgyCt03I5iYjosOzH7A4Oo8mNHAYqutKBortUSDffLMDnw2Q/ja7Gc42jyoNWmFuKTSombL2J4XAmC8DmU9dDBnnCYyebdGtSVf/WP6D7Gg7Wi9gJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv7z4PFms4MdkFSSHF3P+Fr9mjBMuRoZrlNCQ+FpS6U=;
 b=dB9r1qo468tML3KTjLLUbBCnKF3QbLQyBOM/W0Mkq9iaBDN6xYjLaKcSnA2or1UPoj97YgDRLcFkQDLfcSyYNTxNhCIuQ3fixFogXIPspIJZVVazRIOQac5kzHIYYnDzQKLJo9LI+sPN74jKc3KMnxOP7T6VhhpxPIbVPn1ImU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Thu, 22 Aug 2024 14:14:35 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 14:14:35 +0000
Date: Thu, 22 Aug 2024 10:14:32 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: boris.ostrovsky@oracle.com
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH] x86/MCE: Prevent CPU offline for SMCA CPUs with non-core
 banks
Message-ID: <20240822141432.GA211090@yaz-khff2.amd.com>
References: <20240821140017.330105-1-yazen.ghannam@amd.com>
 <2eb4d710-fc8a-4210-a681-666a7ce1afe8@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eb4d710-fc8a-4210-a681-666a7ce1afe8@oracle.com>
X-ClientProxiedBy: BL1PR13CA0338.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::13) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee321ff-bdce-460a-bdb3-08dcc2b4c05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dnwbIosSWOqMRcpdKoyAGnCVGB5i+dxAJ/WlQ/4gSE5YQIa2hjjezjLXpey6?=
 =?us-ascii?Q?aXAvozN7Alcop1WFAmidmsO2s1Cpeoh1p8fyK2Y+vNfFxQo5Bi/YJbEISaKR?=
 =?us-ascii?Q?uXHkBX7KK5I1dlq2psLTAXXX0uVFAPh4rSxE+Fkz4ljmxtXnPT+rFG8PKqU9?=
 =?us-ascii?Q?ITSuahkASsG+MgREKEC8l60eSm+8IXEwLbjp0bXlXarWJpP9LQpN8qF4bYMl?=
 =?us-ascii?Q?2xx5JqeIJ0juhAzmYH28nMlvHrTuHUJ+K6ujPdLdKpdLV96A+GfwUeNN2bJ3?=
 =?us-ascii?Q?AoV8OyrIY0F09NOOLTps2jJkgu2btb3TMdVzsFGPHvs0vnevXOAO9rR6PmGl?=
 =?us-ascii?Q?wwquaDfJuCCc7H9yv+c4b3B0FAEBN3QvEJTNjTDx7ej7tJ0uMFl+gXJZeGRX?=
 =?us-ascii?Q?RHTXwUBVb+YY9hHvOAjBhs+q0G9y+vOH2RhszLkq7u4IAKkY4s+MuK83+64/?=
 =?us-ascii?Q?OUiEOElRnf9A1iXtVbqZ3pWbqd/lfUZeh7Zgf6TkQlAEqax+LNUYEKcGKkqK?=
 =?us-ascii?Q?nXQtHx7PUyJHBtDIl/ckNqGC+5zQ5wVbB9Jg0edCDpiu1JFnmY+6LdihMM+b?=
 =?us-ascii?Q?9Kte62vIYwPlq8hDWdaAsoS7G9jjeKPn0VS1rA9/Sd58Kr41FNM4gFiDxMQ0?=
 =?us-ascii?Q?8OxWn6717+yCP4kmchTOjXaV35v3GMC06xloQC8vryyQvJnNm4d9ezOQuu9t?=
 =?us-ascii?Q?QXXmqMrAePnvUb9RnSn8lQsexbI9w6Q6EZqBoePnS4IQ7GvLYAaSbngDHpQ2?=
 =?us-ascii?Q?YqGnHdnw26wNhxGuVncaTHgNIZuRG0DjWdvGC7OGrBf2bd9eur+LqghlYCwT?=
 =?us-ascii?Q?jIjLrkh2sQZs3QLxquUJqDbSZlUBaOrfLlhEV9kEUuu66cDeo4WDy7zJl7Wn?=
 =?us-ascii?Q?7tIV/aTWhGL9V8EHxMPOhgquVriQzGueD/OkdoEh4pUWQfpnO2vA1hN3vrPJ?=
 =?us-ascii?Q?afhi9hvpVcrDGgL+JNo/B3yg1fjuxwbI3jydfQbQohBcPTMrWZ1rSNTniA06?=
 =?us-ascii?Q?Vc7MCUwSF8TwUtnl0iWl8/neQXolxXkgeu4bhJMY8FmRBJhLqSHvqV7m+QOj?=
 =?us-ascii?Q?SX/umLvgZlAMTvBg42LZz14UOCsr55/AG5X0XlH5haPWqUYTGsSxPoF7gY+8?=
 =?us-ascii?Q?VvH8DaSLpkUp+9Wsd+noHbeJYdxOD2Hba5vacDsYF/9QBXnZ2GgAPlme63M5?=
 =?us-ascii?Q?xF13Oaoxi2Ds64TJ2mbTnrRDSof+RnLCKUwXZWjA1diSjR1rzSTB/rIQMAAd?=
 =?us-ascii?Q?dDUQPC92IxsSbboOL/BwDsJy+wVLTs//P9vhbTiwD7ALykyjDg5tb+caNywe?=
 =?us-ascii?Q?o/gkBQznY5mlQ/P2ztA3VDgrpwlpQlIOZRhSS0xEVdG1xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xyjqTLOnMqqaBEMdOxhPekJCUVbJF8NxIm7JIjzHGQHFGKO9z45U352mKqYj?=
 =?us-ascii?Q?jkyT8qtKL0gPbQZ/+ggW87MqfsQf4B6fzxHkd1iuHk5oM4eyYErlmZn8Hol3?=
 =?us-ascii?Q?NJL1PqrjLih1nwwEoUs9k1mvTK543ElXxntD8P00EtE+3vnOEucNFcrvg/db?=
 =?us-ascii?Q?aq2oo5yW8Jts9ohRbS8sksFpB5RBjpb0xqIIJlea44HbwoivJCX5UfKj02hX?=
 =?us-ascii?Q?9q2U04l2ZDklJL+3av55I4YitkfQypgjPXkEjJnsLR9ENy+IbFrpAHVppMgk?=
 =?us-ascii?Q?v2VdxblKs8w7wwmenVbOZjuAnVJFOKqpwTvl2Nov/zhtcl+bELnuGbzZOSkp?=
 =?us-ascii?Q?TeshOhEriM8tDMJ2FQdvJqjDbsCZbSQIRmUf1XCE4eaBa1zPkTsTJlDYZg4O?=
 =?us-ascii?Q?NM+p3rK9v/sCiu7ObfIcZGHwRrO8SGdXVlsHdX5hUDsC68PDxHyog0bxXjGA?=
 =?us-ascii?Q?7kPtC7LZTI0cS004CCveDi9uY0MukKiwSmUtXUQnnBh+Sc445ffSg9l1497D?=
 =?us-ascii?Q?ESWuhYvFYqk8+yt4GBeSF6krYgBXN4jfS5mc4OZGkGRXie4ZvL40SiaEV96l?=
 =?us-ascii?Q?kyvzZaAkz1STOAhNDezOtGwpSgYccGSmgQbZgehyK/G1ffNkb6FpLV7TCJSQ?=
 =?us-ascii?Q?Num7RhkFfzMm3fblQXEooo5haiG9gpzLUSlFNQjE/Le71I9QQkR3tqVUK59Z?=
 =?us-ascii?Q?8aV+GqQRPEg1L7v5WjUcOKCZm3L4YTzoEiQWBTWNOdF8iAWt1yBSJatuh758?=
 =?us-ascii?Q?IPRgJvvIJD8CMhEx6MtwK6mcrsw1GjDNFv2bKd1o1z5NgkPae6/BPOolHeCP?=
 =?us-ascii?Q?3CZWG4P0cE0vy2tnX3ZQGbFMGDSAN4ThMBLuBBBA+7BIBq8JxPXQYQSNTS+I?=
 =?us-ascii?Q?Sd/QhowojcerMyKNjYPP0bdPlIUzDQVdqSj8L0nR29IxCr693X8AU8lUcAqx?=
 =?us-ascii?Q?kxzaxzgjfwv2wz+8mtKTE+m/iXknWHYPJh/ewQocna7O9GBLDiUFUAdyaFZd?=
 =?us-ascii?Q?ghoHkYziKrU4GGqghK0MxQbujpqoXSTy2DVeqYbCiBRDcEo+Ho87bXc/jorN?=
 =?us-ascii?Q?2yGSqp2jQfB0szi/EWol5Ts/O0jbLYQSk2Pwkm9rwIS+NuMg92DLLvHq+RS5?=
 =?us-ascii?Q?GkL9gtvuzVvZYCIm9OP473RL0qn0hRjXaB4WXofnuCsMC5lmzvwDAZ1G5PUJ?=
 =?us-ascii?Q?5EWvHgZ7kPBP1lUc7I6nCsmbag77/lxLrx2GG5T8aVVn7Ok//fD0EpOyw8gg?=
 =?us-ascii?Q?VTtHXN+kup2ggBBPlVcnjNg0QQP8EfDWbhCelyR90auBERWiG1AzNYDR0pIz?=
 =?us-ascii?Q?Ms5K80e2fYLaU4aW2v7qTnvSqcxnXV+6ZW1vywo5Kua93iblEx298lDiEfKN?=
 =?us-ascii?Q?7QjYo2ab1myX9AwKTDHip4Aw8+ho+RhwAZGVv01TWke4wDOy8zM0w7RHwH7a?=
 =?us-ascii?Q?45RVglzgyL0DoereOEt4KdZRcvsbtbB/ne9Ug73727C4dTdFt+ePWOq8smTX?=
 =?us-ascii?Q?XgWMUu+y2GiniExF48lsJhXSGO3sECAXOKP61xvcsBCto4AlI11LqOOowe5p?=
 =?us-ascii?Q?twcPB5Szxuxc/Y3NL17ABWKrzQlAT/Qz13hn5CtL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee321ff-bdce-460a-bdb3-08dcc2b4c05d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 14:14:35.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bgnKSTCsNmH8DIep/ij4BGrQFZRYto984weKtMAHwm+QzLRnzegZBx11LASxhwwv+XSdipk0qxFtKK8eAJAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309

On Wed, Aug 21, 2024 at 02:35:23PM -0400, boris.ostrovsky@oracle.com wrote:
> 
> 
> On 8/21/24 10:00 AM, Yazen Ghannam wrote:
> 
> > +	if (!mce_cpu_is_hotpluggable()) {
> > +		pr_info("CPU%d is not hotpluggable\n", cpu);
> 
> Can this error message be made a little more informative, e.g. that it is
> emitted from MCA code? And is info the right level? I think notice would be
> more appropriate.
>

Sure thing. I can change the level to notice.

The MCE subsystem has a global prefix set already by pr_fmt. This is
defined in arch/x86/kernel/cpu/mce/internal.h.

Thanks,
Yazen

