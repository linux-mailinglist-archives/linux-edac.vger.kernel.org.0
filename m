Return-Path: <linux-edac+bounces-2148-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0AD9A4A60
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 02:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC02B2192C
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 00:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F017E;
	Sat, 19 Oct 2024 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdPoDizV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA860256F;
	Sat, 19 Oct 2024 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729296295; cv=fail; b=FyPObHCckJ6gTbgWj1QuqCYzg64vy1ldkRctl0YwrjCXnNhdgK6p7pGe4KBhE5M7lYIsAmnv6yQXsX3bjhG5vZmHl6Wir82HNVlQdVoPfTwTDIR38Bt/gnlkRaBDIRkIp4FGn/Qye+7MWicJ4Cf3fJKQQGWjc7fT5AM/c15gF6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729296295; c=relaxed/simple;
	bh=Zr/VNVtJgiZV1bPSwwXV1Qg03fPLkqOkRJXBeHS4oic=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m+i0+HqZvJNSi12tFveAZOpF+hd4WUZGkknhpxtAauBBymBcE7RgU8J2Mh42LRoYMLXLLl7k4YzEdRILlZ1D9O63Lw3S/A+YGpqHy+L1isp9wsHcsVjcdIcrzQNC9LCQjRQ2d6kdsIF382BOA/aCNKDIJom2lePw3D9e8mlhTrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdPoDizV; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729296293; x=1760832293;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zr/VNVtJgiZV1bPSwwXV1Qg03fPLkqOkRJXBeHS4oic=;
  b=hdPoDizVp1qiy9OboDRUrQXPDIILpO3lc7QOZ503u3p1G+vAwJALyfi4
   Mpo9Vz/yvJQV2roVslUEfxUtIliuUk3Nfz6UgF3WlrYBxYlbwd1MykZB5
   Kkdgk78IR7Tg8YuDIJb2YApas8IPSIhEwFAPMcGbSz5GbBMM6+W0hbnu5
   GqB24rkT4y208F3Uss+XOWBXyKGi0CS4Rfiti5aIpiErI64UWvYEeuMiu
   JtRMXRGT47jOZURWaKR4p1Mu6BVJpVWtW+Ffmp6s2lXOReFj98R2yxoVa
   fRymrJSwUvLFJI1gv2fbT27M5X18IdYKLqOK7xthTCYW5Nz6mu5XdfuMq
   w==;
