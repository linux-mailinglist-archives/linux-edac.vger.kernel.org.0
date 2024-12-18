Return-Path: <linux-edac+bounces-2743-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF6A9F6AAD
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 17:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A541896D9B
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 16:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201AD1474A2;
	Wed, 18 Dec 2024 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I1UACFxo"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE812A177;
	Wed, 18 Dec 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537745; cv=fail; b=pVfXAk+LJhbZIwkYt2atSUx3skkkuUOmYTlIvMV+zhzLgB56vE6TnPBwS+U9bgTJFNMiiWM3Ylz8LCn+NJlpcsoi/JBjPAlqTNuWa/ApoUs3uJOQBM9JoI6UTREQGShk5Hx1Sq1+5Aq0JvrNWCmo2k6J73TnutZSB48iQ+2GuDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537745; c=relaxed/simple;
	bh=UzHTsIoDynZzzJ1KSEEfAIS+pHG4lK+QcaMhD/e9z+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t+dB3wiWSWkmb7WnY22NwuB2yGQ40H2Ybem8C587kDvi1yU7f1rtTb/EgQNj7K0DjKOmbUD9QtDpg1XLajUDiYutWv+RZApFNCylvVyf+zftZnR61pMaifus6lX3Zvt+pxXQJjjZ1dWnRPeNRaoHQP5jgdwI55o2H1MyDrmi4Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I1UACFxo; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5nmmw9jefUG9OXKONAIOMjwjNXLPdcT4qNiK/4oQYbxl3fxQEJa9BIEXIigXr7Iy/G0uzQFTkF03Rz+XbM2P9fXHmFa9KFdiHnZmXmNmIOsGrfv3oZCCzSMFIn0LRc46802C70hsJs3d04Pf+KYNoEv1b/36qE0p6eLgfD6uGmcIfLDA5A2UdeMAKVo4utjSGTSzATmvNSQiEspDAty8KVLGnzx7qjr9Nm1o+8xAhJJRzBYSEVrwMPuGr5oxSeVjcIi7ZQyCJnSylNCBNLHWxDeQX+FGPvM7Igh0v530adeB4yK0eC5G8H20Vl5xxfCGDcWKja281IeU+XpxX35AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVe26VRsZwaZmc4xHByLO9Nu/fKUouNV8sBH4ECqz9w=;
 b=gLBebllGh2Z011xQE3Y0gSbKJFrWV6ycI39ROwLg7XAWRy6xATnN6ZDL4PxAWGNBdQLlYt5+oIQcaT1EOgayEG0IrRT/GzSNc8XefiL+fx16pstku9ZrLXUzpmP3g3KfmEMXmYJxpO8rgVyvwdB+53OZF/SVq01IC4K0DReIMtYvZ9Y0b+e5PV9VgRN+GZ67KvGFhDubhgmABcTx8A66Pe+NN9vb1Zc2ywxFQ2YtW/n1q1QjEbbME4z4DeDctUF2bGcQPkD7LqhkRgNJXsud5AJnxBanT9OqWKSlBnPcc4nFHQXz6cVdCDbN4xcN/+kkm2REc0W41tC6zzyw6ou1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVe26VRsZwaZmc4xHByLO9Nu/fKUouNV8sBH4ECqz9w=;
 b=I1UACFxofQnIwj0MX2QtLatl3Zni8fu/hPaeemj9X6jDbKc79ZwBcTzmf8ZOtbX2D0EZHZ/ZZO5RLt5xaj7al67kQsNp6v6O2VFknxHnAQjG57LmWEfLUKOeEG0R5IAxLEXRsyAcFPKLnOGXefb0tNcKvoRyHRcRyiP3el2/fuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Wed, 18 Dec 2024 16:02:20 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 16:02:20 +0000
Date: Wed, 18 Dec 2024 11:02:15 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: bp@alien8.de, tony.luck@intel.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
	sohil.mehta@intel.com, nik.borisov@suse.com, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] x86/mce: Remove the redundant
 mce_hygon_feature_init()
