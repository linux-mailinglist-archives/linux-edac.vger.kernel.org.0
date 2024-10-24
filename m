Return-Path: <linux-edac+bounces-2262-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB6A9AF4C2
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 23:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B466B1F2295B
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 21:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE9B1B6CEB;
	Thu, 24 Oct 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tmoo5Rg5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942D22B655;
	Thu, 24 Oct 2024 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729806083; cv=fail; b=AKEAHGo0k5JkYowPUkW30NCmfIOplDdJG4gfjRmfTFO7mFdgA2TpZbuVYvRSYFPYC9pEVzETLqAL+pzbmebmZuVeisFk7T96GUwXs093YUipls2jYTytGK7Buz5V+LLCgJUWcgfKy/TbXphEKqGVaIGWE1sOd03AblWg91oPNLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729806083; c=relaxed/simple;
	bh=5U0uuaMeHBAY9aUYXr1ssW6SorraUfDRUdveaQer7FY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qagy4HreArevAk8WEuIxOgJIr6TJaajWOq4U0cwhBN6xmFJX5/QYkf4RP/sLOX6KPYMwtPSSMti23VGGjY3cmSdesE19jOXsK6hBxSQMKzoWEWWaqgD1qKe3oT0Y4xu57N9RKt74lLQv8oJ+qYdWkhfn1s2YE+h1c/o3PXRaIjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tmoo5Rg5; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729806081; x=1761342081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5U0uuaMeHBAY9aUYXr1ssW6SorraUfDRUdveaQer7FY=;
  b=Tmoo5Rg5zlvB+Oae0oF1aSlyZ5ZfXm6idQffWyhNIWSFK3pAqkKMKHxs
   LavR2xRxztUCQ+GcNBc7gcKgv3ESGrAulmcjRJmHvxC1BupZWi2jQorbI
   gqrL2mVjZpvG5WvxRV0vZw2kzsukYytqJpChoghywN43+AJu+1JuvgET7
   RY5E7NjftonksPH0uWNAjunY1ExPxxcQ55dS9QtxCQsQmdPqkKrVhD4Gx
   OwBetHA0N16gNzrXLjjXguxmvHVAt601rIMJEX5jyMBucP2iApsSsDr5T
   IwX8WJ0n4Pdhfs5/W+q8v7CoZ5X54cJDCKeVz9WJP2/s/1bXLd1erc99A
   Q==;
X-CSE-ConnectionGUID: tzr9zTL/Sfao8Sw756nTqA==
X-CSE-MsgGUID: YRTPSW/tSAKbdiRyBLEHfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40053704"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="40053704"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:41:21 -0700
X-CSE-ConnectionGUID: ZvbFDC/uS5OOlYwgDha5+Q==
X-CSE-MsgGUID: CsY8hcCGSG+prE0zls777Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="85264852"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 14:41:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 14:41:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 14:41:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 14:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HO3w6y0IBtaLMIkKo3gamQ0Gyv4zMIQHMkhIFUZTRuwMuHr9bVMTLrZx5n53Owp59aWG7emSBYuY11zyueArwWyHIz4NJAUtmcXi1jQsUKNvv2WPvFhn7MxHeV49Ityyhp+TOLIvoyXNdRjn8yK0bUUsNCh7XU79WckQoD736pxwAi9KV+xuBcGru3eTCDqibqkoQa+G9kd5wnRSTq8jxC95536kjwlkytA3jGnkb/o3byn+9+MJ5G5s4siWe9yG2RFlD6yVoGdU8i1onCFQCa4od/iUZCSyHY5ShKQCD7I1q55czjTGo+9Mm4MkFoS9XfnbQEYmZY9KaJf0Wk6MDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5U0uuaMeHBAY9aUYXr1ssW6SorraUfDRUdveaQer7FY=;
 b=PLkab8ijgl04bxehyLOUp6kOKVhVSp3n+Ql0eCMx4WZALTnhJoDn2BswVeiQpSACLqtxZ53hTnvs915pi59/gQt/vJxbaIZBGl2CFWiG6ZY7w3Vl+ZNOuGTH4iIQsGXhCLKeHwJxz4+kPeEsDg663azRa8A2rF1+3ItIYA5ODvVbmyZqxQQBZxTgjJLBdQikx0x2vpTVTg+Wn1FBZTVCVXZZznuUTMEQG3geo83a+3Z5nLiALTCLodDR0rKhK155j151CzKGMCpnpf/bWEfRYzlFrDYpaXvYXairyWOwZwJJHTaEG91LB2/CJ/6lf7ld9oC7eHVpC097d1yvmSZF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 21:41:17 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 21:41:17 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Zhuo, Qiuxu"
	<qiuxu.zhuo@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>
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
Thread-Index: AQHbH8qM4hN2vTGb8EmNSTTck992prKM7JIAgABI4TSAAF9SAIAD0KcAgAAIXgCAAptvAIAB4iEAgAA6hNCAAFLRgIAAAjnA
Date: Thu, 24 Oct 2024 21:41:17 +0000
Message-ID: <SJ1PR11MB6083AB84528B99F6FC0C3A6AFC4E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
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
 <dcfdba92-7004-413d-8011-12771636d11f@intel.com>
