Return-Path: <linux-edac+bounces-4824-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 767BAB819EB
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 21:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DC87B7442
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 19:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676E303A21;
	Wed, 17 Sep 2025 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rvpnGRSj"
X-Original-To: linux-edac@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D22FB968;
	Wed, 17 Sep 2025 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137239; cv=fail; b=qjlt71ju1BKICrxT65noHllXQsTIGsek+7WaBTuNM0/de7UqKEa/Sdk6tx1wx8nL/2+9EcdThEXfD0xHdH5Bw+jXwugJSp0va3O3isctohprWACLIOcj0ZfKx+RKnaujvd16xAzSdy44D12CVeYrlPC5tRC1EAoyfUQW4SDfMR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137239; c=relaxed/simple;
	bh=IYsgGaEuX/w2IKqnCORVTBPkvs54mqt8ZX34ZpbZ6Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uR48NWA0OSa/x/+w3502c+swe/juhz8DKQC1CIFzHEN7P5fL3wZTuG2TyJf0m4esnmFPudnYe/UhcmzHAT6I6bPN3iqCLWfMh0pKxpvY6D+NcbMQvkW4RbVdFiam7EK5LOv9U0MDI/mI/JUGkGiao+d0nGJQ4FiikIn4i22fQcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rvpnGRSj; arc=fail smtp.client-ip=52.101.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juzfbCX6l/QTllufNg8X+mkkBhRK8M6Ez7bUZogmNS2u+AEtRVof+m+rtMZeeDOJgGj+iD+2o8Yqlfb2fzZibocy3VZDy/TecTWf72Igr2N8DPoR93jEsxJb6kynUPQx6QzjXFoCfCHm2LFfE+Z5li7Z8CZfhter3sBicCN0/br5MeHpdOC0BHCgSrJq6IXb2luu/x8zKHCsRcsxKwRyqUhQ7Z143JRLGY7acEw1n/O5KThfZiWbM3LQyTBlXmo+iT4Cc8NA4agSLhC7A+8fJhp3EgaIIWQPyQe7/lyjjlsJJ5jGmL88Q0Akx/sc4RTrQK1UCxRskkxTsFrTFu9Y9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waPqOiWXqRUf6WPQTqJ5b41f5QHMc5cA9vF5Lv5/UqE=;
 b=ZnSQuTSU3veDb5YrBi7IESwECXs3p4msbhKtuZHUqSjKRVgh+lhxxfmnejN6UjQG53cZJgHRLP/fffU2bGEdR81dn0Vj0WIaZFfSsIg/vsC/zP0AIZtiJ1DQe5a7Xjg5HIOqYG+HLfUPls72qKOFi8i7YOvVlEvei7r6u4KqZFVp0vjofwGvdQhbRrYJalsQ1MwHTyUvD4TYYeNsNVohBkqosFMHtMjwfmjnslTMPrioBHKw3hNkQdsgIAEKMQezijg7FKF+4MHSh4ZwtF3ZvTLHxJCLQMWtYoLQJQ0iYBkCPO7Uy+XUOiGSwXzGhNHaBVdd3rjQyP+30KSWE9rt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waPqOiWXqRUf6WPQTqJ5b41f5QHMc5cA9vF5Lv5/UqE=;
 b=rvpnGRSj3VgvpNmithHhLPKXwL24NtplWCniZAegHMtFJ26qGeeeUhBhrrjsvRQIFQ1eqyBswCrLuFUBm6vxWGlfSO6/A7ASa7J7E1BS0bvWOwZAQLyk+IjzWTjTaoH5ieNE3Fe4QjxdwokaNmzeKyUq7vAea9ufmTUosXwNpCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 19:27:13 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 19:27:13 +0000
Date: Wed, 17 Sep 2025 15:26:52 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	x86@kernel.org, rafael@kernel.org, qiuxu.zhuo@intel.com,
	nik.borisov@suse.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: spurious mce Hardware Error messages in next-20250912
Message-ID: <20250917192652.GA1610597@yaz-khff2.amd.com>
References: <20250915010010.3547-1-spasswolf@web.de>
 <20250915175531.GB869676@yaz-khff2.amd.com>
 <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
 <426097525d5f9e88a3f7e96ce93f24ca27459f90.camel@web.de>
 <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
 <20250916140744.GA1054485@yaz-khff2.amd.com>
 <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
 <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
 <20250917144148.GA1313380@yaz-khff2.amd.com>
 <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
