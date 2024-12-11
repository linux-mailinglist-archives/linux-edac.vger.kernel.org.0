Return-Path: <linux-edac+bounces-2689-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAA09ED0A8
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 17:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943CC1886F57
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2005C1D61BB;
	Wed, 11 Dec 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DEO1coIv"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEA1195FEF;
	Wed, 11 Dec 2024 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932890; cv=fail; b=dYZTHP+W/dQVIQU/xR0iM1NoH4DVvAD7I8PdsxUl0EJTwOR4o+iKHzFgDQK7ORKKxMPmJqq335p/L9NGdwYdyLd1aeKOQR3QUzVi9frrQgfuyJz3eNOAzlInjfFIFXwbUCa3YfxUBYc65kqzioz81oGAOaJXatLnXLapRU+pHaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932890; c=relaxed/simple;
	bh=i6gtp69X9HUiCRUh2FCFOnfb5ByMed50WqgrEg5QGy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C8evC8/X/ZOz0ukSH7uLEfC6TJKdZPACom7wnA5m13sOPYMHDPTn84ea0LV5/fNeuSh8FK5La1Y25R1CZv9cXX6Eq7bV2xxYKXQUBKciffGI/7sA2EwxRqE5XvvV0nL1U8TqYojDL9Ipb8VvJcWdda8DcbVcvw5zrAybXzPTMnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DEO1coIv; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQsfaiQJy1ut5TG7joPhSPPYECxgBC1Jc8dtmpTrGjtkGkM1od6GandHyJi+WWgV2gbjb1GVlMCy4rn0GcG41QeJPXfqgY2D7rUXLjtoohdP+n1K5AmZGLoDaVuYby7AebuSABiD7Vkuhmg3LoPDw3cNRmZS+m4qUVzOrNUtxbMMYgHqB251z2hRbzCmjUsznqO/fGl+Kl1vkfd1qWEG/XF/zaTTyZUTkj6MeckXdOMhKMsR83uyXS0z+HtlBLy0ENSrob2JkZxK/og42hqCIZ02r4x+7YHQhvJdqZW2IVxQHH0yE029OWRbFAvdZ+HgONZywNFrrjvrzjtDkv6cuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysZykdVgra2q/E415WTA4cAhHOvL+b2vz3Ai3Pt4utw=;
 b=sPnC+S4UBIY8MvETfc/v1cCIacMAKxMOz9vhkmEAbYCz/S967CpISIADOsPg6HkUYal3RPJzI+waZcGMo3FBjyWkAUppB4WcCpa4irU4Fcs1hcGsyQCPlRIcwYZz+IDggOeQgZrYzNKTNtEiy5YO0jCzI7iEURLt89cUZp126v7MIHroo4lHwwJb3fIZgXaQKdKAgBwXFXUTBqDmryGbfj1jrq+0l1MN55W7+3wub8XR6r/H/N5RkW6O2NBc+RTGwf3NzguJ2XPlPf9wb8ij3lbL5CRE9GbpdikRKlxOW8g5hrergmfkMRWww/UWZRDiDkvSPqQKo2VqRbYJwoclNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysZykdVgra2q/E415WTA4cAhHOvL+b2vz3Ai3Pt4utw=;
 b=DEO1coIviQqxEFRb4ZYzNVJMWl8wmTaEP48k/5RnpLwIuiCzOCNyk0SGwDh5q6aOQINV49zp7zV4NSk/veB3IwbxeO+P8pwkCUSujxovSSyEqvuBOlLv2CgQ8oPH7my5JCYx1DDYqIDhaeUiohOwEsW7TdFiM+gRaRXW2BXqwsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.23; Wed, 11 Dec 2024 16:01:23 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 16:01:23 +0000
