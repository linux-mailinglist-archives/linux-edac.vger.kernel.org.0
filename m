Return-Path: <linux-edac+bounces-2517-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D74149C5F6E
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 18:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619C9B309EE
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B53202F8E;
	Tue, 12 Nov 2024 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zNzmJssO"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D2202653;
	Tue, 12 Nov 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426546; cv=fail; b=Jbd2anqvGzCH3Q6qHJjJTD4ndtcXrkFP2RhEMWjV+9UHkoxrFLevYPCHKqix9VrP0rD4+F8y5YgiE5oGA9x5w2FB9uRGMcEqPNRJL1vzbB2Ay5RysfYG/80R3idh/boAjwSW97qIA53c8wOsuRr1C7qYvjG5Lx4yJDNtrJYoTMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426546; c=relaxed/simple;
	bh=f0L+45HUeFI+tGRS4PpIf7D4hTe3pKMlhrB9hL69H2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pxM5R2M4aK15jYdrCC/93Rlr8vI6gEjWBbYOjUDNK8NLDgeLV68GPmZnJoKCNVuMmgT/MGNkNkFVgXRIMtW/gbAZzUAa3aK5wku3k8pqX/3BVJkhskAlLs6AWEmejZmjH4Pk09b7hN5CEiEzCwQtnKIhs9eLNsihRJbbkprRlo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zNzmJssO; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aH+safw1XmuCcg6KvHHx9dJrAkvZqbDX4bQ3EcqRo43HBuEomd8m3Wy3TO6uADdCFjgfp2bwi9Y304iVSdf20SrJT4VpME8w63etAgC+UzMrjaj89lvIQxc90jmYywb1LX2jPlcrKPJ4e1zyy1UMw776eb9FudFKK28SXcVWPmeB0peadzFP3Eq7mEgNHEtSff1qXKei/aTkyPcDI1S7QFfCbP26daV2hwp1JLMDmID06lpOHBk2AzhMAhVuc3rY1psNKAawlXpi8Z7mR/Qn8l1Loi1Hmi3TsJUbs57+4TYgvWIk5kQBKj03Y6erP1TFUmRvAI+TYcl8yryaQ2yJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbqA1vCn8cUmdIKqvOxMtuHdUAgq1JNu4fe/27tRaSM=;
 b=bFiyYJaBIFH6f3etJ+qUj0PvJL2UkvdBgrIQByUGoehtfAAPDwYgRqRLzc2p6d3yWMhzOCMz2++Xuui9p2JzxfmS0yjvVdhjZYlbUqrCf0j/7NIWss8hH7F7/ETi9DkiEFugSxR9ohWx+0G+hqRTFJPjYFRSMf4ag55xTSTrsnG3j8yl77b5M7Gmn9nKB9qT3NxdoSdnPt1cq8r4JhiWH8kvA8qFNobvLvp6Sl84RzSqgvUAAGV/jBPZqs9EBQnxfdMFqxWBszYP7yRvXaMRU965izF4ctZfRAR/4dKAR4o4Lh7J+gr+3HE8/xRjg67+YXpuB3azlkNAOsKpmo5t4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbqA1vCn8cUmdIKqvOxMtuHdUAgq1JNu4fe/27tRaSM=;
 b=zNzmJssOeqA4ZEoh3/nnoxeKw0bnZNJ9FnUW0VWaSaFmyS1TuqyEClskcmuDHQKORWEO4R6usxfI87Xl0g+0k8hhdAEVwZt4WgNr8JfDyIvBRHDBg+fjMMxZp8KCOhSJ2qQjmHgoKz5p9tnGqtT7vb1twLW7A6C+RoZKJB8RY9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 15:49:01 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:49:01 +0000
Date: Tue, 12 Nov 2024 10:48:57 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: bp@alien8.de, tony.luck@intel.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
	sohil.mehta@intel.com, nik.borisov@suse.com, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] x86/mce/amd: Remove unnecessary NULL pointer
 initializations