X-ClientProxiedBy: BN8PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:408:60::32) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 5811f62c-955a-447f-ac1d-08ddf62033f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iqy7UWLRJUjt+4lp8TbF8BqCisLSDA9oHAEtMYVnTTRH0C8Yui3izh23GkLb?=
 =?us-ascii?Q?ySyI5E9baq27odZvgnMTkZtoWB2owRaPGhYIqyh4cDp8cvBvKghbmC66LQ2U?=
 =?us-ascii?Q?39gu+pqJXH3LpfDQXH9dOYg3bI6+TsXpVldFIgDkwAvfRlBc0X8GBzReVWV1?=
 =?us-ascii?Q?VdHGU0YxCz4bkFYCjeCnYi/UMCVKWc+Tw5puoseFI7OML5HIaqzn+7MqTC18?=
 =?us-ascii?Q?YOpj2CY4o8KVhc2qPu/mjXFdh2lGosSwsAwqbFKaJDYGE3Gv6yOFWUTUfmqN?=
 =?us-ascii?Q?XP711AwIFZYJ6RlDwtx/eTUhbwL7TyH0RAVRA6LQfZnNLL2cK5QlMyBfBm+K?=
 =?us-ascii?Q?G3DRv4iN1lwUdF9XbZmaB4qSTNK4/UqTkB3idlCLHXItl2e57DfarSgP/zPb?=
 =?us-ascii?Q?dU2MHtz7myI+5Yhg2vUqZuUNuMs1LRrJOyLklwNvmaT8/nNYXEssfAvPv+hs?=
 =?us-ascii?Q?BtabtHHp6zO1ahnRTw6xrCuNgqim8JT5oul3TwkdNEoppyGAb6FMrwQR2pj7?=
 =?us-ascii?Q?7IevCCPelbU83IhylnnjwjS9ZxezE8xOMtahHPpvqf9isMilMfz4c/Q4De5w?=
 =?us-ascii?Q?D4T6ZxVtuVkZvqQ+poL+gwtG8/6/4GtW5DkNcUyN6BYuIIL8A1MZzQn/3Mnu?=
 =?us-ascii?Q?pFzCUxjhVFkja+dr/tojQdRJVnUWG/f0jBRAVyz2w245RscCuW9kuC7IYbK4?=
 =?us-ascii?Q?pPx0giKME8PDXBJqYvzOlt2jepLDDCdpkf8QTUn45+85e4q4mTdNq8gewZe8?=
 =?us-ascii?Q?VAxYpxQryzLm0y1ioskTazo6GVm20z4SabsG1oa+b2sYGeMKh2dzipd7ngEM?=
 =?us-ascii?Q?lsyN52zqjcr3PMKL14DNxaTUq+jF6HxrsxrZrNXr7oNWHr9QbsckLvjms17p?=
 =?us-ascii?Q?Q+9OEKxliSXBr+ktdsNUjQmEAVM8LpaZgzVpyotFsnPkRLZS0c280d1EJmSB?=
 =?us-ascii?Q?zJcB1cFDbCopYUHs9osY4Qra9zl/fN6txQLNXoFCCZy+oAYSIFrgPq8fyxYC?=
 =?us-ascii?Q?kly4ChrVRTBCLgMdSvvAwKku6EkYwR/G0tlp4SBwWJEBcbTKZUPwcD1xjFxb?=
 =?us-ascii?Q?Yns0nYWuKag4qzUbBC65OVLPImDGWiz5FlwL7op9tC2Mb4AJN0pAqhaEDwuj?=
 =?us-ascii?Q?evYfthubVd5Nj6sguyCC4dbhMDEnu3+W4aL+vUDSbwGMto20t6zbJN0tCDvZ?=
 =?us-ascii?Q?pvi1HPMrHfgvaZXbA8jft15eGTHcCs2QrtPyUdsVSD9rw45YL99ZzgfkLA09?=
 =?us-ascii?Q?Ued84miH0QvDtm9Nkcv7M6CIs2NgKF/dZWOIOyEQ1JgMAvG9A3A81ZETMIVU?=
 =?us-ascii?Q?1oqI/k5emV5KLYef3VOpvVxLoEZcXqISKxgRl6+EHQOYF9sMTIZA9+HJv+Ta?=
 =?us-ascii?Q?yMDU5qlqoBveyDGV+1JkgTDLCRfYUocIelpLSFHF8VyomfhBMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lWaC4H7n+8UuFDxD2VWQhIUmub2UQ2/480xQ9AZcdrz1ZFRRT0mIlnr4bYxf?=
 =?us-ascii?Q?8n3clKCF5Zbxm+iGvaDElLAd0s2KQuNRYsQKnGLuyQP8bkLxb9r5LXitKh1r?=
 =?us-ascii?Q?/9HwkkVh23cbcnbzw4dH+Ij9XnetNuDrJbDuUnADoi7721aEsJwFU9TBe66T?=
 =?us-ascii?Q?UzXYGSuOQfFKyJEvTkIlC1/r5QepcQfCWHASsOByeFBZbjle/rGmbRZsaexT?=
 =?us-ascii?Q?vqrVDKClhYqCCsUGUsyrCxAQsn2C51+E2c0t9kxndRrF63JzCbDoTkTCj5aq?=
 =?us-ascii?Q?avgSeGW4msgBedX7hiFzTsMfC2vx3R/wEPpKu0OODqLadhVTjKSbmsop1dem?=
 =?us-ascii?Q?CacAXokoq5hJg61SlSe/hCaYDUzlzLPXCO0Si3G9XM8WZpyUIv7Ju3SKWmvn?=
 =?us-ascii?Q?qST3pOyAsPZH2qJh/7J4v6c7RE+rbrr5+MRpXPE782xQakFFItCBH8dbPw+p?=
 =?us-ascii?Q?auCyfL+kOXiVovngPn4VkL1P8Dl2m4Z8G6QBX4PoAYZW9gAEw/LRu42wH/uJ?=
 =?us-ascii?Q?c4k1kK9Hj96DytV1Fs2WkuZyEOcRHZFO/VXZlWOoPu2h5LvdN6zmJqGbch+M?=
 =?us-ascii?Q?KmcJnwt/1yAMwQoNdsUaAnTjPyXwmrNsVUHEvnBOPFvv9IXoS/sRpqR4u+k8?=
 =?us-ascii?Q?Q7Pv7VGYvo2oBbk20C58xn7OZEJs3cznVVQI50NgkWWLyaePN511hS0k7zWl?=
 =?us-ascii?Q?9H4GUtk0pu6Mq10u1pD3NEBtb7zWlIR4dJk35FSpC3oQAklKs6uRRz2NjSkX?=
 =?us-ascii?Q?2sIo/zT4EUIdwCysU6GkTjQQbpH20NuF6MTja5LM8BJz1BeKg/VteaF1EUsP?=
 =?us-ascii?Q?/IzZdi0boiOXAFCCIh2P/OfVUAgbuBCzmvgKde+C7hWmmR2pyS3JLd3ajfhY?=
 =?us-ascii?Q?VwM3Yvz3toclzxaBof2DGHTTd8NdppUZ+kVG23yIpjWTYyTgMyVdLI99thAh?=
 =?us-ascii?Q?RjME+I2hAE8jLDy2VKm0p95EU6ptjBpqFEdP9Jj89m9X4og6LT0fq68oorK+?=
 =?us-ascii?Q?UR1CBPauVHbFQZDtTVJsR7gRDzaKDjRqePlrJnhe38+yBE2xJMtDhVn6C/hG?=
 =?us-ascii?Q?pUdXnkPNZhH7LRhFT185Tmm9QaNLZB4CnU12cm666slP4QKxmrURZHgXE9BY?=
 =?us-ascii?Q?fSHo0zgg6r4GPPToIZ+SU0jLdh+GpljUETgsPFcgz1VFlcgYFo8Rxbp97MlH?=
 =?us-ascii?Q?N8g85NcXCe9nuwMxna1vz1MKKNTsSL9Vl/m1OJLLhszOOPbbgSS4jJdX+ZNT?=
 =?us-ascii?Q?TcdKx4FlItLzB2EGAOEibpb2h4f6acNVF6A+JurTxWWGEQh/Zckz5vuIUEb+?=
 =?us-ascii?Q?H8dBXsuDYZN5yIfD55kMJMh8kZaenHQYIiZjwJWG1DFX01SCL0aMcA3UWdft?=
 =?us-ascii?Q?MSTRz1Be3dA/TFkhGDU5GCe1BYDeorfbrCICi7rwezfKnbY8ACxAbhLcJ1tP?=
 =?us-ascii?Q?Tb2jbuFgjAB+a4LXLRstEmiMWRIjDhh+Vo7oPIzqxFyB94pgVS2ByMRgecIq?=
 =?us-ascii?Q?J+Y1EhMZ44RODtANQBErd0eWL257IvI9fjgDqc1gBgjjXCZUPtEDcg7tCBCO?=
 =?us-ascii?Q?McJzmGZyez4sQ84VZ7FfpTAT7aRkkruGbT2uB9ui?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5811f62c-955a-447f-ac1d-08ddf62033f1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:27:13.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uq6SdKWB6bFv17uoul8zpFxHz8sE5+pP5QRXlpMvjn3fluSBZ3zaDhexod9/UM2JnUd3wkrFvAZo10ja3/ZJsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

