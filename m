Return-Path: <linux-edac+bounces-3287-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75267A54FDE
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 16:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFC316FAC3
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B7B2116E9;
	Thu,  6 Mar 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rGkVDpB6"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F55C146A69;
	Thu,  6 Mar 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276728; cv=fail; b=cYRqqEWdeQDICX+xCyL3gHADecRjG5PyjZXzS1fi94EPUEYAqHwg7SHoenc4sNrj7c/1sAMR0snPOHnveX/LYDa9Ij4IIyBZMs7VyCQLAhJEXzXo6u9ZyiWh6PUGfJGbSkITgMTKjbjvTtSIJkd+S/Wpju2tOUUEQ7Ki+NzMoNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276728; c=relaxed/simple;
	bh=9mszVmjHLnzFko+liVnc/U1UHoVt0DOpeBKazFSRQU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NLT6Or946JG6vH2yRR7SquB5cgEImj9bG1jlnokoo0qn0C9LFTHlQDc/Bl6+x52Ri5Ed/vY+bhGsUNsoS0O5SshHM2ErEE14nVnPz7+rjNZQXWDrv4HXlPs3bHsdadM2ZjD5c9bCJVFCLqcwp60qLcreuloTE+yS27O1McYyVzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rGkVDpB6; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cz4NVhzrXfjJkh0PojLyN84/nXi3wq8+YDB6ExL4nu+Df55wSyVM+icpMhjTqvI77oB+fS+E8xct7/C8rf2JF2WiYn99gV08tl6JVILuYb6ShnY4Ub2pjQX7s1fxPurPquzgbUKHM8kcY0NeV4yCbu0Bd8MQ/2PtW8N5QW3Uz5lVl2phkgwX72gW6L86yl4XUpblDWFjt3IoikJsyk8r4wknbQ+xaDtVT2+WgIpG/ALCEP9FqhcQo3A8jzZ9a4gZsbxPCXLauLbjDBqkrsFXahAfaWqzNpcDw3ViZ4+vGXmyK7KzibIG+na1ySr+o4wNmyJeN0aW0FpJgmNVT4Ky9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9ndgWa2b+28hjYtfUGGtEYi5NrHgUI08juqqgWDr/Y=;
 b=cJ2Wk7jS4uKmqfbHOJAPddlEQPP924XCypaQeuo1vAJnGfjucNsEvLNN+NHKE7aIfLxF6e3XuDDpzNytA00ajCP0KUfOU3OeAFzWF0Ejtp6IBZvPHnfaZPjMk1IZDBLctUTEdvKoWOpW39N2yUBymCLUBcU8OnfsFLS9LdN+gg2gx1XolX90DmaRXNF+j1nMbsPnV6muiRXOfmZEpULiHq+slkcl4Dalei4DmPW6GzYJOc95y/ARhrIvnYgNmDy8/S2+K9UME6DKvFtyCfefiH/0E7f3FhoZ0YsclVQP5nWabM8zD6tLoEnVIfenwRYUXxBqtvdMyUexq6vWa4+2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9ndgWa2b+28hjYtfUGGtEYi5NrHgUI08juqqgWDr/Y=;
 b=rGkVDpB6LaTOLfKWW1FR1O6JH81M4D2sRm7uXBDsFLnA3AT4ZfHpZnMKCQ5LSS8yJi3UJPRyZQOVvkj0hrURuIRH1W5bWb2Noia005Njxxozle1goyy0lpFW3Dn82zidhdOCW1zxUHj+Hleg8t3pkxbGoOXTb4tVnvyOgcerpMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 15:58:44 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 15:58:44 +0000
