Return-Path: <linux-edac+bounces-2236-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01529AEB24
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 17:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4E31C23FDF
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B515A1F668F;
	Thu, 24 Oct 2024 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sg0A3RM4"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C31F585D
	for <linux-edac@vger.kernel.org>; Thu, 24 Oct 2024 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785312; cv=fail; b=Hvttf52Xxgdzt880YB1qTfN4Ximm4dl/P3oTjz8orVWagAgQbQPjG5zBJci6jnQrSnBjTelRwHC7wyZvz6upFMN17gB26g6YFcTmLzMXaF9xBedJ8myVoImAZovSAgY7Np/5SZq4krDWxS7FTo7mwEM05Jx2W9mJPgB9HpIaBSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785312; c=relaxed/simple;
	bh=3I9QWCSJ9KZFjyvgG1dx+0uOC+hJXJLBAqsfiR/LNoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lwl9IGIVP95BwtzrkUKZLzx+y1qgQYOA6XwwbaePOqxQ+8wmmSNwcBGOJ1TjRv4yN6zlxy5fJbNiwMAjIMjaqpQZGvHz6+h2s/R8er/xIEjDrgTOepFsOicEeN1usaLW3ORUeGsKngyPc0HKvfQ1vCyNAv6ohOpn1OeejhR9s4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sg0A3RM4; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNtDn2b91SuzKkBZtrCE5mKu7DJf3UhhuyoBPz/SmYDkqMNzg3t7c8uUFf9I988aVxbMPnJuYzoVPdWpytTUMS9PxLLNP/JmHtsaZcIMrgCarHqEsnW4DG+X9843iPp8SnlDs5I9zQen7yxEk6HYwzk0c1xnmAZVlNp5V2o5qpSeReX4SSnShcqWF4FXcYRqPHxCNbfqKVQojXCUZGlAnmpWTk1ghchVOedbvqv1ZCyqqcBq/T8AlCnpPHFwfvTpiybp8yWzwpxeF62uoTYolgCENoc+JyXbJNlqhi895BDhTJZv+BBdw8Z8fwLomqIjFXs57MxTze74nFIyhSTXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1txSjVcy/p3GHAIj8Y5NNc0GtP4LvCGFB/xD00ID+0U=;
 b=mGfRHHyCcL3NuUckoTEckOWt65uKAA2lzx4d53EKSZHHOAzlc+8cLRJJSrVPe6XSFjOF+z7M2B2C8lxq/De5/AEyreYXzHjcGIi/ihoS/lDjj0MDpaDq/sQ4JW7Jqp6xL8UouX6ET2h75lypNyX9PYwVQHVeMtIqGFg1q5zOW20vJ4al2cFIDV4BMj3kIQYln/8iz9uhZGy9QHixKYzPVbnuI/8nCoNxVHkx2jKIs5A4higLINZFcRhjec9/2ZBkYHdc0PyvWErY9FraXxF1R7GwO1mHGSuj5MW4sAgXCjBLPBhbfNSiwrIDDQurFf/7BRChQgGg1GZgdtz3Nr64WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1txSjVcy/p3GHAIj8Y5NNc0GtP4LvCGFB/xD00ID+0U=;
 b=Sg0A3RM4iayWihvshoAftq12HY8gnB3APdAsQPofA7mdBR3nVGqMjPwsSDrR8r200NWWMNw1hO0OnszL2T9nad4GBhmDNSgtZiYqGQd0KKlqF5guu+utb4HGJKMt4PGWLJnK9gLE1HGXsa+KwkJiP06MH4R1BRMoMiDv8IgkXdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Thu, 24 Oct 2024 15:55:07 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 15:55:07 +0000
Date: Thu, 24 Oct 2024 11:55:03 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH 1/1] RAS/AMD/FMPM: Fix return value check in
 setup_debugfs()
