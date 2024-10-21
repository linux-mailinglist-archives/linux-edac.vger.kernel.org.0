Return-Path: <linux-edac+bounces-2164-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED659A6F0F
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 18:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5323B240CF
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 16:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93EE1CFEC0;
	Mon, 21 Oct 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5Cfz3OQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F21C8FC2;
	Mon, 21 Oct 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526815; cv=fail; b=JT0S0u9y+Vt9XCMkblNmDTmxet74PNO79lnxiW2lNfmSKG8DWU+a8CZ/KnVRHmV5hdhIoE9otg6eX0LY8uB2TQX4fOVde5jd+XmpxzorXYi1oCOYxcdKygCU1C2+9+iey+WJfZn6qFDm+pjrlT8ObQqEXeYpYdvLY4mF9vFyaOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526815; c=relaxed/simple;
	bh=QAn0qzhazS3g4+lCRqc5pVH4RIo0ejAlVMXmnSOJjhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZaAs0/nRReLB5sdVwPiwb2ta0FEuPHA1pOy73rKpV+XEYJTDULebHBDw+CimMuieD590oMJGbO80reN4367OL3LxBxN8FtzCjYVxsHyUNvh21TmyA7u3zt3Ukt5RY33HyMsY/zr18ynhSWgxQnTLn3yx9lfe1w4s7r+uE11DJAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5Cfz3OQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729526814; x=1761062814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QAn0qzhazS3g4+lCRqc5pVH4RIo0ejAlVMXmnSOJjhU=;
  b=n5Cfz3OQnyE1sfc7IhzjUTt/sckGC0O6Fk+EA2LKo7ydNOJuAI65KJjn
   S8Jww0/Usvs6B62tdKzg2yWHKMvXaYhmPnBFFBhOy7jxL9NT1I7kDSmdq
   v477E57CVzeqC8TGMEFxnFftc7r4CZ9K+AKAwC48fgjG73yplCeFMmE7M
   RCvFFqd7xXYVpIXoJJAwrUuKNbsr5OEf7zSNh66P7jHye/pVSqGLknXT8
   EYHpecmpwp9QZR9TbzONKEa/+uMLEDTW+kEj/5ztCX6zJZaeb4N3/VPYu
   qptn1J47oNredIQLaURH2zZfpANVpHqZOemh6BrH/f4aIPFpQFjKoWpJ1
   A==;