Date: Wed, 11 Dec 2024 11:01:13 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Karan Sanghavi <karansanghvi98@gmail.com>, bp@alien8.de
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
Message-ID: <20241211160113.GB1923270@yaz-khff2.amd.com>
References: <20241127-coverity1593397signextension-v3-1-60dd0c4287ff@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127-coverity1593397signextension-v3-1-60dd0c4287ff@gmail.com>
X-ClientProxiedBy: BL1PR13CA0406.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::21) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c27af30-1ea6-4f1b-5a8a-08dd19fd0f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?khkUdrgnGMwkDNQI4YT+p7asCv4Df3f1LXQnu9CeWphHIGwaUGlkgWIjdl2T?=
 =?us-ascii?Q?VjTWceNUzzU2bY4vByMIWRvRECReIgu0d81JXZSA0yBawCdETd3tXXpAEXPy?=
 =?us-ascii?Q?LC81UIzKaIzWRGmbxVksTkKJjyMgK26EKT/zgCtXbDMBegUA+o+YrDcqGlqU?=
 =?us-ascii?Q?Gt4dj9o80abbBilfh8of1mAKE+W9PKOkuvXPFoKnQAKsDy8KkEE9Pnlgo9ui?=
 =?us-ascii?Q?r3UjAS8Jx3dagA/nRa0OH0slb6GH9qQMqItmlNlpakr2ClS5AMpW/BmejONV?=
 =?us-ascii?Q?M8Z/kB+uoS0isKDWyvDME4y9XzobRjwms9RDVuZ5mkDU+tvd6aBzmd5q00Bc?=
 =?us-ascii?Q?VufoA654Ip46DPRM2FZzOPFfn8wHBNi2IGBWRTYy1sof58vCAqQoh/1f/J2b?=
 =?us-ascii?Q?vTxQ8s3DrQNQ81rgCLCJlinRaIUW7q6Fc9ViP8z99nbkxRZ3kasvFKVlCwXQ?=
 =?us-ascii?Q?xGDZGsxt3ZZshgJIsjYLyYvrCxY/MQLaP/0cYA0cm1Tw0o8KEn2nxKVx+ZP3?=
 =?us-ascii?Q?K3dNi0H5kdgCjz7RE/2eqHN7Z85xeCe2RSHcPFVSB/R8l1FwNEH9e6bh5Wng?=
 =?us-ascii?Q?ZOfYHeXSHyj800PGkF28OVYlwNW9jzR9P5Cz01N1sLTlGHROaO5Ss8aCd8iU?=
 =?us-ascii?Q?uTJVNaMA5YumvFu2BJ7nSGbYz/rqzEyitib2tbaRy9tB6lpu6+TpU21Lw4Kf?=
 =?us-ascii?Q?CiIoFz0sb3obeG0vEr1OnubweXBDcCoT0KttZt5Z07pg7cVLmMwlfdnSAbg3?=
 =?us-ascii?Q?VAb318GWrMhBTRXvh5DyEWDIcCjcnfvwbGtXXm6N/0aA1zgCLG0ciXyeEVmJ?=
 =?us-ascii?Q?ml6AZ3tWcELd/vmNOu+EBOX360hS0cU4TXX9UWiCJs2YWKx6ItWU7QHwDin4?=
 =?us-ascii?Q?9P84qI01JtN2W5wv0K6qWnmMtnzl+Kkh7zfeoKB18jwrmcb5jPudN/1B1x/X?=
 =?us-ascii?Q?jUODbjYxsbVkIV1a9kyMlK/UOd/XmGKeXNqGN9LgQ5DL0x0nXdobqjV6PlVZ?=
 =?us-ascii?Q?CiJGyrKpc74uQkjYi/gCTy+AosrvMLqyasU/IL5JYXNR2iMt59EyY1UaYQFg?=
 =?us-ascii?Q?/9CBjNJlvvFM4wHTgqtyF1Oma2PF14EQOhdpFJyP2H8udIJR37fHiN4H+o9x?=
 =?us-ascii?Q?iAwWwzbvxHjRiu6K5wyIzCA33TvPgcng14HXZoP8TvvAImscUcsPrQzE41oz?=
 =?us-ascii?Q?5n3IcZFBKH7N7ztyAxWKikCt5bmzqtfODkPl+qnSf0PqTqP7hzHye1JU3uaU?=
 =?us-ascii?Q?n8j4yxJCfu2UjgTZdPB22a1C4yncuK5NYFkisFdf817zsLsNDmy/qTGFz1Pp?=
 =?us-ascii?Q?DXw29iPpBPQfLOjPCN3rAgFl4b8pw4nXJsDddRycqlvu3VUJKiiR5/jO9YTE?=
 =?us-ascii?Q?UNf1tgs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aa/uqgM2uPumKFqpqSCiwFE173ho05j4bJe8Zf+cO96L9diYJMj+JnTNdqtL?=
 =?us-ascii?Q?LhRA85Su7ipbUavSq/VIekWEdaLtV0E9h0LgliDFkEO/23LzWDQH2/8KNHyw?=
 =?us-ascii?Q?Kv1hwBf55IPbS+y2EH4s8IusZbLbdncMG+xOt9xJyy4cNepX6cvToxq5kQ7U?=
 =?us-ascii?Q?73zH6H+0adxR6pvmtQIwziGlCFmyt/6hOcT6eNvOlU/SdPOR9RsBggCXMB+0?=
 =?us-ascii?Q?pqJGBEbAxwWWtCELqlUCBFIPPEOVf0/W+JJmSkbOaDAOMuQ+bKtpE9ipQLOV?=
 =?us-ascii?Q?OrQJslVItlR5Gk6LRY3WhWNY6OJW44JxUDJOOOe/tMAVSJJPtwjVGVcrHncQ?=
 =?us-ascii?Q?rbXiyQKF1SR0Y/ATiuVnJi/dZmBAUJk5U6ZYHD3ZNL8MAXLshjAZy2v9ypVU?=
 =?us-ascii?Q?K5fgsJYCQBMIJrycYLTWKuuhRPzkT238D9eW2TCFg0RbEk9JsTyPz4WsA/7w?=
 =?us-ascii?Q?DLsnjbx+6fFJGlU/Am/SK2wpXJjBD4yNAFTSLtPhjcwTwICkFjgAHtmpkNQ4?=
 =?us-ascii?Q?hYcLXlZvrPXBGetgLXyRC6U5F8+MZgWQMzVQTivsVSXaw1i+ATQH3Jt5TcyN?=
 =?us-ascii?Q?r8PtHLpLpVkXrRKSlrjm1eadZN4koYmpa3uAku+vHSkxTRkiky8iUsMhs83H?=
 =?us-ascii?Q?JdpNX8gCYT89Wx6HF9Ghi9F4ockHVqZLJkE2j0IDLr1aP7fva4VuwF2sUaX1?=
 =?us-ascii?Q?Ni6wiowg3Zojok+xMG8rZlm0b8crq9oL8OAaXaqk59Z/WGJ8KxwxJ+FI+qz1?=
 =?us-ascii?Q?m1blA5YgUoHoiRxLzffgi+S1Xfn77+Ie+ivj7MtYnvpolzqcnSNQrYU46CZg?=
 =?us-ascii?Q?3PrcFOyuFp+Yn4ERGoITNe/0S+NzPfRSIn6MPm3quAR18e5ScbeV3huzb4+3?=
 =?us-ascii?Q?vLJODnBTfgd9Gq7piGpL6spDf0DxYGTVN01qE/C8RurN3FB/fh2lqQOBxy0y?=
 =?us-ascii?Q?7MQhN/uYQAORGsOoTPOJuEOb5D1P/3dcPOTo1Mejg2JsdksLIUoJ4srew6oI?=
 =?us-ascii?Q?2pnYlK/lP2NyqZcDMxDckPRE9MCaacFki/rBEXLvZhomzchSdRWgQ7P7TYxu?=
 =?us-ascii?Q?i/9a8hWOP/24Xr8rKoGydD1rhZ+AhqfLsXsszxo2jCz29tT0LdN0R5SmSOcg?=
 =?us-ascii?Q?mkRyqby8bvqsPpHpgvdTuZmOqfMd+b2Z8ihBjY8dA8t/ToZNDBCXPxIqfEn4?=
 =?us-ascii?Q?TlThSVR/unOV+4+pwd9b9o96neThx7xvt8ro6JWIaLQsXlpKCUbtC6XJ2qZi?=
 =?us-ascii?Q?rMjUTDPjWx2C5uPANLQg5Vc6ND0G7koYjq3pK/tyAws6IwUK+DbWdryVNT8P?=
 =?us-ascii?Q?vfdi5Kb/y0UXzF5D+7MJUQ05DkQFWn+NchX98ZEXZU91UA2rNrPMufOvZMuD?=
 =?us-ascii?Q?g52hgdnHCmsB/TpJAv0nyYzv2jlRqt1NRPe635Efxr7NfuLhki90sHpUvjJk?=
 =?us-ascii?Q?u8fezeMlLqM+tPt56pvzJe4BiZkAWB6i9DAdtCOPpuapWmeZ6vsHeTCDr3s/?=
 =?us-ascii?Q?GCRqJrgwqMvYdwVEJTzuoDLdv8Ryp40WLA4r61d0pkGYY7U7XImz6ZbOxy77?=
 =?us-ascii?Q?zciZKtrDGFQ8yXbCvxTq9G9TOAIJ3GLXfc4NxQ6x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c27af30-1ea6-4f1b-5a8a-08dd19fd0f28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:01:23.0704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TROts5Xuxjj2SY0OYsgqKfPS5i+y06ZJyajNtdzQCeX3/xy78VDjuczwZhop2hbxz57AFuh20ASx6wWgK0ouSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654

