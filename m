Return-Path: <linux-edac+bounces-5768-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDs6A4x3qGnpugAAu9opvQ
	(envelope-from <linux-edac+bounces-5768-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Wed, 04 Mar 2026 19:18:52 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8E5206280
	for <lists+linux-edac@lfdr.de>; Wed, 04 Mar 2026 19:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E1E530B1871
	for <lists+linux-edac@lfdr.de>; Wed,  4 Mar 2026 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D7C3D5657;
	Wed,  4 Mar 2026 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hkGIEC6w"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44A37EFEA;
	Wed,  4 Mar 2026 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647352; cv=fail; b=uxIIRsJu4iDAC0g2M7RuWlwMVyo4RajN9kAxrs8S7QgGMrZ3wDmUjoZR3M3rlT1V7RJltqCsvZVm9ZSv14B2NoYQLfVrteOeWEhcaMzLDNpRGT7nMDp/91lJIUndZIHE5sSR4IVssA8PXkxESM9oVE0yuTMnKyqvK2KDCX8bVRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647352; c=relaxed/simple;
	bh=ouDYp/0raYu/DEh1gFGC98apIoJ9dH+HoRxrqqmo2nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pah/VJndPiTNgXVE2Yeb+1Y0g28qIntgqB82GTMdi26bBr0cSCRMDQQgRJJN6Wm+OPJNM9lTZjSdtVZYPeHtW+5msJ5f0DTTSiAP8BUx5Uz4pnrUIHtw+8HF4dUbv/8Typu1Q0zmfaFZ/lLrmSLIOatyxr2eTfR8x1JtyFQ2hzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hkGIEC6w; arc=fail smtp.client-ip=40.93.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/gueDGNNin/yLsniwZYBL6yMAozbYF5HSKs3vb9vLiXn/YY5g56q/LVTI8zg1+Ng0QzAPBsuX30lIY3oRGbJIKiNzGtFLwxlkVCJirjfFuWBLuQj7ty5Mf9Ggl+BZ6GrGjGv2hjrZsWb8Z2QOkuSDWGHmPzIN/ZBMcvCqdvW8PhxRw7UUs3lbRRW7FWtGZSbZGt3kMB9LHNZ6RKnxXsjACiOhX3MrmOCYPfG9BWrX3TznLDTeWqlCTGsf6JrUbe71j7yA/+NQ/2Nv7Y6bDpszhfmwut2To05Ff5wK1EfVst5mP8Kr2JcruEyEdN/M+YfPHKegrglLWGd13omIvDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRJdPvXpBzdpkb/DIzZVvBGQ2XmMhb9LK1fq+f4irjM=;
 b=O1e+7pqfOr9LqYAKOC9BSSHvbA5GCtVO/m0RnlcG0IH7sHVOiCOs93s9zbxrDv8D27GNAPu2XDna9z4ZU8Dma1R1RMSlm2qA+z/PItjT5jtFHskJqed1Bpa1e/eQEZ4eiCHTUcAZTrYsMol523aoM74/cEddwdxjKo3MpHgKHfaCwDmnjzRjQiFJxKf+n78g8SZ3u0R88Z1sNOSyvLZ5/nVOpAPyaftEoVwg2du10++5PpwvAkXtWU4mgxQVNWFtrcnG4CGc6U4DnracX9xMqSrAilBrrVDPEWYQR8Pl42SLlZ3neam9LCQJdBqe/glXmd5dRQZDCWDchInrvihFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRJdPvXpBzdpkb/DIzZVvBGQ2XmMhb9LK1fq+f4irjM=;
 b=hkGIEC6wYxBmQAPrkuaYyJlIYpxRtCrS6KyfhuTajDTW1F/fNq/iSUMgdUVN1TW3Uj+iuzzuGcf9Kh6nPjflVRc48em+hLWhf0ib2mqTM2T1KXXX48Aa3maI54p/PA//GcJzgvoa72f3iJCaoOPYTK8jH55mI957878vKFql590=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Wed, 4 Mar 2026 18:02:29 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 18:02:29 +0000
Date: Wed, 4 Mar 2026 13:02:20 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/mce/amd, EDAC/mce_amd: Add new SMCA bank types
Message-ID: <20260304180220.GA980523@yaz-khff2.amd.com>
References: <20260202172158.2455749-1-yazen.ghannam@amd.com>
 <20260228150447.GCaaMED_7sbC3OvDsL@fat_crate.local>
 <20260302142255.GA145106@yaz-khff2.amd.com>
 <20260303153814.GAaacAZrUnFNBhPq1K@fat_crate.local>
 <20260304150402.GA807247@yaz-khff2.amd.com>
 <20260304163953.GAaahgWQIZ5QuxLDP5@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304163953.GAaahgWQIZ5QuxLDP5@fat_crate.local>
X-ClientProxiedBy: SA1P222CA0092.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::12) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: c042ee4e-b851-4012-b528-08de7a18331a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	YKANCm1h+IPEjdCwnLaqzMBGsdWO+IEhpq3GxUS9l771Q+auat8GLqxowCLkZ0nHDYhMUrpT6g+ztBMBXXYFcpKf7ZpxXb+jQpO1Oa/WbOJzOgRKGdRqpTIqij+LFxeJaQxfOUxukaRtXl19c0xoPaon2jAdlEMY1PLlYIYStkBcSkin4XECyDge222cWJO9vx5SZXnmRfvHjY3UjmxLFg1xwklmA8PG/w1EpHJwn2DOuY+XFBNuMiNoblifIMCWi51okjgEJyrAaSJ/YDCAE232wArXj/eENz4E71TfyhOWVrWJ6s+ppVBJUqTI47BxzP44Y4rYolq5YePcaHFcd98ABnPXKvfpF4JUdfxPQijsm7JpsiEdqyBtVdalEh665rzyVo3/EdV7MFyUu94tQIPRDqCd4XJQ60TFlPaYV8OlV56xN4+KM5/9wQ7PYPNgFBdndV5TSn1mosGEf3qbBKD5Wd6qkb5whXScbonuaNEYJL1fCVoPX8XJx+L5ZlOiPn4Azs4pBCTXU7oIbRHdK5sB+t1qv+1JcVkcWDcNJtLZfKqrc+nsYLRx/EeLYC6YkWYFhHz4c6ePfaOsBka9vX+dfAGmqwmGAVPnFC/fRGUYbUCHEM3Fp6rNyLdu3f3xgCzayOSJd9iYLBh1v0EvbirjlP8Hv6fdVACYfQhCBau+/7mtKrK5mkPrtokSDaZYowGTc+/KPtYhsu+GvDVgCE9ZH/H6FvbqRm8tP2DqlMk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lIOFVjAs9k2TJGIizFiZEOhOAAxTvkEdqp7M0TVPXdH68u+JqG003T0nRuqs?=
 =?us-ascii?Q?AcT7B3qLDgqNn4tk31b44e+3I0D2Bbu5IyyuNhqAWuOXxfRwO0DdSkEcJGsd?=
 =?us-ascii?Q?TbTv+ygoyY8LeQ76QGMXPIgj7pz0m784urnz7EcV3+u33sbHUpYv9eyCap/d?=
 =?us-ascii?Q?+1bj3eXjbci+GIeE122exnNLD9eiToQHPCkNzqfc5PMg53qtIgfKa5yF2FyC?=
 =?us-ascii?Q?A25GpTh9VI9d0ex9gjHPUoHkQV7WxHHrh1GY2vcG8X3+H9a6X7P4RpWlxxhY?=
 =?us-ascii?Q?xRVN0PlfVT8LmPD0VTIDUW3MJMp0tCTAwaFzgnkr4jpllE+kwSErfCfvtSc4?=
 =?us-ascii?Q?qyJ3WWese214o8JxZmKqULJ4h6FAlnGkj8B+EYjoFvuQCt0g1x1jI5F72vBh?=
 =?us-ascii?Q?RnM94EoqVyWcF+Du3vu5ZF4LP5o/E7MBZCLm03KOSUwwnRiUosJEeJrrdxnb?=
 =?us-ascii?Q?kVtIwkeqf5tQtNYw4GpTyXuHtqgjSF77ZNh/RHg6hMP05doP6jfqgzXu0oKe?=
 =?us-ascii?Q?dQw/QBcmUXT7cMv4dww1bJNqgkFzMheZ6yQcIpWIzzBLEPP7aUpowjozr8NJ?=
 =?us-ascii?Q?dac07Ve4CCkzaw7odem+ghFnyBPRWU4kQ1mGtYc28fevRMQdtekse7NUj7+4?=
 =?us-ascii?Q?TUU0oHuUMrIRyKteSaZ3zONfhLYN2orALbrYAgx1lHTXRJfDlzC4LQyFu0jE?=
 =?us-ascii?Q?kdQc+orvhofk0lecQd8jDylK1IkIhr1yIPs+Yo/xFol1FLBorPwI1ICYJK9l?=
 =?us-ascii?Q?ACqLkoHko/kdHEn/RBgRUCZyDFmmVmGaWBH5LodIRjw2/piyNJ9D4n9nGE7h?=
 =?us-ascii?Q?L/Ee9a+Tr6hrq/rwIKyYNBiefLnIGlncfy+oLRvaHaSikQHruk+SJYFldQne?=
 =?us-ascii?Q?jlHNUV4wD+Uw0OyNGHMW0z/OYJNmVZ23uWWBPWCi9ST4xQ+mbNvInk5K7xFi?=
 =?us-ascii?Q?pqWAo6iXpe45LP/BAhnuggka9SjXZTOoZVDnMoqpu6xqeFTs8cXlAHs9qFzd?=
 =?us-ascii?Q?T18YC2P3FP21mmbv/oPBXzRQe5fJtaM0Ku2Y0xxXc3a6LDly2IXGYA2dWxFd?=
 =?us-ascii?Q?8VZraEQXqdYFHxfu/4/6mgk67WCIoiY6VsF/G+JJZsI+JdEg7trcjyQrOvUd?=
 =?us-ascii?Q?roY7OY25/vXe845JduM8nzJGMuOyNOXMGfturNCl1DIkg0hC645TlP/LEY79?=
 =?us-ascii?Q?yADuBi7Yj9hf0TQlEmXivVrimZyx7EpwVDm54M8jFG9ErcUMbh23xSPK1rJv?=
 =?us-ascii?Q?f9UPxHFk+mISgD3d5zlDeYOVxVpnppPM349cXcPKI8oj3uNP1x+OZuneHhFS?=
 =?us-ascii?Q?/v+boXUpvbAMsZfNLQdQcoEV2hM7phusv8nzK5EGcebI5gb14w/muT7q2smu?=
 =?us-ascii?Q?RFmkUA/iaevZxre21RJPJCNegfpQYHggVeDxXRg3uH8Pku7GyPqNlLtnokN5?=
 =?us-ascii?Q?palOG/zPyL/RLRSniR4HTFB58ugfEL8Obv1x2BjvsAUgSTH6rYyjmZ/RWWPs?=
 =?us-ascii?Q?MbC6rwwtwog0vHW8FymWEwFDTcVR/b7Q8XlpOd6rCdLZ4+UXdWs6LAzfOFd/?=
 =?us-ascii?Q?gR02rEhIfR6pFINJRFhNhTYTdIeNc8vYmZBx6FSPEHSzIjc6RAMBYPBzKgae?=
 =?us-ascii?Q?AzfDp1vwzKhIZUMeAuGkWc3VBpfd8udozBUriNNMfdixq1m1oYnNoVVRwRIr?=
 =?us-ascii?Q?lVdX8gZ5eITdo+Y6riehpL/xqcZ786ID/ZF4wQcoER87gElB/DUzrcEo/Jxc?=
 =?us-ascii?Q?AuQ1e8T4pQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c042ee4e-b851-4012-b528-08de7a18331a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 18:02:28.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzPjY1C1SWWIwOh2qi7HqOj8G0mbIyx3U3T9gPg1jnUoj/awzZR4JPkuR47Z2ze+VXhb8MlzCG3UIC8yiA5wgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Rspamd-Queue-Id: EE8E5206280
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5768-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yaz-khff2.amd.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:dkim]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 05:39:53PM +0100, Borislav Petkov wrote:
> On Wed, Mar 04, 2026 at 10:04:02AM -0500, Yazen Ghannam wrote:
> > We can re-sort them. Still want to have them alphabetically?
> 
> I'm not sure how yet - all I'm trying to say is that random order is kinda
> suboptimal when having to look at the code.
> 
> Alphabetically probably sounds ok because you have 0xb0 ones, for example,
> which belong to different banks which makes me think that the hwid in
> HWID_MCATYPE(hwid, mcatype) is perhaps arbitrary and not very important. 

The HWID and McaType are defined in the hardware. The name/enum is
arbitrary, and we use those for convenience.

Some of the HWID represent a group of IP, e.g. 0xb0 is (so far) used for
Core banks, 0x2e for Fabric, etc.

So far we haven't needed to use HWID on its own. Though I had a patch to
check for a "memory controller" type by HWID=0x96.

https://lore.kernel.org/all/20231118193248.1296798-6-yazen.ghannam@amd.com/

Though maybe you mean "sorting based on HWID/McaType" is not important?
I agree.

> 
> And perhaps we can work better with alphabetically sorted IP names...
> 
> Rite?
> 
> > I can re-sort in a pre-patch before adding the new ones.
> 
> Yeah, makes sense.
> 

Okay, I'll work on it.

Thanks,
Yazen