X-CSE-ConnectionGUID: XO0aP1/8RoKLCOSZT5Y5uw==
X-CSE-MsgGUID: UKGEwloRS7mBh22KdkTCRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="31705387"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="31705387"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 17:04:52 -0700
X-CSE-ConnectionGUID: LRycnoGARnWLORBbuuKuzw==
X-CSE-MsgGUID: yRQZjTmkRyGT84zz9ODIKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="116466464"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 17:04:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 17:04:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 17:04:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 17:04:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 17:04:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 17:04:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7w9srMl7cdXq33oZNscRTkxhXBx8gThyrstniEDX7Q81GP4eiQevrVQlWwCQzDn+xLHYG0RRIzmdGQZ8+2fpQ2/EwnFFBZUaqs/kHLgFHlpICq00iR0JGXxxm+82iB4gTP1pCnIBi2V1Wq52uRzW7+lzt3BReFRlrcVqCSfAIc8zKqYveVOc+bTcrzB03ZIXEQ7StBP9BwrEojllp3LwJ0A5wBB3i4HLOycWgaFTOdIP4XBzkulJDxW1O1gDGTGcmP80rsjkkVRLG9Qs++f9dxuJdql3TDfcrLLvcJaPzYeVIaK4rCvC5fpUpxFPbVYWbhR2CtlgoXW99EE8VAFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EPVwl6ifIOmo0dVsudfiTZEa5WB2+fkLdZxoU590xg=;
 b=A410v6BxlC084Gbw3wcZVBt/0Nj0Sn2w98guKkp86u5obxMCD1AP0SHdBawjBzW8VY9KASuJ4qVw085wRuFiZlCQe/HJ/a5oQ94smaSL40n4mSnUVaQZ1Xj2ZzAeNm/mccD6AgHmGB4xnAzoS2hHjBLxfpVuw5WDgYZJd7eNLWUaiRhbHTNgv58l4mMhyJyrPupd/fPNqCAmsWUjUiG7mGHPgcFFs0rheBPdHvXNXHeyDKSQPHKpbrS1yDdz0oQ8luL4BZb5roJUIDfCX2eQSL12/yOZAqdvx0Rv/R+44sVzTR0vkW8WidHAXI9WDoCGRzXwa8/7i9G2hsJsJ2LsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CO1PR11MB4947.namprd11.prod.outlook.com (2603:10b6:303:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Sat, 19 Oct
 2024 00:04:46 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Sat, 19 Oct 2024
 00:04:45 +0000
Message-ID: <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
Date: Fri, 18 Oct 2024 17:04:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
To: Tony Luck <tony.luck@intel.com>
CC: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
	<dave.hansen@linux.intel.com>, <mingo@redhat.com>, <hpa@zytor.com>,
	<x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::35) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CO1PR11MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: 10dd641f-d33c-46bc-1e15-08dcefd1a3e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFQ5YnVraXBqNy9VdmFlRmVlN2d3VTF2cW5IUHZTU0QyTXQ3bHRIQjZTcTJa?=
 =?utf-8?B?d2Y3ZnRuK2QyVVQway9Yemc1bUphWGNGSDMrckQzQjhrWVl4YWJtV2dPQ1Q4?=
 =?utf-8?B?K3F3aDk2T0tHU3hiQXpYcWZrUE9CK016R0ZJc0tZeE52RCtCWGZNaVQ3ODRJ?=
 =?utf-8?B?VXp1TytUUUd2c2JYTzNjMkxIZmpwOUJKZ2MrSi92VnlHdDVpS0RIUTdwcXR0?=
 =?utf-8?B?OHJxNFd6eWhZUGdBOUhibzFLK0YxMU1oNHVNbWxxM1ZrUGhBUjRlTUR0UXdL?=
 =?utf-8?B?R1lrVWRIY3UvZ1hrbFR5TUl5M1BCbDJtNFh5TC9lelVQUzZMSzZkWnpvc0Rw?=
 =?utf-8?B?LzZZakNwck5Ea0lWbEdyTFZrQ2dQVytjc2k5aEtCWkYvSWJuYUdYMWd5T2pD?=
 =?utf-8?B?WkdENzRqejNPU1l6SXBBdXFia0Z3QUNUTktPQTV4Q1RjcDU0cDhOeXE1bWRa?=
 =?utf-8?B?Nm9NR3BZS2ZuUzQycjd5cXBzbUdoWlNJZDZ0SC9lb0VmZ20zaG00YXU2c1Vz?=
 =?utf-8?B?cnFDRW5FSVNSVWNBbk5RZXpZR0NKeUM0ZEtkYlN2S1EvSmFuM1VvdXZhNDNa?=
 =?utf-8?B?T3Y1L3pPNytETzRiYTMzT2dRRDhiMzRhWFg5MGMzbVliUTJka0ErNTYvY1Y3?=
 =?utf-8?B?NVY1cWlsaWNIeDFHZWpyL3E1VExXZDF0eHRuZTZzOFladkpaNkRpVEVxdXdM?=
 =?utf-8?B?M2lKOEpvL0RWelRZb05EV1IxUDdVSUpHZ215RDc2bEN5SFlFdFBlNkRQYkdp?=
 =?utf-8?B?OVAzejV0VVp1TWt5aWYvcCtzdEJRT0N2MkFkTldiWFIyQWZEMWs5bFcwOGJv?=
 =?utf-8?B?YjdVNllnN1pWQWE2b0J5Q0FPQ0tJRnVPRzFGeXEvZGhXb1RtdDJMS1VHTlZ0?=
 =?utf-8?B?emJYc1BMV2h4K1E5V1RKOVJDbUdaLzN1WDQrb05kK2VjYXJUVjIvWGxZL0pW?=
 =?utf-8?B?VjN3RnlJWFIrVlAvSnJMNHV4ZlNKSStoeXVaZVFIaEdReHAxYUthZnNuTTEw?=
 =?utf-8?B?Q3pWeGN5a1ZBQXJNdjg3VEJoS2Z3V0ZMY3ZYNjR4TGliY2hSZ3k2QXRSSHlF?=
 =?utf-8?B?bXNadDZjOHhsQ1hlNlQ3NllWQmNFMWZJK1puM2NjeDA2WGx2VGVpVE1hbnIr?=
 =?utf-8?B?TWNXZ3o1ZGxiYWFoSnRpYXorV0xzODduMnVrUkQyUG1UOGhHanBCdE1XcUpO?=
 =?utf-8?B?eDJ5ZURtODhyUXVDbjhsRHVnMHNRd3p4S0xWS3NyYTlISFBqUnB1bS9aekgy?=
 =?utf-8?B?ZEE4SFpIT3FrTyszb0pPNTlHbmNmNmJPWm1BOXpGcUFscUhkMU9JSEYzb0lu?=
 =?utf-8?B?RlFRMW1MRjBIWURiVHg3a0l5NklFVVh1bDFwcVdsclpqaXdlbll3L1ZHUC9X?=
 =?utf-8?B?STIzZXRlZ0ppTU9Xek1iMmRTWU1Hcy9jNytkQUE2UVFHekN3dFFWQmVJNHpy?=
 =?utf-8?B?NStYdURPN2Y5cWJELzBlWk5GaEp5SzRuN1FIbXR2MFp5UURJTm8wb05WcC9Y?=
 =?utf-8?B?NUxtNHY2ekpkcm85dlI0WW1QR05zVmYwT3NWL2dWQ3hYVk1VQzcvK2lQWDhR?=
 =?utf-8?B?T1MwSUJYMXBGbmJwcE1FcjlOa3dDNk1FK0oyL0xIVnJjaThqdDNBamE4dzlZ?=
 =?utf-8?B?ajJRNWI1NzR4STh2cUJlMFY4M3Z2RVI3amQ0aDAzVzVCdGx4S0tDN2VLMDcy?=
 =?utf-8?B?QlJsMlZvQnF6dzZEL1dxd25ZaVRlL1kydmFsSzNVbG5ETC9LMzdpbERybnd5?=
 =?utf-8?Q?NYgQFSA8zE4+/ILctZAsX5RPt5BQFjpdI4gC9iw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTNwdU03cU1LaEltQk1aczZBcjNlSHRMUHhnZjJJSUhVOUIvYnpZdjY5NWZI?=
 =?utf-8?B?ejhmNHIvLzJaVGh5clhIbXhnRWN6Q1lyL25ldDV4OXpCbkRrcmZBUkxISnRT?=
 =?utf-8?B?aEFoT2RpM2dPdXdJR1c2cktpYmVZSDFWZDBWakdXQ1JmRDd6bjRJWnNlYm9F?=
 =?utf-8?B?UzV4MEMrdFYzQzA1TmN1TnkyYnBGbUdVNDN5WkIzcWJid0M1R0VTcWxVaWE5?=
 =?utf-8?B?dTIzM2x5U0doTG85Q25SVkt1VllTbm42My91WHhMRWRON0pSUnAzaEd0b29H?=
 =?utf-8?B?dERPNmJ1UElQNENaRFVCZzZ2dW1oSng0cjFvbit5SldHMlpFQUpFTHJmZWlY?=
 =?utf-8?B?VzlxZmxMMDVTYXVaaXducExUZkZSSUo3MWc4MzlaeDRDVHd0NmYyM1JVOEVE?=
 =?utf-8?B?d2NPRi9KaTdNMVNSSGpORlhrdXVGYWY4bVNlUjZQVkRENVZyVzg2bUtoaUhq?=
 =?utf-8?B?c0pVQStsdEtqdlIvTnU0cGVBbjZFd3dYUS9xQlM2RTZBVFRzWERmM2NDTGMz?=
 =?utf-8?B?VUd3WURHRXIrQlkxV1VBVTJ1MGhHOVF6Nis0d09TUnBpQlE3WXRvTFlhVWxS?=
 =?utf-8?B?cHNYOHJyVi8xWkw5aTVDR0N6MU92My9hdGpkSnZEUG9RSnhRUmI3ODBxOXd0?=
 =?utf-8?B?MDdNcForOEdHWm8vVjVlbU8zcUlpTGUwK0QxeU94Q1FLZndKaHIyZlNGdHVv?=
 =?utf-8?B?UVBaNmE2RlVnREJQWkR2UVZaZy9uZFkzQjUwaWVBSHAza0VkUGc4YzVoeWtV?=
 =?utf-8?B?dmVVang5bWpEaUlPdFpQY3lMYytHN1d6ZTgyL3NpeFkyZ2kzemJmTEpudFl3?=
 =?utf-8?B?dlg3TGRheXhKQUNadENlcTFZQ1plMWhzakhpR1lpa1IreGd2R04yZUFxUzEx?=
 =?utf-8?B?aDQxTE5pNnRic0diQ0F3clpNVGg4c3dMTC9EVEdreXFvYVg3bVY5UitqV3FP?=
 =?utf-8?B?dVYwd2c0aHJiUUprRW5MQ0tCVkN6TlZ0L0t0eHcwcDlFOVl4NkdlWEl2TkJB?=
 =?utf-8?B?elE3MzNjTHpFQy84clNvaXEzVlE5ajJQNktvczVWaFVVbzNTditsN2p4NlZD?=
 =?utf-8?B?QW9MM3htbGp6WHVsRXY1cmlVQmJ0cFZ6dDZuWjU4NE5aZHNYQnNzS0YyZDdM?=
 =?utf-8?B?YXlUeVJVSTlFa0NTSW9MMUJKeE5nRlc5ZWpJaVVPSUFCNnNaaEVrbHhiYm1i?=
 =?utf-8?B?NHdkYlhmdjZ2RnhCbFlRSTlDaEtaWVd5ZkZhUFZCOFN6bFZueVhmYVBxYnZp?=
 =?utf-8?B?em16RXpuRlZ4VGR6elVyMGdKWU9zQmxOZVowc0crb1lLSWY0NXBiZXQ0Zk5S?=
 =?utf-8?B?MW41ZGR4cnJZSDlpVU9sbUZINHJiNkFXTXFpM3o5eUtVeWFObnludWVvSUZp?=
 =?utf-8?B?MHdnVW40N3h1dlhadEhuTjNwTU9UdDJ0UVE0QUJJTy9ldVVmNFZQMmFuNVdp?=
 =?utf-8?B?bko1TnBSckd4eWIvNloxQ3VVR0ozN3Jkclg2YzkwcFpmdS9OWXY5UnF1b2l4?=
 =?utf-8?B?UU8yeWZWYnVDQmV1WXJMQnZXbTUrTDBJK2ZpcHhJNlRtdk5WQ0p6ZjRQVHpx?=
 =?utf-8?B?R1Q2YXU3c3dDTG8rU2hmVUlWbDBIdHFlZXVLRXJJR3AwVnJPOXl3c1R5cVRK?=
 =?utf-8?B?a3ErQ2dSWlo2R2YyZExnT2dPWnV5VGtKdi84U3dBdUNxNTZ3bXU4L2pUMjM1?=
 =?utf-8?B?Ym1mdXdkckU1S1B4eFlvN2V1alVKTyt3djB3b0g3cjZDdE9UTkp3NlB3OWMx?=
 =?utf-8?B?V3ZlZHlGelh0ajQ5VWM1VnJkY21WZ2t6QytFOWtEZDdVQ0tqUlRidnhUZ0RR?=
 =?utf-8?B?MEhNbEd4WksyR1ZyOVFkamc1Vkc4cEJieG9pSk5ocHVja3FteUtXT1Z1QnpV?=
 =?utf-8?B?QVVvcG1VNjV6MVpnUk5SVVlFMWpxbGlHMS9RZFJpZ01Ba2JLU2J5amJHcmsw?=
 =?utf-8?B?Q3YzaWxWSURtRlh0UlBaUzZHTUNiT091QXBwemRpVmlzTnd1MGNTaHhjeURY?=
 =?utf-8?B?cFZYcHIrM29WMHZYVkhkR2d2WUVpTjllcjNWZG5aN2FDblE2bjR3K2Iyalk2?=
 =?utf-8?B?Tk9sZ1J1bEhhYUl1Kzh5cTQydHRKeDFua3pYdURSdkVZazZNSnNDQXRKcU1L?=
 =?utf-8?Q?usimFyfYbv61cqD7DYmlQvGU5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dd641f-d33c-46bc-1e15-08dcefd1a3e5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 00:04:45.9071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 848Or7GYZsb8B8276P6O0kJOpF4dvXoiPMzhZ5C/mRnEyWMO+JaCU2O3pKHxequVLo/O/pNA1adYd87Gntn5FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4947
X-OriginatorOrg: intel.com

On 10/18/2024 1:14 PM, Tony Luck wrote:

> The vendor specific bits are large enough to warrant their own
> static functions (as we do elsewhere in this file).
> 
> How about this (only compile-tested) patch?
> 

Yeah, it does make it easier to read. Can some of the hardcoded numbers
be changed to vfm macros as well?

