Return-Path: <linux-edac+bounces-2152-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6D79A4B5A
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 07:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050572842EC
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 05:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5861D5ABA;
	Sat, 19 Oct 2024 05:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+3bXOQW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F95478E;
	Sat, 19 Oct 2024 05:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729316768; cv=fail; b=JZMUxldbmekzinaEOOzAiWQZtmrxDxpXSA/Yh8KtWpIKZlC+G0jYPo13p1fQR7bAir8yk3118wAayWQJDvvi/3UgQu61FBbZRD02eL5BkUH3J1XxtQ88FK8t9prMPXGJPbdKzhCuAR0trBf4BWPxgOLKXEaUvTb0eaVjtNpDcMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729316768; c=relaxed/simple;
	bh=6i52EW2Tu254qEPQVKFRpVgqw6i3Cj4ml6jCTF8zM1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XiGzqE//OL2ZDwcB0Yy5Wf6jgyAsu/lXZ97Cver3/2eFIHVDOLTJ7UEag0CzZrDkqjt3f81rMao3fmvxKJaIkWu7Quz/pVpv8jojciexCnTE2YZIXEgHfLIr9KcYCF1mIebtuaeOxq2t39MIenacQ61kLxou9BRMgZzJL94On1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+3bXOQW; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729316767; x=1760852767;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6i52EW2Tu254qEPQVKFRpVgqw6i3Cj4ml6jCTF8zM1A=;
  b=a+3bXOQWtpwcaYqlQWShlfmes7AI0KSKlTOXt34ndtyEX2poxfTl0Bnx
   CtqW7uLaad7T9LQ1fj5HmMhC8XZaMHC0k0M7wP7zYMlsAjm91OnzLgqH/
   Dm29p0AlWJajGb3oiau4VyuiG9B2Xb6wwlXlQhFfsSfddg72DwVMbwXSv
   Srmk5nFtoxn4dNhKn1UnjsmutwiPXHj96nxm5362PA0LYE4YLULvqLg5F
   a1+pP+qableXKcgLh6AVj5VVC2qKUBXue4Y6Stg/YEjWxIubUNn/kLM+4
   4mIpM3LAoFZVkVwYJFH3mpay9qUkzn0BpfyIjxGGt27xJIssK9bbVHhYV
   A==;