Message-ID: <20241024155503.GA965@yaz-khff2.amd.com>
References: <20241023070508.275-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023070508.275-1-thunder.leizhen@huawei.com>
X-ClientProxiedBy: BL1PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::16) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM4PR12MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 099fc5d8-4e31-4caf-6427-08dcf4443b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mzj/z8xISazv4x4vTrTHgpav6QUGsFRA37EwOfZqL5Ib7d29CDoDivGKYn5P?=
 =?us-ascii?Q?QpCE+OS91BRCrl91+eGI1wMZawZOB4QkLzGdVjPpnj7vGEIT4APSNBOF1DCU?=
 =?us-ascii?Q?D3x2NjrLL4v8j+sxbKN3fCZTBUVT3YuAQnx59wKX5l3o7F9c7sMTF4h5mBuM?=
 =?us-ascii?Q?1lnvo7EIK0lnyVkjKjlMtFb806J5GH+82jf+jLGQ7b5WIp7UxOLbdzqw13j6?=
 =?us-ascii?Q?vTwvAzNUnJ/kZ5GzcoYe8V3IkAGuiWqzlgNv4nLeuHFQFMfprvReSxhKFflf?=
 =?us-ascii?Q?/6W9AWb8o6X4R+sa6/cBNchrpgHYAd15eviH3BesQbsMfYMRZfVPeWiNEjVd?=
 =?us-ascii?Q?mOqIFo9IQALYYVMmLQLfvnrTTUgrJzXAHpIdp9WW1w0pDVhXKtZ4gIuR1AcJ?=
 =?us-ascii?Q?kSf4lxe/GxuNoTJIga6FVxICLXYLKMhMQDIVlYS3fT8mVjoLwzTZ+KhJaBsp?=
 =?us-ascii?Q?QqsFjf8STt9dErjVts2VhUdRXhwPmYQq0fht5SBNOsRR/3qRD8aoxc5Fk9hY?=
 =?us-ascii?Q?ol05aDQW64XpvfIRDr5NTmWG6bdlfi2um1/6XSL+lK2tkKdlMGN/DG0k3Fbr?=
 =?us-ascii?Q?lHESiPd5tppcHmGXr8JZbs64VeMp83Gs0CgB4aWY+jDkv2FrbSV0k4xx8oNE?=
 =?us-ascii?Q?8Y68dTWMN5wNKM+rebOhgIWoEO8BR6yWnaC/cQCWxIWOgNLqFbj9tYPnsPDh?=
 =?us-ascii?Q?ty7PlpDs73WKNJWtGnxF7frmPCeBh9RQ5cXIfiMJzOkfjoh53wHHlCZVjZ/l?=
 =?us-ascii?Q?do4t4B1SkJ0fC8hUVg2tEOz1316REtuyBfXSxwUkOGYMIK3wGPJbnvUBv5wS?=
 =?us-ascii?Q?1v5VtVaNFGukRp1MZr/Pq5J4WHhizHBqQ0yIt8Cp6/GW0G9jxfN+2mlm2hQg?=
 =?us-ascii?Q?3H3IUMAmuTr/l66rcbFYqcfP4D6L0Hp4aj4Bc3vH5vibXtvFRa/+uD/qNgGG?=
 =?us-ascii?Q?bUL25BONU3mxQrZGRy8WVSNOLZgXkG2g2uMuB/DNNNRCD8ZhtQx31BN5oj4j?=
 =?us-ascii?Q?B5hvp4UZW9WPq49PIRHDL5R7qtukshkSfX8lrrJQ9rGeMzpEo8dPHA1zBTcU?=
 =?us-ascii?Q?D/Uf/UzTbMODQ8B5SU40pBr2cJG3/wwxrLlxhn/7qOTfe6ae9GYVAAnnlJrx?=
 =?us-ascii?Q?8Lh/cP6IwGf3PcmnT4bMw0J0MiQ2iR+tqMg3//mtcOOQZg7haHdQTq1l83Zg?=
 =?us-ascii?Q?xKCo4/kpUvzALzlB4BJhRrbvGYWh6rS6A5m24cNDFZ+WOKFmQ3xzrickmhLy?=
 =?us-ascii?Q?VztQnPs3FVpCJfTr5cKN2v6h0v5PFr0ZetRF4o7ZpQYOhSQ1Y+LiyStUb/uj?=
 =?us-ascii?Q?J8E9NTiks4eG0pWhXXTAvxl+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i0eQ+TStg3270s6n1knf4eUUlvfAGm/Gn8qn8ZTcRC4d4uOHokP/GTmYjBek?=
 =?us-ascii?Q?TQLqYgNckiwhBCZ6escIFOGgk18N7gqIBYaIoaw04JrLZme3sf8M0BZdypIF?=
 =?us-ascii?Q?Iyg+pLu4djty+ICzqzM01TIKKXlphGaFypF61tO4q3pxBAx6QgHWTx5OVbPq?=
 =?us-ascii?Q?h5/NgGj6hb4kFo4hxoza0jrJwqAkNQsqT7oqK6Tvqxs8vX/Ka0i5m5ZG7DVh?=
 =?us-ascii?Q?z+iQuOjRMN+Hd+4l0GFwXGjlE/6CrJgx0gcaVzLALT+4pqkvX9j+MKVPxxWx?=
 =?us-ascii?Q?YeIlBUxHbixHr6tdvU84vJ+x5kMgMlpRIMMWFSQBpzxSO2avpKXXTw8jwk6l?=
 =?us-ascii?Q?5CtxBJ/QvO+uKkOGDXROb+KCENv05m7oo3eHFdiTsJXj1hZGldMl4l+K57uk?=
 =?us-ascii?Q?kQmYzJ/YdiZYtneQb8PEcu+9xrl4KbGK7+zO8NKZHM4HCmmiuv9CuRhl3KVK?=
 =?us-ascii?Q?6I9KojPZPAt9PJRS2ATg7UR6aGC1IBGvIENK9o5kGKIrJKX+TtWBtGRHcxT5?=
 =?us-ascii?Q?9Dxm7zhYXiMZ0MnPCZe8yhLLpA9Vfc/TO6B8/Nmh8dCP8gSQ/RoGhA3ef2R/?=
 =?us-ascii?Q?SoUS7U7O6ivP7BUk+YL/vD8yFRidQu9Q2iAC4t7ncsnXWvGvTgPSeL7HwMXc?=
 =?us-ascii?Q?+YckBRApv90TrsqmWsi8XbKqRjFrB2c+IoDHh+Y2ptm8Jvy33m5jf9iPbKzj?=
 =?us-ascii?Q?9rCBrFQv2KCpJxRdbjVHVDzcBY19As7oUGasbuNAoxq//vQpfq3yPB/qRgKP?=
 =?us-ascii?Q?mcRKBBa/P+OE5t561xPiDXMu6opQbCG7+9Q4aL1oEq8KFS+y+GlzGJKm2vvX?=
 =?us-ascii?Q?dthEdOA3tB0KVnnz04NsIHO4KQahO5EApF8Y2jIXUxQ5nbZ4x6bwvhAbq8qG?=
 =?us-ascii?Q?xBrw78+xnzlHBRlDCPXVYllI+2VlqTeZRwsQOb2d4IBs/rFF7v5MPiCFikz5?=
 =?us-ascii?Q?lLrMbR+opqLktxnGJVxy8hMiTX4HdVVzVrGj96EM4Rs91T30H5swse26Lq+1?=
 =?us-ascii?Q?XOoeEn4YYQUWfCEYD2QyA4ijPHhnRXr5eSb/kdJpIHGvNqxQD7oEwP4m2tVv?=
 =?us-ascii?Q?XLlfqqccp+MdlQKwPLOjXmV5be9bsWcEL99ORj5K0laixjCuJJQzFGCtH2sz?=
 =?us-ascii?Q?ERCyg8B08aCxKOkxIk5cXdpIE2DiY+eEp5FYdCEZJhVcVshcFqdmm15mRUjJ?=
 =?us-ascii?Q?aiD8O5wvMEe7G+UlSuiP1cuwBVvGHpLR6imLIY+hbi/ewa//8N3Bdx7Q9J+m?=
 =?us-ascii?Q?tKixUSCI4hQ3tzDh6x5b7SZvWHVi7FSEaDD4/Y4wvtVN9CcybuvN8sTBfXWy?=
 =?us-ascii?Q?1mv9+CRi8wMPBE632Heq7rb8SxyDW7lHYMe8CnFKrJfCVhHylNs/TAk8rWEi?=
 =?us-ascii?Q?mkncl4SKHLV11+KNDdfyVrEUfAJqS5MorIvcZg8I1dH2JMiemUkwaW2/pTlr?=
 =?us-ascii?Q?YeDEEL9pSW+bppnhf5lGd8aYxAeJf9IZH++qIxYa5MtUpkxNe/fCff+1nH5O?=
 =?us-ascii?Q?bw2nLXwcSUohbb7ZJfhUNE0G6H5jjk+n4IoTIxoTdU6/vdyREID7EDc1OR6M?=
 =?us-ascii?Q?/7bTlOWcohlx3D5IbjP/JI1nC2im3nVn7f7CRUD9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099fc5d8-4e31-4caf-6427-08dcf4443b41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 15:55:07.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lAINOe/0+4vRWb+1haiMOOeMW8U4CG7enakhnTqK/WiZ5tPH4CR3irOQcOTw0IirIpxKVdTAIhgy9YPtnf8Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544