On Wed, Sep 17, 2025 at 05:33:29PM +0200, Bert Karwatzki wrote:
> Am Mittwoch, dem 17.09.2025 um 10:41 -0400 schrieb Yazen Ghannam:
> > On Wed, Sep 17, 2025 at 09:13:11AM +0200, Bert Karwatzki wrote:
> > > Am Dienstag, dem 16.09.2025 um 22:27 +0200 schrieb Bert Karwatzki:
> > [...]
> > > 
> > > I ran a test for 10h and got one real deferred error, I also looked through
> > > older logs (which only go back to 2025-08-17) and they do not contain any
> > > mce Hardware errors. Here's the output of
> > > 
> > > $ dmesg | grep -E "mce|Hardware Error"
> > > [...]
> > > [10163.739261] [   T9326] mce: [Hardware Error]: Machine check events logged
> > > [10163.739265] [   T9326] [Hardware Error]: Deferred error, no action required.
> > > [10163.739267] [   T9326] [Hardware Error]: CPU:0 (19:50:0) MC14_STATUS[-|-|-|AddrV|PCC|-|-|Deferred|-|-]: 0x8700900800000000
> > > [10163.739275] [   T9326] [Hardware Error]: Error Addr: 0x0095464100000020
> > > [10163.739276] [   T9326] [Hardware Error]: IPID: 0x000700b040000000
> > > [10163.739278] [   T9326] [Hardware Error]: L3 Cache Ext. Error Code: 0
> > > [10163.739279] [   T9326] [Hardware Error]: cache level: RESV, tx: INSN
> > > [...]
> 
> This seems to be a real deferred errror.

