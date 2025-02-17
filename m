Return-Path: <linux-edac+bounces-3109-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9872EA385B4
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 15:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E4C3B856B
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AF7223328;
	Mon, 17 Feb 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sl5pYVI3"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A562222B1;
	Mon, 17 Feb 2025 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801372; cv=fail; b=X3LjNQxnThTD2NDBtztBvYwK9xqRGNgMl4nWP/Lzzs0lY3K8VTZ9hM90QvY08kawI+FZc27V1GrYm3/Klz4fKhMDRXjjtdm9e+W38cCmjYKoCu1qxtLW8R2uzSIH1IwGyUO658/ZcH7nN7qBKYBpIcdOPciAsAMT1wqaQEOa3qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801372; c=relaxed/simple;
	bh=b893FQdrXhuJYbjNuhZs8nrWnNdnX0uj7q+keyuUcRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P8iMbjLRetL8ZhvSFxNyt+J3fm6j15ukgMIn9FyrhEfHyyStnCVlH8BUGqWngmoGcNk3L8LzK9wEoHv5t9qAp2s73eufPj7/3MBdQQ0NdAfRNL7Djc2m5bndKvZ9Hp8N984JKH8m4v6i1aht0+N3crj5Wyh3rlCtNvy0Kn4dBHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sl5pYVI3; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mneg+cwYP7If6rf7N3bkdQXpr4EPsXZELY17nzAVOoY4Wp8Y5GZAC4xIFn5lAZ0npVj5OPJcZzpjxiPnHuklx689XN+GpZG4d9GsaCMnwm7zgY4qwHJnLdT9AbcHSDH046oYIao3vQX8c6BptzT/jHEXnO4QwUn2ybgjjKg4Wimdiyyf0E3DYC31dkOpRM7ahrT8MfGrDyT0QHX9sdDn0YqzljTwjzCJNfXvkK8k7mbloJ3z/My9DCE/cpHw2Q1EpMiyqfR29xxfRW/MdzKYH60n51cVXUxlvoozGPjW/tL7zv4MgkVssX7vM4riaIILNksyPnLdfPGpCyBJbGmqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGxI08ZxGocOAfaXsucvC3sG18vxILHitVvkICiE+14=;
 b=WDrHF7OMqz7M+IQcoxcbxTWnVe2tWB9LLVm7oe3c8kVo8XiK8t6npHqgthxI0lPswDCeAgCNUWv299nP0xuN//iozd27Tsr2hUjzE97h2mCA3ch4J7WlyOz7l2jpa0/wmgvfyhsw5AMk5AkrrFOMjhOvBAeJTtryIvyofuDl1bAEIiskxPNVg7Y3YApoHF56NeSyq9raWQy70OWAPhX9YYY/OHt4DLnSetAgxY5JMJw4Eh/wMnbdp7DMEPiBhH7LQDlLHgVt7L9QtkJNuQpYhHOAqIrzAg1Kg9x+SrDcectpnJNdaGF5t69u95Ixb57vy/0T1X3Y4hjfSeVUnf3xag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGxI08ZxGocOAfaXsucvC3sG18vxILHitVvkICiE+14=;
 b=Sl5pYVI3WNYfowisRnQYj+2Tj5/7vlOkKyI32nBsmAGj79HRD+McSRssqrzbYRnUKTzqJnaS7M8ha8v+TpdFvjaLhybuawcB9XSVdGX7jnQsPtouGX8+9TJolmrJ9rKg1WE2oJXKfaJ2XHlpokl5UtRKw27Oyj4UqYVTlpoMJv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 14:09:27 +0000
Received: from IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514]) by IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514%4]) with mapi id 15.20.8445.019; Mon, 17 Feb 2025
 14:09:27 +0000
Date: Mon, 17 Feb 2025 09:09:23 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 02/16] x86/mce/amd: Remove return value for
 mce_threshold_create_device()