Hi Zhen Lei,

Thanks for the patch.

The subject line does not need to include 1/1 for a single patch.

On Wed, Oct 23, 2024 at 03:05:08PM +0800, Zhen Lei wrote:
> Fix the incorrect return value check for debugfs_create_dir() and
> debugfs_create_file(), which returns ERR_PTR(-ERROR) instead of NULL

Yes, the return value check is incorrect. But I think the solution is
simpler. Please see the patch at the end.

> when it fails. In addition, fmpm_dfs_dir should be set to NULL after
> being reclaimed.
>

Why is this needed?

> Fixes: 7d19eea51757 ("RAS/AMD/FMPM: Add debugfs interface to print record entries")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/ras/amd/fmpm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
> index 90de737fbc90978..b1cffbde6d319ed 100644
> --- a/drivers/ras/amd/fmpm.c
> +++ b/drivers/ras/amd/fmpm.c
> @@ -956,12 +956,14 @@ static void setup_debugfs(void)
>  		return;
>  
>  	fmpm_dfs_dir = debugfs_create_dir("fmpm", dfs);
> -	if (!fmpm_dfs_dir)
> +	if (IS_ERR(fmpm_dfs_dir))
>  		return;
>  
>  	fmpm_dfs_entries = debugfs_create_file("entries", 0400, fmpm_dfs_dir, NULL, &fmpm_fops);
> -	if (!fmpm_dfs_entries)
> +	if (IS_ERR(fmpm_dfs_entries)) {
>  		debugfs_remove(fmpm_dfs_dir);
> +		fmpm_dfs_dir = NULL;
> +	}
>  }
>