The "Deferred" status bit is set, but that seems to be coincidence. This
error code shouldn't have this bit set. Likewise, in previous examples
we saw the "Poison" status bit set when it shouldn't be.

> 
> > 
> > Summary so far:
> > 1) Errors are found on CPU0 banks 11 and 14.
> > 2) Errors are found during MCA timer-based polling.
> > 3) The data is coming from MCA_DESTAT register.
> > 4) The status bits are not consistent with documentation.
> > 5) Likely these errors are not generating a deferred error interrupt.
> > 
> > Bert, can you please collecting the following data?
> > 
> > 1) Output of "/proc/interrupts".
> >   a) The MCE, MCP, THR, and DFR lines are of interest.
> >   b) We should verify if any other notification types occur besides
> >      "MCP" (MCA polling).
> 
> This is from next-20250916 (without the debug patch), unfortunately I've
> already rebooted after the testrun with next-20250912 and your debug patch.
> 
> $ cat /proc/interrupts | grep -E "DFR|THR|MCE|MCP"
>  THR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0
> 0          0   Threshold APIC interrupts
>  DFR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0
> 0          0   Deferred Error APIC interrupts
>  MCE:          0          0          0          0          0          0          0          0          0          0          0          0          0          0
> 0          0   Machine check exceptions
>  MCP:         39         39         39         39         39         39         39         39         39         39         39         39         39         39
> 39         39   Machine check polls
> 
> 
> 
> > 2) Using an older kernel, read the MCA_DESTAT registers for L3 cache.
> >   a) CPU0 bank 11: "sudo rdmsr -p 0 0xC00020b8"
> >   b) CPU0 bank 14: "sudo rdmsr -p 0 0xC00020e8"
> >   c) If these are non-zero, then I think we can confirm that the
> >      spurious data was always there.
> > 
> > Thanks,
> > Yazen
> 
> This is from 6.12.43+deb13-amd64 (the stock debian trixie kernel, currently the
> oldest version I have installed):
> 
> # rdmsr -p 0 0xC00020b8
> 8700aa0800000000
> # rdmsr -p 0 0xC00020e8
> 8700a28800000000
> 

Right, so it seems we have bogus data logged in these registers. And
this is unrelated to the recent patches.

We have some combination of bits set in MCA_DESTAT registers. The
deferred error interrupt hasn't fired (at least from the latest
example).

There does seem to be some combination of bits that are always set and
others flip between examples.

I'll highlight this to our hardware folks. But I don't think there's
much we can do other than filter these out somehow.

I can add two checks to the patch to make it more like the current
behavior.

1) Check for 'Deferred' status bit when logging from the MCA_DESTAT.
This was in the debug patch I shared.
2) Only check MCA_DESTAT when we are notified by the deferred error
interrupt.

Technically, both of these shouldn't be necessary based on the
architecture.

So there's a third option: add this error signature to our filter_mce()
function.

As I write this out, I feel more inclined to option #3. I think it would
be better to stick to the architecture. We may get error reports like
this. But that may be preferable so that any potential hardware issues
can be investigated sooner. If there's a real problem, better to get it
fixed in future products rather than implicitly mask it by our code
flow.

Any thoughts from others?

Thanks,
Yazen