Message-ID: <20241112154857.GE3017802@yaz-khff2.amd.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-8-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111060428.44258-8-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: BN9PR03CA0683.namprd03.prod.outlook.com
 (2603:10b6:408:10e::28) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 664ea350-a306-4d46-01f9-08dd03318722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZOj9shCiMNOPA6JzWAIsL9E7wbIetvaPDjObrbEtU8EiLTDQM37qTRtjjAXA?=
 =?us-ascii?Q?J8JkKmq+wmphfNToSXui0DK0bMSaJodq5sepjg8yS+symVtEzgMmEDM7n89d?=
 =?us-ascii?Q?fNWi5DG0SrN2a6fL3jXvdeb2TrXa0UaxVZuvn4gBKWwvRvexLZug/gvhPgsa?=
 =?us-ascii?Q?vqfgixvwgcmi3nNKiEmJ3HNYpJnZdM8n+OK2q/B88gfDN0eW0XV3VK8x5qX/?=
 =?us-ascii?Q?R5oM3ls5awLrGJuX2MnyXQlJYZa2aNaUV0ROu6Szb1OgrXBBq5NtNE6DEuKc?=
 =?us-ascii?Q?hrxzb9gstm6DzKU8P/XJwXCQEa698xZG/bnmrf7+mhN5iV7AxRcU9Iuq0F3I?=
 =?us-ascii?Q?InkSaiTToh21eaVF22Un03XLxl6ZwnD6rAzra0X8/XmYroDQVUePIjV3UJvP?=
 =?us-ascii?Q?V5Tf4lV38ghFC4sSsVa5rMTy61M97dxc3nDii2QKp+iT7dCI4JMMOK7Jdjr2?=
 =?us-ascii?Q?GLf0dt/GPtr4Vf90qjfI8MbvIWCMJK0QRFW/gNw/5UO14MfuCuV+bs8XldYk?=
 =?us-ascii?Q?RmGzBGus0WH8/JWhROguaPGfpR5wBZ1XkNFr4MLTMsSQeYTusbeSF0A2BpUQ?=
 =?us-ascii?Q?+GznO6oiLCde1yKWrSXrs4JxfdbcZzyG2NkBqtuT4mWYZATseXT/lrQwR7n8?=
 =?us-ascii?Q?nnCdb/rTGus0Bj6uNqiZJ0OouN5wE3ZiEguDwq+nAubHSOIQQLY3UqHZky97?=
 =?us-ascii?Q?EE1mNhcoTZmyLNrxzFL2Tcwcglt5pJKYEV7JfRTqSNh9yRAp7+NiUrA4nBJ+?=
 =?us-ascii?Q?gCZ6FeA9y/H6Q195TUmXHrgQHfRparEgsO8wgOmpk5RKUTHkiFnRlmz7Yjlb?=
 =?us-ascii?Q?GkfXnCf0s4YeRIMTrzfmHDsOL6KQr7EV+YJ7yqYtxYoznVkYeo4UukDU6C2+?=
 =?us-ascii?Q?/OBdGuOMhYCi0pMkc/yGoxcNccf014CqcPnWriAKejO8f7jtivHtYZg1KofM?=
 =?us-ascii?Q?JUkGERtL8bcdBW576h2T5AL8WKi2qx/wJJ2yQRWz8M4aQmJwDIrvy38T22Xi?=
 =?us-ascii?Q?x9T1XiMYInL2NZGrpwZYd94feH8OFl+kEllLXMFmCZzUnAA9SFks91cb/8zp?=
 =?us-ascii?Q?7Km1j4kyleDJoJmsqziq6DbGtFxLSP9GJHK9vq9UwcNPJmuI1CuI8XZENWde?=
 =?us-ascii?Q?tbdANZM4ATT9DeY2FsH66rKF1wWptumxlGqnf8D6Epdv+ghPP425NCCI2Mby?=
 =?us-ascii?Q?G6gki4Ue8F18UaHlBcNGvLgFdUhdDmiSzwlMRZrROJIXmW1OHd8ATy6GanMm?=
 =?us-ascii?Q?JkhNGVO28ZaEB1DeUunJRwlov1xC4ZqdKLVWEdKlNz/dO46Se5CVLZ335w7J?=
 =?us-ascii?Q?78XtxLmZnUzLF7Im8lkt5/NX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?suUJR7gPsHvPnBWusetASLbnEYPtUgQEdoYVD/qCNJKScLCzDWL/8lsOh/mj?=
 =?us-ascii?Q?+cBv7Dl7w2IYg4sFtRegPwhny0Od94JkjauJkx0PuQz3o6NSoAnxFTVtkrG0?=
 =?us-ascii?Q?gkg3J39wtWjbu79DGYKiq/XmeZYF75gIM5/XZo36QBA029hS3ADGzLq4h8t/?=
 =?us-ascii?Q?fzeE09npOgcSqmNE+bslaGylnGrf3OmyYXAOloIvd/cOlqhmHkQM+vO52ACy?=
 =?us-ascii?Q?cwNRn2FynXiZALjNdOdA4ajvG6RETnmWaG3jhEaAfoe05sZO7QSNWIoWdh7x?=
 =?us-ascii?Q?10fT39GaGuz3VSPR/9pPzcj5JXqXuZoF+Q3ADzfip+ynQIK+lXOAw0Wbx0o9?=
 =?us-ascii?Q?GPT2QEgHnc1fQPco6570A5+tvjLUMlXtoTV9bKZV4WvwNgD7eA6OmT5KMG7G?=
 =?us-ascii?Q?LNDL39tZl9bSW675Nvh90MUkNua+FB1TQNBnlM+ERy3ylFI+olju57MF5mVU?=
 =?us-ascii?Q?N4jVDxuBl5wOLMeLr2aFA3K9V5ARFS4DsimQ5ZviamQ1PLXIExNmRTYzBcoe?=
 =?us-ascii?Q?p1WL67LRAUS/UuSQ5txxJ2j1kwx38A1Bq5QEmYAhPiF90vTiQE1GbHi5wWGa?=
 =?us-ascii?Q?iU2SNMDAPtWC/52W7aDWg9v++QbS8Q7xkGpDmRn0B2l89oKO85teZjx2ONGs?=
 =?us-ascii?Q?qbjGW8sM35DpxmqwzO+q5ZPBxmYt8OGIOxVecUewJ/5xj4D0A5Sa0g2UWJo/?=
 =?us-ascii?Q?CNN6e8LbigUqmJcTEJJrLFk7gDTSzgNleIcrHHYBrUR1DhADD/2j2CM3d1zc?=
 =?us-ascii?Q?0qzWzYWfsRQREHuvVwZIAi57fG2W3r8Eg0S/WMgXxzs2ekYnnMxnPDSEnuow?=
 =?us-ascii?Q?EewM7n9f/X5etl48z0eUX26L8lqViww1knHX+8r/qwEavmTX3LOTrXtZDsP9?=
 =?us-ascii?Q?lXbIvhe4Zh+E/l1xT6m2Wcf96CdOZNyMGxigBOycy5m7Kz7NoGiiSlFiowDE?=
 =?us-ascii?Q?tqyQf5/4mXvlw31rTQiTs6Aav3mGCVSafTgeJwfI0Nk8vvfImCUaHW1WbL1L?=
 =?us-ascii?Q?qXET0axszWEey2U6mfBKHAplHWrUcbQdY286d4vM1KsDOTwLgrjxPSutsdo/?=
 =?us-ascii?Q?tPetnLkvfhoD4vc1lIx4SCZNIc7g58sbTUE1SnxHtpIsYwJNM7AJVSygLSbx?=
 =?us-ascii?Q?BrrSsphH5lxB4zlvv4IPyed5Nq1M/F/Mh5Ul1UtLnQrTTy4V3ZuPdvY9qv8s?=
 =?us-ascii?Q?oeCUoK0Qys9zRpHdVt1KYk1xUsvo+FqZmsMq8z30bjjy3m2E9kUm6OgrkOxY?=
 =?us-ascii?Q?lL4uGWd/ruVYb2tQRUGg/zf7dSs9hVZ7Di5znZHuhYwbA56/sGJhRk4k+lrM?=
 =?us-ascii?Q?Xs5WAHCyU5nFlHrh9/5zSPlKqnHJOQtI5BBwowBbd7MIElo8Otue+5kD8GuY?=
 =?us-ascii?Q?9PEaBxATQh5L0SQuizogHPz/mutndOeolF2L+SU88423Tp6Kd7L57uEkKAmv?=
 =?us-ascii?Q?p2xRVbSfHcRxkJdcPXZGQzoWbImrzQoGm35/IPmQsqx+QIBQZ1COSWFOBELc?=
 =?us-ascii?Q?Zi9uycoyRI80MobKTumrR56w8xCGA/l6dzsuYCRf3hqn2UNwD1jGy6eN0Ytw?=
 =?us-ascii?Q?HNPd8TOF1Q3MSMLx4eD83JfED1YHdtW+cFMYlnNU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664ea350-a306-4d46-01f9-08dd03318722
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 15:49:01.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMEM4LsImQIwnVm2J+0jHuXsPHxpI8Du/IGvIvmJDkTq72MfBkMqxIZNx6juhh12TZek0i3VfRwglgjpo2RkeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700

On Mon, Nov 11, 2024 at 02:04:27PM +0800, Qiuxu Zhuo wrote:
> Remove unnecessary NULL pointer initializations from variables that
> are already initialized before use.
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