I think the intention here is correct. But the solution is to just
remove the error checks entirely.

Thanks,
Yazen


From 75869583bec8eb95d062cecedc4278bead8a293a Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 24 Oct 2024 10:06:54 -0400
Subject: [PATCH] RAS/AMD/ATL: Simplify debugfs init

Drop return value checks as debugfs API says most drivers should ignore
errors. Issues between creation steps are automatically handled by the
debugfs code.

Also, add a code comment highlighting why a valid ras debugfs dentry is
needed.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/amd/fmpm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 90de737fbc90..3965963d9164 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -952,16 +952,15 @@ static void setup_debugfs(void)
 {
 	struct dentry *dfs = ras_get_debugfs_root();
 
+	/*
+	 * Ensure there's a ras debugfs directory so the fmpm files aren't populated in
+	 * the root debugfs directory.
+	 */
 	if (!dfs)
 		return;
 
 	fmpm_dfs_dir = debugfs_create_dir("fmpm", dfs);
-	if (!fmpm_dfs_dir)
-		return;
-
 	fmpm_dfs_entries = debugfs_create_file("entries", 0400, fmpm_dfs_dir, NULL, &fmpm_fops);
-	if (!fmpm_dfs_entries)
-		debugfs_remove(fmpm_dfs_dir);
 }
 
 static const struct x86_cpu_id fmpm_cpuids[] = {
-- 
2.43.0