Date: Thu, 6 Mar 2025 10:58:39 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: Re: [PATCH v2 2/5] x86/mce: dump error msg from severities
Message-ID: <20250306155839.GA504626@yaz-khff2.amd.com>
References: <20250217063335.22257-3-xueshuai@linux.alibaba.com>
 <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
 <cf9ef89c-ca91-476a-895d-2af50616242f@linux.alibaba.com>
 <20250301111022.GAZ8LrHkal1bR4G1QR@fat_crate.local>
 <dee8d758-dd65-4438-8e42-251fb1a305a7@linux.alibaba.com>
 <20250301184724.GGZ8NWPI2Ys_BX-w2F@fat_crate.local>
 <SJ1PR11MB6083697C08D8B6B8BFD3CC98FCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <89027155-8ca3-46a5-8c3a-e24b903cb3eb@linux.alibaba.com>
 <SJ1PR11MB608315FCD2EDF6408A2A05EDFCCB2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB60837F3079308E3ACF7EC5ADFCCB2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60837F3079308E3ACF7EC5ADFCCB2@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:208:23b::16) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 490302e8-b486-4211-1396-08dd5cc7c5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mta7A091MNjCzbK1ivPNx5LzhoO0loIuybrbFt/TxBDcpgnhPDLRdY3Hqzg3?=
 =?us-ascii?Q?08GRwifOReHIl5ZTyuAJ0otYoO6Hcu3a6vjhvT/jtL7ysHZJe5BquaJtrk2k?=
 =?us-ascii?Q?z6mj7jXIUTh3/5q/9aYJhfTQjTzU6thaIjHKiPvzmYdpka4iJuXxqe1uZiXP?=
 =?us-ascii?Q?B5PKT4ZuYW0cM5aTCaifCc3lhvKq3huTVE7qsjt8VtfKLYY6xHECA9BpYyKd?=
 =?us-ascii?Q?naDNSbYT5rPvLDdRQJervMbiu0CW/953A2Rqvojr088tzh6UdUs3U2HBvFPS?=
 =?us-ascii?Q?iWjFWTQHaA+ICJgADKdXmq1rCI5qNvqGeSqhFd1l3oIj+U5XZBpL5lKzX+s9?=
 =?us-ascii?Q?GBL9tn+DK/8G0dOHu/7nawfz/Gi09VzLVt2yqLdfrWC/9PWq3Mx4XjJHQzD7?=
 =?us-ascii?Q?MZ02LEmKaSO0O534mY6IME8mP1moOe5MA4ZVbKc8gqUkvwX8yK/n5TY6ZfzL?=
 =?us-ascii?Q?c9mFtEj0kXuDqfaQtol94eXJsKJHmjaX6T7mPxbYALiOxeS2oxYEARuP2IYl?=
 =?us-ascii?Q?la3ga9e0UdTeU5rmJf8o2muF5xNDrVZuA/vn9ScEFLXQKtoylv1yRpDs1H0w?=
 =?us-ascii?Q?3DxMwlDcam09ZcBAuJC6RtdCF7fuEWlVZ/K/W5dWoYBN7uiHYbBpjToBgnSs?=
 =?us-ascii?Q?6TuAgUhIjjgQqlQy/9irEqjtbag+0v8JtMzqDtVzPpo/qFDKVPTmWBwRmhRY?=
 =?us-ascii?Q?2Ph43XjJEm3ETzbWZV0aJJw+pYMjmSvKBf1pbk5PDQsJLbaB00oR7727mWxW?=
 =?us-ascii?Q?LIPxv89J9jtU4fKkIKkHlXdbDquOb3TbUkM3sS6Oy5cK/NizkYK91R0aGLJ2?=
 =?us-ascii?Q?+l+f6652GWsnZd7QewW9D9ng5PXk2AihcjBLGcpXeW97dEnz0kgJV0l6EfJl?=
 =?us-ascii?Q?/v+2D51ItllUzO2Zp1Nx5ELYpo8z/M01SaFvXVw7lk39j0WUeHkf3CiC6DkF?=
 =?us-ascii?Q?ZWwQOHFwslL3GFOJa3voB4ohUOhDuyZpCCgxPGcZdzgOHfbe7HfSLMhOKgmF?=
 =?us-ascii?Q?iYCNJA+bH/VYfjOAStdbrEWXVtKxS7hcQEFHeHe5m0GxcLNB81bN/umMSwMc?=
 =?us-ascii?Q?6iSHWpPSEclOJdyy4mwLajQ8Duvj+RNdxH0fm3ULNSw43aMWNKEO1rXkm0Ms?=
 =?us-ascii?Q?wOu9bLrWul30EJR4WqeLR9buCfvxouL48acRlXs9pLmas6bcsHKThyehYJbI?=
 =?us-ascii?Q?RLxwcVXndyXGAFCwW1CZIuFlvi71IJjwlUsjYlzLc8Ov1pdZAkGM6XUVnNLh?=
 =?us-ascii?Q?mLv2MJy9qHoIDtx9u2WuO5LkAM6UFpyeElqGN7VAD3wYMJmZ39fPAdhC9pCv?=
 =?us-ascii?Q?G0mXGI3gG3MDxFRdukT1RDeT+OWVBSKXaRG3oyVrbZU+50U8XE+YpyVCXlDl?=
 =?us-ascii?Q?G81Opij6r3I2rznED2zn6m5T9qqpWkQxBjTEGINiCb6P8GYO8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZKXGcALKHhYfMCU0bZT/SfCW/kthzoK0YPjjSB7BpjsSdMSFR9UM90fOVh/w?=
 =?us-ascii?Q?QDEiVfRSxrIpw80D6Yz8XkFt4Z5ykundfi80BQdd3JfI1vg1FsfxRKTxu/IF?=
 =?us-ascii?Q?+BZ6/tgyfew8vfTIc+oSHYd6zYUvJp4UH555DLKaNPuyiOvMI4sPXTkOv9I/?=
 =?us-ascii?Q?vLZ3Nmwv3tasQIutQTU/LSxp9ukeOxYTbn8C2zM3+hFApLSQsmLS12ZwlRyL?=
 =?us-ascii?Q?DIVZAobAdZoJJjkYYLpCFqo1eGi7umnctvi2tE/mXg9q7b7p5ohzYwhaf9bi?=
 =?us-ascii?Q?dE4fVXPUr0Be5y8g+4xX1elO9OtpZqYiTS6kwRwqYdgifUFrh5+VLAMSc45I?=
 =?us-ascii?Q?RDdU3CnU2mYAC9hpXSqDgbpgAu3bDCT5teCExWmR1tLC91T9u8oxPGymy93g?=
 =?us-ascii?Q?iWL5oJ3J/IhvGCVO8S0eY7OuChonbqQe8SYsGqYHa7+I03k8AoJkc9KhSxLV?=
 =?us-ascii?Q?hOntEhrwouLN7Pp8wcEZ8DdFB6QFfo1WTgkbG54XFBZcCoLBrXDXMpu95Tbn?=
 =?us-ascii?Q?YQn4OX0AfXEXZvDrXtHboafsBkfFy31wNbDcDyABZAgQcfoD7sQmaapdj86n?=
 =?us-ascii?Q?OFDWrD5AhuzBTUnoyEbJKCrRcLCDlH+uKs5m7qh4tQSLbcxoAOGd1dP/nHaI?=
 =?us-ascii?Q?HBuPcWC+QYx8Z20/NdK79cpvvSpXAoY7TkEyX1Mk5RU+7NX4M3rmsvGy4yV/?=
 =?us-ascii?Q?On/EBcwXfQgBtaYwB7EoMgHnhqykuAFibLF2VfykmKj3lv1bO3ry2T6c2JHk?=
 =?us-ascii?Q?UfrosHe49fdYoeTMcOgkWzr4hvCVcV9EkmGIS8lu6F9lJj+QffI/Z/PoiAGQ?=
 =?us-ascii?Q?Ym86lyOB7DHgk2qkFa38g+Og5cnfniFWoCGuDIN2xwVRBbMqUh8Je0NI3OOr?=
 =?us-ascii?Q?3h6I58zNzMub26lITHoAxrjm9vWXACuBJzzuUZ2YDEWg1fGU/xwW1eFHBNWD?=
 =?us-ascii?Q?I4nlQFAJqd4ry97wZX39Q2Nk4S74m4M5DhuHIpzQSVCcagbyOEUP8CU5IbJz?=
 =?us-ascii?Q?VzgcBxNbyWz7kHiF0VBpKp3p5fHrzR7RltllmKJJ/uI1aNzeo6sZNn6yjioi?=
 =?us-ascii?Q?fNxSwa3DmUi7erm1AH4sOrfJabcBvxTTCVyUXTf367CIf4GTCBAfEPFZCSlQ?=
 =?us-ascii?Q?r1lhKalU3Hl5x8sf1a7hvZFnUGCLS5fKVC3zyg9byYPCQqxn7neLFgPP0kPp?=
 =?us-ascii?Q?fa7Wh51EOjjCeYk/Tm/jaZs7X7gc0Rg9axuDxsq2WGZmshPaNLheoKy+IuPb?=
 =?us-ascii?Q?86MFBFqJqd02Qb9x2jAb1A+y4y7w16c7mjnlQsP+phdLWMwQZSx4KiznYfUA?=
 =?us-ascii?Q?iuTeU9o9o4JhVSr0//CnJnOJX7Njvas46yuhQb3JMttyH0CTJo2CI51GcoTL?=
 =?us-ascii?Q?QK5JehDI55Gc7FSYBTO8TwhwTpZwhCOJSCuVatX2GiroyvMMCOykM4ypc96z?=
 =?us-ascii?Q?IkbFtBF3gC9kReAr59hJBSHEQBqak8HhEPmPLd9SbVSn9OcSPRnPhVQ2w9Sk?=
 =?us-ascii?Q?jZshQqROa0f7+GivNLjgx6fqjwHK+Kx4WWbLzcRekbtYCP6/A22X/jR9Uo96?=
 =?us-ascii?Q?COe5ehdOKDjzpWc8opz/kMSFqBzAv3k4kEIZgP17?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490302e8-b486-4211-1396-08dd5cc7c5a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:58:44.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gM0u5vQGgfb7tLVPQ6FYmdvmKiGhKIfPOM+p48065re2k9qr8kbG2WjXGFivEipH2CR/akb7LGOc6Sw9rQn4ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287

On Wed, Mar 05, 2025 at 10:33:04PM +0000, Luck, Tony wrote:
> >>> 2) I'd like to see a patch for a stack trace for the unrecoverable case.
> >>
> >> Could you provide any reference link to your previous patch?
> >
> > https://lore.kernel.org/all/20220922195136.54575-1-tony.luck@intel.com/
> 
> Yazen has some cleanups to the severity code under consideration
> here:
> 
> https://github.com/AMDESE/linux/commit/cf0b8a97240abf0fbd98a91cd8deb262f827721b
> 
> 
> I wonder if a slightly different approach with the "mce_action" that Yazen
> defines being a bitmask of options, instead of an enum, would be possible?
> 
> If that happened, then adding a "dump the call stack to the console" option
> would fit neatly into the scheme.
> 

Right, I was thinking something similar. Basically, replace single
action (enum) with multiple possible actions (flags/bitmask). And we can
have a mask for a "class" of actions for general cases.

Thanks,
Yazen

