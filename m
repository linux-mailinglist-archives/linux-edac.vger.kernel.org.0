Return-Path: <linux-edac+bounces-2261-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 174849AF4B1
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 23:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353AD1C21EFB
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 21:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0521A7AC7;
	Thu, 24 Oct 2024 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9mLV/yp"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7505D22B655;
	Thu, 24 Oct 2024 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729805518; cv=fail; b=NTW6kNvoVyzRa+Fu3xiPe2wwKXxSa20DlZuE6mUa1itNt+ur0mXljFuGD2o2aAX86zBNYZEfruOV+AJpLZ6yY4qqNfl59UA3vngqWQJEvE9ngwUBRAeTvse/7nnV4M95BN/OjYwSPUdL+oX1b90LFw1pqHCu+zka7WVXWa5iFgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729805518; c=relaxed/simple;
	bh=8uI0gm66pe57x/i47bI/QHovecPmBW6zpBfcJrTy1xA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nvvMLV8pOoLkHe8YhmWTW04FRvcGMhb+IODCs7HUZ4ws2GisY/8vaiNf6Znbm3Gqb69DtOhtrdMXUyTKru+RcK39748e39UG9bXkexq56Si3Uc7lcEOB/N9GhhCQZG2tIvqzEL29vilPYf+nHfnKB1mIQZw9f+lb5EvJxoqlIIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9mLV/yp; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729805516; x=1761341516;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8uI0gm66pe57x/i47bI/QHovecPmBW6zpBfcJrTy1xA=;
  b=L9mLV/ypW4T5GYcHMPh9Y9X3TtDglVOtLGzfA52VP+Sy136Inr8kxfJy
   CLeFL+QD3lLbUCLt1EbBJGSKmN0BHpmICNaBgKSrjNQmZ9Da6fgeVAgdr
   ToYJZa8Dxkn6CTYQjU4SToMOVw0kJz5bmYFVAOB87zgdwt4ocFDOOO5aH
   0RJpf0rJ/cAYFhiITMmQnOYcAX1nQOsmAAMvb5sV9l78onK7inEzp6QAi
   1lprW4ZrwhkKr1Cb7v4S+wmNBHZtXzocfERH4aFxq/82mT5URZzQwd6XY
   nDMtcK/FGhyl4vfPudX0VTULeMIEGCse/QBlZThhjqW1+rnGuS54GRMV9
   g==;
