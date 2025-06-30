Return-Path: <linux-edac+bounces-4287-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61899AEDE03
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 15:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6502169FCE
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 13:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6F128C2CD;
	Mon, 30 Jun 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iZP8/DZV"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2111CA84;
	Mon, 30 Jun 2025 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288452; cv=fail; b=JIu4qsvnx1cwK1hex3T/H/e/G1Bzy8OS36ZXnkG6DGAJH5ggimatK+m8cZRZg91DQ8p48na0mW3Zq2dIqG2Z2DeCOP/K2pYk1MNjruOLMpaKZmqbkYEzz5cxT+5bBuf2qdF6ZVmtZK9IgvRDjjcUORWs4uaa7qQe7G92uJNNu5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288452; c=relaxed/simple;
	bh=WDELvhGA/fSBkEHpDe9dTBPeEBCJ8XqrWTYsbFqUT9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kU7I4NYzrqBaF4o81Iduz8DC+P3pl3/mY2Z5eFeO7tKy1t4euks/YtEQO4vlqzpC6OVEMD8se5N3Qxb0YLjb/uqSJ4CrwzFG/fiXirfAB3GpsJTSCoLnxXdqSvjKUOSitfXTtY5nilaBEQQ3iBT4j99pJtnelIE2HXIjPfUE4HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iZP8/DZV; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVS66JtPhTYx4BSBxawGFnZHnM+xkbU8lzWG2j4KIE8IAG/TmTRRQtQDJEGnIo3/8ZKwdUXZPzoj8H59Y6ov9K0GHcdcvvX4Zw3xvHPQW0Uuk3z5X4rrB1C90i1XFd09TJU9s0SNwk6T8Un81Y8v+e/2r+1h/NO6X7bt3oqyp6m5guXWQonLT6G4u65y6/0G1qfCdjS+jHU0fZQw57tvBIO4KAbJZTFwz9geju0oC3EzV7wtWHtVKVn8Zmnf7UrJSjnHsG0nUtFN1CkPqKmpkZPrh4yuP5010DfonRV3nASf5Kg97wI/gTAzi6tGRY02SkN4oI3TWAhpCkhTTSjoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vEPGrnDFk/gbWpO5G3ihh0VWHq2mySaPbOHKekZg08=;
 b=u/TOQnA5/IRWvulLykj9lSVg3hOXo8+pwwquuzZaxBT93YV0GrNqMeH2v5kRixhiLVWoFDEy6I6D6QEY1VC2OqwLRs9dinvV+t834WtKHT3/g9mJIcJa1KxWpbdsl7Apvw0gVqD99shA4ICpxzjRZIProqlsy4i0xMPazDYiBm4ZYoJq21RL7MIX5fHQZUqKSS9rKgrqBLJr/sijjONsKuVdb1V0HBGmXGogfUqskevvmoBRWsldnDsfTn5T0/0T2xtIb1Jlh9wmnpO1xtajc3CoSoB+8KkmQR/FBvVwNT4IVhLCgOUSZ2kUMjfu0YYK/ZcLa5AVVFpineB+WrTM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vEPGrnDFk/gbWpO5G3ihh0VWHq2mySaPbOHKekZg08=;
 b=iZP8/DZV1Je68SGY9OYjSs0+xM/GkEs1Vjso9WGnxVYRHcr99TvyQ3lQJ3ZQoyP6lL0vlQfsvfdSQyU6iI1aGAdwpRzDFQ6VU9tHp30f3oujtQYqMfdhSZqtE/n5suYfJcrMlWSmi+rQqB1JVVWIEQIWwrjZn6UkISPqSHf3Jtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.23; Mon, 30 Jun 2025 13:00:47 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8880.023; Mon, 30 Jun 2025
 13:00:47 +0000
Date: Mon, 30 Jun 2025 09:00:41 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 14/22] x86/mce: Separate global and per-CPU quirks
Message-ID: <20250630130041.GC5995@yaz-khff2.amd.com>
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
 <20250624-wip-mca-updates-v4-14-236dd74f645f@amd.com>
 <c161e5b3-0719-4bf9-b7db-e5dd0fa8902b@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c161e5b3-0719-4bf9-b7db-e5dd0fa8902b@suse.com>