In-Reply-To: <dcfdba92-7004-413d-8011-12771636d11f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW3PR11MB4652:EE_
x-ms-office365-filtering-correlation-id: c413f23f-2521-4273-ff22-08dcf4749786
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UmpXdGUwVGkyQ3RSeWYzYWZOM1d2KzVhd0tLN0V5eTZncjJ1Ti9SZ043QlZB?=
 =?utf-8?B?MnVEY1RNaS92eFB6T0NzcUdUZGhBU0orL3laQTV1MHZzNUt5TFNZUjdickY3?=
 =?utf-8?B?ZXdOL1BacE1ZSlBveFQ3Nnh0cDdIVzM3NHl4VnZ6Vk80bmZCbWV5cG1ob3F3?=
 =?utf-8?B?YmtTQVBKbjV0THhEM04rY0trdVZiZ0lEWlNtSlAyS3RsdlRqQWJkL1Z2UFcv?=
 =?utf-8?B?dDJoSElTUHNyQTVLRWRqeFRRdXh0cVNVMjc3d3BBdkpuZ0lUUk5JZldZWFly?=
 =?utf-8?B?MXBteGwrWnhZWjBmNGNpTHgzQlkrc2E3anEwWkxNRjlncjlUWnpleGJTSWxu?=
 =?utf-8?B?NlRBZHhLWXRiU3Zrb3kvYzNmakx3UlRBMkdoMVllRlNaSGlOV1ZVNEVRWS9l?=
 =?utf-8?B?VStPZDNsTFlYRTZrczZaOWMxS2NVMGZpRHFQcThTK2NjZjFFbEoyMnFqTGJt?=
 =?utf-8?B?ck1mdFV5OWNwSDBKcWxaRUlvUGJjVFBMYThxUUZwRiswK2xvWWl0cUxvQUhT?=
 =?utf-8?B?T2lsVGNQRVlLS3NlZ3lRTkZRamtCcllKQzJSN1JkS042RTVhSzBXZG5pQkRO?=
 =?utf-8?B?aHJtSzhBbW5OalF0bnl3azF2UStqRllJMjgyRVpEeDZEbER2Vk0zVnpaRDIy?=
 =?utf-8?B?WE1UaXFxWnBoKzYrampSdEpiMTFZbU5ySnVuMmk5N0pMYURLM3lrcFZZc1pE?=
 =?utf-8?B?dG8zdUNhTFJWVU5NRGMwSjZqOGg1eW9ZV2ZEdG5tQUNCa2VSOWdCRzY2dExl?=
 =?utf-8?B?ZjJSbnlTR251Zk5HL2hJajNwVDJMcDJzR3paSVhWZ2tQTUhHYlVFMStWZGlQ?=
 =?utf-8?B?WnVwY0xrZjc5WkFON294REhudUJwK3N1WENxWDVHalAxdEptMzNLWlFZSGdM?=
 =?utf-8?B?VW5oTWZxNmZGbDB6OE1NZnkwNUl3UVVVVmEydHZhRWJtUlBZeDdLM2tnWHZn?=
 =?utf-8?B?VXNrbG9NS3pmTVNwQzByZkxYUUtRSVpmZWUwWUVUZHk4NHEzdGpCYlFGVHFn?=
 =?utf-8?B?Y0FLMTgxc1BZT0FOQWdoZkJiaXVrMmVIZHpvdjBqQWZ5bHBlZnFYc0JBRHV3?=
 =?utf-8?B?NFBLUUE3Y0VmZTl0RlFnd1VWeStXVW8yQXFFSXR5V0Y5N1JGd1ovNU90Z2sv?=
 =?utf-8?B?SE9sVWVNZC9Sd1VIWVNRTUZFNEdxYWFKbksxSDN1ODRKellyM0M4SVEzRDJy?=
 =?utf-8?B?QzVOR0lPTkMxL2JlZFhoUGpOMTRrdU5vSGVML0lYUk9RYnJTdVhDMkdJK0Vt?=
 =?utf-8?B?WXpYMXduNjJFMDVRTUhmK2VTNmY0L2dGMFdQSFZZNnNZR1d0TWF0aFpqNzJI?=
 =?utf-8?B?RDg0U3U5bFU2eEdDRThmMngwSnI3eHRuKy9ZdUl5U1VwUm51QUswcG9WS0Zn?=
 =?utf-8?B?QTRPSTA2a0YvallCSWpGK3BsRzJTeFJvSVRqSlRjZjVsYVNqR2dMN3hvWE5r?=
 =?utf-8?B?d3U4aFY1Q3FiVGl5TEZkRTVIeGxFK1lDQ1ZZM3JMNzdlZy9ndDNYL0V4a2px?=
 =?utf-8?B?QXNmVXZnNURTbWd3Skx1U2lvanpiREFpT0ZIU2VmOGRtc0s4dW5JSUlMcFFN?=
 =?utf-8?B?OFcyK0Z0aU1vOFhGNXpjMzlHSE44OWI4RHYyTEkyMktyM0ZNWU96TmU2cWJm?=
 =?utf-8?B?aGJqUmxQbW41eXZwS29jUGNNNHhuT3pQNGlZK1lqckE3WXZPM1AwL0p2NzQ5?=
 =?utf-8?B?THN6T2lBMDVxZ2FxcTBmZW5vNUxGZGRCM2oxMWpkMG5ZZENobTkzSmFoUlh1?=
 =?utf-8?B?VzNNbkNRUW83bFMyT1hjemJEM01yY28vSlZqUW9xbVo0SlhmdjlaalF6dDZG?=
 =?utf-8?Q?bZEfhKrbclYII93PGhCLJcXYUMA74KHrwEYpM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUwvdXNyUDR6TWdKWUZwOVg0ekxpZUFqWVVTTGxsaWhuZ09DbktZRXBWUkZr?=
 =?utf-8?B?VEFrNlFCMWRrbjJMMExjODZyazdTTlBJd0tXb3pnSC8zd0dWR0hHQnhYZ1lI?=
 =?utf-8?B?WVBsQmRQRi9DRDhud051b3MwT1UrdHJwdWtjakVaQm5EdXJ3Kzk5MkNoTW8x?=
 =?utf-8?B?M3Z6U0VtMExuMmVwaEc5L0d3Tk1GcVlySmY2L3MzbDNYTmlvUGpLSUtBNU5B?=
 =?utf-8?B?eGpqdUxnZTkwcURvaTlCUjZjTU5xTXRmYUxMd1pVTjdBbVZpMTBnU3ZibWM4?=
 =?utf-8?B?RGtJcVM1VFZ5MFhUMXVWdi9EeTEzTndvdmwrYVA4bTFaeHhFS1A0TDRBWWsy?=
 =?utf-8?B?ekp1OWE2cWpBVTlSTklCbVI5MUpxUTRFR2k4NXhQSU1QdVJGSkczS2xsNG9E?=
 =?utf-8?B?Ynd1YUQyOWcxZlRiZGJ1VmpXVm4zY2w4c2tra0p6MGsrZWEzU3FYd1F1MjNT?=
 =?utf-8?B?UW10cVZnL1VKODc4VEVNb3R3RFh3dUs2V05QemlYWUsxV1NxUjM3eHdvY0hu?=
 =?utf-8?B?L1lBTzJQVzd6ZWRTNU9HcDUyQ21Ja2tQM1lHKzEyUDVXOVJCZ1FOcG1Wa2lH?=
 =?utf-8?B?ZEdFU1pDRGt3Q3EyenJwQUg5RElubUZ4S2gzckJML1d1alVTR3hZazVhbW9P?=
 =?utf-8?B?ZVZCQzF2UjBwenRDUXNra0lNdTdhYjJic1NtUXZQU3VqSlBvL1R0ZEdlelhH?=
 =?utf-8?B?V0VPd3EvVjJPNENzeG52REJrMjhpL2xua0xRL0phKzNpblZkREZXdXlTOTVK?=
 =?utf-8?B?dkVpZWFRWS9oYm1WMnpNQkJYNFdKT3BBdERGWTQzcmM0eUlsZURrTmYxa2tv?=
 =?utf-8?B?UjVTcXZ4Mm5Ja1pSRFdNSEJBN2pYbzZNekJqQVZuSGpodERRNktZa3R1bVVI?=
 =?utf-8?B?TzZla0J1QWRNaktjT1RSdVF1SldzM0ZndXBLS0g5eSt5czBxTkJLUkcyUEp2?=
 =?utf-8?B?UG1JQkdIa0NibjF2VWVkQXpRVUM2Z1d4OHgvMzVhUGZkQjE3QzJNK3hVYUJm?=
 =?utf-8?B?bWl1SmxYOEFsdzNGUkViZzdLYzI1UWU4ZnVObWZoYnZJTUZIM21NQTFWUGQ4?=
 =?utf-8?B?ZDZoRFZVTmpFd0J6VUIreTdOc3NId1dMY3NCMVBJeDhKNHJqRjhJTzlmR0o0?=
 =?utf-8?B?c05KY3RNRXovQ2hudVo3cStnZ1J1eVRxYmNHVmpHRmRLRnBsWDFPMkgzS0lv?=
 =?utf-8?B?TW9yQm45a1ZpdzZMMHIxakxjSC9VNENEOUl1RVRuNTFXTTBKczBLTVZhMDBK?=
 =?utf-8?B?VGJpUG5yNUsxbmZnSjV3VmJzN0lNV0hBVFNaQUViYnNQdmNPaDd2d09rMThT?=
 =?utf-8?B?NnpaVFhIeHVMWlFqV09ORGdDUXpTL2lvN1NlRGpPZE9xM0V0WWkya0x1amxa?=
 =?utf-8?B?My9FVzUwOHRpQkgwalpHdTJ3akRKL1RtUytDcGlreGw0RE5nSUZZRnNCemE0?=
 =?utf-8?B?YkE0RDllaU9SdnhSS1dpV0VHRm9MUW9sdTNpa05sQzRWU0JCUisrMWE4bTZV?=
 =?utf-8?B?QmVlbFVlQm91ZmFnVUNicmlTWnBTcFdNU3pLazRvZVlpek8rQnVDUlVGZkJN?=
 =?utf-8?B?ZXFPK1lzdm5VUk5CdXpURi9oZFpUcGgzbFNDc3JVR2xwZndkQkpjOE1zbTNB?=
 =?utf-8?B?di8wMysweGdTTkkwMXpZWGdHbzNsSFdYM3dGV0JVMXpwTEZHTU52T1hOSndj?=
 =?utf-8?B?c0MraFB2TUZobUJId0xWdE8wQ3IrOWxWdjVUL2FMQ1BiS2pGaHBGV01BZXZV?=
 =?utf-8?B?Tkh3R29aa0JSNzZrUE9PSFRiSFdKUlQvYTVCRE1kYWo4SjhyZmIwaEVwME1y?=
 =?utf-8?B?ZE1kY3oySzdnVXM2MERuSjFtM2NmM0tPV0FJdnZZV2p6M1lmVzF4MXdsdWp5?=
 =?utf-8?B?VW9LeTlsL2xENlA5WHlMZC9NQmtEWVdBQnQrenJ6aDBKYk1BeWwzKy92Y0xS?=
 =?utf-8?B?aEdnU2NGSFdGbytPelhyWlRudEI1RVVScUpnZDc4NXBxNlY1ZDRpbFQwUmFY?=
 =?utf-8?B?elpNZU84SHg2OSt0Y1ZKRkpMSm5xbUM1RWJ2Vkc5R25TOWswZmdsKzhsamNZ?=
 =?utf-8?B?end1aTBwMUlZcWlRY2FyczRrTTZ0VVBTajRlaXRLV0EvRkJpQlVna0l3Kzlz?=
 =?utf-8?Q?FCQcw2ngyKOITLVrdQ3KwHmon?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c413f23f-2521-4273-ff22-08dcf4749786
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 21:41:17.5035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBR6lyUcAgBTpPv1Ni9RicxgDUp66p8GhphG0YfD88cP2uoi4T9HMbeV3s632ZTt3vmrmJPODwD2brDfB8rJDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
X-OriginatorOrg: intel.com