X-CSE-ConnectionGUID: NbJ9Rk07RDm1SdWfEhl3Hw==
X-CSE-MsgGUID: I0cbK8lORPCvieYTX/FrjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29137906"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29137906"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 09:06:53 -0700
X-CSE-ConnectionGUID: uvRnaFqdQDeAuxxab/8yGA==
X-CSE-MsgGUID: 9cBcY1GkRl2JlYay6I2hxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="84632566"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 09:06:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 09:06:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 09:06:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 09:06:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myiPa5Nx6yVHV1gO/sL7b1IJWqyYcnE2ZTWCF3lHSUYCkhWYmR+crCH6XHZYebc4ohh8ufHGOPCKtebQ8y9imiEVoypyZaGkeS0++sQlOGnUrkBBiNnZL/Weg9Fq1CfXdisDYK5OHrp/vn6GXMLGXQp3WDFPicidRM+Gl9u1KV7DwgCVqzgCRtk2RiXLLnvyIw8EE/rO8T+ecBqn6LAHNYVkajcEEzcDukPgO0AITNLD/qbf9EeqcBEWVLSJVFLFKeRbzxQKedGyZk9hmKD8Ny+JkORTwp36StrweFqUm5RXxQ03bxuCJLqbd6GFYB0zjonKU2pAZ1/KyQ/zYMFUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAn0qzhazS3g4+lCRqc5pVH4RIo0ejAlVMXmnSOJjhU=;
 b=gtUsgbSuslEHDffUj6uJ/q3fLJYFiKKZirokDKGdZ4zk2UEs3y3xspkR8KUDNsqd0jL4hGEBzmd3xK0GvaYfndskOjxQaqIv3Ni/rJ9XhR8dd8qwsesH4aex6Uk7/eL7XfutRZCDOe9x41jfITAWIdFIbJOxdD+78uagCv0G9KlFYyTQjbA9iqxUMhJ/BxbgT5IHmDD1im1MYFLIOxJG+gM7jH4gW4VxVNpVvOU5Mo0TLZJHoz//s4wdAML18D9BkMhJjapknq5QkL4djlBmqWS1WrcNSCTvj53VyddRhMuyCbvjswbrYZEE6zZNJLYfvjBQsKoomPUcZ71UG2T3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB7155.namprd11.prod.outlook.com (2603:10b6:a03:48d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:06:47 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 16:06:47 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>
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
Thread-Index: AQHbH8qM4hN2vTGb8EmNSTTck992prKM7JIAgABI4TSAAF9SAIAD0KcA
Date: Mon, 21 Oct 2024 16:06:47 +0000
Message-ID: <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB7155:EE_
x-ms-office365-filtering-correlation-id: 55441dbf-eea1-409b-f8b8-08dcf1ea5d63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K3lkbU5ncWRCQ05DejhDNXNLRmtXcEp0OTlIdE51QkFycEt2a2NNR1J0OFZK?=
 =?utf-8?B?RWswQldRUmJiLzRnZmw2bFFhY2N6NFRxZUE3K0RGenhmMFgvUi84R0t6RjI5?=
 =?utf-8?B?bjVPU0VEZVVDT1NhdEt1Q0NpRy9Qdlg0dEl3TktydUsrVndYRkR4VDV5RVBh?=
 =?utf-8?B?VzN3MjlFck5LQzBpdEl3YnJVSFUwUTlZUmxPaStyK0REaURtRkw0ZmlKOEk2?=
 =?utf-8?B?ak1LNDN0NDBZSlpBZzZMUC9KYzFlUHdRVFdGZWM4Sjk3YjhRaFF4cXM0ZzNk?=
 =?utf-8?B?ekxmWWlvS3dKUDhISEc4aG9pZVFRRnRROUw2QUFURFMza3Q5c2RxTU1Ndk00?=
 =?utf-8?B?Qnh6c1N2RWVndnREWG1HZWVWaDdHQ1pjWG9aVWtOckkwQUp2RDkrSXB3ZWNw?=
 =?utf-8?B?QWFzYnZraXg0STZjbWd5dXZBTitxbERmOTJjOGpocEdtS2xPMTZ4RmVmNXdv?=
 =?utf-8?B?RWpXWjNvYTZWSCtkdm9TZmFoeFpFdnIxRzlQV0pwbVRGbzBnN3c2TUpkMUZU?=
 =?utf-8?B?Mk5wMmE5TEx6em9OM0duNUhLQU5VbDJmdlBTcXRUN2krZkVYcGhCNDhudzZo?=
 =?utf-8?B?L1JpQkVHREdlYnZjemQ1ZkZ6dHEwdzN2UXNqVHNCNXJ2ZW1GUlZrMVZBZ283?=
 =?utf-8?B?U1pJWDllcW1hTk8wdm1jNC9oY21yZE9NbVU0Z25XeUlSREVZKzl2S0p5dzg5?=
 =?utf-8?B?Q213SHgreFRjamhvRVJ5cDJPYWVvU3ovS2tUUXprVGNNa00yaFFXYk1RVytC?=
 =?utf-8?B?ZzloTFJBMG00SHNGOGJ4NU9FVU5pRUsyRW5UeFVRSlFtSS9xR3l1M1pJK3Vo?=
 =?utf-8?B?Wm8ybWhVWUtnVXl4NnNXZHc5eXhWSTJseEI2Qms1OEVNNGQrcWlUbVdlazJD?=
 =?utf-8?B?ZTI1RllHazV5TmJxbnpjMGhSdXRIQktROGdicG5Na1NoUUVDdlZQYlp4MHZ5?=
 =?utf-8?B?N0FpUFhodlJTcmFjbVlKUG02a0djMmRLeUR1WElmS3ZLR3I5alh5MStKaXAw?=
 =?utf-8?B?cVNrMzJDM0VkWE5QQitlK0ZCQ29Zbkkrbkh5ejZxSklSaDF1RG9iQ0JZRUtq?=
 =?utf-8?B?b1JUS20xTVVHTFlHOE9UOE9HanNtL1IyWTB5aVRYb053MHFMYkJtWVF2MWwv?=
 =?utf-8?B?NkVrR1dtTDNUUXBpYTRKd3pIWHZqa0dMcTdId2xCZTJ2cVUwN3RyT2gwTWZ5?=
 =?utf-8?B?Sm8yL2xIQWJzNkpYSFNQZEluZGlOcjhuZWgwMFNCRXRFUlhDRHlvRnFQL1A4?=
 =?utf-8?B?TU1KcGFhSVkyZy9aL2F6S2tCdkZRS2VZeCsrNUdKRDdHNHZoR3h4R1ZueGFy?=
 =?utf-8?B?TFdDMkxQMnZpczJRRHVmb3haNDUxZVVYc2xLVUpQdGJPQW8vOVY4eCtEODJ3?=
 =?utf-8?B?a2h2cmR1NGN5V3BkaVV2NDVqMkRPNElBVS9hZUcrSVI0QnMvRWtCNEZIMGFM?=
 =?utf-8?B?dDdTbVZnRTlWYTNjZktQdmJkWEt6RHdnKzJpa2pzN2JtSmNNK1pONDNidGIy?=
 =?utf-8?B?WVBxZ3lTSkF1SkNzMk0xMWd3VjVsK1cwM1FGb2dlSE5USUp3SFBvVkNyY2tP?=
 =?utf-8?B?ak1rSVk2RG9IVnVxRkFsS1BGR3lGa3FWVlBoWWtlWUFpcTVvRnlPYnV0bC9l?=
 =?utf-8?B?WEtrNXRGcFQzNUszcmZkcjFQL1pHTitVKy9JeHQ5VXFZVXI0UlVVUUkzc21y?=
 =?utf-8?B?UlAvSlEvR2FHa0ZudlZJam1oWVFFeWV1c3J2M0FPVTFNV1BZM2NCVnFiN0lK?=
 =?utf-8?B?RHlWcERPRGtUZkhSeDc2SVhiVVRmZzhJa2pvdDAweGF1aFUzQStBSHI4eERS?=
 =?utf-8?Q?kubE3Pu1DuIsnzYnWIgxBZzC/kszjna4M22ys=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U05KdEcwVWx1a2xLU25XRWh4cEtvd3BIdWdFZDY1ZlRQaVBkQlU3eWRTVXBK?=
 =?utf-8?B?QW9wdWM4VzhBVzhUckkyL1hHdnpXbE85eXdVNFordU9YSy9SRk1xQVNtckU5?=
 =?utf-8?B?R2Q4MG52bUNndTZLSHRISUFDdnlFelpyazJ3VmdXdEZwemZjNklmQ21xYmxo?=
 =?utf-8?B?cENWMlNWN25rbTRvZkdSTmVDd1RscTZOWGdoVTNyRXBxN0pBODVacXJXRi9H?=
 =?utf-8?B?RFJlQWN1ZXk0TVluNFY4SFhhV29QbUkvSjVQS0VoM29YN3NHd3A5bDZYcHlB?=
 =?utf-8?B?UnhFLy9TMXpYNGg3cDVVbG1VZjFYb09kYkp3bGVmYmxvM0NyNStWTlI5QW5F?=
 =?utf-8?B?aWNPL0NncVM4azNtcHhLREZPTEpodm14cTV0YzJrdFNmRDNSTmt5K1NGM2pY?=
 =?utf-8?B?QkJWWEhRWHJORE5WWVdzd1EwRVFNZlZ2bVY2bHVpZ0IxS1I2Vk1CZEg4MXRr?=
 =?utf-8?B?V1VEQnNRZ0FCVldzS3NuWjhKeGZtbUZRc0g0WnJrZ1pFbjBVYkdkRmpiVExL?=
 =?utf-8?B?bXVWOG5scHJ4cEMySnR2d0o3MUVkOWlyUkErSzZidGw0UUZKeEV3Y0VBdmt6?=
 =?utf-8?B?YW5jL1kraGtsS3hNd25IY0lpTVFtZndBSlFqRGdvMlhCdm04aUNVaWdIMkNV?=
 =?utf-8?B?cUVoaU9qYjRFNHJNc1c1ZkhrVm5sMHJHOGFKcEg0bEI1YUdQVThGclkydGpr?=
 =?utf-8?B?dVRibjBmN09yUytTaVNhZVlKbU9saW9SZ0p5NTdHQkRmWFVpNkdKUDVmVjNS?=
 =?utf-8?B?V3gwbmkrZ3hUdDBzbFJ6ZlV3MzBGcThLcG96WGNvUkpGc0o5d3Irc3ZjU09P?=
 =?utf-8?B?cXB4UzlLM1B2WWhEalJmTGtTTjVPQklnUzYzdERTbmw5OHd0UUtZR1NPOG9H?=
 =?utf-8?B?QWFoMXJ5L2N1QTRrVDZYT3M2dFAyYW1JRFZScnFubUVXOHpDWkd6TmJzVm5U?=
 =?utf-8?B?VjJsTHdVS3o3c3cxRVU4b0lEd1RjQVBZOTNibU83NmpMVnU3SnlCTDF4SzJG?=
 =?utf-8?B?VTM4WTZPV3YvRnJEWnQwRWtldlFnUmVMdlJYcjlUVkJIOGZ4Y0ZWK2IyOVRX?=
 =?utf-8?B?K0VoSDVkWDkweWxEWGJYZUpkaVliL2F6ZHpsU0djeUQzOFBpUkZPc0k4Z0ky?=
 =?utf-8?B?NDdZT1VTRE1wSkxWc1JOSDM2OEp6ZVplSFplVnk2bzZZM0ZzOG5HUGh0cGd2?=
 =?utf-8?B?VlRTeWVRUmtUNTY1TnZidkVCVjhRLzNjZFd3dFNPZTRxQXl5QXh2b2pzcHpX?=
 =?utf-8?B?N3FzMEpGejRzSWVDbGR5bGNTQ0pJanVabFFobStwd1RSUXZHK2tQUTNZSFNO?=
 =?utf-8?B?Nk1ZTWtwbWNvQ0U3TFhKZjhTenBvT3Boeno3UWxFcHB4QnE4U2h0QktUdjcv?=
 =?utf-8?B?S0RYQ1BYZDlKWGVKaWxUWWhTYVRSSDNzTnBhSFBLNDNNbE1XVEFVd3RRU3Ft?=
 =?utf-8?B?RFpIYWVkOGdLOUpwSFRQN2V2SDhHVCtYWnI5YlFzdFhFYUw3Rnhxay80aURY?=
 =?utf-8?B?SmVaYlhPQUpUNFZ2UUdqM0ZNdXJhN3VXUVBrR0xRbUpKNDB0Vi94MEU5bmZn?=
 =?utf-8?B?cG1sa3Y2UXd5QjNGQ1NyN1ljSCt4RitkcGJwcVkydHUvWTVqMVRWcG4weWw3?=
 =?utf-8?B?UzNPcHpxMjlhb3B4ZUdhNjdsNytsRzRia2Q5dFNYUms0NjBFWGhuTmhoYkVo?=
 =?utf-8?B?d3BqQnNybklYZjJyeU12WURNNEFyT2xyMXdHc3dqUlJNZGxnNHJINktzN0Mv?=
 =?utf-8?B?TVJ4a3dLaEVtTitnUGpmSlp0RzBZay9FYlNLcVYySnI0STFJVWVpbUVsOFVq?=
 =?utf-8?B?bzVEaWFvVGVEb0djYnFUVG9YRWd6WDJ3TTNOS013M1A2dmlsVnl6L2lWd1Rw?=
 =?utf-8?B?NjFmZ1MrQmJYRG5sbGM2REt0M3orci9hd3MvT25vZHE0elFTSElmaFdldzdz?=
 =?utf-8?B?UnZvWVQxU2pRWmF3R2NCa0pxMHpLTHkxamUzeHdLZW0wYjVBQUJaTVZqcm9r?=
 =?utf-8?B?SWsrTnF0SzR5aXFUL3JwZ0lCbE5pRUpBYk9XKzRUa1ppUDFCTlpVQW0yZktV?=
 =?utf-8?B?d3ozMVZMc1ZadTI1cER2K0hTNk9vYUFvRFl3eUhqWEJwU2ZQN1Q1YkN2cStr?=
 =?utf-8?Q?HpjaY73IMztflhnFjDL95qMzW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55441dbf-eea1-409b-f8b8-08dcf1ea5d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 16:06:47.1093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vUZxkz7zPTKFCnQYdN7HrvcAWl12dJKuZYWGEPwULb01mJRhj/VERkXH52VMQLHaOVhK7nceV+HOJSWRyCEtvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7155