Message-ID: <20241218160215.GE1155365@yaz-khff2.amd.com>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-7-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212140103.66964-7-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: BN0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:408:e6::32) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa37057-e919-4e70-201c-08dd1f7d5a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9KDGXXJxWdSpcJU2JihVZp8bFDNy9qt88njaKm6C7CVI/DEsCToXMeXN0sDd?=
 =?us-ascii?Q?B3vwN9AdQBY5rvuSY2VBEfT/XnPn4nPPrPYTOhQCIaJppDlUMF4tGzSwI2fR?=
 =?us-ascii?Q?GgLHZIXU+AE45uFQWPYvbMgfrZ5/HBJ8q4iJLH9C0HCpQXtv530MSdaFNqSB?=
 =?us-ascii?Q?gfeRcf1/PjbT3qbWCopn+dqZCWfIgyo9o48HxdDMpV1jiJYjy+2bq4ognLEv?=
 =?us-ascii?Q?RvGFIMway5esjVMTsfq1hjF4PRNOKFIm/D1IApp36my6sC9jAC6PEUw326Iz?=
 =?us-ascii?Q?2XXspBKEVUhfXNu2NenB6Dz9TQEilBGcKl1MPg8Ce77JuAHulsxfuP3MmTb1?=
 =?us-ascii?Q?Dh1FW1xfRTLHG9MFgWLLC/eY0jIdBVHYpw/eW819q7T1Wu2W+dQWlB2cdzCf?=
 =?us-ascii?Q?iVTan5F6fMg8eK8T6Hp9BxwCbpXZeXI+GE7cS1Ss41vrH6N/1xn66K9cnmVR?=
 =?us-ascii?Q?4vHoYRzHY9S6GxVbAOVE1XzwXQeuTqBBM2v/avAyyned38iuLZvAkt0oKPcM?=
 =?us-ascii?Q?GX/Zu3DWyXSIt46QC0kM9kT3m37Yz9Hfync5WRC5EfPdYbL5t84toLfd3/Ye?=
 =?us-ascii?Q?GHIIFniJXziNeXytH+rnVg4h5mHGsTr4OhWNFYooDJ+3QqbE0yv7Lp+//foB?=
 =?us-ascii?Q?wduD0yVa4RsUwgeHgVMsmZ+8scKjqD9q64t30vcR3v+2L+lvyu+g4aJLWALG?=
 =?us-ascii?Q?en2ZI2ezoLye3VFJzcTsk/ati591NeFhDl5onqinlTG1X9mM761UInFrpNOH?=
 =?us-ascii?Q?B3afkAVpYxs1J0shbI59j1rX7OpG1sTqBz1Bxsi4mi4BfECNDPIGdpZYDxoX?=
 =?us-ascii?Q?nDO0akm9RI10aK+Qb86B6X3a/b0x80oFl7dY4oFnkw26udXiqMnBrfg3kin9?=
 =?us-ascii?Q?QuSNlYsQTaNK7ul1UhMlLF2NC85eld/F9LKTptGI27ulhKmvqpT+bH58ATUQ?=
 =?us-ascii?Q?dMbt8zV4a9mcZp7yZmMBYlXMLttTxvxaEgC9a7913PW1CiGZyhRYCTdxcbZb?=
 =?us-ascii?Q?SKkuNb2v4p8FnEI2AzOvn9qGwFWncAQgFaHZ9DdrkDH5kPYQJa6cQW4Wb8oR?=
 =?us-ascii?Q?uX/rB/4dmnYUUcE+ARsCYwE577/yYH2pnjFM74eH9M5b4KCEXieNkbla1Wm5?=
 =?us-ascii?Q?/ItjOmOpr0GRbPECwQnAyQsCTUDIkyxALkB5lGxYvD0PM+Swqq4QhLCINcAD?=
 =?us-ascii?Q?7YPrLqTglDdiQKuCNMW1hQX7mghYM1LdDxDBxpPYsw2MpihKq137zSkDbUu+?=
 =?us-ascii?Q?9XBvajXBVmbvEiIu1bFHIKK369FUHkO2wYpqCb0yPbt1XzgAZGkra5pgjUXT?=
 =?us-ascii?Q?1TqUrHS5vvxHQ39tAe2GGXpz7LPfb+X/tHcc9OnSFZvzKftYBoorK1qzYycu?=
 =?us-ascii?Q?ufh+EYTZUAifRAoVIf2SdhREGlFX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8o5j9f3EtQDcSA7wxjKNrjcxJ8aLSGYIFtIs6+fEryd73+RwDowWXHq7ZXWT?=
 =?us-ascii?Q?uRI4cTcDjgK5AAKR/T5FB0WcpdR8l3Rq9NjK+sspDmVyr2bE5iZHFi7bpqLY?=
 =?us-ascii?Q?eO0jPltiKMpN5DhY5WQ71xKzbI8kcc1IDJuMqBYpLKf2HTdWdFOSTtvAb4EW?=
 =?us-ascii?Q?rG56KQW4nRBg8shOgyKcz7q6mtbS8aGPCRtq7/UpTaLF6MCjwABoYFpDm4LY?=
 =?us-ascii?Q?dtLizfUtE0KsOCuUg4X+dGUelNjc3jH+wRS4Cas5WKbwlRGTJ/x15wUeuHB+?=
 =?us-ascii?Q?gjwUIPmiL7HqU44bvWSgulAoGsCvgqK72X4MxMgdk7u+dtTZvrgndycrxptC?=
 =?us-ascii?Q?JhjuS3yQvhdxmDplnwWBJKyjGMpvuCRQjRZscLOYKbfDYfP5m09C2V8wQAWc?=
 =?us-ascii?Q?FpBI1KoM0CRyc0a5w2jI8jOleQFptHH7VO8TGQy54yf4fY+oyd0P9R/gNEsJ?=
 =?us-ascii?Q?pEB0w6LSILgCgltmdvHkckwqdwZ0ahmfWIpWkBHYZ3/7gwch0gQ9lL2HFLS0?=
 =?us-ascii?Q?ujMNhPXDtItnN+D5E5upM7wuKdU/62FjGnFLBvIG7nl2qg+zDCsQAXvO/UsM?=
 =?us-ascii?Q?uI3PeE31DURzAOkBdFmeMgc+LEoIRsF3WZbuNN0z/4FJltrwbBBOV23OAor0?=
 =?us-ascii?Q?FnHt4UlExgz5bR12f2f1fHdd9igbdTXZnfUuN9Chqd7g5hEtwd12dtp/zqlY?=
 =?us-ascii?Q?P//IeLCDCFpHg6XwZcBVAYGwtNxqUFjLNSCDlKUlt0AYaHloDESeBfhiNjvS?=
 =?us-ascii?Q?DAuyoHKIYAmHnEINyNpsZtkroQ8DJsmgwaW72wvURuvlJeaSMRfHUb6X5LFy?=
 =?us-ascii?Q?qpJN08Q7Qc9dcvAQc7/08ay5CsO5PoTC7Tq32xyjRwwgULXvMuD4tBtLpUyH?=
 =?us-ascii?Q?GPbOHJJJlJdRUcFhvwCYNIrjZMdiPNvnlsoCBUExcfTFGyU1U4nyaPW433hG?=
 =?us-ascii?Q?46FCYttvwngnZ8wQLGXsJw2atbKj7mPo9eRetXzIUKMjTCY8eurGwTbKmTTh?=
 =?us-ascii?Q?xI0QpahZYQsskmie09sdm4REVBVDxKdB6K7j8YJVXdWWVNWKsNi6NUcS4B6s?=
 =?us-ascii?Q?DGhfUGhgK4sNlkAMlegW+BF2BkH7ghuW+tTdBHVKyiYLjAfWMbwm+tSdxm1j?=
 =?us-ascii?Q?4dziqd6iHZis6sLlV5DzocAfWLZdsyMVNuSdKhRdaD/1SIEVjqf2cdxxRMBm?=
 =?us-ascii?Q?K3IcHCq3REnKBupPlH1wI+5OkgACdBjd75LIRmSGMA3pP/Udl1VpU0E3YQna?=
 =?us-ascii?Q?Wy0Oy6AorDrLeyKSKDIrYVKijcittzuyzCwFOAPVlh97r0S14i0mWIEUNtaO?=
 =?us-ascii?Q?Zau5E4x6bYJ/Cg3uRvDkidijbZFEeMfTDChJMBcP2dfYEFRclKnUTQ0YjCn+?=
 =?us-ascii?Q?okHmTMH0/HuqvhiHeCoMyJHzlfO/PeZ5f1ERtxnnK1MBACcfbJ+TBjoNZS/u?=
 =?us-ascii?Q?6uqtZQpOmPisGqtdbIy5jBJ5yPoCk/s1rgY99zww76RBZRhT9bPEzCyQVYpV?=
 =?us-ascii?Q?h6c+Jmb839622a/rHCRJcLV5FcWIFX7vCZ+rMXwT2+1P+EBUT4Y9WJo4fA4S?=
 =?us-ascii?Q?f+m+Ui14eZNJUfeQuq1MPoKoUl0OQZtHCZOhmUIJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa37057-e919-4e70-201c-08dd1f7d5a62
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 16:02:20.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9G6aUgEA8y0/PHHnu4xDnQ2FiYriDtgULOOp50Yucxq5/oMXc71ZraCWP5cj51ciQ26qN1hN8N05QfBK+kjHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772

On Thu, Dec 12, 2024 at 10:01:02PM +0800, Qiuxu Zhuo wrote:
> Get HYGON to directly call mce_amd_feature_init() and remove the
> redundant mce_hygon_feature_init().
> 
> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

> Changes in v5:
>   - New patch.
> 
>  arch/x86/include/asm/mce.h     | 2 --
>  arch/x86/kernel/cpu/mce/core.c | 8 ++------
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index ea9ca7689f6b..eb2db07ef39c 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -386,8 +386,6 @@ static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
>  static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
>  #endif
>  
> -static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
> -

Another cleanup idea: move functions from <asm/mce.h> to "internal.h".

Thanks,
Yazen