PiA+IC0gICAgICAgaWYgKGMtPng4NiA9PSA2ICYmIGMtPng4Nl9tb2RlbCA8IDB4MUEgJiYgdGhp
c19jcHVfcmVhZChtY2VfbnVtX2JhbmtzKSA+IDApDQo+ID4gKyAgICAgICBpZiAoYy0+eDg2X3Zm
bSA8IElOVEVMX05FSEFMRU1fRVAgJiYgdGhpc19jcHVfcmVhZChtY2VfbnVtX2JhbmtzKSA+IDAp
DQo+ID4gICAgICAgICAgICAgICAgIG1jZV9iYW5rc1swXS5pbml0ID0gZmFsc2U7DQo+ID4NCj4g
PiBVcGRhdGVkIGNvZGUgbm93IG1hdGNoZXMgZm9yIGZhbWlsaWVzIGJlZm9yZSA2ICg0ODYsIFBl
bnRpdW0pLiA0ODYgd291bGQgbmV2ZXIgZ2V0DQo+ID4gdG8gdGhpcyBjb2RlLiBCdXQgSSB0aGlu
ayBmcm9tIHRoZSBjb21tZW50cyBhYm91dCBtYWNoaW5lIGNoZWNrIGJhbmsgMCBiZWluZyBtYWdp
Yw0KPiA+IHRoYXQgUGVudGl1bSBoYWQgc29tZSBydWRpbWVudGFyeSBzdXBwb3J0Lg0KPiA+DQo+
DQo+IEFzIHlvdSBtZW50aW9uZWQgaXQgeW91cnNlbGYgKHRoZSBsYXN0IHRpbWUgSSB3YXMgY29u
Y2VybmVkIGFib3V0IGZhbWlseQ0KPiA1KSwgdGhlIGZvbGxvd2luZyBjaGVjayBzaG91bGQgY292
ZXIgdGhpcyBzY2VuYXJpbz8NCj4NCj4gPiBAQCAtMTkyNCw2ICsxOTI0LDEwIEBAIHN0YXRpYyB2
b2lkIGFwcGx5X3F1aXJrc19pbnRlbChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+ID4gICAgICAg
ICBzdHJ1Y3QgbWNlX2JhbmsgKm1jZV9iYW5rcyA9IHRoaXNfY3B1X3B0cihtY2VfYmFua3NfYXJy
YXkpOw0KPiA+ICAgICAgICAgc3RydWN0IG1jYV9jb25maWcgKmNmZyA9ICZtY2FfY2ZnOw0KPiA+
DQo+ID4gKyAgICAgICAvKiBPbGRlciBDUFVzIChwcmlvciB0byBmYW1pbHkgNikgZG9uJ3QgbmVl
ZCBxdWlya3MuICovDQo+ID4gKyAgICAgICBpZiAoYy0+eDg2X3ZmbSA8IElOVEVMX1BFTlRJVU1f
UFJPKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm47DQoNClNvIEkgZGlkLiBJIHdhcyByaWdo
dCBhYm91dCBpdCB0b28uDQoNClNvcnJ5IGZvciB0aGUgbm9pc2UuIFRoaXMgcGF0Y2ggbG9va3Mg
Z29vZC4NCg0KLVRvbnkNCg==

