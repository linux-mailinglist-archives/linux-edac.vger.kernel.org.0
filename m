Return-Path: <linux-edac+bounces-2518-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C82A09C6456
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 23:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D5F1F2328C
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 22:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B9A2185AD;
	Tue, 12 Nov 2024 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/5kEbYY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF1193092;
	Tue, 12 Nov 2024 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450966; cv=fail; b=N9Xm6mcfszABIahKz02cFATnzVpD7GSpTlF1S3w+eFrAFQfCItoLIaUC7vMCVlmMl0x1BFDBuHXSynh76FLVFx3fcyD477Tz2P3DgI5ZWEVbNXlyBrU/KF7lZcj5bJ3FoVdzr3jrup1jXf3SFqXGcGQGe2j990f7xtFufjvGJuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450966; c=relaxed/simple;
	bh=tEqQMfTGCk05UApXQ33BnW+rTfHfN1LhVCK29Gqhe2I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eQZRO04/XuRKiM1VseIkYDclBs24WWhkNjRgaAZaDFcQtzGCs0xljykod7iXc/GxpT9ztHH8hgBHhxFWgp0UXDMX7MGL6leK0OmL5j1Nu4p7R/vfASY/1M/vSSwPAGBXdCfbHud1FZOSO8qjrd/W3qjrdNH6Pb4riFRDjIX/IIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/5kEbYY; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731450962; x=1762986962;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tEqQMfTGCk05UApXQ33BnW+rTfHfN1LhVCK29Gqhe2I=;
  b=R/5kEbYY4FZp8BdVEf5EgXZ49D+4CaicPrwq7dNO9GM5OMVcpMW2UF2o
   jNESZ6rRF72wa67rEARDcCaMjSf3FGEfafxn9TJKqG5htsoSC3zZxt8CI
   PVKECTvFj4gibxRJ8ePAcLE++vxAdKJwnRy92QuV4iKMu8HJGIuJtNTCr
   sXR0JL/j6umRJRtoleSxIr/YR40GWV1Rdtb8z2sazneOq+ZoLKFF2dei9
   uHziU/bDZhHxdjOqfQqDLhjPdOJnaaT9NUeDYq4A0GHnD7Xj8pKfB0ojB
   PeWDaLikWlknl3TX3jJIIjIxY75VlsGuT1gaOy5vQAYqzesIzmc3GFvXF
   Q==;