Message-ID: <20250217140923.GC591070@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-2-3636547fe05f@amd.com>
 <CY8PR11MB71345FB3EA6A7AE492D62E5589FB2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB71345FB3EA6A7AE492D62E5589FB2@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL6PEPF00013E02.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:18) To IA1PR12MB6354.namprd12.prod.outlook.com
 (2603:10b6:208:3e2::11)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6354:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: efb644f8-5091-4145-1624-08dd4f5cb07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y+zKQ3JYlLJwqjjiz8N7e98eCEThDE9zQXAXYsL9mH32IgWB//p6kFPFc/N5?=
 =?us-ascii?Q?7RMbbaSf+GGNNKWGk+Z0b0Kk1w5ITFQFyfLJ/6tlEpTAWN/F2BL1juGdCdrR?=
 =?us-ascii?Q?uMW6H/3n2boj1QxJBEeGJVgVSmckupe3kvXFu9JdE9K+rdiljvqkzTdTd37i?=
 =?us-ascii?Q?FXQUblpRxSXTm1W3q7wCFc5YqhQZjLinpvzNRmgZzPTW3pnkiYS2kf/eEmiw?=
 =?us-ascii?Q?NzuSXDZ9Ab5+dzLyosuDLcVHhX+F5NooxOQuDDwsPxaw09Q/IpdRuROaKXxO?=
 =?us-ascii?Q?eE/C2s2sHjL6SBXH0GJ8Jbn7D7ZLFBEkQ4j2iW4wUeBD8/nHl4U+EAeqTfv1?=
 =?us-ascii?Q?rg/fV5hfm5nxZsP4OFuHepOrxuQO4Xz+4AbRa+hLyQKVqUKzj88hFomw7u4O?=
 =?us-ascii?Q?KFMzAes42nGTCoOOVw7SbU0/c5agBnRadM2fyp1r9Tyy7B/oQsLKfj/XRT0F?=
 =?us-ascii?Q?DmQu9naIKoz2kOp3126vycG38KjUpSrAKbvm9+zH6NkGP9OVcN7OgTvtXFVc?=
 =?us-ascii?Q?/+RNTkgnG7CfA7MYK+x67TlG14DOGTt/tPYH/iurS0VsAlD/fQUmhFkbObyr?=
 =?us-ascii?Q?ChQtcokh1iBaFpi2Qyks/KnkFTp1K/2lPFMG076YxBmDVer+01zzeHW1legH?=
 =?us-ascii?Q?kbLgq9TFpn30wWpswep1UnZkkZAAuTjpdLkRG/DODucwY2z5s+sUxZgLH6ZR?=
 =?us-ascii?Q?eOQtCA+MCaMfFRaZHID5KA+kRJJwlhf4TqRVTDe+0c0g2KADbshf/NQlmuFu?=
 =?us-ascii?Q?hOd5jrpK3GxdRKpcY2tRdk4sy5x8FAVf3EV5sZf08XNs+d7aCGu5TwcULh5b?=
 =?us-ascii?Q?wmc0leJ2adlgNPdY7e3JfAK4K+oY6LqMgKMtz2dwGCNljvfXkaZDCwAHrT6t?=
 =?us-ascii?Q?isYSvDlakdkp56uxT50msjnMIV8iM6t2JzAro/lhxpy8pBZlrXR+SXBSNyg9?=
 =?us-ascii?Q?Ubmq27oAeC1KGIxI3UajOlbK+3a6X4x5EFmAAqI1SAPoTFlWKF8Jdvy4cq/5?=
 =?us-ascii?Q?GlJEEvIHKXqMYIPchvmdx66LrVwbAlHkkrYqlovx2Qd6qKuicbXyKLcWBYI/?=
 =?us-ascii?Q?Bgf38PiW4kYUwAsM7cpf/Aseo8/QhS6kvZJsmdHN/8UN3jiPhnur7tXeQyJF?=
 =?us-ascii?Q?k2Hwv12jeGC8yQsaMkyUQyeYO2Ps+X4PiEhlpb/pztqHI35uovg7fjsyeQGD?=
 =?us-ascii?Q?jukczv8pwG8asTNqAax3xyHfbpm7rWJLp3sQKF2rIIrumWxngOyGLpS0AeCe?=
 =?us-ascii?Q?gs8LWxMDgffnE7oDWptmGCMCKc/nZALkQfe5lM07qPGP1B9lSRIjRylv/bG1?=
 =?us-ascii?Q?wBU3q/HWtOKC7k9XlYi60zTDO0FRxBwP7zj3v/cOhd21pMChwA1BQDSfs/6F?=
 =?us-ascii?Q?O1R68LiT+7ufEP+8/59+U/WoCAIc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6354.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eFLtaVtaOo/K95LzQW0XyuTsdlmPXtZrp112ACMPKx/v1N7ptNNNYk1e+lSX?=
 =?us-ascii?Q?WD9WPJHZIbEtDWvvV6qAzjYNzLGffDMAy2dOy3i/mO1akaK1ar7yCR1saP2v?=
 =?us-ascii?Q?eEC7rvGnni1xTe589JEtZwsT2PqOoJ8HQSHND1K5Gg50gnK67MQzvabShrpY?=
 =?us-ascii?Q?nGmQ82TPVICxLGS6PUM6+hQN60WYqTT/X6jDAv0iEXfkO/uU16lL8fG9d4nn?=
 =?us-ascii?Q?pmUP6mlqva7v9+aRSZQQxDkhwcg+zq8NMZ7GvlmYe3STjoJ5zonz96qvr3Xo?=
 =?us-ascii?Q?0tOO4JTjjybX4RLq72PjKZYH47ap592CHeLHzuMCDi+nYXiUv0krXohdEPMS?=
 =?us-ascii?Q?2OSBCGo/9crop0Rd8LoeUIvf6qbD4wz30KeP6sS8Tl6yAmRBNkCcU419g1O5?=
 =?us-ascii?Q?5lwELgA5kwUPwBLpgfgxmElpI1AUcq23nXWwA3jVtU5ANJ0bXdKJPdV8V4Ft?=
 =?us-ascii?Q?Pb4W/ow8PzbUDa9pg2Qxl3O/zxtMlwQyQyVP8uOv2eZtv3mgqlddarYzpRrq?=
 =?us-ascii?Q?25PZTjc+ypCrzcr2k5cAd8jxJLSZPI+CwRSIlkT64BSjThKbhFDqEtVbTCNc?=
 =?us-ascii?Q?klXaTBqZEJwi9bIGbg7fhWyJyEihKyUn2qKJK5WIYykutAxv1CRASpyQUHIx?=
 =?us-ascii?Q?EsL38WKY+971JKMV4aqRGbn8FP1HuAFDjUeW7pqlR2W3jMhDQxWKc3VA2mvU?=
 =?us-ascii?Q?m3ETqj8dBSbRFoFxrHCUVK1jJRASFcVo25f0uvZWRIfjqmnGwRP2ej0u5C5d?=
 =?us-ascii?Q?xJBAfJo0uKoL7oG2R/qiOGtVa4asRCTGrQwT6RMJiM+E5sXCCqB+ic6Ynees?=
 =?us-ascii?Q?H17gvmyfT/XXz+5fdBBHZlhz7iufNSk78nhpnDpIs4WQ71XaU3VjVKcazhiZ?=
 =?us-ascii?Q?z2iwrnUva36z+gCyGPFI4odknTRzZWQC0M63Aw+RGXTKeyQ3Bp2oxO1Ris3S?=
 =?us-ascii?Q?ZhoQmW9GcySgsKEmbkHLXlqvIzW8PbaITpkwxXW9EQXLFs1EL8zpbmB2gZrs?=
 =?us-ascii?Q?/37yxbY2qTBwljUweHvX98mIx8+C1S6rIPNO9vkCWTNFjvurzDnfO1ULpdkQ?=
 =?us-ascii?Q?+C1qhAe3aCL53czInCA7G7bxoGENsiPJJkr9o1hPfrYnYO5y2FFSARHTSDMn?=
 =?us-ascii?Q?TtB53ZKXbrUNm50EGgV6Q/wUAv/crQO4UWodqlLNdqZPXFRQp4ErN6xW94As?=
 =?us-ascii?Q?QxyyRz5QSNVPRx9kwXz3rKIsqQsUuhKHMLK90PSSILBgi2wnt0OlAre0vMVp?=
 =?us-ascii?Q?5qqej+1j7L3FSCewQ+92ldy/6IFFqfK2+A45hmZHAoNYJ9YJcZ00K1BPrUAq?=
 =?us-ascii?Q?cKtHZqGC9rW+BUU1TdNiUggG5enk3UJGmK/feUVo11eb96AMKIy+agjamG4+?=
 =?us-ascii?Q?2IRWOSTN+DJbM2jpMjMElu32G0QXNepfESUu+VvPXkgSzMgwCexqrn07WhKH?=
 =?us-ascii?Q?NbS0Zfh+LWePFGDhUIJyyHIPni3uDntUpQThVRtRhLtvqTSVKLiaYqOV2quh?=
 =?us-ascii?Q?JBge5VRR3kSpejyDuon9ZmkhGWEcAbHnvqT1NOs5QZsFgwgKwE40H2lmWsiS?=
 =?us-ascii?Q?rCSB/ieY94AGpcwXoNTZEA2TgdtpeBYyVliHYZpq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb644f8-5091-4145-1624-08dd4f5cb07e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6354.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:09:27.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pcj4D/ytMDic9o23pqWZaVXX4Zx/TiW6+s5hPjRZkm8qWSNbqEIXU58FRLPN6nY2sRDZd7bq+/OYs43EFi91Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270

On Mon, Feb 17, 2025 at 07:11:52AM +0000, Zhuo, Qiuxu wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > Sent: Friday, February 14, 2025 12:46 AM
> > To: x86@kernel.org; Luck, Tony <tony.luck@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-edac@vger.kernel.org;
> > Smita.KoralahalliChannabasappa@amd.com; Yazen Ghannam
> > <yazen.ghannam@amd.com>
> > Subject: [PATCH v2 02/16] x86/mce/amd: Remove return value for
> > mce_threshold_create_device()
> > 
> > The return value is no longer checked, so set return type to 'void'.
> >
> 
> This change can also be applied to mce_threshold_remove_device().
> 
> > Also, move function declarations to internal.h, since this function is only used
> > within the MCE subsystem.
> 
> This change can also be applied to mce_threshold_remove_device().
> 
> So, can we also apply the two changes above for mce_threshold_remove_device() 
> in this patch?
> 

Yes, good point. I can include these updates.

Thanks,
Yazen