X-CSE-ConnectionGUID: rdzjb2D3SN+gHE3Fsen+mQ==
X-CSE-MsgGUID: Ag8Ch9FcRQiJbWE+2AxDmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="40254760"
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="40254760"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 22:46:06 -0700
X-CSE-ConnectionGUID: oXiaklkNRdyS+9cZjhimVg==
X-CSE-MsgGUID: Xow13+MHRlqqAPX7HlGdyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="83022644"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 22:46:05 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 22:46:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 22:46:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 22:46:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 22:46:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 22:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kyr2GKu4K44Cz+xxmuaG2tmshKiZnjxEhAF3ZjbqA6uEx9yN9PbnQDhLQyUDTMGey0dhhp6EvxvEx6M0D9NpnWJxFFMoF62Z0s49CEVz+zl6L6z93kP8mTO208ZJAPf0QA3xxUApwylsU3P7M3zv+5HaLkHWicS5EBudeA3tkZA6jfv/92HL4g33DlchnmaA+FARVDd6Pi51DDY0B5twCXeJCcKLv+zfpnvuO8P52frsj7DAoNI1fAekMoEorHAP8AdkTWW+S9ESv4yWyfufQIbnli0XABpgv8H8wQuGbAG8BdvAMlIAmUkOM8lgsfaFoQwgrcQ2v5s+7B6SF816IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6i52EW2Tu254qEPQVKFRpVgqw6i3Cj4ml6jCTF8zM1A=;
 b=u/lFnFxFaNFTfFTsAA5Y18K1RXYSl25XueC1tm29f6OVZRtrAuTxTBh/CgFnB4goEPmzhsxVkDXvqFu00pITTCgF3MVuIR+Q9866Lb64Lqca5eN/rElnEX0UmV+zKoo+yiM4H4hGPpGGbypTn3cj1OK3S5ED7xo74BJqiQ8FF8wnlBd8acZKJa/kkFchG9uOe2y/GlxOoY8JojPQbhWmQLIcAkM/GQRJ59JEOJgn4ohH4kpyXHnQ36DT17xA1ONqGyifpM5qNA9qyJH3KcSmuZUk0Z4B+Qrael7+Ved8CPyPIh+ZhcStkSwgjLHSxybeROnCczRM+7BWEVysWlsWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by LV1PR11MB8843.namprd11.prod.outlook.com (2603:10b6:408:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Sat, 19 Oct
 2024 05:46:00 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.024; Sat, 19 Oct 2024
 05:46:00 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony" <tony.luck@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Topic: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Index: AQHbH8qMGT1zWO0jCkCWfyye27yAq7KM7JIAgAAIpQCAAEAyAIAAVvpw
Date: Sat, 19 Oct 2024 05:46:00 +0000
Message-ID: <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
In-Reply-To: <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|LV1PR11MB8843:EE_
x-ms-office365-filtering-correlation-id: 588ffebd-2790-4c86-ee43-08dcf0014fcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QTAxLzVJbTFpdzJmRFhzV21lU2hrV09uR25SUk5NRGlPT1VxRnQ1anZFdTVh?=
 =?utf-8?B?MDJHb1VyVGNvTjh6ZjhONzVzK2xoZTUzN2JaMVQwcjB3MXVDS0FRZ1NjcXJ3?=
 =?utf-8?B?WVl2dEZqODdRZkhTb01XZkZKNHpXdkRxeEYzZUFYWG94VXlJYlI5SFJ4cUhH?=
 =?utf-8?B?d3hBQnRvQllycllTVXd6VHlubTVOb2o1dVRnTWxsQVhoY1JxSzhudjN0bTlQ?=
 =?utf-8?B?NnV6OHdFZXczZ3c4UW1MOEJ1SUxCeWxiU2V1Z0ZQQ29ZWnFXNGwzUXl2OUlv?=
 =?utf-8?B?Yjk5ODJFcmJDYWwzR0UycjJ4aEg4MXpXUmdPdjhoYUhKdXZtWU5YV2g2c2dV?=
 =?utf-8?B?RGJ0bVpUNFZvNTZMZ0dIRktuZUx4dlk1NWlXUzdnK1g0Z0xQQ3VkNXBITW5k?=
 =?utf-8?B?TkQyYWVDZC81QitIOVBOaUlpMmVxTDVtczRteXJ3dEFTZmRFb20zMm0wSmVV?=
 =?utf-8?B?K2JVY2s3aTVPR1o2T0NrYzZXRytIby9zYVAzQnZMbERQeDJFY2xnaDV6RkNT?=
 =?utf-8?B?a2xZL0c4b0ZzWWVuQ0JKdWF2djZUNE9tb0JDRzZxcHZIZFRNa1lKSUpaZmVm?=
 =?utf-8?B?RHc3QkcrZ1ozcXdiZ1YxTHI2RGlaS1piU0FoTEY1dlpQQnJkUkIxYVhwbEFp?=
 =?utf-8?B?THR6ZEdoVXVHazE5S0Yxc1pHNHNxWm5WcDI3SWdqZzRaVFFrYk5Db2dSYUdr?=
 =?utf-8?B?RGEwOFpoZ1crOTMzM2FwVVRTOFpWZ3pOdEJraG14Q1RXblppbnpQci85YU1N?=
 =?utf-8?B?MVpEOVVwTW9MNzFIMkYzUGltWU9iWUVaSW9haE5ITnRrTFppcXRjeVg0a0w1?=
 =?utf-8?B?SlhuWjdBVlFtZGJWS0dxU0F2R1Bld0xqVlRBWmF4cXB5QnFxWXFrYko0dS9q?=
 =?utf-8?B?YWU3UnJiZXozbGVaZjdNYlJrZm9mU1RFSFN6c0JHM2dYODJhT1JLdldLWU0r?=
 =?utf-8?B?ZjN5M1NsZkZPbWRockNqRlR0alpIMjdseVBxNm8rZVJ5OEcvV21vZDBXS0Ny?=
 =?utf-8?B?WE43Vk1Fako1MEc0TjNhcUVMTGhiMkpibTluWXVKV0VoNU9WaHduY1NrUDJv?=
 =?utf-8?B?UmZUaEh4MXVCbGplZ3pTK0Z5Q3U2WWVycEg0cHBmb2xtb0kvYXhlaHU2OHZy?=
 =?utf-8?B?emhtS2gvb0hkTzhjaFhyZy81ZkRqWHNmMzM2dnI1dlQzSHhJMjNKMllNSXVo?=
 =?utf-8?B?cThHK0g5dGNwYWNxOEZTNC85R2tlZi94QlUwd3BlcGl1dWdJeEdmNHVuTjhQ?=
 =?utf-8?B?WmpMRm5ub1NnUTJCTlZYdnh2UU1XYzYvcXRxWDBkaElUalFSbHpTekp4bWNO?=
 =?utf-8?B?bWNGOU1UUFB2aTMvYU9lZld1WGZJMmUzbml1UUlPTCtsdXVhMHNvSUlaaElm?=
 =?utf-8?B?bHlMeERqQlVzWU5Eak83NzgvdUJRVWY1cGVkeCtCVWM2d1RQVW1YcE5ONlZo?=
 =?utf-8?B?c09LNDlvWmlTTHlFaGREWERvaEkrb3FoR2Z3WVFKMndjbHd1M25BOUpOcTFa?=
 =?utf-8?B?VThhSEdUMVJSY2xZdXRyUUxZOFl5R1ZSQmVMa0dFbmFrTlB5OVBuaXFYYmlo?=
 =?utf-8?B?a2VleUtxeWgzajdlR2NsRUExanVwcUlnWFBLMGRQMEFiQW4zWFRjc2xtTTZ5?=
 =?utf-8?B?bTEvMlFydmtSbXR5cCtFOXhiTlVDM0JJNzlPQU1vNkovZDZSUHN4SGxMZFEy?=
 =?utf-8?B?bjVVbG1paVhCOUN2RnZIWDVJbUxma0JtUmVCSy9PbnVjZi83YWVNeFRNWmZq?=
 =?utf-8?B?Nm5xK2trWVNxZXJEMFh2dzFMVVRkL1RrNWR0WkVObjc1SzhaYzBzZmRwWHFD?=
 =?utf-8?Q?Lx01ksSApOs+X2jbxSJA8bhdsVUrmQhhepvbo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVBTaG9VSmM1Q0RxZWxrVzFETVZmbnZJNnhHOUQ2c2V6Q2s2ZXNDMGVGcnFl?=
 =?utf-8?B?Yjd4UHF6T2V3VUI3QkNIc1lXWG9UZm02NldJUlZ3R2dRTFBiaU92L2lxUTZk?=
 =?utf-8?B?Wmx5Um1mN0VCakpKVFd1K1RSMjRlL29saVJrcHhLOUlPMnFJTVJhSCt4aHM2?=
 =?utf-8?B?a3l1amE0ZWwzZ2EvdFF3eURxNm5QWjNuQUNsOC93MWNhUTk5UTVHNnFIQzRT?=
 =?utf-8?B?ZVdjcWd3dzcrZ3ZLTVhZN0djclFhbnRac2l0NEVqaHFoYUxkMHZZNTA4Wkww?=
 =?utf-8?B?aG5VN00wWkw3bURyV3dUM2o4OGNRRzZwQmRtMUxYRy90M2RxQUlJbWdITEtr?=
 =?utf-8?B?eDJiMWxqRjdCQWpJclE5WXNBa1hxb20rdUJmVENTRUo1cXRUbEtETEVraDhX?=
 =?utf-8?B?RHp5VHBaakRKaHdDK0VVQXdjTjNWektSUklKSWZyYzhhbk9LQUV6WHNlR0Qr?=
 =?utf-8?B?SXB0YTNzUG9XNHJNVGxHczdWVVVmNFJyaUsyYXF2MXhUZ3VMZ3FQNldSc2xy?=
 =?utf-8?B?N2JBWWMySXdPV2YybDRPS0V3TFhhM2FGMGZDREhLNFNORCtiL2xYR1FsMm9O?=
 =?utf-8?B?aVFjTDlIeGk1QmVpem9kL2k3c3dOVTd1SkxkRjdoTVEwajU4VzI1eWs0NXNo?=
 =?utf-8?B?UVpHTjNqVmowK2lsTTd6amh0ZjhBbDBwM3E0QTJ4UHRBeEthU2VIWHFzQ1RN?=
 =?utf-8?B?TmE0VGtkblc5ZnFPOGYxRjIwb1FZTWJnekIxQkhQV05HanBieFZjUWg4V3JF?=
 =?utf-8?B?R3ByanVSb0NVbThqYkpDL3ZIaEZjaEZUeGsraENOUzJ3MTRqcGgwUEY3L2M5?=
 =?utf-8?B?ZnlpWnduMjBTd2ZkZmxHVTVaQlEzbk1odkUzS0R6YXY4eHFWQVUwcjBvbUpR?=
 =?utf-8?B?emVFZW9OVGRzWVh4emU5d25lMjFNWnhYN3RqL3JRNFJCK01obWUxeUpxVUF2?=
 =?utf-8?B?WW1UTURsV1lJTW5DdmFPdnc3T2krVUtCRmdJZ2RJNWlGcS9HNXRhUjhBbkVm?=
 =?utf-8?B?NnpXdFFEQWtSQTBpMUVNTHhSenR2MnducVdFR0lpdEU0T01nSzhsWkJydStS?=
 =?utf-8?B?Q2V5TUxlczJtQmF6ZmF2R3FRYjcwZWtNVWw2Y0FpN1o0Q2VhaHNreDJEbUN4?=
 =?utf-8?B?MnNkSlRBbmVoZmpXaTdlcTRRRUpTMHBIVUtxdm0yd0NaZXdKNHNYTW5aR3Ax?=
 =?utf-8?B?dmlBTUg1VXlVZnhoa043RFpjenpabVBwSW1JaDdENXJ2MHJEcWRITmFuUUps?=
 =?utf-8?B?UHBGZGZUREdwYWZPWmtqd1NXVzVMTDF0SEFZbzhITWVQV3NoOWlzTk9RY2xx?=
 =?utf-8?B?TkFvaHF0akVKNEJaeGl2cXk2Nm9QaG0zbFExMzg0emRpTWtwU1BZdWNvbnVI?=
 =?utf-8?B?L3ArTmhZamNMc0xxWjcvTTJha1owcnpMcFJEMVhDc2F1M3FxaGFLZ1d5NmFK?=
 =?utf-8?B?TUVHWHNYVkRqM3JmdFA1U2NDV2NZaC9Vbno2RVZqOHRyanlkOEVPNW44bVI0?=
 =?utf-8?B?ZFlBN3E2MmoxODhBUXRhaGs3a1VXd2xKSmpNeWtLUGt1bERIdUU4MHJHZDJK?=
 =?utf-8?B?ZXZWSUNVZTI5b2twd1NTVzFZK29YREJWSE43WWQ3ejQxdHdkZVhMZVJLNDFp?=
 =?utf-8?B?N2E3SGtMTVNOK0dpN25PN3YraEc2cW1oVHpZMEtrL2V2c3YrdldzWEFXOENN?=
 =?utf-8?B?Ym1ZNXE5Q3VJUkM3bk9HNkp3YXNxWVdJeVpBOEtRMnhOT3lXVW9xQmNwMFlE?=
 =?utf-8?B?ZFVyM0NLMitRaU8vc2ZJQ0tjcG5yelpGdXNYbHJ1a1VlSzk5SzEvdnh5WEJ1?=
 =?utf-8?B?MVUxV0ROTlBYVlp4N1liRGlpVS9oQW5ZdXdGNVJKcTZrVkFQMnl1QU45bVgz?=
 =?utf-8?B?VEd6OHAzVHJCbG56NUJnTWhJRWNkcm01V2ZKaVVmRVVpMld3REtVZFcrVmZD?=
 =?utf-8?B?RmJ3U0hhRFF1akJ1MEN6cGluWC9MVkFmVGdZSU81WmxvWE9OanZjTXVpZzBH?=
 =?utf-8?B?MzBTY1BnUE1ra0tZT3lRSnI1RG8zL3AwYUw1aG9DN1F4SENXWUo4Ym11enN0?=
 =?utf-8?B?R3JDYzllNU9TZlNkSkNqbnVJekc0K3RjMXlEcnJUY1p6aE93Y1EyNUg4a3RK?=
 =?utf-8?Q?AexD8qIFEUhK9xYVWqW+5+i39?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588ffebd-2790-4c86-ee43-08dcf0014fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 05:46:00.4019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USjrlQEBeqz2abJB8ubDGNEYwGvYR61YKFahhoFl/j+L45X+YcMXPFVNNDAgdk8tM3+6HUvLOe1HzaIKqHjKPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8843
X-OriginatorOrg: intel.com

PiBGcm9tOiBNZWh0YSwgU29oaWwgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCj4gWy4uLl0NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNi8xMF0geDg2L21jZTogQ29udmVydCBtdWx0aXBsZSBp
ZiAoKSBzdGF0ZW1lbnRzIGludG8NCj4gYSBzd2l0Y2goKSBzdGF0ZW1lbnQNCj4gDQo+IE9uIDEw
LzE4LzIwMjQgMToxNCBQTSwgVG9ueSBMdWNrIHdyb3RlOg0KPiANCj4gPiBUaGUgdmVuZG9yIHNw
ZWNpZmljIGJpdHMgYXJlIGxhcmdlIGVub3VnaCB0byB3YXJyYW50IHRoZWlyIG93biBzdGF0aWMN
Cj4gPiBmdW5jdGlvbnMgKGFzIHdlIGRvIGVsc2V3aGVyZSBpbiB0aGlzIGZpbGUpLg0KPiA+DQo+
ID4gSG93IGFib3V0IHRoaXMgKG9ubHkgY29tcGlsZS10ZXN0ZWQpIHBhdGNoPw0KPiA+DQo+IA0K
PiBZZWFoLCBpdCBkb2VzIG1ha2UgaXQgZWFzaWVyIHRvIHJlYWQuIENhbiBzb21lIG9mIHRoZSBo
YXJkY29kZWQgbnVtYmVycyBiZQ0KPiBjaGFuZ2VkIHRvIHZmbSBtYWNyb3MgYXMgd2VsbD8NCg0K
Q29udmVydCBzb21lIGhhcmQtY29kZWQgbnVtYmVycyB0byBWRk0gbWFjcm9zIG9uIHRvcCBvZiBU
b255J3MgcGF0Y2ggYXMgc2hvd24gYmVsb3cuIA0KUGxlYXNlIHJldmlldyBpdCBmb3IgYW55IGVy
cm9ycyBvciBvbWlzc2lvbnMuDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21j
ZS9jb3JlLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCmluZGV4IGY1MWZiMzkz
ZDM2OS4uM2I4M2VmYTFjYTY1IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2Uv
Y29yZS5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCkBAIC0xOTI0LDYg
KzE5MjQsMTAgQEAgc3RhdGljIHZvaWQgYXBwbHlfcXVpcmtzX2ludGVsKHN0cnVjdCBjcHVpbmZv
X3g4NiAqYykNCiAgICAgICAgc3RydWN0IG1jZV9iYW5rICptY2VfYmFua3MgPSB0aGlzX2NwdV9w
dHIobWNlX2JhbmtzX2FycmF5KTsNCiAgICAgICAgc3RydWN0IG1jYV9jb25maWcgKmNmZyA9ICZt
Y2FfY2ZnOw0KDQorICAgICAgIC8qIE9sZGVyIENQVXMgZG9uJ3QgbmVlZCBxdWlya3MuICovDQor
ICAgICAgIGlmIChjLT54ODYgPCA2KQ0KKyAgICAgICAgICAgICAgIHJldHVybjsNCisNCiAgICAg
ICAgLyoNCiAgICAgICAgICogU0RNIGRvY3VtZW50cyB0aGF0IG9uIGZhbWlseSA2IGJhbmsgMCBz
aG91bGQgbm90IGJlIHdyaXR0ZW4NCiAgICAgICAgICogYmVjYXVzZSBpdCBhbGlhc2VzIHRvIGFu
b3RoZXIgc3BlY2lhbCBCSU9TIGNvbnRyb2xsZWQNCkBAIC0xOTMyLDIzICsxOTM2LDIxIEBAIHN0
YXRpYyB2b2lkIGFwcGx5X3F1aXJrc19pbnRlbChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQogICAg
ICAgICAqIERvbid0IGlnbm9yZSBiYW5rIDAgY29tcGxldGVseSBiZWNhdXNlIHRoZXJlIGNvdWxk
IGJlIGENCiAgICAgICAgICogdmFsaWQgZXZlbnQgbGF0ZXIsIG1lcmVseSBkb24ndCB3cml0ZSBD
VEwwLg0KICAgICAgICAgKi8NCi0NCi0gICAgICAgaWYgKGMtPng4NiA9PSA2ICYmIGMtPng4Nl9t
b2RlbCA8IDB4MUEgJiYgdGhpc19jcHVfcmVhZChtY2VfbnVtX2JhbmtzKSA+IDApDQorICAgICAg
IGlmIChjLT54ODZfdmZtIDwgSU5URUxfTkVIQUxFTV9FUCAmJiB0aGlzX2NwdV9yZWFkKG1jZV9u
dW1fYmFua3MpID4gMCkNCiAgICAgICAgICAgICAgICBtY2VfYmFua3NbMF0uaW5pdCA9IGZhbHNl
Ow0KDQogICAgICAgIC8qDQogICAgICAgICAqIEFsbCBuZXdlciBJbnRlbCBzeXN0ZW1zIHN1cHBv
cnQgTUNFIGJyb2FkY2FzdGluZy4gRW5hYmxlDQogICAgICAgICAqIHN5bmNocm9uaXphdGlvbiB3
aXRoIGEgb25lIHNlY29uZCB0aW1lb3V0Lg0KICAgICAgICAgKi8NCi0gICAgICAgaWYgKChjLT54
ODYgPiA2IHx8IChjLT54ODYgPT0gNiAmJiBjLT54ODZfbW9kZWwgPj0gMHhlKSkgJiYNCi0gICAg
ICAgICAgIGNmZy0+bW9uYXJjaF90aW1lb3V0IDwgMCkNCisgICAgICAgaWYgKGMtPng4Nl92Zm0g
Pj0gSU5URUxfQ09SRV9ZT05BSCAmJiBjZmctPm1vbmFyY2hfdGltZW91dCA8IDApDQogICAgICAg
ICAgICAgICAgY2ZnLT5tb25hcmNoX3RpbWVvdXQgPSBVU0VDX1BFUl9TRUM7DQoNCiAgICAgICAg
LyoNCiAgICAgICAgICogVGhlcmUgYXJlIGFsc28gYnJva2VuIEJJT1NlcyBvbiBzb21lIFBlbnRp
dW0gTSBhbmQNCiAgICAgICAgICogZWFybGllciBzeXN0ZW1zOg0KICAgICAgICAgKi8NCi0gICAg
ICAgaWYgKGMtPng4NiA9PSA2ICYmIGMtPng4Nl9tb2RlbCA8PSAxMyAmJiBjZmctPmJvb3Rsb2cg
PCAwKQ0KKyAgICAgICBpZiAoYy0+eDg2X3ZmbSA8IElOVEVMX0NPUkVfWU9OQUggJiYgY2ZnLT5i
b290bG9nIDwgMCkNCiAgICAgICAgICAgICAgICBjZmctPmJvb3Rsb2cgPSAwOw0KDQogICAgICAg
IGlmIChjLT54ODZfdmZtID09IElOVEVMX1NBTkRZQlJJREdFX1gpDQoNCg==