On Wed, Nov 27, 2024 at 06:23:48PM +0000, Karan Sanghavi wrote:
> This error is reported by coverity scan stating as
> 
> CID 1593397: (#1 of 1): Unintended sign extension (SIGN_EXTENSION)
> sign_extension: Suspicious implicit sign extension: pc
> with type u16 (16 bits, unsigned) is promoted in
> pc << bit_shifts.pc to type int (32 bits, signed),
> then sign-extended to type unsigned long (64 bits, unsigned).
> If pc << bit_shifts.pc is greater than 0x7FFFFFFF,
> the upper bits of the result will all be 1.
> 
> Use u32 for bitwise operations to prevent unintentional
> sign extension by assigning the u16 value to a u32
> variable before performing the bitwise operation to
> avoid unintended sign extension and maintain
> consistency with the existing code style.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>

Thanks Karan.

One minor nit: the Reviewed-by tag should go after the Signed-off-by.
This is noted in the "tip tree handbook":
https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#ordering-of-commit-tags

The EDAC and RAS subsystems generally follow the "TIP" group guidelines,
in my understanding.

I see you're using "b4", so you may want to adjust the "trailer-order"
config option. I've been trying out b4 myself, so this is fresh in my
mind.
https://b4.docs.kernel.org/en/latest/config.html

Boris, can you please take this patch if no objections?

Thanks,
Yazen