X-ClientProxiedBy: BN8PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:408:c0::24) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f56bd1-5cd8-4df1-37e9-08ddb7d621c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E9MpjkV2/meu0dSmQZBFHaLS3NSI56PTsENkbCkeAEirifGIgNU4cduiqwyi?=
 =?us-ascii?Q?rvWvc9oVUZuQnb6SlU/AJIFByNKI1WQ+dLeEx8zIHpcfUiit6YrCormgY1FM?=
 =?us-ascii?Q?HpyRYp/Q6stvdor3WRYnGnQipFOY4ybkHsW9ULmOrSQSYVgl9NADWBabmrO3?=
 =?us-ascii?Q?lc4RWYoXWpwltCTrDG8MOtxnEquy+U0HGHahpkW+tUyUv/Mo/xjagTBz78+j?=
 =?us-ascii?Q?23+lb3N37qTVh4zrlRfT6b4bqXPejTp5MqsEbSf8sRyPDfGOixTACmXIdDm0?=
 =?us-ascii?Q?Z7qc0lzs7ve0aOCd1pLVC4CPGjR3vc6mB7H9TqX/YdbtE6i68KupnObgOQm4?=
 =?us-ascii?Q?+aWxtEy8RKQngq2afhIRikyKUhenw/BEPPyG0lQedFtWMg7BdndUBbBxjUEe?=
 =?us-ascii?Q?a7QnvGaB7+hCJzsvDmfowl6+38LKQNoRapyeqsZH6vxp36gnFoZJIsBdAClA?=
 =?us-ascii?Q?eZ7iz4gipK1g0GWaLA3I6Vkz/QluYUu+hN7MNWoHGQkKAKXDRuYAYaYEnOWD?=
 =?us-ascii?Q?nyBFpcNX5/2BAQPeos3tnUrpzdA/FRNqyof3bNY1FbhqudNmkrMLK6AmlBhZ?=
 =?us-ascii?Q?VMHTBVbpCMb7sPhqrUisjUCdq3Dz9ldHJkrSKGlBmP/3GhsBI4U3y2hUUv6h?=
 =?us-ascii?Q?KSvtXoZudS+/ML/0w06jlIifW4gbWrSjG8pKRK8Mu8/Y6ltrtURBYY7RhavK?=
 =?us-ascii?Q?GNFv8ri+csREwJKohXR+qA0W5pGgNJqj1PjeYI5pYHkDthYeBL7Z3JtVW2kl?=
 =?us-ascii?Q?gNvJfh7zcqyqiNf1l8uny42/W4Lz3OzOyjE0spjRDAiELClCqpPk9qM7q2sA?=
 =?us-ascii?Q?kIRBS5jbTaC0saJKLKANFynS4h5b/SfG+P/DmDaVtgNs0fV8icrd5UK7Ucz4?=
 =?us-ascii?Q?AvCto1mduKCmr37mYKU5tUuobkU+Yg6BM4mJf0wqcgyYKsGvFuDq5Zc5aInT?=
 =?us-ascii?Q?ibcL0ybtAvW1IWrhybn2OUx9hpylkzzxr6Tz8Wb4ChSBmJkViBYHZxfnLbjZ?=
 =?us-ascii?Q?27k4h5Lgl8l5Pgx9KlviH4IIjbcosj5E6iA/brRRPqceNNW2wx94KszSpRZt?=
 =?us-ascii?Q?kONFAY+4vqrzCnTrhfFZUqAMGbqoRfMAEMK1rI3yev+OMIUo3eg7A5wccOP7?=
 =?us-ascii?Q?y2PDuzQyaDHgACHKfC/eDEKhA92Ma/Y3VCD7cMOKJU/YMFrZpbZMg3Bq5q4u?=
 =?us-ascii?Q?ti7Wcfdg1MEg8EMUdEHg9uPixFixYmxsxcSLaXPEwICYCzqnt8yZuGf3G2Pt?=
 =?us-ascii?Q?s2VaSd6XvPzCyAHL6tO/uv36KKCI5C58YxMRZWpbxEtwe/DV7FbXkzczjZ58?=
 =?us-ascii?Q?9saVfCmuoUl5lOa/QsEMHi1xOdoJDH5rFEBCGuNYxPj46lfzzRQGlRXGP7qe?=
 =?us-ascii?Q?XOW1BO6S09b19hDKjUHuUt7y5wN/+4ynQVbZOxWpCAUDZ+VGqo+ZwcY31wWH?=
 =?us-ascii?Q?EJoh81H6IIc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kd+UVS6+AfMm6wP6X/ncqaXG9YnULvLpfmj1ghpQjufs1G5SNBsf85Rr4Anm?=
 =?us-ascii?Q?kV+vRQvcobF7WnZ4zMLPBtYthonOVXXL+H0OyzGimGUusrf3hdILGZ0qh0cg?=
 =?us-ascii?Q?6TZpsYPhCtdwF1EVKPhnpFukS6etIniguXgyIM5d8MxP0n46DlkTHQ+pVnx7?=
 =?us-ascii?Q?ehGYGEYg9N0gfM6zfgpdJ9D08SdqMgmwCiaKptRaZL73kRe4OCuGcQfoj+KP?=
 =?us-ascii?Q?2N7n73t9sSusJugwImZ3Y7Mc29hrEPBIPhgOL8fjAZoXnjBjgZllS0HsUnOT?=
 =?us-ascii?Q?3n6L9mCN7J7ifNixJlQgMR2cvxCPT9ESoZ4f0e61TYiFsZAVItFDa7aJOV6j?=
 =?us-ascii?Q?Jcac8sj2q1T4ABVYv1MaG1y5bTTG9nH1BizC8gQAwYCtOo0nx/UVlvxx8q4K?=
 =?us-ascii?Q?rqmWcNNXxcB5Ksl1fWpaL0KDG94Dlk77eBjJC8JQ62zoCsj4ks3MG2M+XPR6?=
 =?us-ascii?Q?3yCGYkla7SuT74nt5ybz/69C3SAVqPkN4/z+YTdy2oYU6GVxRbOg0Nm5Qjq0?=
 =?us-ascii?Q?6dHYc5zXaGT4eimUrGA+xiSvqz3oGxoDzv+WLphefkFWPpOiOPOvY/xEyRyZ?=
 =?us-ascii?Q?IkRbLs0VfT0mAKWXKxXFbjJx+5YQBWGv36eR4jl5kwNeVXP8g+forui4+UB8?=
 =?us-ascii?Q?pHEiXA5eWOj96YxPdVv/pi9/Xi8gAFalnl0sVkJamr6oKpJFY4gRNFXINHU/?=
 =?us-ascii?Q?wIVKhoE7ArvaiR/hHc8eDPvOAj0EJ3+CbBgrAlwfZiWP9QbWneikNdtDw9t5?=
 =?us-ascii?Q?jhv4gtyOWstdUZBfY+54U0Zco+M0axvNemsQZdHJcAJRZT5o2VB4LsEnp5pC?=
 =?us-ascii?Q?sFN+o3odenxkiPGmeZiXPBqoJfgqFCM8E7bsWglX+LEj0EzZpPxdCqHqYqr3?=
 =?us-ascii?Q?GwyD4QpubDDzYEL+yJf4IT1pZc7LMTdSD9xVWqbeF3mmL8fEqgKMSoMhrMsC?=
 =?us-ascii?Q?N+sGuHnz4LtuTdyrRcda6zgl6sYwxgakPZ6qqt2eYiO0GNdGQtbF9jlSvgmF?=
 =?us-ascii?Q?8SrMONnDEnzOPvo3KmeE/MNJ3Jily+xCet/DuMiGC1wDXji9C05vI/VM9678?=
 =?us-ascii?Q?onifXAcwld7QsGcGshWQlrYF9/ULsSCO0oLsB2P9Vrdt3bsSq0xNgoRoZl/Q?=
 =?us-ascii?Q?gtgls2fYDtIvsYvRmGb10P3Nkc/5GT5Nn2w/mxc26i+OfJGJ48IxHeg1a/g6?=
 =?us-ascii?Q?D/n2P+B373VYCpIxr88blX07TPsLPn6Eqj94HYFckmliOVpFOk2NvSTpOHaP?=
 =?us-ascii?Q?+Bmb6LkgufNv27dqsGETHiu0uhkV0VGfAgrQYir+hUOFvTHxbs2cEZy7FJbj?=
 =?us-ascii?Q?Lc4EcnUxE6pNYCI6NwbCxXIaWBcVGueoNCYqDcWvnhCPZapod6h3w3m5aS1J?=
 =?us-ascii?Q?+uokDdm/zHscT9dR7nvNQCcNv91jeNyR+AvkuXf6Jg3MLOGxg4K3IABJHqEh?=
 =?us-ascii?Q?390sc+8c8mt/aG/PXnMoVa8nDjghgFvKRHKC9D6pRb9kUUP58La5no9JQEu5?=
 =?us-ascii?Q?cHdYFuRHUcfV34MLvh5wZAD2ToqESTyCn+T3YjWCIP/t6eauP35PAVgz30uo?=
 =?us-ascii?Q?Oxs7eyYO6aEH993pjvYY/VKPyM8Tfd1TLAyHLXtL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f56bd1-5cd8-4df1-37e9-08ddb7d621c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 13:00:47.5735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsj7MMGLM2z565Byr9b40YLqzPQCxK27HIYoa5WO312DCjP2irvkfR8qawig94taxy9S/uUQWd7lwwJeP2UoNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730

On Fri, Jun 27, 2025 at 02:02:22PM +0300, Nikolay Borisov wrote:
> 
> 
> On 6/24/25 17:16, Yazen Ghannam wrote:
> > Many quirks are global configuration settings and a handful apply to
> > each CPU.
> > 
> > Move the per-CPU quirks to vendor init to execute them on each online
> > CPU. Set the global quirks during BSP-only init so they're only executed
> > once and early.
> > 
> > Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Tested-by: Tony Luck <tony.luck@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> 
> After this patch the code ends up with 2 sets of quirk functions with very
> confusing names:
> 
> amd_apply_quirks/apply_quirks_amd
> intel_apply_quirks/apply_quirks_intel
> 
> 
> Better naming convention would be something along the lines of:
> 
> amd_apply_global_quirks/amd_apply_cpu_quirks and the same for intel.
> 

Yes, good point. I'll make this change.

Thanks,
Yazen