X-CSE-ConnectionGUID: m4wDB0wkTIqOuN56kN9vJw==
X-CSE-MsgGUID: kagPvWIFTSCrt3Ix3ukpOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42704268"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="42704268"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 14:36:01 -0800
X-CSE-ConnectionGUID: GwqV0OlcTwu6qtzTrmcb3w==
X-CSE-MsgGUID: vcsfDRSGR9i6hKWhnVpxHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="88089085"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 14:36:01 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 14:36:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 14:36:01 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 14:35:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hm6RKg/70rlCX44VmDSk6hUklrxvDTwtApwPzav2iKNnZG+L911jewhsWkQo6SCeISzoHybSOtp33E/QC/l2KWrsOZG0qIWKwkZtd12gq1nccimUyD7rzAZGcKS6Bk+ghjsrL5Eq55yOjQ+FsvbwNAb2GGfs+Jj5jFXlbqeQJ7WI7T3PLfpmXCxoyFIkjc1KT7PvFpA9QafDL+2jU8dg5QOA1QlwyqHR2+FCj5ciUctVuox8rKDM418/2lckLb0weZyH5xWbv8TZCRIk8p8CMvhiBzRR+RIX5TdInkuL+U43OuhrNM4iG3B5lBubhEY7qjTu99jR5sw1n7L1o/ytmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3eeaox64jRWZjmNnmOfw5kqz2I+YL9lNr/q+st+pnQ=;
 b=AOfOIyKzD3FyO5I+ECCYDn+0AH08gqdTmUqMo/GFSq5YlFJYI/7eB81Xf0nyNF7djAjFwFgwpV+W5Ijy9jwgWdGumlkIXSe/0hFHVypVgMxlPQ9uJbtq77L6/sCbwEoSodAu8j/LWhqRiibFhqPjg56Vc4ivLn9jYQW7Ay+WNu9nkc7CfcB1/Bzz+415eHRSnEfdie0zX/kmCRfg+Nyyy2X6dpIQSjbSckSnsS6fjkFQxxUqoJ6b8Di29YyUmZnuyijDsdJcHmYIYdR4Em1O1x+4Ent2fOrCMF7QsaSd9rjti+TdUldQwkavvdSQVitJ90Q/Z3FJOYxJnHcdoa1R2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW4PR11MB6762.namprd11.prod.outlook.com (2603:10b6:303:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 22:35:35 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8114.023; Tue, 12 Nov 2024
 22:35:34 +0000
Message-ID: <befe8002-a5fb-4d68-a7f6-1bffb97ed255@intel.com>
Date: Tue, 12 Nov 2024 14:35:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] x86/mce: Fix typos
To: Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <tglx@linutronix.de>,
	<dave.hansen@linux.intel.com>, <mingo@redhat.com>, <hpa@zytor.com>,
	<nik.borisov@suse.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-9-qiuxu.zhuo@intel.com>
 <20241112153842.GC3017802@yaz-khff2.amd.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241112153842.GC3017802@yaz-khff2.amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:a03:333::20) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW4PR11MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 40db2577-d8bb-44fc-e1a6-08dd036a528a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUU4RXJ2TnNUY0dmNVlHeG1jSCtUTVVxYmRSd00xUzMwK0xIWldNeXN6SVN2?=
 =?utf-8?B?NmNhdmpxeHpxdllpUk95R2Y5eEhPZEF4ZjhGaTNxaFNteG95MUVnMjNKRVE2?=
 =?utf-8?B?OTBVVUFGSkxzUkZYYTJHSVZaRFhjWnkyRUhnTmQ5MkZwOElFOWZPaEtVNE5p?=
 =?utf-8?B?ZTZENWV0VTZxNWZxcGNjVVIvclk1YXVBdlp6NmpkT0FXenFNZkFlOVZlaEZ2?=
 =?utf-8?B?MUQ3N0EzSncrQzNpYmRtTnJoUHloS2didDdMRkVRM0NSMjJvZmFQN0FDTllZ?=
 =?utf-8?B?Qk1LL0JscGlvV2lnMkE2V0RaYTlrN2c5Tkt5RlBkK1pPZm1IenIwRE1ZNG5X?=
 =?utf-8?B?Yk5GZThNUGFTVnZCWVczZDVXcHJJaGpOWUJRNFNacjFtNzMyS3VZc3o5Qjh6?=
 =?utf-8?B?ajZwWjQ2YXhpcmhHeDRCUC9wNzVNaEFYd29rMHFEbnJ1TGdkWUNRL1ZNVVdt?=
 =?utf-8?B?WEdySEd2cHF5Q1hpVkZLMHVvV2MzWEVXWEFMYjZtMisyMHBpRzdmUnFwRmJG?=
 =?utf-8?B?dFUwZ0ZSeFZDbHFqeHJSSUEzWUhmaDcyOEI4aVV1YmZDQTlKTlovUzgxckJo?=
 =?utf-8?B?Z1h3TSt5ZXJzUWJkdFNka3BYSWxMR2VsdFFpRlB1Y2tUTm5MR1h0NW9wemtr?=
 =?utf-8?B?SUQzOHRYcTJRengrYkxVcHFFTmV3VXNiWkh0a2dhL25YWkU0ZnM2RGpVbHRB?=
 =?utf-8?B?TFh4SS9mT2x0OFk4MFFkODJuWDdib2JFcVd2SG96cjFWVys5K3N1cndXeVlX?=
 =?utf-8?B?R1F1b1lMZG9WSExLczJzU1ZsRlNlQ3RXdXZSK3BPSVZWbjRNZDE0cVJWOUxt?=
 =?utf-8?B?amJXbWJxeUwrSnpvZlVkVXk3WEZTZC8vQ2xyUERhdUlRMEovb0dWWldRZE5x?=
 =?utf-8?B?aGR2ZFlRR2puU05zblA5aE9MZ1FnS1JvN0NibjZUUThwZUxkK3ZhOEgzR2px?=
 =?utf-8?B?V0pzeHluazJ3YldOVGFrR2tqUHR2aEpjSzQyVXlpOHFMOUZyVG43MkhHUjdp?=
 =?utf-8?B?QjIyTFN0WTJFanA2UGNvOXdnKzJwVHNvMS96UkRuRm90eTRvQkhMQjllbjNn?=
 =?utf-8?B?T2MvRzZiSzFseFFNM0ZsWEkxaWFhUGVrYTZqUi9sL2VQTVpxRE16aGJYdGds?=
 =?utf-8?B?VW94RkZJVTVBVkR4YWE1VkJ3OFk5WHBvQmFPT24rSXc5aHVCU3FWVkJDZ3lz?=
 =?utf-8?B?cm5OejFKY3V5MmdQTXp2bXRrUEU2ZUJIVk45TElyU1J2QTZyQnFJSHBXWkdN?=
 =?utf-8?B?eTlJV3N5TmlrSnFtb2lFM04zdG1icHFScFlLcFVqeVU4eldjUXpWQTltNFM3?=
 =?utf-8?B?dTlhSWJYRk5sUUtRRmNwZ2ZFNUFMYzZjek1qeTVKZTZ6OHkvSFpXZFFsVWFh?=
 =?utf-8?B?MVp0QVRZUko0dDQzTmExVVNXTHh5UmhPYWZZMllzYlE2eTF2aGtxWXFiNmIv?=
 =?utf-8?B?NUxzMTlCSkVhL2VnL3Z0UnRUQXdQdCtMTkRnRS9DU09TR3VuN3BxZjhzV3NH?=
 =?utf-8?B?SGJZTlJmTXJpQzY3b0dPRWlGSkR0cXJ2N3NDLzA3N0s3Nk5hVXo1OVhTaDZ4?=
 =?utf-8?B?ekpxbElMcktwY2pJOElYMUU5M1ozVm9NM1NEVVpXdzVwSGcrUWFkWWF5K2pW?=
 =?utf-8?B?L2JSMVZCa2JER0svV2owSy9qZzdsZ1BVQmwrTkp5TUNNa3lQNzd2U1I3S3hX?=
 =?utf-8?B?ZFpnTkRvMXRXemNZdWd2MnJOU29WTUJCc3JkQ0g0Qml1MUdVeExvTDNpUmJJ?=
 =?utf-8?Q?+aJonyY2ge0/TZI+nrnMT2YmhI0b4oBGHAnRne/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFQyelN1MGVzRnJhNitwUmlMc2JWcXhFbGJtNVQxMUd5S1o0UityemVxaEpQ?=
 =?utf-8?B?R2pNRnlQbHZSV28zUHFpaWF6NzBVRXAzV1h2Z1RaTjR5VzRJRUsrZzQ4QjZ5?=
 =?utf-8?B?c0sxaXhoQnlPWjlkMHRYL1I0eEgxTkcrTjBlZVpwSFZKdG1OT0RWTDVQRThV?=
 =?utf-8?B?akhud0grbzc0a0cwc3U3VWl2ZVdIMG5hR0dhTy9LSStmMzdqZ3lRNTZYbnFF?=
 =?utf-8?B?R0VnYkdBdHpuWFQ3M1JCeU82VjFEU0ZhcE4ybTFMQnM2ZzdjRHFtYXFOdnNK?=
 =?utf-8?B?K3ZGNm9zejc3Z2hGSUs0SUdReXQrMHlvMXJzeUphMlBMOGtOSmJSZk1GTjZ4?=
 =?utf-8?B?T1hGWjJSbVNSN1pENzFTdW9nWSt2Q2hxN2NFcjNqWHZFcnUrOC9zbFhIOVF3?=
 =?utf-8?B?dEsxV040aHpVVnJncU9hWit6N3F6cENuUHJFL2ppN2N1cGZ6V2l4YVM4Rk1E?=
 =?utf-8?B?YTZ6bVIwVlhxMS9yLzBqMFdGL2JGd2l1a0poR3FTV0tHK2RLaWQvZXBVbWd2?=
 =?utf-8?B?KzUrRjdaZFRFaWVFaWtwOVRjeGNwWCtWY2llUTZDb09rcEFMSkZKd3pmOWxl?=
 =?utf-8?B?VmJ4Q0orYjRYdzZkSFpjelNEaVpodVRiN2FLUXZXYkxKSldJcExoeUYyVVBj?=
 =?utf-8?B?OHZtNkFVbHRlZ29FSW1TTDJZOXl4UjdIcUxHa2xNVUlpamI4QURNbmE3UFBs?=
 =?utf-8?B?ZE9FVGR0Z21mamEwbHFEZnQ1dU9HTlhqcThJZFVYbHhxS2dwNnc0SDlVRUFr?=
 =?utf-8?B?WTlIQnhHOG9VZmJuZUNKWkZOWG9XZnRUUVhsRlR2OXNabWJmSG8xQTJXU2RT?=
 =?utf-8?B?UVBHVVVXOGFWMDYzZzRsc0c1T0NSdnJWc1Z5ZFVoMmlKdzVseVBRdjFvb2Iy?=
 =?utf-8?B?WThMY0dWTUFQcmttV2p4eUVFcndtbWkxMVlHektua1NUV2dJclFTKzF6VWVo?=
 =?utf-8?B?YmNvUUNHOGEvc3pKTmxKdGlpNXpiT3YyRHJGekd1YzZzNENyNXNVNVU0Umlh?=
 =?utf-8?B?UVE2NHl3SkI5NUIvdGRoeHN5MUVscm1NOUpWU3dYUUxvYjhiYi9rWGFSYkdI?=
 =?utf-8?B?WnppMTJwcldHUEJlTVhBZGZRQUt2WUh6UTUwdEtldVpFKzlYcEwrRFpqZTFY?=
 =?utf-8?B?MzRqNmluZlZPdnpCOTJxQUhxM0txWkE5TWpSQlNVcGYvd3I0SmtYa0Nvay8z?=
 =?utf-8?B?dG9NNDNPL3NwR1dTQXp3eGp1MTN5eXloQXFmZ1pVeU9YTnVzNGgyeDNaVnNi?=
 =?utf-8?B?WWhRVS9qblN1Z0YrTHR4dGkzUnc1OEVmOW9UWTljVXZtZ3ErUitkaS9YbmtW?=
 =?utf-8?B?Ukk3Wk5yNVN3K3hjZStWRG0vR2F1bnJJYXhRTS9XeWxBME11TXZpckh3QUNH?=
 =?utf-8?B?dC9hWmZHSWJpckVnSDgwbEpRTVl6T1lycExYN1Zvb0doVzJXd3J4Q1p4aGp6?=
 =?utf-8?B?YTU0dmt3eUF2VkpvWC83bWsyQjdhdjE3blZkVDhkNTRhUGZGWlAvYURxdjJX?=
 =?utf-8?B?eEM0Q2VQbFh5Vk1jNTJ3OXN4S1R4M1BucW9kUVZnemhyZlVrbDY2cU1wZjJV?=
 =?utf-8?B?U1JxU29BYm9jUnRRYjdaN09FWmJCOTZlU0Z2Y21OYnVtUURGVWZQbjQ5cnlZ?=
 =?utf-8?B?RTU0Rmd3VXN4Yk9NcFN4NWY3aEpvaG1PTE1CZFZoZDVDSnhtZmJ3cTVrb3lE?=
 =?utf-8?B?QkttRkNQZFJZWnlnME5MdFZScXhLM0tIL2w5eWdYdWZ1ekI0TUtOT1Y0cUZH?=
 =?utf-8?B?cEROOTVYVzdGUkhub0FRRzRsanZWNTF1VWxQRCtXeS9OVUJvdTVsb09KNEdu?=
 =?utf-8?B?cmIwVFl2KzBKZFRoTzcyNG9QT0J1MmsyRGY5N2tXRWVJemFLdXR1cWp5d0dW?=
 =?utf-8?B?cjc5WENZZnZtV2kyU1RCVXdtMnFHUVYzTGFEWnc2Q1QrdnVHdEpIdHhNeXIz?=
 =?utf-8?B?b0RNa0tQb3JSYk9pMklOcE1KNmpFTmU3RlJkdGdJYk8yREcrQytDem14V1oz?=
 =?utf-8?B?L0FjVFh1S2E5bXNEZFQzTlFKL08vZ1RvUUl6UFI2cmFDYldhOXdRMUFiWjNC?=
 =?utf-8?B?b2lrUS8vNTFFeFNKZmhkYkFCeUdxWDRoSVJsOENoVWxwUDc2bHZhaEhmYW1z?=
 =?utf-8?Q?ry5lfb7L4b5dGL1dh+9mkP1ry?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40db2577-d8bb-44fc-e1a6-08dd036a528a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 22:35:34.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1w3PNwZPkXdZ2d++TUYKrkZTq3yi+tINweA1Kg6OE7xfTvE3SNpAI9rZstbqHT/wDEdyS3c62Op+qjj1qpa6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6762
X-OriginatorOrg: intel.com

On 11/12/2024 7:38 AM, Yazen Ghannam wrote:
> 
>>  		 * This way when there are any shared banks it will be
>>  		 * only seen by one CPU before cleared, avoiding duplicates.
>>  		 */
>> @@ -1917,7 +1917,7 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
>>  	/* This should be disabled by the BIOS, but isn't always */
>>  	if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
>>  		/*
>> -		 * disable GART TBL walk error reporting, which
>> +		 * disable GART TLB walk error reporting, which
> 
> This also is not a typo. TBL -> table
> 
> From old AMD K8 BKDG document:
> 	10 GartTblWkEn GART Table Walk Error Reporting Enable R/W 0
> 

There is another comment in init_amd_gh() that seems to be related to
the same thing and similarly worded. That seems to refer to TLB instead
of TBL(table).

/*
 * Disable GART TLB Walk Errors on Fam10h. We do this here because this
 * is always needed when GART is enabled, even in a kernel which has no
 * MCE support built in. BIOS should disable GartTlbWlk Errors already.
 * If it doesn't, we do it here as suggested by the BKDG.
 *
 * Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=33012
 */
msr_set_bit(MSR_AMD64_MCx_MASK(4), 10);