X-CSE-ConnectionGUID: I04MUgJNQmyvpmSOYQ4fMw==
X-CSE-MsgGUID: OT9SAzFKRRO0ErdPXsfqcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29577436"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="29577436"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:31:55 -0700
X-CSE-ConnectionGUID: zPmI2I1mSJedxrsxiPpLNA==
X-CSE-MsgGUID: +4tMSCfRTjS+6pSM9kOfvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="118183098"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 14:31:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 14:31:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 14:31:54 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 14:31:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITCE6DRjpugu4XSup2OMEixIFwnGAIBYhYeGz8cqhT042FlSnze1lQ5PWeL4S70AvNDSnBNxCJ1S4oYrWxMkL3B8AimaaxVf4lj93hz4uFs8YkQS9gjJtY8NRM+n+bqNQlbsS/VfskJ2Nf8uh759MDrwumUjqLARHc1ZS8nYoMNWAv3D/PCAGUNpAQdt4XGOyT2edxwV7oCQTNc9O78rKnf4Tv7gmH+IE114UjVm9AuL2IctcuQ73fWSgXaEu/9oZ+bs4L073g/Jf5bMjcfICbWH/ZGYf8y63rgbQlnq5MheGjPqvEEyRlLDnTwyWPbi4wMjMPikaifjRwxKvujPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlspAa3ZMk/E2XS/mgnCY+0GmwXI6QaA2YWpmCYvZEE=;
 b=Lepxex4qfaS6+razl4JipTtq/KsDfIYhrn2zqEWv77EPNXcHZa0cSyiL7FL4neYwYvL6oSlPhA2AJahWH808y+zNMZQdXra6ppbdzYLxMpLLzioYhH5Tkj/WNAdTlGZyHn+LC2Z+c8Lab96BAVdPjs9h1PbhEaf1MOdjHwmh1Bh11mIKqBJD9JN0mvBbXGxPa/NcFPhxkJ+ZmxVYyHTJKTaiS07+CCGz9DQiHqqDowVJNgMpT7SIh3Dp7avYb+PZHqPES+TbbcyVodcCH8v/EfUwbHt2yXSPAW9pdx2LyfEU0j2jttMFRgTptJkV2e5DQcv46Y8pUhlOdH6vRc3MEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB7460.namprd11.prod.outlook.com (2603:10b6:8:142::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 21:31:50 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Thu, 24 Oct 2024
 21:31:50 +0000
Message-ID: <dcfdba92-7004-413d-8011-12771636d11f@intel.com>
Date: Thu, 24 Oct 2024 14:31:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
To: "Luck, Tony" <tony.luck@intel.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <c9ffb6b0-9c75-4990-afb5-33094d049570@intel.com>
 <CY8PR11MB7134E2BD84013EF41F8F5AC8894D2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CY8PR11MB7134DED56F51E59273F3B063894E2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB608380793D6F55A62332E0D1FC4E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <SJ1PR11MB608380793D6F55A62332E0D1FC4E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0053.prod.exchangelabs.com (2603:10b6:a03:94::30)
 To BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f28bc1-1a57-4523-bd8e-08dcf4734531
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVFCRjFWM2JxYmFBQkdpUC8rQitONHZsbE5DTTB0R0ZnbkQxdTBiVFV2MENs?=
 =?utf-8?B?VEZXS2w1ajdybFY2NC8zajhCbGwwSHFzVzYzR3VrK1JHTjlxUm4rcEExdG16?=
 =?utf-8?B?M00vRjFlMFVuOEJXOUJySG82eTNsYUh1a21kOVd3bGp5TVY5b2tTVXRjcHNN?=
 =?utf-8?B?NjcyVCtYeTdockdOV2wrTC9sWXd4VnQ1ZFB4K2ZiRkNnK2JRRC82YTZQWWxy?=
 =?utf-8?B?QnAyUElwemZ2MmtnTEhDQTU0T1Y2VUpJVitZZkdKeEl2ZTF1MmpBR29YRkdw?=
 =?utf-8?B?cStva1FSbUhTN0gxVkhFcXJScmFvL1ZCQ01qR2RtUlJReE5mWVFMR1VTTzlH?=
 =?utf-8?B?WkpxRHY5aFJEcWZvVGhKekZtY3F0ZTZwTEE2M1hvWDVVb0lHdGlzejFLOEZH?=
 =?utf-8?B?SVlJSXFUUUtubWtEc0M5b09abGhwVUlFYlNBM0o4WGpGTXYzYWZIbVpxVUlG?=
 =?utf-8?B?TnRRdEpka2hSVHZ6Z1pNNlJmd3RQUGpISUEzSlc5WWhQcXA4UG52UFRBcERx?=
 =?utf-8?B?RGF1RnhiSXNVM1VjTWM3bmNSZ3RHaDI5aEcwTnd1b1ZUcVppZDZsVGd0cGNp?=
 =?utf-8?B?c2NaN3h5Zy9WQXpJelVScEZGeDhyK1BNYVprbWF6bVNZZEEvWS9uSGRQTTAx?=
 =?utf-8?B?dGpsK0dZZFVjYnBwZGhYOGZkUHkvMkY4Nm9JT050TEVSMElqb1RCUFJQcmFX?=
 =?utf-8?B?Uldka255c3RySWxxeUtzT0dueVlaTUh5MTZvV1lCMVpNWm5KK2o0SU9tNVl3?=
 =?utf-8?B?bmN3amcrSjl3SUE0aER4aVlXSnBURVJBMDR2alcwVVZQYXZrUmYraFNVc0pJ?=
 =?utf-8?B?YWxEdGQ2R2xFa09hMzBJbHhqbjBNaXhpdS9nQ3RGVlBJRDVWUVNId05RSUMy?=
 =?utf-8?B?L1IxRXAxeU9MeXVPY0o4OWlSN0ltMTJJWmY2MjlGZHhrM1JwM0s3aHpMQWRo?=
 =?utf-8?B?RUFIbUlWUUVUT00wMHJYdlhZSTVPWlVkTTV5OWRKTklBLzRldVNaNzErZm8x?=
 =?utf-8?B?WGEwMlZIS2RHSjUvTkRRbVZtcUVldGNtN2pub2RzaE5BeElpQjZERHNTWWN2?=
 =?utf-8?B?RlF2MFBJVUtWckNrWlA3bW1yMkFMNTlVdFd3bkZuYVhsWWJLTDZRK2ZUS0dm?=
 =?utf-8?B?UTdkb2VNMXpWNGdrUkdkYzJXYm4yYUx0UUJaRGZqVUZGMmRwSTN1Q24zNGhK?=
 =?utf-8?B?NlByNEIrN0hyRVdyV1A1ckx1Sjl0bUxxaDU0RW1FUnRMRytXWVdIQkxkTWVV?=
 =?utf-8?B?UnJ1czc4YnFNSGpTd1JVekZRNmNiVTNBRk9BZUV6SG5kVzQzaFhrcHNpTEw3?=
 =?utf-8?B?OWdwOTdZT1E5YkFZczVlTTNhd0NrNm9DSFlrV3huUXI1b0xPQ1BPbzZlUmxE?=
 =?utf-8?B?S0xEMnB0d09iS3V2NnowYzZPTmloL3lLbXRCZjUzd3hzVmxCVWtvb0dZNGJz?=
 =?utf-8?B?QlB5Q2ltTDRLM1AvWGNDWHRzTWsvdlc3TklnYXc2VkNkOHFDWU8xVmlQbjlJ?=
 =?utf-8?B?SC82UnU1QTFRMktCR1VDTWNZOGZ4dS9VMmVqelBZVVZDZ0hhY1B1WTdKM1Zv?=
 =?utf-8?B?elJPcXBrQ3FTRzF6KzNWWDVWcFF3cFRWeU1BcFNvdWowL3hpY1BpRy8xbGNC?=
 =?utf-8?B?ZUpDVnV6TkFhNFExNEVGaDd2MGcrSEErZTE5L1JPYzNMTVlJV1d0b1RqVGgw?=
 =?utf-8?B?UXYvWjBHUllYU3NwOVFWYVpERUQybGM5MjUwNnJEYW5tSU8xNk1vR0o0NVNs?=
 =?utf-8?Q?eul2Y7HYU22VG49xnX0dOa0tG0LzotpgP96TNH8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1hBTmxQK29HVk1Ya0RVTzlNQm03VHNCcWhLLzFTZ25ZYVRFcVl3dFcwbUwz?=
 =?utf-8?B?WkJkRTNrek1Wc25UM2pwRFdmR1FjNkR2UGpjZVBvZ1lINHlFV2Y2MElHNm85?=
 =?utf-8?B?WU5BOG9JSkszUHJUQ2RlOWZCR3lCSEd3d2Z1eDdVczZmUjRLRCtmZ05iYlR2?=
 =?utf-8?B?NEs2N3c1T1dWaU1yM09wSmROMlZqUW1kaVErMkhCbTgxQUhKSU5mbEVCU281?=
 =?utf-8?B?QnZMTE51MUZDS0g0T3I4S0JHd1N6ZExVVk5RSkNZZ21tU0lVNXhSUzZGbzU5?=
 =?utf-8?B?czZKODFJK3dVZm9BOU5nYVNsYXgxUG0yRXlUVFZWOFpJN0VwK05OVGR6clBH?=
 =?utf-8?B?T0hqYXEwd1c1T3ZPRFpZUGxNOFl1ZVRKa2VCelppc1p3OUdDOXB3aE1UMjJT?=
 =?utf-8?B?SkJRUUpsa2I1cTkvK2NWV3Y4VHEzV2F4cXZkZVFwajNhbCszVXFhMHpxM01l?=
 =?utf-8?B?N2hsSVlGcnd6eUpXSDJPS0lDL2VqdjRBQ2MwT0EzQ2s5eXZQTTVHQWpTR1p6?=
 =?utf-8?B?VFlLS0ZFdHorc1BEYmJWYmRlTTR1RW4rZUxkNlFLN3pUcVFtUFhhZlhXYm5l?=
 =?utf-8?B?bUJmR2M3OUVDaW5NbnY0dWhWZ0g3VXFmNXZWRE5TZWk3dVhSdndIb2lld3Y2?=
 =?utf-8?B?SThuS2R5V3U2Nko3OTRmdndlSDdpcVdGQjRZRTBMK0U1NVFXQUgrdVpQWWVP?=
 =?utf-8?B?cE1UTkIrUjVpU2QrL2ltZTE3OUhGVVlXSDdoVFMwR004Y09nODljVnhrU1lO?=
 =?utf-8?B?OWRYV3ZuV1FmTVFFZm9NaVhQa1RaQmdNVHd4ckp0VWtpWXlob2dxUmtnWHFC?=
 =?utf-8?B?Z3ZDVmlLTWlSQlR1RG42aWhTTkpFcDNFbHhGdkZTSjJhSm8wZm1IQVRzVEd1?=
 =?utf-8?B?UkpPWm5QajdXOGxoT2haZCtCMk56YkZqSUpTeUVYTVpFZUE4dWthSVVBc3B1?=
 =?utf-8?B?Y2JOQnorY0ZCMHlDdExsUlM3SC8zci9WVDhoZ0tZcEpleCtSMnpFbFU5Yk5s?=
 =?utf-8?B?eGsrMUk1VGVNUjd3cTRJYW5hcUdaQjRMVTVNb1lzamRVdElKS2pCeTNocXVY?=
 =?utf-8?B?eVNSRW1lYVgyTEozM0dIVmlTdWxVQ0RiY0xlNm9sblVoTC9zZWdveFdORlp1?=
 =?utf-8?B?V3NqUEI1aVl1SkM0M3hzWW1zSVJIK2pjdFAyRXhiWHpIRWFTZDk3ZnRlaDl3?=
 =?utf-8?B?ZDhxVzlvVzUzSHhqUHJDSFVUUWR3V1NzcERTVjdheFlxVGtqU05ueGxlQ3ds?=
 =?utf-8?B?VWYvbTZ3R1FBd3ljUFJqcE9wdFZPZGJnTVdpRG5rNEluL1hiS2tqKy9yb3NY?=
 =?utf-8?B?UkVWSCtvTnJReHEzUmtPNWd2V05CQWNNNnF5VlJGQU9iUmxFck9UWFpjcXhU?=
 =?utf-8?B?VHBHOVF2YWdHM1p5cEVGYXM5djloQmIwRm85S282S1RHajNCQ0RYS0srVENx?=
 =?utf-8?B?QXpqZW11RDdsdjZNNVFxb2xQSzJ5SVQxclRjbE5BbFB0WHhYSWg4V1k3YnpF?=
 =?utf-8?B?Qm5yUU9CbnpNYVNZbklGeEI3T01kMTRoU1gzWW82RjhNNzlLRXNtY3NyT2ZY?=
 =?utf-8?B?QkdUNFd1clFlbEs4Y2hpZlZFa0xKNld4YUdQaXRnNHlKaUJ2Y3BPNUV4cXBG?=
 =?utf-8?B?UU4yM3BoMkxwUWdtUVU2UmdqU3ZPMS9VZkpPdGk3Y0MyaGM0YW1vcFpWa0JM?=
 =?utf-8?B?NVROcDBZcERzVjR4K3dZamZPS3FXdVBsbS9HNnloUld5MyszVkQ2UG01NWFi?=
 =?utf-8?B?VmpSeWlub2NoaXdxUDJMcWhleDVFRFNQdVVCSDlrdm5WZis2c29Ubk9NNHh4?=
 =?utf-8?B?dWZZbUV0NTVvamhSYnY2SnVWM3JOd3VubktUcHZDMk5Ra3A3ek81dW5PS0dr?=
 =?utf-8?B?aERIMkltbGFDOFlycUJPazdVNDZzV1p2dUxVblRaS1hzbm5GS2RLNmlhTGxC?=
 =?utf-8?B?UjVQb08zcUlJM29ZS25Ua3BwY0dDN1hrWnk4eWJwU29QT2JBMlE1cWkyMlA4?=
 =?utf-8?B?MHIrOHRPZDZMZGZoY0d2M3A2MUxjRWc2UFBMclBKNG9wRys1dUVjYmI5bmVL?=
 =?utf-8?B?UmdhNnJXWUZlcUUvL1hNdnhRWVdZRU51YzBJSmdnY3J1ZmI3MW5LZnp5OFg4?=
 =?utf-8?Q?tWmpHEo+oECh8TDPuFDa4gcEM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f28bc1-1a57-4523-bd8e-08dcf4734531
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 21:31:50.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3yqm3p8RD+rI/KBLMeWknex+wysfbYFu7FY1vL0ImmWuthqTxkfhhtG8AdnomySkdzLjbEKC6TaH7GfOZCFqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7460
X-OriginatorOrg: intel.com

On 10/24/2024 9:42 AM, Luck, Tony wrote:
> -       if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
> +       if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks) > 0)
>                 mce_banks[0].init = false;
> 
> Updated code now matches for families before 6 (486, Pentium). 486 would never get
> to this code. But I think from the comments about machine check bank 0 being magic
> that Pentium had some rudimentary support.
> 

As you mentioned it yourself (the last time I was concerned about family
5), the following check should cover this scenario?

> @@ -1924,6 +1924,10 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
>         struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
>         struct mca_config *cfg = &mca_cfg;
> 
> +       /* Older CPUs (prior to family 6) don't need quirks. */
> +       if (c->x86_vfm < INTEL_PENTIUM_PRO)
> +               return;
> +


Sohil