X-OriginatorOrg: intel.com

PiAgICAgICAgIC8qDQo+ICAgICAgICAgICogQWxsIG5ld2VyIEludGVsIHN5c3RlbXMgc3VwcG9y
dCBNQ0UgYnJvYWRjYXN0aW5nLiBFbmFibGUNCj4gICAgICAgICAgKiBzeW5jaHJvbml6YXRpb24g
d2l0aCBhIG9uZSBzZWNvbmQgdGltZW91dC4NCj4gICAgICAgICAgKi8NCj4gLSAgICAgICBpZiAo
KGMtPng4NiA+IDYgfHwgKGMtPng4NiA9PSA2ICYmIGMtPng4Nl9tb2RlbCA+PSAweGUpKSAmJg0K
PiAtICAgICAgICAgICBjZmctPm1vbmFyY2hfdGltZW91dCA8IDApDQo+ICsgICAgICAgaWYgKGMt
Png4Nl92Zm0gPj0gSU5URUxfQ09SRV9ZT05BSCAmJiBjZmctPm1vbmFyY2hfdGltZW91dCA8IDAp
DQo+ICAgICAgICAgICAgICAgICBjZmctPm1vbmFyY2hfdGltZW91dCA9IFVTRUNfUEVSX1NFQzsN
Cg0KVGhpcyBjaGFuZ2UgaXMgY29ycmVjdC4gQnV0IHRoZSBvbGQgY29kZSBtYWtlcyBpdCBtb3Jl
IGV4cGxpY2l0IHRoYXQNCkNQVXMgaW4gZmFtaWxpZXMgPiA2IHRha2UgdGhpcyBhY3Rpb24uIEFz
IHRoZSBhdXRob3Igb2YgdGhlIFZGTSBjaGFuZ2VzDQppdCdzIGNsZWFyIHRvIG1lLCBtYXliZSBs
ZXNzIHNvIHRvIG90aGVycz8NCg0KQnV0IG1heWJlIGl0cyBPSy4gIFRoZSBjb21tZW50IGRvZXMg
aGVscCBhIGxvdC4gQW55b25lIGVsc2UgaGF2ZSB0aG91Z2h0cyBvbiB0aGlzPw0KDQotVG9ueQ0K

